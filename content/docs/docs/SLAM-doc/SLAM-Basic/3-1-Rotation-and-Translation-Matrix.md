---
title: Rotation & Translation Matrix
authors: 
    - EndlessPeak
toc: true
date: 2024-06-18
featuredImage: 
hidden: false
draft: false
weight: 31
description: 本文总结了三维空间刚体的运动相关内容。
---

## Point & Vector & Coordinate System
旋转矩阵的推导可以参考 **姿态解算** 部分。

基是张成三维空间的一组线性无关的向量。三维空间中的某个点 $a$ 可以用 $\mathbb{R}^3$ 来描述，假设线性空间中存在一组基 $(e_1,e_2,e_3)$，则由原地到点 $a$ 的向量 $\mathbf{a}$ 在这组基下的坐标是：$(a_1,a_2,a_3)$ ，满足
$$
\mathbf{a} = \mathbf{e} \cdot \mathbf{a} =
\begin{bmatrix} 
e_1 & e_2 & e_3 
\end{bmatrix}
\begin{bmatrix} 
a_1 \\ a_2 \\ a_3 
\end{bmatrix} = a_1 e_1 + a_2 e_2 + a_3 e_3
$$

对于向量 $\mathbf{a},\mathbf{b} \in \mathbb{R}^3$ 的内积：
$$
\mathbf{a} \cdot \mathbf{b} = \mathbf{a}^T \mathbf{b} = \sum_{i=1}^3 a_ib_i = |a||b|\cos\langle \mathbf{a},\mathbf{b} \rangle 
$$

其中 $\left \langle \mathbf{a},\mathbf{b} \right \rangle$ 是两个向量的夹角。**内积可以描述向量间的投影关系。**

对于向量 $\mathbf{a},\mathbf{b} \in \mathbb{R}^3$ 的外积：
$$
\begin{aligned}
\mathbf{a} \times \mathbf{b} &= 
\left \|  
\begin{matrix}
e_1 & e_2 & e_3 \\
a_1 & a_2 & a_3 \\
b_1 & b_2 & b_3
\end{matrix}
\right \| \\
&= \left( a_2 b_3 - a_3 b_2 \right) e_1 - \left( a_1 b_3 - a_3 b_1 \right) e_2 + \left( a_1 b_2 - a_2 b_1 \right) e_3 \\
&=
\begin{bmatrix}
a_2b_3-a_3b_2 \\
a_3b_1-a_1b_3 \\
a_1b_2-a_2b_1
\end{bmatrix} \\
&=
\begin{bmatrix}
0 & -a_3 & a_2 \\
a_3 & 0 & -a_1 \\
-a_2 & a_1 & 0
\end{bmatrix}\mathbf{b}
\stackrel{\mathrm{def}}{=} \mathbf{a}^{\wedge}\mathbf{b}
\end{aligned}
$$

**外积的结果是向量**，且有以下性质：
1. 方向：垂直于两个向量
2. 长度： $\left \|a \right \|\left \|b \right \| \sin \left \langle \mathbf{a},\mathbf{b} \right \rangle$ 
3. 几何意义：两个向量张成的四边形的有向面积

记符号 $\wedge$ 为反对称符号， $\mathbf{a} \times \mathbf{b} = \mathbf{a}^{\wedge} \mathbf{b}$ 将外积变成了线性运算。

**任何向量都对应唯一的反对称矩阵，反之亦然**，其对应关系为：
$$
\mathbf{a}^{\wedge}=
\begin{bmatrix}
0 & -a_3 & a_2 \\
a_3 & 0 & -a_1 \\
-a_2 & a_1 & 0
\end{bmatrix}
$$

## Coordinate Systems' Euclidean transformation
坐标系之间的欧式变换由一个旋转加上一个平移组成，这种变换称之为刚体运动。

