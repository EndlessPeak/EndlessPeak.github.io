---
title: Non linear Optimize
authors: 
    - EndlessPeak
toc: true
date: 2024-06-01
featuredImage: 
hidden: false
draft: false
weight: 7
description: 本文记录了非线性优化的相关内容。
---

## Matrix Derivative
下面介绍矩阵求导的相关内容。

矩阵和向量求导是批量求导数的一种方式，其本质上还是矩阵或向量中的标量在求导，只是借助矩阵或者向量的形式，同时对多个因变量进行关于自变量的求导。

矩阵求导的类型如下表所示：
<style>
    table {
        width: 100%;
        border-collapse: collapse;
    }
    th, td {
        padding: 10px;
        text-align: center;
        height: 60px; /* Adjust the font size as needed */
        vertical-align: middle; /* Ensure text is vertically centered */
        font-size: 15px; /* Adjust the font size as needed */
    }
</style>
<table>
  <thead>
    <tr>
      <th>Types</th>
      <th>Scalar</th>
      <th>Vector</th>
      <th>Matrix</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Scalar</td>
      <td>$\frac{\partial y}{\partial x}$</td>
      <td>\(\frac{\partial \mathbf{y}}{\partial x}\)</td>
      <td>\(\frac{\partial \mathbf{Y}}{\partial x}\)</td>
    </tr>
    <tr>
      <td>Vector</td>
      <td>$\frac{\partial y}{\partial \mathbf{x}}$</td>
      <td>\(\frac{\partial \mathbf{y}}{\partial \mathbf{x}}\)</td>
      <td></td>
    </tr>
    <tr>
      <td>Matrix</td>
      <td>$\frac{\partial y}{\partial \mathbf{X}}$</td>
      <td></td>
      <td></td>
    </tr>
  </tbody>
</table>

### Derivative of a scalar with respect to a vector
标量对向量求导。

假设我们有一个标量值函数 \( f(\mathbf{x}) \)，其中 \(\mathbf{x} = [x_1, x_2, \ldots, x_n]^T\) 是一个 \( n \) 维向量。标量对向量的导数结果是一个行向量（梯度），表示为：
$$
\nabla_{\mathbf{x}} f = \frac{\partial f}{\partial \mathbf{x}} = \begin{bmatrix}
\frac{\partial f}{\partial x_1} & \frac{\partial f}{\partial x_2} & \cdots & \frac{\partial f}{\partial x_n}
\end{bmatrix}^T 
$$

### Derivative of a vector with respect to a scalar
向量对标量求导。

假设我们有一个向量值函数 \(\mathbf{f}(x)\)，其中 \(\mathbf{f} = [f_1(x), f_2(x), \ldots, f_m(x)]^T\)，而 \( x \) 是一个标量。向量对标量的导数结果是一个列向量，表示为：
$$ 
\frac{d \mathbf{f}}{d x} = \begin{bmatrix}
\frac{d f_1}{d x} \\
\frac{d f_2}{d x} \\
\vdots \\
\frac{d f_m}{d x}
\end{bmatrix} 
$$

### Derivative of a vector with respect to a vector
假设我们有一个向量值函数 \(\mathbf{f}(\mathbf{x})\)，其中 \(\mathbf{f}\) 是 \( \mathbb{R}^n \to \mathbb{R}^m \) 的函数，\(\mathbf{f}(\mathbf{x}) = [f_1(\mathbf{x}), f_2(\mathbf{x}), \ldots, f_m(\mathbf{x})]^T\)，而 \(\mathbf{x} = [x_1, x_2, \ldots, x_n]^T\) 是一个 \( n \) 维向量。

