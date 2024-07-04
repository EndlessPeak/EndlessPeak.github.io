---
title: 支持向量机推导
authors:
  - EndlessPeak
toc: true
featuredImage: 
date: 2023-05-31
hidden: false
draft: false
weight: 3
---

## 目标综述 {#目标综述}

在特征空间中找到一 **分离超平面** 能将实例分到不同类。

当数据集 **线性可分** 时，有无数个分离超平面可将数据正确分开，支持向量机利用 **间隔最大化** 求解最优分离超平面，因此解是唯一的。

> 对训练集找到几何间隔最大的超平面意味着以充分大的确信度对训练数据进行分类。对最难分的实例点(离超平面最近的点)也有足够大的确信度将它们分开，对未知新实例有很好的分类预测能力。

通过拉格朗日对偶对原优化问题进行转化，使之更容易求解；

当数据集 **线性不可分** 时，通过非线性变换的过程将其转化为线性问题。非线性变换可将输入空间中的超曲面模型对应特征空间（希尔伯特空间）中的超平面模型，通过在特征空间中求解线性支持向量机完成输入空间分类问题的学习。


## 线性二分类模型 {#线性二分类模型}

给定一组数据\\((x\_1,y\_1),(x\_2,y\_2),⋯,(x\_m,y\_m)\\)，其中 \\(x\_i \in R^d ,y \in \\{-1,1\\}\\)。

二分类任务的目标是希望从数据中学得一个假设函数\\(h:R \rightarrow \\{-1,1\\}\\),使得 \\(h( x\_ {1} )=y\_ {i}\\)，即

\begin{align}
h(x\_ 1)=\begin{cases}+1 \quad y\_{1}=+1;\\\-1 \quad y\_{1}=-1;\end{cases}
\end{align}

更进一步，线性二分类模型认为假设函数的形式基于对特征$x_i$的线性组合，即

\begin{equation}
h(x\_i)=sign(\omega^T\cdot x\_i+b) \quad \omega\_i \in R^d,b \in R
\end{equation}

线性二分类模型的目标是找到一组合适的参数\\((\omega,b)\\), 使得

\begin{equation}
∀i.y\_i(w^Tx \_i+b)>0
\end{equation}


## 线性硬间隔支持向量机 {#线性硬间隔支持向量机}

线性支持向量机是一种线性二分类模型，需要找到满足定理 1 约束的划分超平面, 即\\((\omega,b)\\)。其中：

1.  参数$&omega;$方向与超平面垂直，它是超平面的法向量。
2.  参数$b$代表的是超平面的偏置，决定超平面与原点间的距离。

进一步来说，SVM 希望找到与各样本的间隔最大化的划分超平面。


### 间隔 {#间隔}

间隔用来刻画点到分类超平面的距离，距离的远近程度可以用于度量分类的准确性或正确程度。

定义超平面到数据集的 **函数间隔** 为：

\begin{equation}
\hat\gamma=\underset{1,2,...,m}{min}y\_i(\omega\cdot x\_i+b)
\end{equation}

定义超平面到数据集的 **几何间隔** 为：

\begin{equation}
\gamma=\underset{1,2,...,m}{min}y\_i(\frac{\omega}{\Vert\omega\Vert}\cdot x\_i+\frac{b}{\Vert\omega\Vert})
\end{equation}

函数间隔和几何间隔的关系：\\(\gamma=\frac{\hat{\gamma}}{\Vert\omega\Vert}\\)

为什么这样定义函数间隔？

在超平面$&omega;&sdot; x+b=0$确定的情况下，$&vert; &omega;&sdot; x+b&vert;$表示点距离超平面的远近。

为什么需要引入几何间隔？

因为相同比例缩放参数$&omega;,b$时，超平面在高维空间中的位置不会发生变化，但函数间隔变化了。

因此需要将参数大小固定，如给分离超平面的参数添加 L2 范数约束后，其间隔表示式表示的度量不受缩放的影响。


### 间隔最大化 {#间隔最大化}

约束最优化问题：

\begin{align}
& \underset{\omega,b}{max} \quad \gamma \\\\
& s.t \quad y\_i(\frac{\omega}{\Vert\omega\Vert}\cdot x\_i+\frac{b}{\Vert\omega\Vert})\geq \gamma, \quad i=1,2,...,N
\end{align}

带入函数间隔与几何间隔的关系得：

\begin{align}
& \underset{\omega,b}{max} \quad \frac{\hat\gamma}{\Vert\omega\Vert} \\\\
& s.t. \quad y\_i(\omega\cdot x\_i+b)\geq \hat\gamma, \quad i=1,2,...,N
\end{align}

由于函数间隔成比例改变对目标函数的优化无影响，故转为凸优化问题：

