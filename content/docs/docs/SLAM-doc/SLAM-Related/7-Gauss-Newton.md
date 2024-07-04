---
title: Guass Newton Algorithm
authors: 
    - EndlessPeak
toc: true
date: 2024-06-18
featuredImage: 
hidden: false
draft: false
weight: 6
description: 本文记录了手写高斯牛顿法及使用非线性优化库的相关实验。
---

## Guass Newton
考虑曲线拟合问题，使用加权非线性最小二乘法

代码如下：

```cpp
#include <Eigen/Core>
#include <Eigen/Dense>
#include <chrono>
#include <iostream>
#include <vector>
#include <opencv2/opencv.hpp>

using namespace std;
using namespace Eigen;

int main(int argc, char **argv){
    double ar = 1.0, br = 2.0, cr = 1.0;    // 真实参数值
    double ae = 2.0, be = -1.0, ce = 5.0;   // 估计参数值
    int N = 100;                            // 数据点
    double w_sigma = 1.0;                   // 噪声标准差
    double inv_sigma = 1.0 / w_sigma;       // 噪声标准差的倒数
    cv::RNG rng;                            // 随机数产生器

    vector<double> x_data, y_data;          // 拟合数据
    for (int i = 0; i < N; i++){
        double x = i / 100.0;
        x_data.push_back(x);
        // 生成带噪声的数据
        y_data.push_back(exp(ar * x * x + br * x + cr) + rng.gaussian(w_sigma * w_sigma));
    }

    // 开始Gauss-Newton迭代
    int iterations = 100;                   // 迭代次数
    double cost = 0, lastCost = 0;          // 本次迭代的代价和上一次迭代的代价

    chrono::steady_clock::time_point t1 = chrono::steady_clock::now();
    for (int iter = 0; iter < iterations; iter++){
        Matrix3d H = Matrix3d::Zero(); // Hessian = J^T W^{-1} J in Gauss-Newton
        Vector3d b = Vector3d::Zero(); // 偏置向量 bias
        cost = 0;

        for (int i = 0; i < N; i++){
            double xi = x_data[i], yi = y_data[i];  // 第i个数据点
            double error = yi - exp(ae * xi * xi + be * xi + ce);
            Vector3d J; // 雅可比矩阵
            J(0) = -xi * xi * exp(ae * xi * xi + be * xi + ce); // de/da
            J(1) = -xi * exp(ae * xi * xi + be * xi + ce);      // de/db
            J(2) = -exp(ae * xi * xi + be * xi + ce);           // de/dc

            // 构建 Hessian 矩阵和偏置向量 b
            // 这里 W^{-1} 是标量，因此可以约去
            H += inv_sigma * inv_sigma * J * J.transpose();
            b += -inv_sigma * inv_sigma * error * J;

            cost += error * error;  // 累加当前的误差平方和
        }

        // 求解线性方程 Hx=b
        // 对于正定矩阵，使用LDL^T分解（cholesky 分解法的一种）
        Vector3d dx = H.ldlt().solve(b);
        if (isnan(dx[0])){
            cout << "result is nan!" << endl;
            break;
        }

        // 如果当前迭代的代价大于等于上一次迭代的代价，则终止迭代
        if (iter > 0 && cost >= lastCost){
            cout << "cost: " << cost << ">= last cost: " << lastCost << ", break." << endl;
            break;
        }

        // 更新估计后的参数值
        ae += dx[0];
        be += dx[1];
        ce += dx[2];

        // 更新上一次迭代的代价
        lastCost = cost;

        // 输出当前迭代的总代价和更新后的参数
        cout << "total cost: " << cost << ", \t\tupdate: " << dx.transpose() << "\t\testimated params: " << ae << ","
             << be << "," << ce << endl;
    }

    chrono::steady_clock::time_point t2 = chrono::steady_clock::now(); // 记录结束时间
    chrono::duration<double> time_used = chrono::duration_cast<chrono::duration<double>>(t2 - t1);
    cout << "solve time cost = " << time_used.count() << " seconds. " << endl;
    // 输出最终估计的参数值
    cout << "estimated abc = " << ae << ", " << be << ", " << ce << endl;
    return 0;
}

```