列向量 \(\mathbf{f}(\mathbf{x})\) 对行向量 \(\mathbf{x}\) 的导数是**雅可比矩阵（Jacobian matrix）**，定义如下：
$$
\frac{\partial \mathbf{f}}{\partial \mathbf{x}^T}=
\begin{bmatrix}
\frac{\partial f_1}{\partial \mathbf{x}^T} \\
\frac{\partial f_2}{\partial \mathbf{x}^T} \\
\vdots \\
\frac{\partial f_m}{\partial \mathbf{x}^T}
\end{bmatrix}=
\begin{bmatrix}
\frac{\partial f_1}{\partial x_1} & \frac{\partial f_1}{\partial x_2} & \cdots & \frac{\partial f_1}{\partial x_n} \\
\frac{\partial f_2}{\partial x_1} & \frac{\partial f_2}{\partial x_2} & \cdots & \frac{\partial f_2}{\partial x_n} \\
\vdots & \vdots & \ddots & \vdots \\
\frac{\partial f_m}{\partial x_1} & \frac{\partial f_m}{\partial x_2} & \cdots & \frac{\partial f_m}{\partial x_n}
\end{bmatrix} 
$$

> 这是雅可比矩阵的分子分布，还有一种是分母分布，即行向量对列向量求导得到的，结果是以上雅可比矩阵的转置。

这个矩阵的第 $i$ 行第 $j$ 列的元素是函数 $ f_i $ 对变量 $ x_j $ 的偏导数。换句话说，雅可比矩阵的每一行对应于向量值函数的一个分量对所有变量的偏导数组成的行向量。

对于一个具体的例子，假设 $\mathbf{f}(\mathbf{x})$ 是一个二维向量值函数：
$$ 
\mathbf{f}(\mathbf{x}) = \begin{bmatrix} f_1(x_1, x_2) \\ f_2(x_1, x_2) \end{bmatrix} 
$$
则雅可比矩阵为：
$$
\mathbf{J} = 
\frac{\partial \mathbf{f}}{\partial \mathbf{x}^T} = 
\begin{bmatrix} 
\frac{\partial f_1}{\partial x_1} & \frac{\partial f_1}{\partial x_2} \\ 
\frac{\partial f_2}{\partial x_1} & \frac{\partial f_2}{\partial x_2} 
\end{bmatrix} 
$$

这是向量对向量求导的公式和方法。

### Derivative of a matrix with respect to a vector

### Key Derivative
下面介绍几个重点导数：

假设我们有两个向量 \(\mathbf{a}\) 和 \(\mathbf{x}\)，其中 \(\mathbf{a} = [a_1, a_2, \ldots, a_n]^T\) 和 \(\mathbf{x} = [x_1, x_2, \ldots, x_n]^T\)，则 $\frac{\partial \mathbf{a}\mathbf{x}}{\partial \mathbf{x}}$ 推导如下：

首先，向量 \(\mathbf{a}\) 和 \(\mathbf{x}\) 的内积定义为：
\[ f(\mathbf{x}) = \mathbf{a}^T \mathbf{x} = a_1 x_1 + a_2 x_2 + \cdots + a_n x_n \]
我们需要对 \(\mathbf{x}\) 求导。根据向量微积分的定义，对 \(\mathbf{x}\) 求导时，每个分量 \(x_i\) 的偏导数是 \(a_i\)。因此，梯度（导数）可以表示为一个列向量：
$$ 
\nabla_{\mathbf{x}} (\mathbf{a}^T \mathbf{x}) = \begin{bmatrix}
\frac{\partial (\mathbf{a}^T \mathbf{x})}{\partial x_1} \\
\frac{\partial (\mathbf{a}^T \mathbf{x})}{\partial x_2} \\
\vdots \\
\frac{\partial (\mathbf{a}^T \mathbf{x})}{\partial x_n}
\end{bmatrix} = \begin{bmatrix}
a_1 \\
a_2 \\
\vdots \\
a_n
\end{bmatrix} = \mathbf{a}
$$
因此，向量 \(\mathbf{a}\) 和 \(\mathbf{x}\) 的内积对 \(\mathbf{x}\) 的导数结果是向量 \(\mathbf{a}\) 本身。

---
假设 $x$ 是一个 $n \times 1$ 的列向量，$A$ 是一个 $n \times n$的对称矩阵，则 $\frac{\partial x^TAx}{\partial x}$ 推导如下：

