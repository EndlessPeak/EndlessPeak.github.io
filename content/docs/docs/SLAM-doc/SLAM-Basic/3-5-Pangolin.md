---
title: Pangolin Exercise
authors: 
    - EndlessPeak
toc: true
date: 2024-06-19
featuredImage: 
hidden: false
draft: false
weight: 35
description: 本文记录了Pangolin的使用。
---

## CMake Usage

下面提供了一个 `pangolin` 的 `cmake` 模板。

```cmake
cmake_minimum_required(VERSION 3.24)
project(eigen_example)

set(CMAKE_CXX_STANDARD 17)
find_package(Eigen3 REQUIRED)
find_package(Pangolin REQUIRED)
find_package(GLEW REQUIRED)
# find_package(OpenGL REQUIRED)

# 非必须的，但还是加上
include_directories(
    ${Pangolin_INCLUDE_DIRS}
)

include_directories(
    "src/eigen_geometry"
    "src/eigen_matrix"
    "src/argparse"
    "src/coordinate_transform"
    "src/visualize_plot"
)

file(GLOB_RECURSE SOURCES
    "src/*"
    "src/argparse/*"
    "src/coordinate_transform/*"
    "src/eigen_geometry/*"
    "src/eigen_matrix/*"
    "src/visualize_plot/*"
)

add_executable(${PROJECT_NAME} ${SOURCES})
target_link_libraries(${PROJECT_NAME} Eigen3::Eigen)
target_link_libraries(${PROJECT_NAME} ${Pangolin_LIBRARIES})
```

注意事项：

1.  对于 `target_link_libraries(${PROJECT_NAME} Pangolin)`
    1.  在 `CMake Reload Project` 的时候确实不会报错
    2.  编译时会提示大量关于 `pangolin/gl/gl.hpp` 以及 `pangolin/gl/glsl.h` 的错误
2.  CSDN上 **大部分** 解决办法已能够想到对头文件进行设置，如：
    ```cmake
    # Pangolin
    find_package(Pangolin REQUIRED)
    if(Pangolin_FOUND)
        include_directories(${Pangolin_INCLUDE_DIRS})
        message(STATUS "Pangolin FOUND: ${Pangolin_INCLUDE_DIRS}")
    else()
        message(STATUS "Pangolin not FOUND")
    endif()
    ```
    然后把 `pangolin` 从 v0.8 降级到 v0.6 。但这种方法可能忽略了链接的问题，或者说没有找到编译中断的根本原因。
3.  实际上，上面这种链接的写法不会正确链接 `Pangolin` 的库文件，不妨注释这句链接，重新编译后还会出现相同的问题。因此建议使用以上给出的代码链接方法进行链接。
4.  关于 `eigen` 的链接
    1.  理论上来说 `eigen` 是纯头文件库，不需要链接，即可以写 `include_directories` 的方式向项目添加 `eigen` 依赖
    2.  CMake 提供了 `find_package` 的方法，使用该方法需要写 `target_link_libraries` 添加链接，否则编译中断
    3.  `pangolin` 依赖 `eigen` ，因此链接 `pangolin` 的时候可以取消链接 `eigen` ，根据依赖关系，CMake会自动寻找 `eigen` 并进行链接