## Ceres Solver
步骤如下：
1. 构建最小二乘问题 `ceres::Problem problem`
   1. 创建代价函数的计算模型，可以是 `struct` 或 `class`
   2. 向问题中添加误差项 `problem.AddResidualBlock`
   3. 描述代价函数的微分，指定代价函数的类型、残差维度、参数维度等
2. 构建求解器 `ceres::Solver`
   1. 配置求解器的选项 `ceres::Solver::Options options`
   2. 声明求解器的摘要 `ceres::Solver::Summary summary`
3. 执行优化 `ceres::solve(options,&problem,&summary)`
代码如下：

```cpp
#include <ceres/ceres.h>
#include <chrono>
#include <iostream>
#include <opencv2/core/core.hpp>

using namespace std;

// 代价函数的计算模型
struct CURVE_FITTING_COST {
    CURVE_FITTING_COST(double x, double y) : _x(x), _y(y) {}

    // 残差的计算
    // 声明模板；abc是指向待估计参数的预测值的指针，residual是指向残差的指针
    // 该 operator 将在 ceres 库的内部被调用
    template <typename T>
    bool operator()(const T * const abc, T * residual) const{
        // 使用 ceres 提供的模板化指数函数，否则无法用 ceres 优化
        // 使用强制类型转换
        residual[0] = T(_y) - ceres::exp(abc[0] * T(_x) * T(_x) + abc[1] * T(_x) + abc[2]);
        // y - exp(ax^2 + bx + c)
        // Ceres 要求 operator() 返回一个 bool 值，以指示计算是否成功。
        return true;
    }

    // 类的属性包括 x, y 数据
    const double _x, _y;
};

int main(int argc, char **argv)
{
    double ar = 1.0, br = 2.0, cr = 1.0;  // 真实参数值
    double ae = 2.0, be = -1.0, ce = 5.0; // 估计参数值
    int N = 100;                          // 数据点数量
    double w_sigma = 1.0;                 // 噪声的标准差
    double inv_sigma = 1.0 / w_sigma;
    cv::RNG rng; // OpenCV随机数产生器

    vector<double> x_data, y_data; // 数据
    for (int i = 0; i < N; i++)
    {
        double x = i / 100.0;
        x_data.push_back(x);
        // 生成带有噪声的y数据
        y_data.push_back(exp(ar * x * x + br * x + cr) + rng.gaussian(w_sigma * w_sigma));
    }

    double abc[3] = {ae, be, ce}; // 待估计的参数
    // 也可以用 Eigen 的 Vector3d 作为参数
    // Vector3d abc;
    // abc << ae, be, ce;

    // 构建最小二乘问题
    ceres::Problem problem;
    for (int i = 0; i < N; i++){
        // 向问题中添加误差项
        problem.AddResidualBlock( 
            // 使用自动微分代价函数进行自动求导，或者也可以使用其他方法
            // 模板参数：误差类型，输出维度，输入维度，维数要与前面struct中一致
            // 1. 自动求导 Auto Diff
            // 2. 数值求导 Numeric Diff
            // 3. 自行推导解析的导数形式
            new ceres::AutoDiffCostFunction<CURVE_FITTING_COST, 1, 3>(new CURVE_FITTING_COST(x_data[i], y_data[i])),
            nullptr,// 核函数，这里不使用，为空
            abc     // 待估计参数
            // abc.data()  // 使用 Eigen 的 data() 方法获取指向数据的指针
        );
    }

    // 配置求解器
    ceres::Solver::Options options;                             // 这里有很多配置项可以填
    options.linear_solver_type = ceres::DENSE_NORMAL_CHOLESKY;  // 增量方程使用 cholesky 分解
    // 1. DENSE_QR
    // 2. DENSE_NORMAL_CHOLESKY
    options.minimizer_progress_to_stdout = true;                // 输出到 cout

    ceres::Solver::Summary summary; // 优化信息
    chrono::steady_clock::time_point t1 = chrono::steady_clock::now(); // 记录起始时间
    ceres::Solve(options, &problem, &summary); // 开始优化
    chrono::steady_clock::time_point t2 = chrono::steady_clock::now(); // 记录结束时间
    chrono::duration<double> time_used = chrono::duration_cast<chrono::duration<double>>(t2 - t1); // 计算总耗时
    cout << "solve time cost = " << time_used.count() << " seconds. " << endl;

    // 输出结果
    cout << summary.BriefReport() << endl; // 输出优化摘要
    cout << "estimated a,b,c = ";
    for (auto a : abc)
        cout << a << " ";
    cout << endl;
    // 使用 Eigen 时
    // cout << "estimated a,b,c = " << abc.transpose() << endl;

    return 0;
}

```

