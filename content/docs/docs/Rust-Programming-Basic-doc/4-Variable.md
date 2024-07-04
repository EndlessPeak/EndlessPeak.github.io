---
title: Variable
authors:
  - EndlessPeak
toc: true 
date: 2023-07-11
hidden: false
draft: false
weight: 4
description: 本文记录了通用编程概念在Rust背景下的表现形式。
---

## Variable Basic {#variable-basic}


### Varibale {#varibale}

变量拥有以下特性：

1.  默认情况下变量是不可变的(immutable)
    1.  它是 Rust 众多精妙特性的其中一个
    2.  它令用户充分利用 Rust 提供的安全性和简单并发性的方式来编写代码
    3.  在此情况下，一旦将值绑定到变量将不能再更改
2.  添加 `mut` 关键字让变量可变(mutable)


### Constant {#constant}

常量是绑定到一个常量名且不允许更改的值，它与不可变变量的差异如下：

1.  常量使用 `const` 关键字，并且 **必须注明类型**
2.  常量只能设置成常量表达式，这代表：
    1.  编译期计算完成，不能在运行时计算
    2.  不能是函数调用的结果
3.  常量命名约定是全部字母大写，且下划线分隔单词

<!--listend-->

```rust
const THREE_HOURS_IN_SECONDS: u32 = 60 * 60 * 3;
```


### Shadow {#shadow}

遮蔽使用户可以声明和前面变量具有相同名称的新变量，它和可变变量差异如下：

1.  如果不小心尝试重新赋值给变量，将得到编译错误
2.  遮蔽允许对值进行转换，也允许对类型进行转换

<!--listend-->

```rust
let spaces = "    ";
let spaces = spaces.len();
```
