---
markup: pandoc
title: 图的弗洛伊德算法
toc: true
authors:
  - EndlessPeak
date: 2021-02-10
hidden: false
draft: false
weight: 13
---

## Floyd算法

解题步骤：

1. 图的顶点从$V_0$开始，依次标记所有顶点位序；

2. 按图画出邻接矩阵$A^{-1}$；$path^{0}$矩阵全取-1。

3. 顶点 $i$ 作中间顶点时遍历时，邻接矩阵$A^i$只画出第i行和第i列，补齐对角线中的0。

   对第 $i$ 行和第 $i$ 列中的每个元素求十字交叉的值与邻接矩阵$A^{i-1}$对应的值比较，小则替换之。

4. 如有替换，顺手把 $path^i$ 的第 $i$ 行第 $i$ 列的值改成 $i$ 。

例题：（电子科技大学2016年）利用Floyd算法计算每次迭代的结果。
$$
dist^{-1}=\left[
\begin{array}{c}
0 & 1 & 4 & \infty \\
\infty & 0 & 2 & 5 \\
\infty & \infty & 0 & 1 \\
2 & \infty & \infty & 0 \\
\end{array}
\right]
\
path^{-1}=\left[
\begin{array}{c}
-1 & 0 & 0 & -1 \\
-1 & -1 & 1 & 1 \\
-1 & -1 & -1 & 2 \\
3 & -1 & -1 & -1 \\
\end{array}
\right]
$$

第一次迭代：

$$
dist^{0}=\left[
\begin{array}{c:ccc}
0 & 1 & 4 & \infty \\ \hdashline
\infty & 0 & 2 & 5 \\
\infty & \infty & 0 & 1 \\
2 & 3 & 6 & 0 \\
\end{array}
\right]
\
path^{0}=\left[
\begin{array}{c}
-1 & 0 & 0 & -1 \\
-1 & -1 & 1 & 1 \\
-1 & -1 & -1 & 2 \\
3 & 0 & 0 & -1 \\
\end{array}
\right]
$$

第二次迭代：

$$
dist^{1}=\left[
\begin{array}{c:c:cc}
0 & 1 & 3 & 6 \\ \hdashline
\infty & 0 & 2 & 5 \\ \hdashline
\infty & \infty & 0 & 1 \\
2 & 3 & 5 & 0 \\
\end{array}
\right]
\
path^{1}=\left[
\begin{array}{c}
-1 & 0 & 1 & 1 \\
-1 & -1 & 1 & 1 \\
-1 & -1 & -1 & 2 \\
3 & 0 & 1 & -1 \\
\end{array}
\right]
$$

第三次迭代：

$$
dist^{2}=\left[
\begin{array}{cc:c:c}
0 & 1 & 3 & 4 \\ 
\infty & 0 & 2 & 3 \\ \hdashline
\infty & \infty & 0 & 1 \\ \hdashline
2 & 3 & 5 & 0 \\
\end{array}
\right]
\
path^{2}=\left[
\begin{array}{c}
-1 & 0 & 1 & 2 \\
-1 & -1 & 1 & 2 \\
-1 & -1 & -1 & 2 \\
3 & 0 & 1 & -1 \\
\end{array}
\right]
$$

第四次迭代：

$$
dist^{3}=\left[
\begin{array}{ccc:c}
0 & 1 & 3 & 4 \\ 
5 & 0 & 2 & 3 \\ 
3 & 4 & 0 & 1 \\ \hdashline
2 & 3 & 5 & 0 \\
\end{array}
\right]
\
path^{3}=\left[
\begin{array}{c}
-1 & 0 & 1 & 2 \\
3 & -1 & 1 & 2 \\
3 & 3 & -1 & 2 \\
3 & 0 & 1 & -1 \\
\end{array}
\right]
$$