1.  展开 $x^TAx$:
    $$
    x^TAx=\sum_{i=1}^{n}\sum_{j=1}^{n}x_iA_{ij}x_j
    $$
    其中 $x_i$ 是 $x$ 的第 $i$ 个分量，$A_{ij}$ 是 $A$ 的第 $i$ 行第 $j$ 列的元素。

2.  对 $x_k$ 求导：
    $$
       \frac{\partial }{\partial x} \left ( \sum_{i=1}^{n} \sum_{j=1}^{n} x_i A_{ij} x_j \right ) = \sum_{i=1}^n\sum_{j=1}^n \frac{\partial }{\partial x_k}(x_i A_{ij} x_j)
    $$

3.  考虑每一项 $x_i A_{ij} x_j$ 的导数：
    $$
    \frac{\partial}{\partial x_k} \left ( x_i A_{ij} x_j \right ) = \delta_{ik} A_{ij} x_j + x_i A_{ij} \delta_{jk}
    $$

    其中 $\delta_{ik}$ 和 $\delta_{jk}$ 是克罗内克 $delta$ 函数，当且仅当 $i=k$ 或 $j=k$ 时其值为 1，否则为 0。

4.  非零项的和为：
    $$
    \sum_{i=1}^{n} \sum_{j=1}^{n} (\delta_{ik} A_{ij} x_j + x_i A_{ij} \delta_{jk})=\sum_{j=1}^{n}A_{kj}x_j + \sum_{i=1}^{n}x_iA_{ik}
    $$

5.  由于 $A$ 是对称的，即 $A_{ij}=A_{ji}$ ，所以：
    $$
    \sum_{j=1}^{n}A_{kj}x_j + \sum_{i=1}^{n}x_iA_{ik} = \sum_{j=1}^{n}A_{kj}x_j + \sum_{j=1}^{n}x_jA_{jk} =
    2\sum_{j=1}^{n}A_{kj}x_j
    $$

    相当于：
    $$
    \frac{\partial}{\partial x_k}(x^TAx)=2(Ax)_k
    $$

6.  因此向量形式的求导结果是：
    $$
    \frac{\partial}{\partial x}(x^TAx)=2Ax
    $$

---
不失一般性，若 $A$ 不是对称矩阵，则推导如下：
考虑函数的微分形式：

\[ df = d(\mathbf{x}^T \mathbf{A} \mathbf{x}) \]

根据微分的性质：

\[ d(\mathbf{x}^T \mathbf{A} \mathbf{x}) = (\mathbf{d x})^T \mathbf{A} \mathbf{x} + \mathbf{x}^T \mathbf{A} (\mathbf{d x}) \]

这可以进一步简化为：

\[ df = (\mathbf{d x})^T \mathbf{A} \mathbf{x} + \mathbf{x}^T \mathbf{A} (\mathbf{d x}) \]

注意到 \((\mathbf{d x})^T \mathbf{A} \mathbf{x}\) 是一个标量，等于它的转置，即：

\[ (\mathbf{d x})^T \mathbf{A} \mathbf{x} = (\mathbf{x}^T \mathbf{A}^T \mathbf{d x})^T = \mathbf{d x}^T \mathbf{A}^T \mathbf{x} \]

因此我们有：

\[ df = (\mathbf{d x})^T \mathbf{A} \mathbf{x} + (\mathbf{d x})^T \mathbf{A}^T \mathbf{x} = (\mathbf{d x})^T (\mathbf{A} + \mathbf{A}^T) \mathbf{x} \]

由此可以看出：

\[ \frac{\partial (\mathbf{x}^T \mathbf{A} \mathbf{x})}{\partial \mathbf{x}} = (\mathbf{A} + \mathbf{A}^T) \mathbf{x} \]

如果 \(\mathbf{A}\) 是对称矩阵：

\[ \frac{\partial (\mathbf{x}^T \mathbf{A} \mathbf{x})}{\partial \mathbf{x}} = 2 \mathbf{A} \mathbf{x} \]

