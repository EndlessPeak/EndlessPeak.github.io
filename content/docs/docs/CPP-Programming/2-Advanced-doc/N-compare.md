---
title: Compare
authors:
  - EndlessPeak
toc: true 
date: 2023-11-19
hidden: false
draft: false
weight: 2
description: 本文记录用于比较的函数及其相关内容。
---

## Three-way Comparison {#three-way-comparison}

三向比较运算符是C++20引入的特性，可用于确定两个值的大小顺序。它返回一个类枚举(enumeration-like)类型，其定义在 `<compare>` 和 `std` 名称空间中。

相比原始类型，使用三向比较运算符不会带来太多收益；但是对于比较昂贵的对象来说则很有用。


### Strong Ordering {#strong-ordering}

如果操作数是整数类型，则结果是强排序。

1.  `strong_ordering::less`
2.  `strong_ordering::greater`
3.  `strong_ordering::equal`

下面给出了一个操作整数类型的例子。

```cpp
int i {11};
if (std::strong_ordering result { i<=>0 }; result == std::strong_ordering::less) {
    std::cout<<"less"<<"\n";
}
else if(result == std::strong_ordering::greater){
    std::cout<<"greater"<<"\n";
}
else {
    std::cout<<"equal"<<"\n";
}
```


### Partial Ordering {#partial-ordering}

如果操作数是浮点类型，则结果是一个偏序。

1.  `partial_ordering::less`
2.  `partial_ordering::greater`
3.  `partial_ordering::equivalent`
4.  `partial_ordering::unordered`

下面给出了一个操作浮点数类型的例子。

```cpp
#include <cmath>

float a = std::nan("");
float b = std::numeric_limits<float>::infinity();
float c = 3.14;
if( std::partial_ordering result { a<=>b };
    result == std::partial_ordering::unordered)
    std::cout << "Error,some number is illegal." << "\n";
```


### Weak Ordering {#weak-ordering}

如果需要针对自己的类型实现三向比较，则选择弱排序。

1.  `weak_ordering::less`
2.  `weak_ordering::greater`
3.  `weak_ordering::equivalent`

下面给出了一个操作类的对象类型的例子。

```cpp
module;
#include <string>

export module employee;

export class Employee{
public:
    std::string name;
    char first_initial;
    char last_initial;
    int employee_number;
    int salary;
    auto operator<=>(const Employee& other) const -> std::weak_ordering;
};

auto Employee::operator<=>(const Employee& other) const -> std::weak_ordering{
    // 按照薪水进行比较
    if (salary < other.salary) {
        return std::weak_ordering::less;
    } else if (salary > other.salary) {
        return std::weak_ordering::greater;
    } else {
        return std::weak_ordering::equivalent;
    }
}
```

其中：

1.  一般地，三向比较运算符可以写 `auto operator<=>(const Person& other) const = default;` 这个默认成员函数
2.  通过使用 `= default` ，编译器将使用默认的比较行为来生成该函数的实现。默认比较的逻辑是按照类成员顺序逐个比较，并返回适当的 `std::weak_ordering` 值。
3.  在该函数定义中，=const= 关键字表示该成员函数是一个常量成员函数，不修改对象状态。const 关键字必须放在函数参数列表后面，以确保函数签名的一致性。

值得说明的是，如果不指定返回类型，下面的代码将会返回对应数据类型所属的类枚举类型 `std::strong_ordering`

```cpp
auto operator<=>(const Employee& other) const {
    return salary <=> other.salary;
}
```
