---
title: Eigen Exercise
authors: 
    - EndlessPeak
toc: true
date: 2023-11-16
featuredImage: 
hidden: false
draft: false
weight: 32
description: 本文记录了使用Eigen的相关实验。
---

## CMake Usage

`Eigen` 是用头文件组成的库，对于它的使用，有两种办法：

1.  理论上只需要引入头文件即可，见下面代码中的“直接引入”；
2.  按照官网说明和 `cmake` 规范，依次 `find_package` 并 `target_link_libraries`

下面提供了一些 `Eigen` 的 `cmake` 模板。

```cmake
cmake_minimum_required(VERSION 3.24)
project(eigen_example)

set(CMAKE_CXX_STANDARD 17)
find_package(Eigen3 REQUIRED)
# 直接引入的办法：
# include_directories("/usr/include/eigen3")

# 使用 include_directories 加入代码头文件
# 也可以用 target_include_directories
include_directories(
      "src/eigen_matrix"
      "src/argparse"
)

# 使用 file 递归加入代码文件
# 建议使用 add_executable 或 add_library 手动加入代码文件
file(GLOB_RECURSE SOURCES
      "src/*"
      "src/argparse/*"
      "src/eigen_matrix/*"
      )

add_executable(${PROJECT_NAME} ${SOURCES})
# 方法一：直接使用 Eigen3::Eigen
target_link_libraries(${PROJECT_NAME} 
    Eigen3::Eigen
)
# 方法二：使用 ${EIGEN3_INCLUDE_DIR} 加上 ${EIGEN3_LIBS}
target_include_directories(${PROJECT_NAME}
    PRIVATE #也可以使用 PUBLIC
    ${EIGEN3_INCLUDE_DIR}
)
target_link_libraries(${PROJECT_NAME}
    ${EIGEN3_LIBS}
)
```

下面提供了一些 `eigen` 的代码模板。

## Variable

变量的声明如下：

```cpp
// 变量表
// Eigen 中所有向量和矩阵都是Eigen::Matrix，它是一个模板类。它的前三个参数为：数据类型，行，列
Eigen::Matrix<float, 2, 3> matrix_f23;

// Eigen 通过 typedef 提供了许多内置类型，其底层是Eigen::Matrix
Eigen::Vector3d v_3d_1;
Eigen::Matrix<float, 3, 1> v_3f_1;

// Matrix3d 实质上是 Eigen::Matrix<double, 3, 3>
Eigen::Matrix3d matrix_d33 = Eigen::Matrix3d::Zero(); //初始化为0
// 如果不确定矩阵大小，可以使用动态大小的矩阵
Eigen::Matrix<double, Eigen::Dynamic, Eigen::Dynamic> matrix_dynamic;
// 或者更简单的方式
Eigen::MatrixXd matrix_x;

clock_t time_stt;
```


## Initialize

初始化部分代码如下：

```cpp
// 下面是对Eigen阵的操作
// 输入数据（初始化）
matrix_f23 << 1, 2, 3, 4, 5, 6;
// 输出
std::cout << "matrix 2x3 from 1 to 6: \n" << matrix_f23 << "\n";

// 用()访问矩阵中的元素
std::cout << "print matrix 2x3: " << "\n";
for (int i = 0; i < 2; i++) {
    for (int j = 0; j < 3; j++)
        std::cout << matrix_f23(i, j) << "\t";
    std::cout << "\n";
}
```


## Mutiplication

矩阵与向量相乘代码如下：

```cpp
// 矩阵和向量相乘（实际上仍是矩阵和矩阵）
v_3d_1 << 3, 2, 1;
v_3f_1 << 4, 5, 6;

// 但是在Eigen里你不能混合两种不同类型的矩阵，这样是错的
// Eigen::Matrix<double, 2, 1> result_wrong_type = matrix_f23 * v_3d_1;
// 应该显式转换
Eigen::Matrix<double, 2, 1> result = matrix_f23.cast<double>() * v_3d_1;
std::cout << "[1,2,3;4,5,6]*[3,2,1]=" << result << "\n";
// transpose 代表转置
std::cout << "[1,2,3;4,5,6]*[3,2,1]=" << result.transpose() << "\n";

Eigen::Matrix<float, 2, 1> result2 = matrix_f23 * v_3f_1;
std::cout << "[1,2,3;4,5,6]*[4,5,6]: " << result2 << "\n";
std::cout << "[1,2,3;4,5,6]*[4,5,6]: " << result2.transpose() << "\n";

// 同样你不能搞错矩阵的维度
// 试着取消下面的注释，看看Eigen会报什么错
// Eigen::Matrix<double, 2, 3> result_wrong_dimension = matrix_23.cast<double>() * v_3d_1;
```