\begin{align}
&  \underset{\omega,b}{min} \quad \frac{1}{2}\Vert\omega\Vert^2\\\\
&  s.t. \quad y\_i(\omega\cdot x\_i+b)-1 \geq 0, \quad i=1,2,...,N\\\\
\end{align}

线性可分训练数据集的最大间隔分离超平面是存在且唯一的。


### 支持向量 {#支持向量}

训练数据集的样本点与分离超平面距离最近的点称为支持向量。

\begin{equation}
y\_i(\omega\cdot x\_i+b)-1 = 0
\end{equation}

在决定分离超平面的时候只有支持向量起效，其他实例点不起作用。

正例所在的平行于分离超平面的超平面与负例所在的平行于超平面的超平面之间的距离称为间隔边界。

间隔边界：\\(\frac{2}{\Vert\omega\Vert}\\)


### 拉格朗日对偶 {#拉格朗日对偶}

引入对偶的优点：

1.  不等式约束转为等式约束，使得对偶问题更容易求解；
2.  自然引入核函数，进而推广到非线性分类的问题；
3.  改变了问题的复杂度。由求特征向量转为求拉格朗日乘子，原问题下与样本维度有关，对偶问题只与样本数量有关；
4.  求解高效， **拉格朗日乘子仅在支持向量中非 0** 。

问：为什么拉格朗日乘子仅在支持向量中非 0？

1.  按 KKT 条件有：
    \\[
       \alpha^{\*}\_i\geq 0\quad\alpha\_i^{\*}(y\_i(\omega\cdot x\_i+b)-1)=0
       \\]

2.  若不是支持向量，则不在间隔边界上，则\\(y\_i(\omega \cdot x\_i+b)-1> 0\\)，故\\(\alpha^\*\_i=0\\)

3.  若是支持向量，则在间隔边界上，则\\(y\_i(\omega \cdot x\_i+b)-1= 0\\)，故\\(\alpha^\*\_i>0\\)

拉格朗日函数：

\\[
L(\omega,b,\alpha)=\frac{1}{2}\Vert\omega\Vert^2-\sum\limits\_{i=1}^{N}\alpha\_iy\_i(\omega\cdot x\_i+b)+\sum\limits\_{i=1}^{N}\alpha\_i
\\]

其中$&alpha;_i&ge;0\quad i=1,2,...,N$是拉格朗日乘子，$&alpha;=(&alpha;_1,&alpha;_2,...,&alpha;_N)^T$为拉格朗日乘子向量。

根据拉格朗日对偶性，原始问题的对偶问题是极大极小问题：

\\[
\underset{\alpha}{max}\ \underset{\omega,b}{min}L(\omega,b,\alpha)
\\]

计算，化简，转换得到等价的对偶最优化问题：

\begin{align}
& \underset{\alpha}{min}\quad \frac{1}{2}\sum\limits\_{i=1}^{N}\sum\limits\_{j=1}^{N}\alpha\_i\alpha\_jy\_iy\_j(x\_i\cdot x\_j)-\sum\limits\_{i=1}^{N}\alpha\_i \\\\
& s.t. \quad \sum\limits\_{i=1}^N\alpha\_iy\_i=0 \\\\
& \quad \quad \quad \alpha\_i\geq0,\quad i=1,2,...,N
\end{align}

满足的 KKT 条件如下：

\begin{align}
& \nabla\_\omega L(\omega^\*,b^\*,\alpha^\*)=\omega^\*-\sum\limits\_{i=1}^{N}\alpha\_i^\*y\_ix\_i=0\\\\
& \nabla\_b L(\omega^\*,b^\*,\alpha^\*)=-\sum\limits\_{i=1}^{N}\alpha\_i^\*y\_i=0\\\\
& \alpha\_i^\*(y\_i(\omega^\* \cdot x\_i+b^\*)-1)=0, i=1,2,...,N\\\ \\\\
& y\_i(\omega^\* \cdot x\_i+b^\*)-1\geq 0,i=1,2,...,N\\\ \\\\
& \alpha\_i^\* \geq 0,i=1,2,...,N
\end{align}

设$&alpha;^\*=(&alpha;_1^\*,&alpha;_2^\*,...,&alpha;_l^\*)^T$是对偶最优化问题的解，则存在下标$j$使得\\(\alpha\_j^\*>0\\)，且

\begin{align}
& \omega^\*=\sum\limits\_{i=1}^{N}\alpha\_i^\*y\_ix\_i \\\\
& b^\*=y\_j-\sum\limits\_{i=1}^{N}\alpha\_i^\*y\_i(x\_i\cdot x\_j)
\end{align}

特别地，若\\(\alpha\_i^\*=0\\)，则\\(\omega^\*=0\\)，不是原始最优化问题的解。

