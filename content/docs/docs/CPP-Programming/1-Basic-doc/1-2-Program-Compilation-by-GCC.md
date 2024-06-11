---
title: Program Compilation by GCC
author:
    - EndlessPeak
toc: true
featuredImage:
date: 2022-07-01
draft: false
hidden: false
weight: 2
description: 本文总结了 C/C++ 程序使用GCC从源文件进行编译的过程。
---

## GNU Compile Collection

Linux 平台上使用的编译器是 GCC(GNU Compile Collection) 编译器。

当提到 GCC 时，通常指的是 GNU 编译器套件，它支持多种高级语言（实验性的），提供较好支持的语言包括：

1.  C/C++
2.  Fortran
3.  Ada
4.  Objective-C/C++
5.  D
6.  Rust

GCC 为这些语言提供了良好的链接支持，同时提供了相对应的编译工具，它们都属于 GCC 的一部分。

当提到 gcc 时，专指的是 gcc 编译器，它的编译选项可以归纳为以下几类：

1.  总体选项
    ```text
    -c	对源文件进行编译或汇编
    -E	对源文件进行预处理
    -S	对源文件进行编译
    -o	输出目标文件
    -v	显示编译阶段命令
    ```
2.  语言选项
    ```text
    -ansi	支持符合ANSI标准的C语言程序
    -x	用户可以输出希望gcc处理的语言
    ```
    对 GCC 的 `-x` 功能说明：

    1.  可以用该功能调用 GCC 针对不同语言的编译前端处理不同的代码，支持 `c/c++/assembly` 等三种语言
    2.  `-x c++` 可以处理 C++代码，但是有以下内容需要注意：
        1.  gcc 默认不会链接 C++的标准库，需要 `-lstdc++` 才能正常编译
        2.  gcc 不会自动定义 `__cplusplus` 宏，需要手动添加 `-D__cplusplus` 参数

3.  警告选项
    ```text
    -W	屏蔽所有的警告信息
    -Wall	显示所有类型的警告信息
    -Werror	出现警告信息就停止编译（将警告视作错误）
    ```
4.  调试选项
    ```text
    -g	产生调试信息
    ```
5.  优化选项
    ```text
    -O0	不进行任何优化
    -O1	对目标文件的性能进行优化
    -O2	提高目标文件的运行性能
    -O3	支持函数集成优化
    ```
6.  链接选项
    ```text
    -Wl,<option>	将该选项跳过并传递该选项给链接器
    -l<library>	链接指定的库文件
    -L <dir>	指定链接器的额外搜索路径
    -static	指定使用静态链接
    -shared	生成共享文件（动态库）
    -fuse-ld 指定使用哪个链接器
    ```
7.  目录选项
    ```text
    -I <dir>	指定头文件的搜索目录
    -L <dir>	指定链接器的额外搜索路径
    ```
8.  配置选项
    待补充。


## Preprocessing

处理宏定义和 `include` ，去除所有的注释。 **不会对语法错误进行检查。**

如果需要知道 `#inlcude <...>` 的搜素路径，可以在预处理时加上 `-v` 选项，显示搜索列表的详情。

特别地，如果仅执行 `gcc -v` ，则得到的是 gcc 的版本。

```shell
gcc -E a.c -o a.i
gcc -E a.c -o a.i -v
```


## Compilation {#compilation}


### Native Compilation

狭义上编译指的是生成汇编代码，并在此阶段检查语法错误。 **不会对逻辑错误进行检查。**

```shell
gcc -S a.i -o a.s
```

广义上编译指一直到生成 **可重定位** 的目标代码。


### Cross Compilation

交叉编译是在一个平台上生成另一个平台上的可执行代码。用来编译这种程序的编译器叫交叉编译器。交叉编译器的名字一般都有前缀，如 `arm-none-eabi-gcc` 。

交叉编译的使用方法跟本地编译相似，但有一点特殊的是：必须用 `-L` 和 `-I` 参数指定编译器用 arm 系统的库和头文件，不能用本地(X86)的库。或者也可以在 `makefile` 中使用 `-include` 指定头文件位置。


## Assembly

使用 `-C` 参数生成可重定位的目标代码。

```shell
gcc -c a.s -o a.o
```

可重定位的目标代码不能直接执行，可使用 `file` 命令查看：

```shell
file a.o
a.o: ELF 64-bit LSB relocatable
```

考虑下面的两个 C++ 源代码文件：
A.cpp：

```cpp
#include <iostream>
#include "B.h"
int main(){
    int a = 100;
    swap(&a, &shared);
    std::cout<<a<<std::endl;
    std::cout<<shared<<std::endl;
}
```

B.h:

```cpp
extern int shared;
void swap(int * a, int * b);
```

B.cpp：

```cpp
#include "B.h"
int shared = 1;
void swap(int* a, int* b){
    int tmp = *a;
    *a =  *b;
    *b = tmp;
}
```

