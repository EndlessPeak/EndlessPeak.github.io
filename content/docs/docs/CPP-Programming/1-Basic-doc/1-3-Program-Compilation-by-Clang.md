---
title: Program Compilation by Clang
author:
    - EndlessPeak
toc: true
featuredImage:
date: 2023-07-13
draft: false
hidden: false
weight: 3
description: 本文总结了C/C++程序使用clang编译的过程
---

## Low Level Virtual Machine


### General

LLVM(Low Level Virtual Machine)是一个开源的编辑器基础设施项目。

> LLVM 最初设计时，因为只想着做优化方面的研究，所以只是想搭建一套虚拟机，所以当时这个的全称叫 Low Level Virtual machine
>
> 后来因为要变成编译器，官方就放弃了这个称呼，不过 LLVM 的简称还是保留下来了

LLVM 提供了一组通用的编译工具和技术：

1.  编译器前端
2.  优化器
3.  代码生成器
4.  链接器

LLVM 支持多种编程语言：

1.  C/C++
2.  Objective-C/C++
3.  Rust
4.  Swift


### IR

LLVM 提供了灵活的中间表示（Intermediate Representation,IR）和强大的优化功能，使得编译器可以更高效地生成高质量的目标代码。IR 是 LLVM 编译快的原因之一，它不像 gcc 在每个阶段结束生成一些中间过程文件。

在 LLVM 中，IR 有两种表示：

1.  可读的 IR
    1.  类似于汇编代码，其实它介于高等语言和汇编之间，这种表示的磁盘文件后缀为.ll；
    2.  是编写和调试优化器规则和转换的首选形式
2.  二进制 IR
    1.  称作位码(bitcode)，磁盘文件后缀为.bc；
    2.  二进制形式是一种紧凑、可序列化的格式，可以在不丢失信息的情况下进行存储和传输
    3.  可以被后续阶段的 LLVM 工具直接读取和处理，也可以在不同系统之间进行跨平台的交流和共享

> LLVM 还提供了一种称为"Memory Buffer"的数据结构，用于在内存中存储和传输 LLVM IR 的文本表示形式
>
> 这种形式可以方便地在内存中进行读写和处理，但它并不是 LLVM IR 的一种独立形式。

LLVM IR：

1.  不是直接对应于内存中的数据结构，而是一种抽象的中间表达形式
2.  用于表示源代码的控制流、数据流以及各种指令和操作
3.  在编译过程中，LLVM IR 可以在内存中进行操作和转换，但它并不是一种专门的内存格式。

可以在 Clang/LLVM 工具的参数中指定生成这些文件，通过 `llvm-as` 和 `llvm-dis` 来在两种 IR 之间做转换。


## Clang

Clang(Compiler Front End for LLVM)是一个开源的编译前端。

C、C++、Objective-C 和 Objective-C++编译器前端。clang 主要负责将源代码转换为中间表示（LLVM IR），并将其传递给 LLVM 后端进行优化和生成目标代码。

> 最初时，LLVM 的前端是 GCC，后来 Apple 立志自己开发了 Clang 取代 GCC
>
> 不过现在带有 `Dragon Egg` 的 GCC 还是可以生成 LLVM IR，也同样可以取代 Clang 的功能


## Linker

LLVM 的链接器是 `lld` 。
