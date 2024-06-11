---
title: OpenCV
date: 2024-06-11
authors: 
    - EndlessPeak
toc: true
featuredImage: 
hidden: false
draft: false
weight: 3
description: 本文记录C++第三方库OpenCV编程的相关知识。
---

# CV::Mat
在 OpenCV 中，`cv::Mat` 是用于表示图像或矩阵的主要数据结构。它封装了一个 n 维数组，可以存储不同类型的数值（如图像的像素值）。

`cv::Mat` 的构造和析构过程涉及内存管理和引用计数机制，确保高效和安全地处理图像数据。

## Constructor
`cv::Mat` 有多种构造方式，以下是几种常见的构造方法：

1. 默认构造函数
   
   创建一个空的 cv::Mat 对象:`cv::Mat mat;`

2. 指定大小和类型的构造函数
   
   创建一个指定大小和类型的矩阵:`cv::Mat mat(rows, cols, type);` 例如创建一个 3x3 的单通道 8 位无符号整数矩阵：`cv::Mat mat(3, 3, CV_8UC1);`

3. 通过数据指针和步长构造

   使用已有数据指针创建 `cv::Mat`: `cv::Mat mat(rows, cols, type, data, step);`

4. 通过文件读取构造
   
   读取图像文件并创建 cv::Mat 对象。如`cv::Mat mat = cv::imread("image.jpg", cv::IMREAD_COLOR);`

## Destructor
`cv::Mat` 的析构函数会自动处理内存管理，确保内存安全释放。OpenCV 使用引用计数机制来管理 cv::Mat 对象的内存，当没有对象引用时，内存才会被释放。

以下是析构的过程：

1. 引用计数递减：

   cv::Mat 内部维护了一个指向数据的指针和一个引用计数。当 cv::Mat 对象被销毁时，引用计数递减。

2. 内存释放：

   如果引用计数变为零，说明没有对象再引用这块内存，才会释放数据内存。

以下是一个简化的示例，展示 cv::Mat 的引用计数和内存管理：

```cpp
#include <opencv2/opencv.hpp>
#include <iostream>

void display_ref_count(const cv::Mat& mat) {
    std::cout << "Reference count: " << mat.u->refcount << std::endl;
}

int main() {
    cv::Mat mat1 = cv::imread("image.jpg", cv::IMREAD_COLOR);
    display_ref_count(mat1);  // 初始引用计数

    {
        cv::Mat mat2 = mat1;  // mat2 共享 mat1 的数据
        display_ref_count(mat1);  // 引用计数增加
        display_ref_count(mat2);
    }  // mat2 作用域结束，引用计数减少

    display_ref_count(mat1);  // mat2 销毁后，引用计数减少

    return 0;
}
```

结论：
1. 构造：cv::Mat 提供多种构造函数，可以创建空矩阵、指定大小和类型的矩阵，或通过已有数据指针创建矩阵。
2. 析构：cv::Mat 使用引用计数机制管理内存，当引用计数为零时释放内存，确保内存安全。

通过这种机制，OpenCV 确保 cv::Mat 对象的内存管理高效且安全，避免内存泄漏和重复释放的问题。