## G2O
G2O 是通用的图优化库，图优化是将非线性优化与图论结合起来的理论。

图是图论意义上的图，由若干个顶点和边组成，顶点表示的是优化变量，边表示的是误差项，因此对于非线性最小二乘问题，都可以构建与之对应的图，或称**贝叶斯图**、**因子图**。

G2O 可选依赖于 `suitesparse` 和 `cxsparse` 。

步骤如下：
1. 定义顶点类，表示优化问题中的参数，继承自 `g2o::BaseVertex`，重写其虚函数
   1. 重置顶点的估计值 `void setToOriginImpl()`
   2. 更新顶点的估计值 `void oplusImpl(const double *update)`
2. 定义边类，表示误差项，它可以连接一个或多个顶点，继承自一元边 `g2o::BaseUnaryEdge` 或二元边 `g2o::BaseBinaryEdge` 或多元边 `BaseMultiEdge`
   1. 计算误差 `void computeError()`
   2. 计算雅可比矩阵 `void linearizeOplus()`
3. 构建优化问题
   1. 创建g2o图模型，设置求解器
   2. 向图中添加顶点和边
   3. 执行优化

代码如下：

```cpp
#include <iostream>
#include <opencv2/core/core.hpp>
#include <chrono>
#include <cmath>
#include <Eigen/Core>
#include <g2o/core/base_unary_edge.h>
#include <g2o/core/base_vertex.h>
#include <g2o/core/block_solver.h>
#include <g2o/core/g2o_core_api.h>
#include <g2o/core/optimization_algorithm_dogleg.h>
#include <g2o/core/optimization_algorithm_gauss_newton.h>
#include <g2o/core/optimization_algorithm_levenberg.h>
#include <g2o/solvers/dense/linear_solver_dense.h>

using namespace std;
// 曲线模型的顶点类，优化变量
// 模板参数：优化变量维度和数据类型
class CurveFittingVertex : public g2o::BaseVertex<3, Eigen::Vector3d>{
public:
    EIGEN_MAKE_ALIGNED_OPERATOR_NEW

    // 重置顶点的估计值
    // `virtual` 关键字可以省略，因为这是在派生类中重写基类的函数，但是加上则有助于可读和维护；
    virtual void setToOriginImpl() override { 
        _estimate << 0, 0, 0; 
    }

    // 更新顶点的估计值
    virtual void oplusImpl(const double *update) override { 
        _estimate += Eigen::Vector3d(update); 
    }

    // 存盘和读盘：留空
    virtual bool read(istream &in) {}

    virtual bool write(ostream &out) const {}
};

// 曲线模型的边类，误差模型 
// 模板参数：观测值维度，类型，连接顶点类型
class CurveFittingEdge : public g2o::BaseUnaryEdge<1, double, CurveFittingVertex>{
public:
    EIGEN_MAKE_ALIGNED_OPERATOR_NEW

    CurveFittingEdge(double x) : BaseUnaryEdge(), _x(x) {}

    // 计算曲线模型误差
    virtual void computeError() override{
        const CurveFittingVertex *v = static_cast<const CurveFittingVertex *>(_vertices[0]);
        const Eigen::Vector3d abc = v->estimate();
        _error(0, 0) = _measurement - std::exp(abc(0, 0) * _x * _x + abc(1, 0) * _x + abc(2, 0));
    }

    // 计算雅可比矩阵，微分部分
    virtual void linearizeOplus() override
    {
        const CurveFittingVertex *v = static_cast<const CurveFittingVertex *>(_vertices[0]);
        const Eigen::Vector3d abc = v->estimate();
        double y = exp(abc[0] * _x * _x + abc[1] * _x + abc[2]);
        _jacobianOplusXi[0] = -_x * _x * y;
        _jacobianOplusXi[1] = -_x * y;
        _jacobianOplusXi[2] = -y;
    }

    virtual bool read(istream &in) {}

    virtual bool write(ostream &out) const {}

public:
    double _x; // x 值， y 值为 _measurement
};

int main(int argc, char **argv)
{
    double ar = 1.0, br = 2.0, cr = 1.0;    // 真实参数值
    double ae = 2.0, be = -1.0, ce = 5.0;   // 估计参数值
    int N = 100;                            // 数据点
    double w_sigma = 1.0;                   // 噪声的标准差
    double inv_sigma = 1.0 / w_sigma;       // 噪声的标准差的倒数
    cv::RNG rng;                            // OpenCV随机数产生器

    vector<double> x_data, y_data;          // 数据
    for (int i = 0; i < N; i++){
        double x = i / 100.0;
        x_data.push_back(x);
        y_data.push_back(exp(ar * x * x + br * x + cr) + rng.gaussian(w_sigma * w_sigma));
    }

    // 构建图优化
    // 先设定g2o
    // 每个误差项优化变量维度为3，误差值维度为1
    typedef g2o::BlockSolver<g2o::BlockSolverTraits<3, 1>> BlockSolverType;
    // 线性求解器类型
    typedef g2o::LinearSolverDense<BlockSolverType::PoseMatrixType> LinearSolverType; 

    // 梯度下降方法，可以从GN, LM, DogLeg 中选
    // solver 可选
    // 1. OptimizationAlgorithmGaussNewton
    // 2. OptimizationAlgorithmLevenberg
    // 3. OptimizationAlgorithmDogleg
    auto solver = new g2o::OptimizationAlgorithmGaussNewton(
        g2o::make_unique<BlockSolverType>(g2o::make_unique<LinearSolverType>()));
    g2o::SparseOptimizer optimizer; // 图模型
    optimizer.setAlgorithm(solver); // 设置求解器
    optimizer.setVerbose(true);     // 打开调试输出

    // 往图中增加顶点
    CurveFittingVertex *v = new CurveFittingVertex();
    v->setEstimate(Eigen::Vector3d(ae, be, ce));
    v->setId(0);
    optimizer.addVertex(v);

    // 往图中增加边
    for (int i = 0; i < N; i++){
        CurveFittingEdge *edge = new CurveFittingEdge(x_data[i]);
        edge->setId(i);
        // 顶点索引，顶点指针
        edge->setVertex(0, v);                      // 设置连接的顶点
        edge->setMeasurement(y_data[i]);            // 观测数值
        edge->setInformation(Eigen::Matrix<double, 1, 1>::Identity() * 1 /
                             (w_sigma * w_sigma));  // 信息矩阵：协方差矩阵之逆
        optimizer.addEdge(edge);
    }

    // 执行优化
    cout << "start optimization" << endl;
    chrono::steady_clock::time_point t1 = chrono::steady_clock::now();
    optimizer.initializeOptimization();
    optimizer.optimize(10);
    chrono::steady_clock::time_point t2 = chrono::steady_clock::now();
    chrono::duration<double> time_used = chrono::duration_cast<chrono::duration<double>>(t2 - t1);
    cout << "solve time cost = " << time_used.count() << " seconds. " << endl;

    // 输出优化值
    Eigen::Vector3d abc_estimate = v->estimate();
    cout << "estimated model: " << abc_estimate.transpose() << endl;

    return 0;
}

```