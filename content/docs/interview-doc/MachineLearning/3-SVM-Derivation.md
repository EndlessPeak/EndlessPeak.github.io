---
markup: pandoc
title: 支持向量机推导
authors:
  - EndlessPeak
toc: false
featuredImage: 
date: 2022-03-25
hidden: false
draft: false
weight: 3
---

## 目标综述

在特征空间中找到一**分离超平面**能将实例分到不同类。

当数据集**线性可分**时，有**无数个**分离超平面可将数据正确分开，支持向量机利用**间隔最大化**求解最优分离超平面，因此解是**唯一**的。

> 对训练集找到几何间隔最大的超平面意味着以充分大的确信度对训练数据进行分类。对最难分的实例点(离超平面最近的点)也有足够大的确信度将它们分开，对未知新实例有很好的分类预测能力。

通过拉格朗日对偶对原优化问题进行转化，使之更容易求解；

当数据集**线性不可分**时，通过非线性变换的过程将其转化为线性问题。非线性变换可将输入空间中的超曲面模型对应特征空间（希尔伯特空间）中的超平面模型，通过在特征空间中求解线性支持向量机完成输入空间分类问题的学习。

## 线性二分类模型

给定一组数据$(x_1,y_1),(x_2,y_2),⋯,(x_m,y_m)$，其中 $x_i \in R^d ,y \in \{-1,1\}$。

二分类任务的目标是希望从数据中学得一个假设函数$h:R \rightarrow \{-1,1\}$,使得 $h( x_ {1} )=y_ {i}$，即

$$
\begin{align}
h(x_ 1)=\begin{cases}+1 \quad y_{1}=+1;\\-1 \quad y_{1}=-1;\end{cases}
\end{align}
$$

更进一步，线性二分类模型认为假设函数的形式基于对特征$x_i$的线性组合，即

$$
h(x_i)=sign(\omega^T\cdot x_i+b) \quad \omega_i \in R^d,b \in R
$$

线性二分类模型的目标是找到一组合适的参数$(\omega,b)$, 使得

$$
∀i.y_i(w^Tx _i+b)>0
$$

## 线性硬间隔支持向量机

线性支持向量机是一种线性二分类模型，需要找到满足定理1约束的划分超平面, 即$(\omega,b)$。其中：

1. 参数$\omega$方向与超平面垂直，它是超平面的法向量。
2. 参数$b$代表的是超平面的偏置，决定超平面与原点间的距离。

进一步来说，SVM希望找到与各样本的间隔最大化的划分超平面。

### 间隔

间隔用来刻画点到分类超平面的距离，距离的远近程度可以用于度量分类的准确性或正确程度。

定义超平面到数据集的**函数间隔**为：
$$
\hat\gamma=\underset{1,2,...,m}{min}y_i(\omega\cdot x_i+b)
$$
定义超平面到数据集的**几何间隔**为：
$$
\gamma=\underset{1,2,...,m}{min}y_i(\frac{\omega}{\Vert\omega\Vert}\cdot x_i+\frac{b}{\Vert\omega\Vert})
$$
函数间隔和几何间隔的关系：$\gamma=\frac{\hat{\gamma}}{\Vert\omega\Vert}$

为什么这样定义函数间隔？

在超平面$\omega\cdot x+b=0$确定的情况下，$\vert \omega\cdot x+b\vert$表示点距离超平面的远近。

为什么需要引入几何间隔？

因为相同比例缩放参数$\omega,b$时，超平面在高维空间中的位置不会发生变化，但函数间隔变化了。

因此需要将参数大小固定，如给分离超平面的参数添加L2范数约束后，其间隔表示式表示的度量不受缩放的影响。

### 间隔最大化

约束最优化问题：

$$
\begin{align}
& \underset{\omega,b}{max} \quad \gamma \\
& s.t \quad y_i(\frac{\omega}{\Vert\omega\Vert}\cdot x_i+\frac{b}{\Vert\omega\Vert})\geq \gamma, \quad i=1,2,...,N
\end{align}
$$

带入函数间隔与几何间隔的关系得：

$$
\begin{align}
& \underset{\omega,b}{max} \quad \frac{\hat\gamma}{\Vert\omega\Vert} \\
& s.t. \quad y_i(\omega\cdot x_i+b)\geq \hat\gamma, \quad i=1,2,...,N
\end{align}
$$