如果 \(\mathbf{A}\) 不是对称矩阵：

\[ \frac{\partial (\mathbf{x}^T \mathbf{A} \mathbf{x})}{\partial \mathbf{x}} = (\mathbf{A} + \mathbf{A}^T) \mathbf{x} \]

## Least Squares Introduce
接下来探讨为什么SLAM问题中使用优化方法时需要引入最小二乘。

在SLAM（Simultaneous Localization and Mapping，即时定位与地图构建）中，最小二乘法是用于优化的问题解决方法之一。我们需要从SLAM中的条件概率分布出发，通过后验概率分布的最大化，再到最大似然估计，最终引出最小二乘的使用。

### Conditional Probability Distribution
在SLAM中，我们需要估计机器人在环境中的位置和地图，这可以表示为状态变量 $\mathbf{x}$（包括机器人的位置和地图的所有特征）。SLAM问题可以描述为在给定所有观测数据 $\mathbf{z}$ 和运动数据 $\mathbf{u}$ 的条件下，求状态变量 $\mathbf{x}$ 的概率分布：

$$
p(\mathbf{x} \mid \mathbf{z}, \mathbf{u})
$$

### Posterior Probability Distribution
我们希望找到最有可能的状态变量 $\mathbf{x}$，即后验概率最大的状态。这涉及最大化上述条件概率分布。根据贝叶斯公式，后验概率可以表示为：
$$
p(\mathbf{x} \mid \mathbf{z}, \mathbf{u}) = \frac{p(\mathbf{z}, \mathbf{u} \mid \mathbf{x}) p(\mathbf{x})}{p(\mathbf{z}, \mathbf{u})} \propto p(\mathbf{z},\mathbf{u} \mid \mathbf{x})p(\mathbf{x})
$$

其中，分母 $p(\mathbf{z}, \mathbf{u})$ 对于给定的观测和运动数据是一个常数。分子中左侧的 $p(\mathbf{z},\mathbf{u} \mid \mathbf{x})$ 代表似然，而 $p(\mathbf{x})$ 称为先验。

**直接求后验分布是困难的，但是求一个状态最优估计，使得在该状态下后验概率最大化，则是可行的。**

最大化后验概率 $p(\mathbf{x} \mid \mathbf{z}, \mathbf{u})$ 等价于最大化联合概率 $p(\mathbf{z}, \mathbf{u} \mid \mathbf{x}) p(\mathbf{x})$:
$$
\mathbf{x}_{\text{MAP}} = \arg\max_{\mathbf{x}} p(\mathbf{x} \mid \mathbf{z}, \mathbf{u}) = \arg\max_{\mathbf{x}} p(\mathbf{z}, \mathbf{u} \mid \mathbf{x}) p(\mathbf{x})
$$

### Maximum Likelihood Estimation
在许多情况下，先验概率 $p(\mathbf{x})$ 被假设为均匀分布或者对所有可能的状态 $\mathbf{x}$ 来说是相同的，或者我们可能没有关于状态变量 $\mathbf{x}$（例如机器人的位置或路标的位置）的先验知识。

此时，最大化后验概率就简化为最大化似然函数 $p(\mathbf{z}, \mathbf{u} \mid \mathbf{x})$ ，即最大似然估计（Maximum Likelihood Estimation, MLE）：
$$
\mathbf{x}_{\text{MLE}} = \arg\max_{\mathbf{x}} p(\mathbf{z}, \mathbf{u} \mid \mathbf{x})
$$

### Leads to Least Squares
为了实际进行计算，我们需要对似然函数 $p(\mathbf{z}, \mathbf{u} \mid \mathbf{x})$ 进行建模。常见的做法是将观测误差和运动误差建模为高斯分布。假设观测误差 $\mathbf{e}_{\mathbf{z}}$ 和运动误差 \(\mathbf{e}_\mathbf{u}\) 是独立的高斯分布，即：
 
