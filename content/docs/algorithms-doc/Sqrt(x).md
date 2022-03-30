---
title: Sqrt(x)
authors:
  - EndlessPeak
toc: true
featuredImage: 
date: 2022-03-21
hidden: false
draft: false
weight: 5
---

## Question

Implement *int sqrt(int x)*.

Compute and return the square root of x.

## Answer

### 二分查找

对于一个非负数n，它的平方根不会大于$\frac{n}{2}+1$。在$[0, \frac{n}{2}+1]$这个范围内进行二分查找，求出n的平方根。

所谓二分查找，又称为折半查找。要求线性表必须采用顺序存储结构，而且表中元素按关键字有序排列。 

```c
int sqrt(int x) {
    int i = 0;
    int j = x / 2 + 1;
    while (i <= j)
    {
        int mid = (i + j) / 2;
        int sq = mid * mid;
        if (sq == x) return mid;
        else if (sq < x) i = mid + 1;
        else j = mid - 1;
    }
    return j;
}
```

### 牛顿迭代法

（待补充牛顿迭代法的完整内容）

为计算$x^2=n$的解，令$f(x)=x^2-n$，即相当于求$f(x)=0$的解。

任取$x_0$，如果$x_0$不是解，作过$(x_0,f(x_0))$的切线，与x轴交点为$x_1$；

同样地，如果$x_1$不是解，作过$(x_1,f(x_1))$的切线，与x轴交点为$x_2$；

以此类推，最终得到$f(x)=0$的解。

其中，经过$(x_i,f(x_i))$点的切线方程为$y-f(x_i)=f'(x_i)(x-x_i)$，其中$f'(x)$是$f(x)$的导数。

令切线方程等于0，则

$$
x_{i+1}=x_i-\frac{f(x_i)}{f'(x_i)}
$$
化简可得
$$
x_{i+1}=x_i-\frac{x_i^2-n}{2x_i}=x_i-\frac{x_i}{2}+\frac{n}{2x_i}=\frac{x_i+\frac{n}{x_i}}{2}
$$
程序如下：

```c
double sqrt(double x){
    if(x==0)	
        return 0;
    double last=0;//即xi
    double res=1;//即xi+1
    while(res!=last){//可以改为res-last<=epsilon,其中epsilon是误差
        last=res;
        res=(res+x/res)/2;
    }
    return res;
}
```

