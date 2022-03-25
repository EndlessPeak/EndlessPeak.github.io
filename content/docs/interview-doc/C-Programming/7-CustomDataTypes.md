---
title: 自定义数据类型
authors:
  - EndlessPeak
toc: true
featuredImage: 
date: 2022-03-25
hidden: false
draft: false
weight: 70
---

## 结构体

存储空间：所有成员变量占用内存空间的和。

结构体定义：

```c
struct student{
	int num;
    char name[20];
    char sex;
    char addr[20];
}std1,std2;//分号前可以直接声明具有结构体类型的变量
```

声明结构体变量：

```c
student a;
```

## 共用体

共用体允许在相同的内存位置存储不同的数据类型。

可以定义带有多成员的共用体，但是任何时候只能有一个成员带有值。为某成员赋值会破坏其他成员存储的值。

```c
union Data{
    int i;
    float f;
    char str[20];
}data1,data2;
```

存储空间：等于最大成员占的内存空间。