$$
\mathbf{e}_{\mathbf{z}} \sim \mathcal{N}(0, \mathbf{R}) \quad \text{和} \quad \mathbf{e}_{\mathbf{u}} \sim \mathcal{N}(0, \mathbf{Q})
$$

其中 $\mathbf{R}$ 和 $\mathbf{Q}$ 分别是观测和运动误差的协方差矩阵。于是，似然函数可以表示为：
$$
p(\mathbf{z}, \mathbf{u} \mid \mathbf{x}) \propto \exp\left(-\frac{1}{2} \left( \mathbf{e}_{\mathbf{z}}^T \mathbf{R}^{-1} \mathbf{e}_{\mathbf{z}} + \mathbf{e}_{\mathbf{u}}^T \mathbf{Q}^{-1} \mathbf{e}_{\mathbf{u}} \right)\right)
$$

最大化这个似然函数等价于最小化其负对数似然函数：
$$
\mathbf{x}_{\text{MLE}} = \arg\min_{\mathbf{x}} \left( \mathbf{e}_{\mathbf{z}}^T \mathbf{R}^{-1} \mathbf{e}_{\mathbf{z}} + \mathbf{e}_{\mathbf{u}}^T \mathbf{Q}^{-1} \mathbf{e}_{\mathbf{u}} \right)
$$

这实际上就是一个加权最小二乘问题，因为我们在最小化误差的平方和。

## Least Squares Solution
### Introduce
考虑最简单的最小二乘问题：
$$
\min_x F(x)=\frac{1}{2} \| f(x) \|_2^2
$$

其中，自变量 $x \in \mathbb{R}^n$， $f$ 是任意标量非线性函数 $f(x): \mathbb{R}^n \to \mathbb{R}$ 。

当求解 
$$
\frac{\mathrm{d} y}{\mathrm{d} x}=0
$$
较为困难时，可以使用迭代的方式，从初始值出发，不断更新当前的优化变量，以令目标函数下降：

1. 给定初始值 $x_0$
2. 对于第 $k$ 次迭代，寻找增量 $\Delta x_k$，使得 \(\| f(x_k+\Delta x_k) \|_2^2\) 达到极小值
3. 若 $\Delta x_k$ 足够小，则停止
4. 否则，令 $x_{k+1}=x_k+\Delta x_k$，返回2

### Gradient Descent Method
考虑第 $k$ 次迭代，将目标函数 $F(x)$ 在 $x_k$ 处泰勒展开：
$$
F(x_k+\Delta x_k) \approx F(x_k) + \mathbf{J}(x_k)^T\Delta x_k + \frac{1}{2}\Delta x_k^T\mathbf{H}(x_k)\Delta x_k
$$

其中 $\mathbf{J}(x_k)$ 是 $F(x)$ 关于 $x$ 的一阶导数（或雅可比矩阵），而 $\mathbf{H}$ 是二阶导数（海塞Hessian矩阵）。

由于梯度是向量，自变量沿着该向量方向变化时，函数增长最快，因此保留一阶梯度时，取增量为反向的梯度保证函数下降：
$$
\Delta x^* = -\alpha \mathbf{J}(x_k)
$$

其中 $\alpha$ 是学习率或者步长，以上的方法称为最速下降法(Gradient Descent Method)。

### Newton Method
保留二阶梯度时，增量方程为 
$$
\Delta x^* = \arg\min \left ( F(x)+\mathbf{J}(x)^T\Delta x + \frac{1}{2}\Delta x^T\mathbf{H}\Delta x \right )
$$

设 
$$
G(\Delta x)=\mathbf{J}(x)^T\Delta x + \frac{1}{2}\Delta x^T\mathbf{H}\Delta x
$$ 

我们希望找到 $\Delta x$ 使得 $G(\Delta x)$ 最小。求解其关于 $\Delta x$ 的导数并令其为零，得到
$$
\mathbf{J}+\mathbf{H}\Delta x=0 \Rightarrow \mathbf{H}\Delta x=-\mathbf{J}
$$