## Operation

矩阵运算与操作代码如下：

```cpp
// 四则运算直接用+-*/即可。

// 生成随机数矩阵
matrix_d33 = Eigen::Matrix3d::Random();
// 显示矩阵
std::cout << "random matrix: \n" << matrix_d33 << "\n";
// 转置
std::cout << "transpose: \n" << matrix_d33.transpose() << "\n";
// 各元素和
std::cout << "sum: " << matrix_d33.sum() << "\n";
// 迹
std::cout << "trace: " << matrix_d33.trace() << "\n";
// 数乘
std::cout << "times 10: \n" << 10 * matrix_d33 << "\n";
// 逆
std::cout << "inverse: \n" << matrix_d33.inverse() << "\n";
// 行列式
std::cout << "det: " << matrix_d33.determinant() << "\n";

```


## Matrix values & vectors

矩阵的特征值与特征向量代码如下：

```cpp
// 实对称矩阵可以保证对角化成功
// A^T*A 一定是实对称矩阵
Eigen::SelfAdjointEigenSolver<Eigen::Matrix3d> eigen_solver(matrix_d33.transpose() * matrix_d33);
// 特征值
std::cout << "Eigen values = \n" << eigen_solver.eigenvalues() << "\n";
// 特征向量
std::cout << "Eigen vectors = \n" << eigen_solver.eigenvectors() << "\n";

```


## Matrix inverse

矩阵求逆的三种方法：
1. 直接求逆
2. 矩阵分解 QR 分解
3. 正定矩阵 cholesky 分解

```cpp
// 直接求逆法
int matrix_equation_direct(Eigen::Matrix<double, MATRIX_SIZE, 1> &x,const Eigen::Matrix<double, MATRIX_SIZE, MATRIX_SIZE> &matrix_NN,const Eigen::Matrix<double,MATRIX_SIZE,1> &v_Nd) {
    time_stt = clock(); // 计时
    x = matrix_NN.inverse() * v_Nd;
    std::cout << "time of normal inverse is "
              << (double) (1000 * (clock() - time_stt)) / (double) CLOCKS_PER_SEC << "ms" << "\n";
    return 0;
}

// 矩阵分解法，通常用此方法来求解，例如QR分解，速度会快很多
int matrix_equation_qr(Eigen::Matrix<double, MATRIX_SIZE, 1> &x,const Eigen::Matrix<double, MATRIX_SIZE, MATRIX_SIZE> &matrix_NN,const Eigen::Matrix<double,MATRIX_SIZE,1> &v_Nd) {
    time_stt = clock();
    x = matrix_NN.colPivHouseholderQr().solve(v_Nd);
    std::cout << "time of Qr decomposition is "
              << (double)(1000 * (clock() - time_stt)) / (double) CLOCKS_PER_SEC << "ms" << "\n";
    return 0;
}

// cholesky分解法
// 对于正定矩阵，还可以用cholesky分解来解方程
int matrix_equation_cholesky(Eigen::Matrix<double, MATRIX_SIZE, 1> &x,const Eigen::Matrix<double, MATRIX_SIZE, MATRIX_SIZE> &matrix_NN,const Eigen::Matrix<double,MATRIX_SIZE,1> &v_Nd) {
    time_stt = clock();
    x = matrix_NN.ldlt().solve(v_Nd);
    std::cout << "time of ldlt decomposition is "
              << (double)(1000 * (clock() - time_stt)) / (double) CLOCKS_PER_SEC << "ms" << "\n";
    return 0;
}
```


## Matrix Equation
解矩阵方程代码如下：

