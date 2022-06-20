---
title: 散列查找
toc: true
authors:
  - EndlessPeak
date: 2021-02-10
hidden: false
draft: false
weight: 15
---

## 处理冲突方法

主要分为开放定址法、拉链法（链地址法）和再散列法。

### 开放定址法

开放定址法意思是可存放新表项的空闲地址既向同义词开放，又向非同义词开放。
$$
H_i=(H(key)+d_i)\%m
$$
主要分为

1. 线性探测（再散列）法
2. 平方探测（再散列）法；二次探测（再散列）法
3. 伪随机序列（再散列）法。

## 查找长度计算

### 线性探测法

#### 查找成功

$$
ASL_{成功}=\frac{SearchCount}{N}
$$

对于查找次数$SearchCount$，它是通过哈希函数查找到各元素的次数总和，即：
$$
SearchCount=\sum_{i=1}^{N}a_{i}
$$

$$
a_i=\begin{equation}
\left\{
		\begin{array}{lr}
        1 & 若元素无冲突 \\
        ... & 冲突次数不确定 \\  
    	\end{array}
\right.
\end{equation}
$$

#### 查找失败

$$
ASL_{失败}=\frac{SearchCount'}{p}
$$

对于质数$p$，它是哈希函数选取的用作MOD的数。

对于查找次数$SearchCount’$，它是对长为质数$p$的表中各个元素一直查找到空为止的次数和，即：
$$
SearchCount'=\sum_{i=1}^{p}p_i
$$

$$
p_i=\begin{equation}
\left\{
             \begin{array}{lr}
             1  & 若表的该处为空 \\
             N-i+1  & 若该处一直到表的结尾均不为空 \\
             ... & 到空位置为止，空位置算一次 \\  
             \end{array}
\right.
\end{equation}
$$

哈希表长$m>p$。

### 链地址法

#### 查找成功

$$
ASL_{成功}=\frac{SearchLength}{N}
$$

$SearchLength$是链表中搜索各有值结点的路径长度和；
$$
SearchLength=\sum_{i=1}^{N}l_i
$$
$l_i$是每个元素从链结点到该结点的长度；

$N$是关键字序列的个数(即链表中的空元素不计算)；

$p$是链表长度(拉链长度通常取质数$p$，小于表长)。

#### 查找失败

$$
ASL_{失败}=\frac{N}{p}
$$