分离超平面写成
\\[
\sum\limits\_{i=1}^{N}\alpha\_i^\*y\_i(x\cdot x\_i)+b^\*=0
\\]
决策函数为
\\[
f(x)=sign(\sum\limits\_{i=1}^{N}\alpha\_i^\*y\_i(x\cdot x\_i)+b^\*)
\\]
即分类决策函数只依赖于输入 x 和训练样本输入的内积。


## 线性软间隔支持向量机 {#线性软间隔支持向量机}

引入松弛变量\\(\varepsilon\_i\geq0\\)，约束条件变为：

\\[
y\_i(\omega\cdot x\_i+b)\geq 1-\xi\_i
\\]

同时，对每个松弛变量，支付代价\\(\epsilon\_i\\)，则有凸优化问题：

\begin{align}
&  \underset{\omega,b}{min} \quad \frac{1}{2}\Vert\omega\Vert^2+C\sum\limits\_{i=1}^{N}\xi\_i\\\\
&  s.t. \quad y\_i(\omega\cdot x\_i+b)\geq 1-\varepsilon\_i, \quad i=1,2,...,N\\\\
& \quad \quad \quad \varepsilon\_i \geq0, \quad i=1,2,...,N
\end{align}

对偶问题是：

\begin{align}
& \underset{\alpha}{min}\quad \frac{1}{2}\sum\limits\_{i=1}^{N}\sum\limits\_{j=1}^{N}\alpha\_i\alpha\_jy\_iy\_j(x\_i\cdot x\_j)-\sum\limits\_{i=1}^{N}\alpha\_i \\\\
& s.t. \quad \sum\limits\_{i=1}^N\alpha\_iy\_i=0 \\\\
& \quad \quad \quad 0\leq\alpha\_i\leq C,\quad i=1,2,...,N
\end{align}

且它的解、分离超平面、分类决策函数与硬间隔相同。


### 支持向量 {#支持向量}

软间隔的支持向量要么在间隔边界上，要么在间隔边界与分离超平面之间，要么在误分类一侧。

实例到间隔边界的距离：\\(\frac{\xi\_i}{\Vert\omega\Vert}\\)


### 合页损失函数 {#合页损失函数}

最小化目标函数：

\\[
\sum\limits\_{i=1}^{N}[1-y\_i(\omega\cdot x\_i+b)]\_++\lambda\Vert\omega\Vert^2
\\]

前面是经验损失或经验风险，后面是\*\*正则化项\*\*。

其中下标+表示函数：

