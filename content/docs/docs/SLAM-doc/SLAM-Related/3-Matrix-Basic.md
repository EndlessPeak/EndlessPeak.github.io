---
title: Matrix Base
authors: 
    - EndlessPeak
toc: true
date: 2024-06-18
featuredImage: 
hidden: false
draft: false
weight: 3
description: 本文对矩阵的常见知识进行概括，包括分解和求解线性方程组。
---

## Direct Method
### Gauss 

### LU Decomposition

### QR Decomposition

### Cholesky Decomposition

## 迭代解法
迭代解法通常用于处理大型稀疏矩阵，或当矩阵 A 具有特定结构时。
### Jacobi Method
雅可比迭代法

### Gauss-Seidel Method
高斯-赛德尔迭代法是雅可比迭代法的改进，每次迭代使用最新的值来更新解

### Conjugate Gradient Method
共轭梯度法特别适用于求解大型对称正定矩阵的线性方程组。它通过在共轭方向上最小化二次型函数来逼近解。