---
title: Data Type
authors:
  - EndlessPeak
toc: true 
date: 2023-07-11
hidden: false
draft: false
weight: 5
description: 本文记录了Rust中常见的数据类型。
---

## Data Type {#data-type}

Rust 是一种静态类型（statically typed）的语言，它必须在编译期知道所有变量的类型。

1.  常见的静态类型语言有 C/C++/Java/C#/Rust/Go/Swift/TypeScript/Kotlin/Haskell
2.  常见的动态类型语言有 JavaScript/Python/Ruby/PHP/Perl/Lua/Shell/R/Matlab/Lisp


## Scalar {#scalar}

标量类型表示单个值，Rust 基本的标量类型有整型、浮点型、布尔型、字符


### Integer {#integer}


#### Type {#type}

Rust 整型如表所示：

| 长度  | 有符号类型 | 无符号类型 | 字节 |
|-----|-------|-------|----|
| 8 位  | i8    | u8    | 1  |
| 16 位 | i16   | u16   | 2  |
| 32 位 | i32   | u32   | 4  |
| 64 位 | i64   | u64   | 8  |
| 128 位 | i128  | u128  | 16 |
| arch  | iszie | usize | -  |

注：

1.  有符号和无符号表示数字能否取负数，有符号数字以二进制补码形式存储。
2.  存储范围
    1.  每个有符号类型存储范围是 \\(-(2^{n-1})\\) ~ \\(2^{n-1}-1\\)
    2.  每个无符号类型存储范围是 0 ~ \\(2^{n}-1\\)
3.  默认整型是 `i32`
4.  `isize` 和 `usize` 主要用于某些集合的索引

对于数学计算：

1.  Rust 所有数字类型都支持基本数学运算
2.  整数除法会向下取整


#### Literal {#literal}

Rust 整型字面量格式如表所示：

| 数字字面量 | 示例        |
|-------|-----------|
| 十进制 | 98_222      |
| 十六进制 | 0xff        |
| 八进制 | 0o77        |
| 二进制 | 0b1111_0000 |
| 字节  | b'A'        |

注：字节字面量仅限于 `u8` 类型。


#### Overflow {#overflow}

整型溢出分为两种：

1.  当在调试（debug）模式编译时，Rust 会检查整型溢出，若存在这些问题则使程序在编译时 panic。
2.  在当使用 `--release` 参数进行发布（release）模式构建时
    1.  Rust 不检测会导致 panic 的整型溢出
    2.  当运行到整型溢出时，Rust 会进行一种被称为二进制补码包裹（two’s complement wrapping）的操作
    3.  简而言之类似环绕，从最大值变为最小值

要显式处理溢出的可能性，可以使用标准库针对原始数字类型提供的以下一系列方法：

1.  使用 `wrapping_*` 方法在所有模式下进行包裹
2.  使用 `checked_*` 方法，发生溢出则返回 `None` 值
3.  使用 `overflowing_*` 方法返回该值和一个指示是否存在溢出的布尔值
4.  使用 `saturating_*` 方法使该值达到最小值或最大值


### Floating {#floating}

Rust 的浮点类型有两种类型：

1.  `f32` 大小为 32 位
2.  `f64` 大小为 64 位
    1.  它是默认浮点类型
    2.  在现代的 CPU 中它的速度与 `f32` 的几乎相同，但精度更高

注：所有浮点型都是有符号的。


### Boolean &amp; Char {#boolean-and-char}

1.  布尔类型可用 `bool` 声明，布尔值的大小为 1 个字节。
2.  字符类型可用 `char` 声明，字符类型大小为 4 个字节。

注：

1.  字符 `char` 字面量采用 **单引号** 括起来
2.  字符串 `String` 字面量采用 **双引号** 括起来
3.  字符表示的是一个 Unicode 标量值，这意味着它可以表示的远远不止 ASCII


## Compound {#compound}


### Tuple {#tuple}

1.  元组是将多种类型的多个值组合到一个复合类型中的一种基本方式
2.  元组的长度是固定的，声明后就无法修改

元组的绑定与通过模式匹配进行解构的过程如下所示：

```rust
fn main() {
    let tup = (500, 6.4, 1);
    let tup: (i32, f64, u8) = (500, 6.4, 1);

    let (x, y, z) = tup;

    println!("The value of x is: {}", x);
    println!("The value of y is: {}", y);
    println!("The value of z is: {}", z);
}
```

元组的元素访问如下所示：

```rust
fn main() {
    let x: (i32, f64, u8) = (500, 6.4, 1);
    let five_hundered = x.0;
    let six_point_four = x.1;
    let one = x.2;
}
```

Rust 元组与 C 语言结构体的相似之处：

1.  都可以用于组合多个值，以作为整体进行处理
2.  元组和结构体都可以包含不同类型的数据成员
3.  元组和结构体都可以通过索引访问成员

Rust 元组与 C 语言结构体的不同之处

1.  成员构成
    1.  元组的成员仅有值，只能通过索引访问，索引用 **点号**
    2.  结构体的成员是键值对，即可以通过索引或字段名访问
2.  应用场景
    1.  元组主要为临时存储、函数返回值等简单场景
    2.  结构体主要用于自定义数据结构

特别注意，Rust 中存在空元组的概念：

1.  没有任何值的元组 `()` 是一种特殊的类型，它只有一个值 `()`
2.  该类型被称为单元类型(unit type)，该值被称为单元值(unit value)
3.  如果表达式不返回任何其他值，就隐式地返回单元值
4.  由于它没有元素，因此无法解构或访问其中的内容


### Array {#array}

1.  数组的每个元素都具有相同类型，Rust 中数组具有固定长度。
2.  当希望数据分配到栈上而非堆上时，或希望确保始终具有固定数量元素，选择数组
3.  如果希望使用动态数组，选择 `vector`

<!--listend-->

```rust
fn main() {
    let weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];
    let a: [i32; 5] = [1, 2, 3, 4, 5];
    let a = [3; 5];

    let first = a[0];
}
```

如果产生了无效的数组元素访问，则会导致运行时错误，Rust 程序会 panic 并退出。

```rust
use std::io;
fn main() {
    let a = [1, 2, 3, 4, 5];
    println!("Please enter an array index.");

    let mut index = String::new();

    //这里用直接expect的写法
    io::stdin()
        .readline(&mut index)
        .expect("Failed to read line.");

    //这里用match的方法
    let index: usize = match index.trim().parse() {
        Ok(num) => num,
        Err(_) => expect("Failed to parse number"),
    };

    let element = a[index];

    println!(
        "The value of the element at index {} is {}",
        index, element
    );
}
```