\begin{equation}
[z]\_{+}=
\left\\{
    \begin{array}{lr}
    z,\quad z>0 & \\\\
    0,\quad z\leq 0 &\\\\
    \end{array}
\right.
\end{equation}


## 核函数与核技巧 {#核函数与核技巧}

若存在从输入空间到特征空间（希尔伯特空间）的映射，使得

\\[
K(x,z)=\phi(x)\cdot\phi(z)
\\]

其中$&phi;(x)$为映射函数。

核技巧的想法是，只定义核函数\\(K(x,z)\\)，而不显式定义映射函数\\(\phi(x)\\)。

通常所说的核函数是正定核函数。正定核具有正定矩阵，即任意二次型都大于 0 的矩阵，行列式恒为正，特征值均为正等。

常用核函数：

1.  多项式核函数
2.  高斯核函数
3.  字符串核函数


## 序列最小优化算法 SMO {#序列最小优化算法-smo}

SMO 是一种启发式算法，基本思路是：所有变量的解都满足 KKT 条件即可，因为 KKT 是最优化问题的充要条件。它采用坐标梯度下降的思想：选择两个变量，固定其他变量，构建二次规划问题；

为什么选择两个变量？因为存在约束：

\\[
\sum\limits\_{i=1}^{N}\alpha\_iy\_i=0
\\]


### 变量优化 {#变量优化}

SMO 将对偶问题转化为子问题：

\begin{align}
& \underset{\alpha\_1,\alpha\_2}{min}\quad W(\alpha\_1,\alpha\_2)=\frac{1}{2}K\_{11}\alpha\_1^2+\frac{1}{2}K\_{22}\alpha\_2^2+y\_1y\_2K\_{12}\alpha\_1\alpha\_2\\\\
& \quad \quad -(\alpha\_1+\alpha\_2)+y\_1\alpha\_1\sum\limits\_{i=3}^{N}y\_i\alpha\_iK\_{i1}+y\_2\alpha\_2\sum\limits\_{i=3}^{N}y\_i\alpha\_iK\_{i2}\\\\
& s.t. \quad \alpha\_1y\_1+\alpha\_2y\_2=-\sum\limits\_{i=3}^{N}y\_i\alpha\_i\\\\
& \quad \quad \quad0 \leq \alpha\_i \leq C,i=1,2
\end{align}

1.  不等式约束使$&alpha;_1,&alpha;_2\\(在盒子\\)[0,C]&times;[0,C]$内；
2.  等式约束使它们连成的直线在平行于盒子对角线的直线上。
3.  由于$&alpha;_i$有取值范围，若最优点落在取值范围内，直接取值，否则取边界值。该过程称为剪辑。
    1.  先求沿着约束方向未经剪辑的解
    2.  再求剪辑后的解

引入函数对输入的预测值与真实输出之差的度量：

\\[
E\_i=g(x\_i)-y\_i=(\sum\limits\_{j=1}^{N}\alpha\_jy\_j(x\_j\cdot x\_i)+b)-y\_i
\\]


### 变量选择 {#变量选择}

1.  外循环
    1.  违反 KKT 最严重的样本点；
    2.  检验样本点是否满足 KKT 条件；
2.  内循环
    1.  希望目标函数具有足够大的变化；\\(max\ |E\_1-E\_2|\\)
    2.  否则遍历间隔边界上的样本点；
3.  每次完成两个变量优化后需要重新计算偏置$b$和\\(E\_i\\)


## 最小二乘法 LSSVM {#最小二乘法-lssvm}

最小二乘法支持向量机将优化问题由非等式约束转为等式约束替换。

\begin{aligned}
& \underset{W,b}{min} \quad \frac{1}{2}\Vert\omega\Vert^2+\lambda\sum\limits\_{i=1}^{N}\xi\_i^2 \\\\
& s.t. \quad y\_i(\omega\cdot x\_i+b)=1-\xi\_i,\quad i=1,2,...,N
\end{aligned}

其中，$&lambda;$为正则化参数。

对于非线性可分的训练样本，可以将原始样本从映射到更高维的线性可分的空间中。设非线性变换$&varphi; (x_i)$将$x_i$映射到更高维空间中，则上述约束条件改为

\\[
s.t. \quad y\_i(\omega \cdot \varphi (x\_i)+b)=1-\xi\_i \ ,\quad i=1,2,...,N
\\]

拉格朗日函数为：

\\[
\mathcal{L}(\omega,b,e,\alpha)=\frac{1}{2}\Vert\omega\Vert^2+\lambda\sum\limits\_{i=1}^{N}e\_i^2-\sum\limits\_{i=1}^{N}\alpha\_i\\{[y\_i(\omega\cdot \varphi(x\_i)+b)]-1+\xi\_i\\}
\\]

按 KKT 条件依次求偏导：

\begin{aligned}
& \frac{\partial \mathcal L}{\partial \omega}=0 \Rightarrow \omega=\sum\limits\_{i=1}^N\alpha\_i y\_i\varphi(x\_i)\\\\
& \frac{\partial \mathcal L}{\partial b}=0 \Rightarrow \sum\limits\_{i=1}^N \alpha\_i y\_i=0\\\\
& \frac{\partial \mathcal L}{\partial \xi\_i}=0 \Rightarrow \alpha\_i=\lambda \xi\_i \\\\
& \frac{\partial \mathcal L}{\partial \alpha\_i}=0 \Rightarrow y\_i[\omega \cdot \varphi(x\_i)+b]-1+\xi\_i=0 \ ,\quad i=1,2,...,N
\end{aligned}

可通过矩阵运算求解$&alpha;=[&alpha;_1,...,&alpha;_m]$和$b$：

\begin{equation}
\left[ \begin{array}{c}
0 & \vec{1}^T \\\\
1 & \Omega+\frac{1}{\lambda}E \\\\
\end{array}
\right]
\cdot
\left[ \begin{array}{c}
b \\\\
\alpha \\\\
\end{array}
\right]
=\left[ \begin{array}{c}
0 \\\\
y \\\\
\end{array}
\right]
\end{equation}

其中\\(\vec{1}^T=[1,1,...,1]^T\\)，$E$是单位矩阵，\\(Z=(\varphi(x\_1)y\_1,...,\varphi(x\_N)y\_N)\\)，\\(\Omega=ZZ^T\\)。

求解得决策函数

\\[
f(x)=sign(\sum\limits\_{i=1}^N\alpha\_i y\_i K(x,x\_i)+b)
\\]

最小二乘法支持向量机模型中支持向量的拉格朗日乘子\\(\alpha\_i=\lambda\xi\_i\\)，因此基本不为 0，几乎所有样本都是支持向量。

LSSVM 的优点：运算迅速，计算简单；

LSSVM 的缺点：

1.  最小二乘法支持向量机对异常点敏感；
2.  最小二乘法缺少稀疏性。