由于函数间隔成比例改变对目标函数的优化无影响，故转为凸优化问题：

$$
\begin{align}
&  \underset{\omega,b}{min} \quad \frac{1}{2}\Vert\omega\Vert^2\\
&  s.t. \quad y_i(\omega\cdot x_i+b)-1 \geq 0, \quad i=1,2,...,N\\
\end{align}
$$

线性可分训练数据集的最大间隔分离超平面是存在且唯一的。

### 支持向量

训练数据集的样本点与分离超平面距离最近的点称为支持向量。

$$
y_i(\omega\cdot x_i+b)-1 = 0
$$

在决定分离超平面的时候只有支持向量起效，其他实例点不起作用。

正例所在的平行于分离超平面的超平面与负例所在的平行于超平面的超平面之间的距离称为间隔边界。

间隔边界：$\frac{2}{\Vert\omega\Vert}$

### 拉格朗日对偶

引入对偶的优点：

1. 不等式约束转为等式约束，使得对偶问题更容易求解；
2. 自然引入核函数，进而推广到非线性分类的问题；
3. 改变了问题的复杂度。由求特征向量转为求拉格朗日乘子，原问题下与样本维度有关，对偶问题只与样本数量有关；
4. 求解高效，**拉格朗日乘子仅在支持向量中非0**。

问：为什么拉格朗日乘子仅在支持向量中非0？

1. 按KKT条件有：
   $$
   \alpha^{*}_i\geq 0\quad\alpha_i^{*}(y_i(\omega\cdot x_i+b)-1)=0
   $$

2. 若不是支持向量，则不在间隔边界上，则$y_i(\omega \cdot x_i+b)-1> 0$，故$\alpha^*_i=0$

3. 若是支持向量，则在间隔边界上，则$y_i(\omega \cdot x_i+b)-1= 0$，故$\alpha^*_i>0$

拉格朗日函数：
$$
L(\omega,b,\alpha)=\frac{1}{2}\Vert\omega\Vert^2-\sum\limits_{i=1}^{N}\alpha_iy_i(\omega\cdot x_i+b)+\sum\limits_{i=1}^{N}\alpha_i
$$
其中$\alpha_i\geq0\quad i=1,2,...,N$是拉格朗日乘子，$\alpha=(\alpha_1,\alpha_2,...,\alpha_N)^T$为拉格朗日乘子向量。

根据拉格朗日对偶性，原始问题的对偶问题是极大极小问题：
$$
\underset{\alpha}{max}\ \underset{\omega,b}{min}L(\omega,b,\alpha)
$$
计算，化简，转换得到等价的对偶最优化问题：
$$
\begin{align}
& \underset{\alpha}{min}\quad \frac{1}{2}\sum\limits_{i=1}^{N}\sum\limits_{j=1}^{N}\alpha_i\alpha_jy_iy_j(x_i\cdot x_j)-\sum\limits_{i=1}^{N}\alpha_i \\
& s.t. \quad \sum\limits_{i=1}^N\alpha_iy_i=0 \\
& \quad \quad \quad \alpha_i\geq0,\quad i=1,2,...,N
\end{align}
$$
满足的KKT条件如下：
$$
\begin{align}
& \nabla_\omega L(\omega^*,b^*,\alpha^*)=\omega^*-\sum\limits_{i=1}^{N}\alpha_i^*y_ix_i=0\\
& \nabla_b L(\omega^*,b^*,\alpha^*)=-\sum\limits_{i=1}^{N}\alpha_i^*y_i=0\\
& \alpha_i^*(y_i(\omega^* \cdot x_i+b^*)-1)=0, i=1,2,...,N\\
& y_i(\omega^* \cdot x_i+b^*)-1\geq 0,i=1,2,...,N\\
& \alpha_i^* \geq 0,i=1,2,...,N
\end{align}
$$
设$\alpha^*=(\alpha_1^*,\alpha_2^*,...,\alpha_l^*)^T$是对偶最优化问题的解，则存在下标$j$使得$\alpha_j^*>0$，且
$$
\omega^*=\sum\limits_{i=1}^{N}\alpha_i^*y_ix_i \\
b^*=y_j-\sum\limits_{i=1}^{N}\alpha_i^*y_i(x_i\cdot x_j)
$$
特别地，若$\alpha_i^*=0$，则$\omega^*=0$，不是原始最优化问题的解。

