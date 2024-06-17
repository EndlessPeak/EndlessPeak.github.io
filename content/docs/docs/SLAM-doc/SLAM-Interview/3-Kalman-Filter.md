---
title: Kalman Filter
date: 2024-06-11
authors: 
    - EndlessPeak
toc: true
featuredImage: 
hidden: false
draft: false
weight: 3
description: 本文记录卡尔曼滤波的相关知识。
---

## Kalman Filter Process

### Model
假设系统状态空间模型为：

$$
\begin{aligned}
X(k) &= AX(k-1) + BU(k-1) + W(k) \\
Z(k) &= HX(k) + V(k)
\end{aligned}
$$

其中：
1. $A$ 和 $B$ 分别表示系统状态参数矩阵和系统控制参数矩阵；
2. $Z(k)$ 是在 $k$ 时刻的测量值; 
3. $H$ 是系统测量参数矩阵； 
4. $X(k)$ 表示系统在 $k$ 时刻的系统状态；
5. $U(k)$ 是处于 $k$ 时刻对系统的控制量；
6. $W(k)$ 和 $V(k)$ 是过程和测量噪声。

### Process
卡尔曼滤波过程如下：
1. 进行先验估计估算（一步状态预测）
   $$
   \hat{X}(k|k-1) = A \hat{X}(k-1|k-1) + B U(k-1)
   $$
2. 计算预测协方差矩阵
   $$
   P(k|k-1) = A P(k-1|k-1) A^T + Q
   $$
3. 计算卡尔曼增益
   $$
   K(k) =\frac{P(k|k-1) H^T} {(H \hat{P}(k|k-1) H^T + R)^{-1}}
   $$
4. 计算最优化估计值（更新状态估计）
   $$
   \hat{X}(k|k) = \hat{X}(k|k-1) + K(k) (Z(k) - H \hat{X}(k|k-1))
   $$
5. 更新后验协方差矩阵
   $$
   P(k|k) = (I - K(k) H) P(k|k-1)
   $$

其中 $Q$ 和 $R$ 是过程和测量噪声的协方差矩阵。