设单位正交基 $(e_1,e_2,e_3)$ 经过一次旋转变成 $(e_1',e_2',e_3')$，对同一个向量 $\mathbf{a}$ 分别在两个正交基下的坐标 $\begin{bmatrix} a_1,a_2,a_3 \end{bmatrix}^T$ 和 $\begin{bmatrix} a_1',a_2',a_3' \end{bmatrix}^T$ 有：
$$
\begin{bmatrix}
e_1,e_2,e_3
\end{bmatrix}
\begin{bmatrix}
a_1 \\
a_2 \\
a_3
\end{bmatrix} =
\begin{bmatrix}
e_1',e_2',e_3'
\end{bmatrix}
\begin{bmatrix}
a_1' \\
a_2' \\
a_3'
\end{bmatrix}
$$

等式同时左乘下面的向量
$$
\begin{bmatrix} 
e_1^T \\
e_2^T \\
e_3^T 
\end{bmatrix}
$$ 

得到：

$$
\begin{bmatrix}
a_1 \\
a_2 \\
a_3
\end{bmatrix} =
\begin{bmatrix}
e_1^Te_1' & e_1^Te_2' & e_1^Te_3' \\
e_2^Te_1' & e_2^Te_2' & e_2^Te_3' \\
e_3^Te_1' & e_3^Te_2' & e_3^Te_3' \\
\end{bmatrix}
\begin{bmatrix}
a_1' \\
a_2' \\
a_3'
\end{bmatrix}
\stackrel{\mathrm{def}}{=}
\mathbf{Ra}'
$$

定义中间的矩阵为旋转矩阵，可以看到:
1. **旋转矩阵由两组基的内积组成**。
2. 矩阵各分量是两个坐标系基的内积，基的长度为1，因此实际上是各基向量夹角的余弦值，又称方向余弦矩阵。
3. 旋转矩阵是正交矩阵，即 $R^{-1}=R^T$ 或 $R^{T}R=RR^{T}=I$，且行列式为1；反过来说，行列式为1的正交矩阵即为旋转矩阵

> 特别地，行列式为-1也称为旋转矩阵，这种旋转是瑕旋转，即一次旋转加上一次反射。

旋转矩阵的集合定义为：
$$
SO(n)=\left \{\mathbf{R} \in \mathbb{R}^{n \times n} | \mathbf{RR^T=I},\det(R)=1 \right \}
$$

旋转矩阵为正交矩阵，其逆等于转置，均描述了一个相反的旋转：
$$
\mathbf{a'}=\mathbf{R}^{-1}\mathbf{a}=\mathbf{R}^T\mathbf{a}
$$

平移相对旋转来说更加简单，只需要进行简单的坐标相加，若考虑世界坐标系中的向量 $\mathbf{a}$ ，经过一次旋转 $\mathbf{R}$ 和一次平移 $\mathbf{t}$ 后得到 $\mathbf{a}'$ ，那么把旋转和平移合到一起为：
$$
\mathbf{a}'=\mathbf{Ra}+\mathbf{t}
$$

若定义两个坐标系1和2，向量 $\mathbf{a}$ 在两个坐标系下的坐标为 $\mathbf{a}_1$ 和 $\mathbf{a}_2$，则：
$$
\mathbf{a}_1=\mathbf{R}_{12}\mathbf{a}_2+\mathbf{t}_{12}
$$

其中 \(\mathbf{R}_{12}\) 表示把坐标系2的向量变换到1，而 \(\mathbf{t}_{12}\) 对应的是坐标系1原点指向坐标系2原点的向量在**坐标系1下的坐标**。

> 在完成旋转后，我们还需要考虑坐标系2相对于坐标系1的位置，这一步通过平移向量 \( \mathbf{t}_{12} \) 来实现。
> 因此，在完成旋转变换后，我们需要再加上\( \mathbf{t}_{12} \)来获得最终在坐标系1中的表示。

反过来，\(\mathbf{t}_{21}\) 虽然是坐标系2原点指向坐标系1原点的向量在**坐标系2下的坐标**，却并不等于 \(-\mathbf{t}_{12}\) 。

> 从向量层面上来看，两个向量是完全反向的关系，但是由于两个坐标系的方向可能发生了变化，因此它们在各自坐标系下的坐标值并非相反数。

## Transform Matrix & Homogeneous Coordinate 
为了让旋转和平移满足线性关系，引入齐次坐标和变换矩阵：
$$
\begin{bmatrix}
\mathbf{a}' \\
1
\end{bmatrix} = 
\begin{bmatrix}
\mathbf{R} & \mathbf{t} \\
0^T & 1
\end{bmatrix}
\begin{bmatrix}
\mathbf{a} \\
1
\end{bmatrix}
\stackrel{\mathrm{def}}{=}
\mathbf{T}
\begin{bmatrix}
\mathbf{a} \\
1
\end{bmatrix}
$$

在这里，三维向量末尾添加1变成了**齐次坐标**，矩阵 $\mathbf{T}$ 是**变换矩阵**。

关于该变换矩阵，称其为特殊欧式群：
$$
\operatorname{SE}(3) = \left\{ 
\mathbf{T} = 
\begin{bmatrix}
\mathbf{R} & \mathbf{t} \\
\mathbf{0}^\mathrm{T} & 1
\end{bmatrix} 
\in \mathbb{R}^{4 \times 4} \mid
\mathbf{R} \in \mathrm{SO}(3), \mathbf{t} \in \mathbb{R}^3 \right\}
$$

求解该矩阵的逆表示一个反向的变换：
$$
\mathbf{T}^{-1} = 
\begin{bmatrix}
\mathbf{R}^T & \mathbf{-R}^T\mathbf{t} \\
\mathbf{0}^\mathrm{T} & 1
\end{bmatrix}
$$

为了实现计算 $\mathbf{Ta}$ 时使用齐次坐标，计算 $\mathbf{Ra}$ 时使用非齐次坐标，可以采用以下思路：
1. 先进行矩阵转换，后进行计算
2. 定义运算符重载，以适应不同的矩阵

有关该部分的内容查看后面的 Eigen 编程实践内容。