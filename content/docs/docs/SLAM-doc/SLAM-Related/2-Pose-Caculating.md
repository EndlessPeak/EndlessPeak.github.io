---
title: Pose Caculating
date: 2024-06-11
authors: 
    - EndlessPeak
toc: true
featuredImage: 
hidden: false
draft: false
weight: 2
description: 本文记录姿态解算的相关知识。
---

## Rotation Matrix

### 2 Dimensional
从二维角度推导旋转矩阵更加明确。

假设二维坐标系 $xOy$ 的第一象限中有点 $P(x,y)$，其与原点 $O$ 的连线 $OP$ 与 $x$ 轴正向夹角为 $\alpha$，则：

$$
\left \{ 
\begin{aligned}
x&=|OP|\cos \alpha \\
y&=|OP|\sin \alpha
\end{aligned}
\right .
$$

1. 当坐标系向逆时针方向旋转 $\beta$ 角时，原 $P$ 点的坐标变为：
   $$
   \left \{ 
   \begin{aligned}
   x'&=|OP|\cos (\alpha-\beta)=|OP|(\cos\alpha\cos\beta+\sin\alpha\sin\beta)=x\cos\beta+y\sin\beta \\
   y'&=|OP|\sin (\alpha-\beta)=|OP|(-\cos\alpha\sin\beta+\sin\alpha\cos\beta)=-x\sin\beta+y\cos\beta
   \end{aligned}
   \right .
   $$

   写成矩阵形式即：
   $$
   \begin{bmatrix}
   x' \\
   y'
   \end{bmatrix} = 
   \begin{bmatrix}
   \cos\beta & \sin\beta \\
   -\sin\beta & \cos\beta
   \end{bmatrix}
   \begin{bmatrix}
   x \\
   y
   \end{bmatrix}
   $$

2. 当坐标系向顺时针方向旋转 $\beta$ 角时，原 $P$ 点的坐标变为：
   $$
   \left \{ 
   \begin{aligned}
   x'&=|OP|\cos (\alpha+\beta)=|OP|(\cos\alpha\cos\beta-\sin\alpha\sin\beta)=x\cos\beta-y\sin\beta \\
   y'&=|OP|\sin (\alpha+\beta)=|OP|(\sin\alpha\cos\beta+\cos\alpha\sin\beta)=-x\sin\beta+y\cos\beta
   \end{aligned}
   \right .
   $$

   写成矩阵形式即：
   $$
   \begin{bmatrix}
   x' \\
   y'
   \end{bmatrix} = 
   \begin{bmatrix}
   \cos\beta & -\sin\beta \\
   \sin\beta & \cos\beta
   \end{bmatrix}
   \begin{bmatrix}
   x \\
   y
   \end{bmatrix}
   $$

### Coordinate System
常见的坐标系包括地理坐标系（地球固连坐标系/导航坐标系）和载体坐标系（机体坐标系）。
1. 地理坐标系：用于研究飞行器相对地面的运动状态，相当于世界坐标系。
2. 载体坐标系：以运动载体自身结构构成坐标系。

姿态是载体坐标系与地理坐标系的变换关系。

### 3 Dimensional
当扩展到三维旋转时，可以使用齐次坐标的方式将旋转矩阵增广到三维矩阵，令未变化的坐标轴相对应的保持不变。

由于线性变换不满足乘法交换律，因此为了得到确定的姿态，需要规定确定的旋转次序。假设旋转次序按照以下方式：
1. 绕物体的 $Z$ 轴旋转 $\alpha$，得到偏航角 $yaw$
2. 绕旋转之后的 $Y$ 轴旋转 $\beta$，得到俯仰角 $pitch$
3. 绕旋转之后的 $X$ 轴旋转 $\gamma$，得到滚转角 $roll$

旋转矩阵均是正交矩阵：
$$
\begin{aligned}
R_z(\alpha) &= 
\begin{bmatrix}
\cos \alpha & -\sin \alpha & 0 \\
\sin \alpha & \cos \alpha & 0 \\
0 & 0 & 1
\end{bmatrix} \\
R_y(\beta) &= 
\begin{bmatrix}
\cos \beta & 0 & \sin \beta  \\
0 & 1 & 0 \\
-\sin \beta & 0 & \cos \beta
\end{bmatrix} \\
R_x(\gamma) &= 
\begin{bmatrix}
1 & 0 & 0 \\
0 & \cos \gamma & -\sin \gamma \\
0 & \sin \gamma & \cos \gamma
\end{bmatrix}
\end{aligned}
$$

---

这里需要注意，为什么 $Y$ 轴的旋转矩阵负号和其他两维不一样，因为对于 $Y$ 轴旋转时，其旋转矩阵维度顺序是
$$
\begin{bmatrix} 
z' \\
x'
\end{bmatrix}=
\begin{bmatrix} 
\cos\beta & -\sin\beta \\
\sin\beta & \cos\beta
\end{bmatrix}
\begin{bmatrix} 
z \\ 
x
\end{bmatrix}
$$ 
当对向量进行反序时
$$
\begin{bmatrix} 
x \\ 
z
\end{bmatrix}=
\begin{bmatrix} 
\cos\beta & \sin\beta \\
-\sin\beta & \cos\beta
\end{bmatrix}
\begin{bmatrix} 
x \\ 
z
\end{bmatrix}
$$ 
可以看到，其负号形式自然就发生变化了。

---

地理坐标系依次经过欧拉角 $yaw$,$pitch$,$roll$ 角度旋转 $\alpha,\beta,\gamma$ 角度得到载体坐标系，则**由地理坐标系到载体坐标系**变换的姿态变换矩阵为：
$$
\begin{aligned}
R_n^b(\alpha, \beta, \gamma) &= R_z(\alpha)R_y(\beta)R_x(\gamma) \\
&= 
\begin{bmatrix}
\cos\alpha & -\sin\alpha & 0 \\
\sin\alpha & \cos\alpha & 0 \\
0 & 0 & 1
\end{bmatrix}
\begin{bmatrix}
\cos\beta & 0 & \sin\beta  \\
0 & 1 & 0 \\
-\sin\beta & 0 & \cos\beta
\end{bmatrix}
\begin{bmatrix}
1 & 0 & 0 \\
0 & \cos\gamma & -\sin\gamma \\
0 & \sin\gamma & \cos\gamma
\end{bmatrix} \\
&= 
\begin{bmatrix}
\cos\alpha\cos\beta & -\sin\alpha\cos\gamma+\cos\alpha\sin\beta\sin\gamma & \sin\alpha\sin\gamma+\cos\alpha\sin\beta\cos\gamma \\
\sin\alpha\cos\beta & \cos\alpha\cos\gamma+\sin\alpha\sin\beta\sin\gamma & -\cos\alpha\sin\gamma+\sin\alpha\sin\beta\cos\gamma \\
-\sin\beta & \cos\beta\sin\gamma & \cos\beta\cos\gamma
\end{bmatrix}
\end{aligned}
$$

反过来，**由载体坐标系向地理坐标系**变换的姿态变换矩阵为：
$$
\begin{aligned}
R_b^n(\alpha, \beta, \gamma)&= R_x(-\gamma)R_y(-\beta)R_z(-\alpha) \\
&= 
\begin{bmatrix}
1 & 0 & 0 \\
0 & \cos\gamma & \sin\gamma \\
0 & -\sin\gamma & \cos\gamma
\end{bmatrix}
\begin{bmatrix}
\cos\beta & 0 & -\sin\beta  \\
0 & 1 & 0 \\
\sin\beta & 0 & \cos\beta
\end{bmatrix}
\begin{bmatrix}
\cos\alpha & \sin\alpha & 0 \\
-\sin\alpha & \cos\alpha & 0 \\
0 & 0 & 1
\end{bmatrix} \\
&=
\begin{bmatrix}
\cos\alpha\cos\beta & \sin\alpha\cos\beta & -\sin\beta \\
-\sin\alpha\cos\gamma+\cos\alpha\sin\beta\sin\gamma & 
\cos\alpha\cos\gamma+\sin\alpha\sin\beta\sin\gamma & 
\cos\beta\sin\gamma \\
\sin\alpha\sin\gamma+\cos\alpha\sin\beta\cos\gamma & -\cos\alpha\sin\gamma+\sin\alpha\sin\beta\cos\gamma & \cos\beta\cos\gamma\\
\end{bmatrix}
\end{aligned}
$$

## Inertial Measurement Unit
由于惯性运动单元测量得到的姿态角通常是基于载体坐标系的，而不是地理坐标系的，因此其姿态变换矩阵与前述姿态变换矩阵对应关系正好相反。

假设载体坐标系测量得到的欧拉角为 $yaw$,$pitch$,$roll$，则存在下列对应关系：
1. 由载体坐标系到地理坐标系的姿态变换矩阵 $C_n^b=R_b^n$
2. 由地理坐标系到载体坐标系的姿态变换矩阵 $C_b^n=R_n^b$

### Gyromscope
惯性测量单元所在的载体坐标系和地理坐标系重合时，加速度计的测量值为 $A_n=\begin{bmatrix} 0 & 0 & g \end{bmatrix}^T$

若载体处于任意一个位置时，加速度计的测量值为 $A_n=\begin{bmatrix} a_x & a_y & a_z \end{bmatrix}^T$。

根据
$$
\begin{bmatrix}
a_x \\
a_y \\
a_z
\end{bmatrix}=
\begin{bmatrix}
\cos\alpha\cos\beta & \sin\alpha\cos\beta & -\sin\beta \\
-\sin\alpha\cos\gamma+\cos\alpha\sin\beta\sin\gamma & 
\cos\alpha\cos\gamma+\sin\alpha\sin\beta\sin\gamma & 
\cos\beta\sin\gamma \\
\sin\alpha\sin\gamma+\cos\alpha\sin\beta\cos\gamma & -\cos\alpha\sin\gamma+\sin\alpha\sin\beta\cos\gamma & \cos\beta\cos\gamma\\
\end{bmatrix}
\begin{bmatrix}
0 \\
0 \\
g
\end{bmatrix} 
$$

化简得
$$
\begin{bmatrix}
a_x \\
a_y \\
a_z
\end{bmatrix}=
\begin{bmatrix}
-\sin\beta \\
\cos\beta\sin\gamma \\
\cos\beta\cos\gamma
\end{bmatrix} g
$$

解算得到
$$
\left \{
\begin{aligned}
&\beta = \arcsin \frac{a_y}{a_z} \\
&\gamma = -\arcsin \frac{a_x}{\sqrt{a_y^2+a_z^2}}
\end{aligned}
\right .
$$

### Magnetometer
惯性测量单元所在的载体坐标系和地理坐标系重合时，磁力计的测量值为 $M_n=\begin{bmatrix} M_N & 0 & M_D \end{bmatrix}^T$。

这里磁力计的测量值只包含了 $x,z$ 两轴，若记 $x,y,z$ 三轴分别对应地理坐标系上的南、东、天，则可以发现：
1. 东方向始终在地球上绘制同心圆，天和南方向组成的向量指向了地球的南极；
2. 测量值中，$M_N$ 代表了北（南）方向的磁场强度分量，$M_D$ 代表地心（天）方向的磁场强度分量。

若载体处于任意一个位置时，磁力计的测量值为 $M_b=\begin{bmatrix} M_x & M_y & M_z \end{bmatrix}^T$。

根据载体坐标系和地理坐标系的关系：
$$
M_b=C_n^bM_n
$$

推导可得：
$$
\begin{bmatrix}
M_x \\
M_y \\
M_z
\end{bmatrix}=
\begin{bmatrix}
M_N\cos\alpha_m\cos\beta - M_D\sin\beta \\
M_N(\cos\alpha_m\sin\beta\cos\gamma-\sin\alpha_m\cos\gamma)+M_D\cos\beta\sin\gamma \\
M_N(\cos\alpha_m\sin\beta\cos\gamma+\sin\alpha_m\sin\gamma)+M_D\cos\beta\cos\gamma
\end{bmatrix}
$$

即有：
$$
\left \{
\begin{aligned}
&M_x\cos\beta+M_y\sin\beta\sin\gamma+M_z\sin\beta\cos\gamma=M_N\cos\alpha_m \\
&M_x\sin\gamma-M_y\cos\gamma=M_N\sin\alpha_m
\end{aligned}
\right .
$$

从而可以计算出载体**相对地磁北极的航向角**：
$$
\alpha_m = \arctan \frac{M_x\sin\gamma-M_y\cos\beta}{M_x\cos\beta+M_y\sin\beta\sin\gamma+M_z\sin\beta\cos\gamma}
$$

最终航向角 $\alpha = \alpha_m + \Delta \alpha$，其中 $\Delta \alpha$ 是地磁北极与地理北极的夹角。