最终得到
$$
\Delta x_k=-\mathbf{H}(x_k)^{-1}\mathbf{J}(x_k)
$$

该方法称为牛顿法。

### Derivative
对 $\Delta x$ 向量，$\frac{1}{2} \Delta x^T \mathbf{H} \Delta x$ 关于 $\Delta x$ 求导：

1.  由于 $\mathbf{H}$ 是 Hessian 矩阵，因此它是对称的
2.  根据
    $$
    \frac{\partial}{\partial x}(x^TAx)=2Ax
    $$
    其中，$A$ 是对称矩阵。

    我们有：
    $$
    \frac{\partial}{\partial x}(\frac{1}{2} x^T\mathbf{H}x)=\mathbf{H}x
    $$

### Gauss-Newton Method
高斯牛顿法用于求解非线性最小二乘问题，它的思想是将 $f(x)$ 进行一阶泰勒展开，注意是 $f(x)$ 不是目标函数 $F(x)$。
$$
f(x+\Delta x) \approx f(x) + J(x)^T \Delta x
$$

其中 $ J(x)^T $ 是 $f(x)$ 关于 $x$ 的雅可比矩阵。根据前面所述，目标是寻找增量 $\Delta x$ 使得 \( \| x+\Delta x \|^2\) 达到最小
$$
\begin{aligned}
\Delta x^*&=\| x+\Delta x \|^2 \\
&=\frac{1}{2} \| f(x_k) + J(x_k) \Delta x \|^2
\end{aligned}
$$

接下来，我们需要化简这个目标函数。首先展开并利用矩阵范数性质：
$$
\frac{1}{2} \| f(x_k) + J(x_k) \Delta x \|^2 = \frac{1}{2} (f(x_k) + J(x_k) \Delta x)^T (f(x_k) + J(x_k) \Delta x)
$$

展开内积：
$$
= \frac{1}{2} \left( f(x_k)^T f(x_k) + f(x_k)^T J(x_k) \Delta x + (\Delta x)^T J(x_k)^T f(x_k) + (\Delta x)^T J(x_k)^T J(x_k) \Delta x \right)
$$

注意到 $ f(x_k)^T J(x_k) \Delta x $ 和 $ (\Delta x)^T J(x_k)^T f(x_k) $ 是标量，且它们互为转置，因此相等：
$$
= \frac{1}{2} \left( f(x_k)^T f(x_k) + 2 f(x_k)^T J(x_k) \Delta x + (\Delta x)^T J(x_k)^T J(x_k) \Delta x \right)
$$

我们可以进一步简化：
$$
= \frac{1}{2} f(x_k)^T f(x_k) + f(x_k)^T J(x_k) \Delta x + \frac{1}{2} (\Delta x)^T J(x_k)^T J(x_k) \Delta x
$$

这个目标函数是关于 $ \Delta x $ 的二次函数。为了最小化它，我们对 $ \Delta x $ 求导并设导数为零：
$$
\nabla_{\Delta x} \left( \frac{1}{2} f(x_k)^T f(x_k) + f(x_k)^T J(x_k) \Delta x + \frac{1}{2} (\Delta x)^T J(x_k)^T J(x_k) \Delta x \right) = 0
$$

求导得到：
$$
J(x_k)^T f(x_k) + J(x_k)^T J(x_k) \Delta x = 0
$$

解得：
$$
\Delta x = - (J(x_k)^T J(x_k))^{-1} J(x_k)^T f(x_k)
$$

因此，高斯-牛顿法的迭代更新公式为：
$$
x_{k+1} = x_k + \Delta x = x_k - (J(x_k)^T J(x_k))^{-1} J(x_k)^T f(x_k)
$$

这个更新公式将新的迭代值 $ x_{k+1} $ 计算为当前迭代值 $ x_k $ 减去修正量 $\Delta x$，其中 $\Delta x$ 由雅可比矩阵 $ J(x_k) $ 和函数值 $ f(x_k) $ 计算得到。