```cpp
// 解矩阵方程
int matrix_equation() {
    // 我们求解 matrix_NN * x = v_Nd 这个方程
    // N的大小在前边的宏里定义，它由随机数生成
    // 直接求逆自然是最直接的，但是求逆运算量大

    //Eigen::Matrix<double, MATRIX_SIZE, MATRIX_SIZE> matrix_NN
    //        = Eigen::MatrixXd::Random(MATRIX_SIZE, MATRIX_SIZE);
    Eigen::Matrix<double, MATRIX_SIZE, MATRIX_SIZE> matrix_NN
            = Eigen::Matrix<double, MATRIX_SIZE, MATRIX_SIZE>::Random();
    matrix_NN = matrix_NN * matrix_NN.transpose();  // 保证半正定
    Eigen::Matrix<double, MATRIX_SIZE, 1> v_Nd = Eigen::MatrixXd::Random(MATRIX_SIZE, 1);

    Eigen::Matrix<double, MATRIX_SIZE, 1> x{Eigen::Matrix<double,MATRIX_SIZE,1>::Random()};
    matrix_equation_direct(x,matrix_NN,v_Nd);
    std::cout << "x = " << x.transpose() << "\n";
    matrix_equation_qr(x,matrix_NN,v_Nd);
    std::cout << "x = " << x.transpose() << "\n";
    matrix_equation_cholesky(x,matrix_NN,v_Nd);
    std::cout << "x = " << x.transpose() << "\n";
    return 0;
}
```

## Homogeneous Computation
为了实现计算 $\mathbf{Ta}$ 时使用齐次坐标，计算 $\mathbf{Ra}$ 时使用非齐次坐标，可以使用以下办法：

1. 实现齐次坐标矩阵与非齐次坐标矩阵之间的转换
2. 实现运算符重载

假设实现旋转和平移的矩阵叫作 SE3，则代码如下：

```c++
#include <iostream>
#include <Eigen/Dense>

class SE3 {
public:
    Eigen::Matrix3d rotation_matrix;
    Eigen::Vector3d translation_matrix;
    Eigen::Matrix4d homogeneous_matrix;

    SE3() {
        rotation_matrix = Eigen::Matrix3d::Identity();
        translation_matrix = Eigen::Vector3d::Zero();
        homogeneous_matrix = Eigen::Matrix4d::Identity();
    }

    SE3(const Eigen::Matrix3d& R, const Eigen::Vector3d& t) {
        rotation_matrix = R;
        translation_matrix = t;
        to_homogeneous_matrix();
    }

    // 转为齐次坐标矩阵
    // 该函数不能为 const，因为他会修改成员变量
    void to_homogeneous_matrix() {
        homogeneous_matrix = Eigen::Matrix4d::Identity();
        homogeneous_matrix.block<3, 3>(0, 0) = rotation_matrix;
        homogeneous_matrix.block<3, 1>(0, 3) = translation_matrix;
    }

    // 与三维向量相乘
    Eigen::Vector3d operator*(const Eigen::Vector3d& vec) const {
        return rotation_matrix * vec + translation_matrix;
    }

    // 与四维齐次向量相乘
    Eigen::Vector4d operator*(const Eigen::Vector4d& vec) const {
        return homogeneous_matrix * vec;
    }

    friend std::ostream& operator<<(std::ostream& os, const SE3& se3) {
        os << "Rotation:\n" << se3.rotation_matrix << "\n";
        os << "Translation:\n" << se3.translation_matrix.transpose() << "\n";
        os << "Homogeneous Matrix:\n" << se3.homogeneous_matrix << "\n";
        return os;
    }
};

int main() {
    // 定义一个旋转矩阵 (SO(3))
    Eigen::Matrix3d R = Eigen::AngleAxisd(M_PI / 4, Eigen::Vector3d::UnitZ()).toRotationMatrix();

    // 定义一个平移向量
    Eigen::Vector3d t(1, 2, 3);

    // 创建一个 SE3 对象
    SE3 se3(R, t);

    // 打印 SE3 对象
    std::cout << se3 << std::endl;

    // 定义一个三维向量
    Eigen::Vector3d a(4, 5, 6);
    // 使用非齐次坐标相乘
    Eigen::Vector3d result_non_homogeneous = se3 * a;
    std::cout << "Result (non-homogeneous):\n" << result_non_homogeneous << std::endl;

    // 定义一个四维齐次向量
    Eigen::Vector4d a_homogeneous(4, 5, 6, 1);
    // 使用齐次坐标相乘
    Eigen::Vector4d result_homogeneous = se3 * a_homogeneous;
    std::cout << "Result (homogeneous):\n" << result_homogeneous << std::endl;

    return 0;
}
```