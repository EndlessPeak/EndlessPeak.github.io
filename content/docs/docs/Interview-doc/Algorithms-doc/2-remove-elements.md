---
title: Remove Element
author: 
    - EndlessPeak
date: 2024-06-10
toc: true
hidden: false
draft: false
weight: 2
description: 移除数组中指定的元素
---

## Remove Element

给你一个数组 `nums` 和一个值 `val`，你需要 *原地* 移除所有数值等于 `val` 的元素。元素的顺序可能发生改变。然后返回 `nums` 中与 `val` 不同的元素的数量。

假设 `nums` 中不等于 `val` 的元素数量为 `k`，要通过此题，需要执行以下操作：

1.  更改 `nums` 数组，使 `nums` 的前 `k` 个元素包含不等于 `val` 的元素。=nums= 的其余元素和 `nums` 的大小并不重要
2.  返回 `k`


## Code

双指针法，一个指向被赋值的元素，一个指向查找的元素。
我写的方法是头指针与尾指针调换(仅给头指针赋值)。

```cpp
class Solution {
public:
    int removeElement(vector<int>& nums, int val) {
        int length = nums.size();
        int head = 0;
        int tail = length - 1;
        for (head=0; head<=tail; head++) { // 考虑相等时该元素可能需要被排除
            if(nums[head]==val) {
                nums[head]=nums[tail--];
            }
            else {
                head++;
            }
        }
        return tail+1; // 考虑所有都不符合要求，使用head+1会导致多增加一个
    }
};
```

官方题解是双指针都从头出发。

其实这类题目隐含的是数组最右侧都是不需要关心的，此时双指针即可从头开始触发。

```cpp
class Solution {
public:
    int removeElement(vector<int>& nums, int val) {
        int left = 0; // 头指针
        int length = nums.size();// 长度

        for(int right=0;right<length;right++){
            if(nums[right]!=val){
                nums[left]=nums[right];
                left++;
            }
        }
        return left;
    }
};
```