分离超平面写成
$$
\sum\limits_{i=1}^{N}\alpha_i^*y_i(x\cdot x_i)+b^*=0
$$
决策函数为
$$
f(x)=sign(\sum\limits_{i=1}^{N}\alpha_i^*y_i(x\cdot x_i)+b^*)
$$
即分类决策函数只依赖于输入x和训练样本输入的内积。

## 线性软间隔支持向量机

### 软间隔

引入松弛变量$\varepsilon_i\geq0$，约束条件变为：
$$
y_i(\omega\cdot x_i+b)\geq 1-\xi_i
$$
同时，对每个松弛变量，支付代价$\epsilon_i$，则有凸优化问题：
$$
\begin{align}
&  \underset{\omega,b}{min} \quad \frac{1}{2}\Vert\omega\Vert^2+C\sum\limits_{i=1}^{N}\xi_i\\
&  s.t. \quad y_i(\omega\cdot x_i+b)\geq 1-\varepsilon_i, \quad i=1,2,...,N\\
& \quad \quad \quad \varepsilon_i \geq0, \quad i=1,2,...,N
\end{align}
$$
对偶问题是：
$$
\begin{align}
& \underset{\alpha}{min}\quad \frac{1}{2}\sum\limits_{i=1}^{N}\sum\limits_{j=1}^{N}\alpha_i\alpha_jy_iy_j(x_i\cdot x_j)-\sum\limits_{i=1}^{N}\alpha_i \\
& s.t. \quad \sum\limits_{i=1}^N\alpha_iy_i=0 \\
& \quad \quad \quad 0\leq\alpha_i\leq C,\quad i=1,2,...,N
\end{align}
$$
且它的解、分离超平面、分类决策函数与硬间隔相同。

### 支持向量

软间隔的支持向量要么在间隔边界上，要么在间隔边界与分离超平面之间，要么在误分类一侧。

实例到间隔边界的距离：$\frac{\xi_i}{\Vert\omega\Vert}$

### 合页损失函数

最小化目标函数：
$$
\sum\limits_{i=1}^{N}[1-y_i(\omega\cdot x_i+b)]_++\lambda\Vert\omega\Vert^2
$$
前面是经验损失或经验风险，后面是**正则化项**。

