---
title: Modules for CPP
authors:
  - EndlessPeak
toc: true 
date: 2023-11-19
hidden: false
draft: false
weight: 1
description: 本文记录了C++中模块的相关内容。
---

## GCC {#gcc}

`GCC 13` 支持 p1689 特性，但是与 `cmake` 配合尚存在一定问题。


## Clang {#clang}

`Clang 16` 支持 p1689 特性，且可以直接与 `cmake` 配合使用。

注意：

1.  模块特性尚处于实验状态，需要开启对应的 `cmake` 版本的 API。
2.  目前测试情况是需要将模块编译成库进行链接，但不必一定是共享库。

<!--listend-->

```cmake
cmake_minimum_required(VERSION 3.27)
project(learnCPP20)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_EXPERIMENTAL_CXX_MODULE_CMAKE_API "aa1f7df0-828a-4fcd-9afc-2dc80491aca7")
set(CMAKE_EXPERIMENTAL_CXX_MODULE_DYNDEP 1)

add_library(employee_lib SHARED)
target_sources(employee_lib
        PUBLIC
        FILE_SET cxx_modules TYPE CXX_MODULES FILES
        src/employee.cppm
)

add_executable(learnCPP20
    src/employee.cpp
)
```
