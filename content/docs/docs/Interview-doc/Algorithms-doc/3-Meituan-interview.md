---
title: MeiTuan Interview 1
author: 
    - EndlessPeak
date: 2024-06-17
toc: true
hidden: false
draft: false
weight: 3
description: 美团2024年春招第一场笔试题目。
---

## 平衡矩阵
小美拿到了一个 $n∗n$ 的矩阵，其中每个元素是 0 或者 1。小美认为一个矩形区域是完美的，当且仅当该区域内 0 的数量恰好等于 1 的数量。

现在，小美希望你回答有多少个 $i∗i$ 的完美矩形区域。

你需要回答 $1\leq i \leq n$ 的所有答案。

**输入描述：**

第一行输入一个正整数n，代表矩阵大小。
接下来的n行，每行输入一个长度为n的 01 串，用来表示矩阵。
$1\leq n \leq 200$

**输出描述：**

输出n行，第i行输出i*i的完美矩形区域的数量。

**解题思想：**
1. 前缀和数组计算：
   1. prefix_zeros 数组的每个元素 prefix_zeros[i][j] 表示从矩阵左上角 (0, 0) 到 (i, j) 范围内 0 的数量。
   2. 利用动态规划的方法逐步累加每个位置的0数量，并减去重复计算的部分
2. 快速计算子矩阵中的0数量：
   
   利用 prefix_zeros 数组，快速计算任意子矩阵中0的数量。计算公式基于二维前缀和的性质。

```cpp
bool perfect_matrix(int count_zero, int size) {
    int total_elements = size * size;
    return count_zero * 2 == total_elements;
}

std::vector<std::vector<int>> compute_prefix_zeros(const std::vector<std::vector<int>>& a, int n) {
    std::vector<std::vector<int>> prefix_zeros(n, std::vector<int>(n, 0));
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            prefix_zeros[i][j] = (a[i][j] == 0 ? 1 : 0);
            if (i > 0) prefix_zeros[i][j] += prefix_zeros[i-1][j];
            if (j > 0) prefix_zeros[i][j] += prefix_zeros[i][j-1];
            if (i > 0 && j > 0) prefix_zeros[i][j] -= prefix_zeros[i-1][j-1];
        }
    }
    return prefix_zeros;
}

int count_zeros_in_submatrix(const std::vector<std::vector<int>>& prefix_zeros, int x1, int y1, int size) {
    int x2 = x1 + size - 1;
    int y2 = y1 + size - 1;
    int total = prefix_zeros[x2][y2];
    if (x1 > 0) total -= prefix_zeros[x1-1][y2];
    if (y1 > 0) total -= prefix_zeros[x2][y1-1];
    if (x1 > 0 && y1 > 0) total += prefix_zeros[x1-1][y1-1];
    return total;
}

int main() {
    int n;
    std::cin >> n;
    std::vector<std::vector<int>> a(n, std::vector<int>(n)); 
    for (int i = 0; i < n; i++) {
        std::string row;
        std::cin >> row;
        for (int j = 0; j < n; j++) {
            a[i][j] = row[j] - '0';
        }
    }

    // 计算前缀和数组
    std::vector<std::vector<int>> prefix_zeros = compute_prefix_zeros(a, n);

    for (int size = 1; size <= n; size++) {
        int count = 0;
        // 遍历所有可能的子矩阵起点
        for (int i = 0; i <= n - size; i++) {
            for (int j = 0; j <= n - size; j++) {
                int count_zero = count_zeros_in_submatrix(prefix_zeros, i, j, size);
                if (perfect_matrix(count_zero, size))
                    count++;
            }
        }
        std::cout << count << std::endl;
    }

    return 0;
}
```

## 数组询问
小美拿到了一个由正整数组成的数组，但其中有一些元素是未知的（用0来表示）。

现在小美想知道，如果那些未知的元素在区间 $[l,r]$ 范围内随机取值的话，数组所有元素之和的最小值和最大值分别是多少？

共有q次询问。

**输入描述：**

第一行输入两个正整数n,q，代表数组大小和询问次数。
第二行输入n个整数a_i，其中如果输入的a_i为 0，那么说明a_i是未知的。
接下来的q行，每行输入两个正整数 l,r，代表一次询问。

$$
\begin{aligned}
1\leq n,q \leq 10^5
0 \leq a_i \leq 10^9
1\leq l \leq r \leq 10^9
\end{aligned}
$$

**输出描述：**

输出 $q$ 行，每行输出两个正整数，代表所有元素之和的最小值和最大值。

示例：

输入例子：
```text
3 2
1 0 3
1 2
4 4
```
输出例子：
```text
5 6
8 8
```

例子说明：

1. 只有第二个元素是未知的。
2. 第一次询问，数组最小的和是 1+1+3=5，最大的和是 1+2+3=6。
3. 第二次询问，显然数组的元素和必然为 8。

**解题思想：**

1. 前缀和数组：预处理已知元素的前缀和，使得每次查询能够快速计算已知元素的和。
2. 统计未知元素：在处理每个查询时，统计数组中未知元素（即值为0的元素）的数量，并根据查询的范围 $[l, r]$ 计算最小值和最大值。

```cpp
#include <iostream>
#include <vector>
#include <numeric>
using namespace std;

int main() {
    int n, q;
    cin >> n >> q;
    vector<int> a(n);
    vector<long long> prefix_sum(n + 1, 0);
    vector<int> unknown_count(n + 1, 0);

    for (int i = 0; i < n; ++i) {
        cin >> a[i];
        // 计算前缀和，对已知元素进行累加
        prefix_sum[i + 1] = prefix_sum[i] + (a[i] != 0 ? a[i] : 0);
        // 统计未知元素的数量
        unknown_count[i + 1] = unknown_count[i] + (a[i] == 0 ? 1 : 0);
    }

    for (int i = 0; i < q; ++i) {
        int l, r;
        cin >> l >> r;
        long long known_sum = prefix_sum[n];
        int zero_count = unknown_count[n];
        long long min_value = known_sum + zero_count * l;
        long long max_value = known_sum + zero_count * r;
        cout << min_value << " " << max_value << endl;
    }

    return 0;
}
```