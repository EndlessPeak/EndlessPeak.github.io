---
title: Rust Installation
authors:
  - EndlessPeak
toc: true 
date: 2023-07-04
hidden: false
draft: false
weight: 1
description: 本文介绍Rust编程语言的安装。
---

## Rustup {#rustup}

`rustup` 是管理 Rust 版本和相关工具的命令行工具。即使部分 Linux 发行版已经打包提供了 `rust` 软件包，我们仍然建议使用 `rustup` ，因为它可以自由地添加目标平台支持以及工具链列表。


### Unix {#unix}

标准的安装 Rust 最新稳定版本的 `rustup` 的流程为：

```shell
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
```

特别需要注意，Rust 代码在编译为目标文件后，需要调用链接器进行链接。

建议安装 GCC (GNU 编译器套件)或 Clang(LLVM 编译器套件)等 C 编译器。一方面，一些常见的 Rust 包依赖于 C 代码；另一方面，Rust 尚无自己独有的稳定链接器。该部分在以后会下该纳西讨论。

> `rustc` 仅能将代码编译为目标文件，不能编译成目标机器指令。
>
> 可以将其看作一个完整的编译前端和部分编译后端，目标文件需要经过链接器链接后生成可执行的文件(目标机器指令)。


### Windows {#windows}

1.  访问 <https://www.rust-lang.org/zh-CN/tools/install> 安装
2.  `Rust` 提供基于 GNU 和 MSVC 构建的版本
    1.  MSVC 需要 C++ build tools，访问 <https://visualstudio.microsoft.com/visual-cpp-build-tools/>
    2.  GNU 需要 MinGW 程序包，安装后配置好环境变量即可。


## Update &amp; Uninstall {#update-and-uninstall}

通过 rustup 安装 Rust 后，更新到最新版本很简单。在 shell 中运行以下更新命令： `rustup update`

要卸载 Rust 和 rustup，在 shell 中运行以下卸载命令： `rustup self uninstall`

特别地，这行卸载命令在 Windows 中会将已注册的环境变量全部删除。


## Doc {#doc}

Rustacean 可以通过 `rustup doc` 在本地打开文档并查看帮助。

在互联网上查阅官方所有文档索引，见 <https://www.rust-lang.org/zh-CN/learn>

对标准库使用有疑问也可访问：

1.  中文版 <https://rustwiki.org/zh-CN/std/>
2.  英文版 <https://doc.rust-lang.org/std/index.html>
