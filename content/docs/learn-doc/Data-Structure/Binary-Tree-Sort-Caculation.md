---
title: 二叉排序树
toc: true
authors:
  - EndlessPeak
date: 2021-02-10
hidden: false
draft: false
weight: 10
---

## 二叉排序树

### 查找长度计算

查找成功情况下：
$$
ASL_{成功}=\frac{SearchLength}{N}
$$

$SearchLength$是链表中搜索各有值结点的路径长度和；

$N$是二叉排序树中结点的个数。
$$
SearchLength=\sum_{i=1}^{N}l_i
$$

$l_i$是每个结点从根结点到该结点的长度。

查找失败情况下：
$$
ASL_{失败}=\frac{SearchLength'}{N’}
$$
$SearchLength'$是链表中搜索**非满孩子的结点**的**虚拟子结点**路径长度和；
$$
SearchLength'=\sum_{i=1}^{N'}l'_i
$$

$l'_i$是每个非满孩子的结点的虚拟子结点从根结点到该结点的长度。

$N’$是二叉排序树中各叶子结点的虚拟子结点的个数。