其中下标+表示函数：
$$
[z]_+=
\left\{
    \begin{array}{lr}
    z,\quad z>0 & \\
    0,\quad z\leq 0 &\\
    \end{array}
\right.
$$

## 核函数

若存在从输入空间到特征空间（希尔伯特空间）的映射，使得
$$
K(x,z)=\phi(x)\cdot\phi(z)
$$
其中$\phi(x)$为映射函数。

核技巧的想法是，只定义核函数$K(x,z)$，而不显式定义映射函数$\phi(x)$。

通常所说的核函数是正定核函数。（正定矩阵是任意二次型都大于0的矩阵，行列式恒为正，特征值均为正等）

常用核函数：

1. 多项式核函数
2. 高斯核函数
3. 字符串核函数

## 序列最小优化算法

SMO是一种启发式算法，基本思路是：所有变量的解都满足KKT条件即可，因为KKT是最优化问题的充要条件。

采用坐标梯度下降的思想：选择两个变量，固定其他变量，构建二次规划问题；

为什么选择两个变量？因为存在约束：
$$
\sum\limits_{i=1}^{N}\alpha_iy_i=0
$$

### 变量优化

SMO将对偶问题转化为子问题：
$$
\begin{align}
& \underset{\alpha_1,\alpha_2}{min}\quad W(\alpha_1,\alpha_2)=\frac{1}{2}K_{11}\alpha_1^2+\frac{1}{2}K_{22}\alpha_2^2+y_1y_2K_{12}\alpha_1\alpha_2\\
& \quad \quad -(\alpha_1+\alpha_2)+y_1\alpha_1\sum\limits_{i=3}^{N}y_i\alpha_iK_{i1}+y_2\alpha_2\sum\limits_{i=3}^{N}y_i\alpha_iK_{i2}\\
& s.t. \quad \alpha_1y_1+\alpha_2y_2=-\sum\limits_{i=3}^{N}y_i\alpha_i\\
& \quad \quad \quad0 \leq \alpha_i \leq C,i=1,2
\end{align}
$$

1. 不等式约束使$\alpha_1,\alpha_2$在盒子$[0,C]\times[0,C]$内；
2. 等式约束使它们连成的直线在平行于盒子对角线的直线上。
3. 由于$\alpha_i$有取值范围，若最优点落在取值范围内，直接取值，否则取边界值。该过程称为剪辑。
   1. 先求沿着约束方向未经剪辑的解
   2. 再求剪辑后的解

引入函数对输入的预测值与真实输出之差的度量：
$$
E_i=g(x_i)-y_i=(\sum\limits_{j=1}^{N}\alpha_jy_j(x_j\cdot x_i)+b)-y_i
$$

### 变量选择

1. 外循环
   1. 违反KKT最严重的样本点；
   2. 检验样本点是否满足KKT条件；
2. 内循环
   1. 希望目标函数具有足够大的变化；$max\ |E_1-E_2|$
   2. 否则遍历间隔边界上的样本点；
3. 每次完成两个变量优化后需要重新计算偏置$b$和$E_i$

## 最小二乘法支持向量机

最小二乘法支持向量机将优化问题由非等式约束转为等式约束替换。
$$
\begin{aligned}
& \underset{W,b}{min} \quad \frac{1}{2}\Vert\omega\Vert^2+\lambda\sum\limits_{i=1}^{N}\xi_i^2 \\
& s.t. \quad y_i(\omega\cdot x_i+b)=1-\xi_i,\quad i=1,2,...,N
\end{aligned}
$$
其中，$\lambda$为正则化参数。

对于非线性可分的训练样本，可以将原始样本从映射到更高维的线性可分的空间中。设非线性变换$\varphi (x_i)$将$x_i$映射到更高维空间中，则上述约束条件改为
$$
s.t. \quad y_i(\omega \cdot \varphi (x_i)+b)=1-\xi_i \ ,\quad i=1,2,...,N
$$
拉格朗日函数为：
$$
\mathcal{L}(\omega,b,e,\alpha)=\frac{1}{2}\Vert\omega\Vert^2+\lambda\sum\limits_{i=1}^{N}e_i^2-\sum\limits_{i=1}^{N}\alpha_i\{[y_i(\omega\cdot \varphi(x_i)+b)]-1+\xi_i\}
$$
按KKT条件依次求偏导：
$$
\begin{aligned}
& \frac{\partial \mathcal L}{\partial \omega}=0 \Rightarrow \omega=\sum\limits_{i=1}^N\alpha_i y_i\varphi(x_i)\\
& \frac{\partial \mathcal L}{\partial b}=0 \Rightarrow \sum\limits_{i=1}^N \alpha_i y_i=0\\
& \frac{\partial \mathcal L}{\partial \xi_i}=0 \Rightarrow \alpha_i=\lambda \xi_i \\
& \frac{\partial \mathcal L}{\partial \alpha_i}=0 \Rightarrow y_i[\omega \cdot \varphi(x_i)+b]-1+\xi_i=0 \ ,\quad i=1,2,...,N
\end{aligned}
$$
可通过矩阵运算求解$\alpha=[\alpha_1,...,\alpha_m]$和$b$：
$$
\left[ \begin{array}{c}
0 & \vec{1}^T \\
1 & \Omega+\frac{1}{\lambda}E \\
\end{array}
\right]
\cdot
\left[ \begin{array}{c}
b \\
\alpha \\
\end{array}
\right]
=\left[ \begin{array}{c}
0 \\
y \\
\end{array}
\right]
$$
其中$\vec{1}^T=[1,1,...,1]^T$，$E$是单位矩阵，$Z=(\varphi(x_1)y_1,...,\varphi(x_N)y_N)$，$\Omega=ZZ^T$。

求解得决策函数
$$
f(x)=sign(\sum\limits_{i=1}^N\alpha_i y_i K(x,x_i)+b)
$$
最小二乘法支持向量机模型中支持向量的拉格朗日乘子$\alpha_i=\lambda\xi_i$，因此基本不为0，几乎所有样本都是支持向量。

LSSVM的优点：运算迅速，计算简单；

LSSVM的缺点：

1. 最小二乘法支持向量机对异常点敏感；
2. 最小二乘法缺少稀疏性。
   