编译上面两个程序的命令是：

```shell
g++ -c B.cpp -o B.o
g++ -c A.cpp -o A.o
```


## Linking

将各个可重定位的目标代码与启动代码组合起来。

```shell
gcc a.o -o a
```

例如，将上面两个程序的目标代码组合并运行：

```shell
g++ A.o B.o -o a1
```

链接分为静态链接和动态链接两种，默认为动态链接，不必指明链接方式，可以添加需要链接的库文件参数；静态链接则均需显式说明。

需要注意的是，无论是静态链接还是动态链接，链接的目标都是 **库文件** 而不是 **目标文件** 。


### Dynamic Linking


#### Concept

动态链接是运行时链接，把调用所需要的动态库(或称为共享库)的模块和在库中的\*位置信息\*链接进目标程序，程序运⾏的时候寻找相应的库文件，并从中执行相应的代码，因此需要被链接的动态库文件的支持 。

`gcc` 和 `g++` 都是默认使用动态链接的。因此不需要考虑额外的命令。


#### Generate

生成动态库的方法如下：

1.  准备好源文件和其对应的头文件，源文件可以有多个，头文件数量可以和源文件数量不同，也可以和编译出的库文件数量不同；
2.  使用下面的命令编译动态库：
    ```shell
    g++ B.cpp -shared -fPIC -o libB.so
    ```
    需要注意：

    1.  `-shared` 表明编译的是共享库
    2.  `-fPIC` 表明指定生成位置无关代码
    3.  特别地，此处绝对不能使用 `-c` 选项，否则编译结果将为可重定向的目标文件，而非共享库
3.  使用下面的命令链接：
    ```shell
    g++ A.cpp -L . -lB -o A
    ```

4.  由于默认动态库的链接路径为 `/usr/lib` ，因此从当前路径链接需要修改生成的二进制文件，可以修改 `LD_LIBRARY_PATH` 或者使用 `patchelf`
    ```shell
    patchelf --add-rpath . A
    ```

5.  使用 `ldd` 来检查二进制程序依赖的动态库。
    ```shell
    ldd ./a1
    ```


#### Advantage

1.  对同一个函数的调用只会在内存中产生一份拷贝，无论是多个相同的程序还是不同的程序；
    这是因为动态库使用相对地址，所有依赖的进程都可从同一入口进入；
2.  更新方便，只需要对库文件进行更新，而不需要更新依赖库文件的程序；
3.  动态库可以再包含其他的动态或静态库。


#### Disadvantage

链接推迟到了程序运行时，执行程序会有性能损失。


### Static Linking

#### Concept

静态链接是编译时链接，把源文件中用到的静态库（归档文件）直接放进目标程序，程序运行的时候不再需要其它的库文件。


#### Generate

生成静态库的方法如下：

1.  编译代码为目标文件
    ```shell
    g++ -c B.cpp -o B.o
    ```

2.  将目标文件生成静态库(归档文件)

    1.  `r` 将文件插入到静态库中，如果文件已经存在于库中，则替换原有的文件
    2.  `c` 创建一个静态库，如果库文件不存在，则创建一个新的库文件
    3.  `s` 为静态库中的成员文件创建符号表，这对于链接时解析符号非常重要

    ```shell
    ar rcs libB.a B.o
    ```

3.  使用 `-static` 参数显式指定使用静态链接的方式。
    ```shell
    g++ -static A.o -L . -lB -o a2
    ```

静态链接下，所有依赖的库均已与该程序一起合并成了一个二进制文件，因此无法查看依赖的库。


#### Advantage

直接执行程序而不需要链接，没有性能损失。


#### Disadvantage

1.  对同一个函数的调用会在内存中产生多份拷贝，即使是相同的程序的多个运行实例（即进程）也会如此；
    这是因为不同的进程有各自的地址空间，入口不同，程序不知道如何共享；
2.  库文件需要更新时，依赖它的所有程序都需要重新编译，否则只能使用原来的版本；
3.  静态库不能再 **包含其他静态库和动态库** 。
    因为静态库是编译好的归档文件，不能与其他库链接。除非重新用归档工具将多个静态库的源文件链接成一个新的静态库。


## Loading

运行生成的可执行文件。

```shell
./a
```

可执行的目标代码可以直接执行，可使用 `file` 命令查看：

```shell
file a
a: ELF 64-bit LSB executable
```

如需检查返回值，使用命令 `echo $?` ，它将显示上次程序执行完后的返回值。


## Optimization

编译的过程并非每一步命令都是必须的，可以跳过一些步骤，编译器会自动处理。


### Pre/Compile/Assembly

从源文件快速生成目标文件的命令：

```shell
gcc -c a.c -o a.o
```


### Rapid Generation

从源文件快速生成可执行文件的命令：

```shell
gcc a.c -o a
```
