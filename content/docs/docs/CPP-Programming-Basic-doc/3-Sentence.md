---
title: 语句
authors:
  - EndlessPeak
toc: true
featuredImage: 
date: 2022-03-22
hidden: false
draft: false
weight: 30
---

## 运算符

<style>
	table,table tr th, table tr td { border:1px solid #000000;text-align:center; }
    table tr td { vertical-align:middle;}
</style>
<table border="1" cellpadding="0" cellspacing="0">
    <tbody>
        <tr>
            <td>
                <p><b>优先级</b></p>
            </td>
            <td>
                <p><b>运算符</b></p>
            </td>
            <td>
                <p><b>名称或含义</b></p>
            </td>
            <td>
                <p><b>使用形式</b></p>
            </td>
            <td>
                <p><b>结合方向</b></p>
            </td>
            <td>
                <p><b>说明</b></p>
            </td>
        </tr>
        <tr>
            <td rowspan="4">
                <p>1</p>
            </td>
            <td>
                <p>[]</p>
            </td>
            <td>
                <p>数组下标</p>
            </td>
            <td>
                <p>数组名[常量表达式]</p>
            </td>
            <td rowspan="4">
                <p>左到右</p>
            </td>
            <td>
                <p>--</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>()</p>
            </td>
            <td>
                <p>圆括号</p>
            </td>
            <td>
                <p>(表达式）/函数名(形参表)</p>
            </td>
            <td>
                <p>--</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>.</p>
            </td>
            <td>
                <p>成员选择（对象）</p>
            </td>
            <td>
                <p>对象.成员名</p>
            </td>
            <td>
                <p>--</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>-&gt;</p>
            </td>
            <td>
                <p>成员选择（指针）</p>
            </td>
            <td>
                <p>对象指针-&gt;成员名</p>
            </td>
            <td>
                <p>--</p>
            </td>
        </tr>
        <tr>
            <td rowspan="9">
                <p>2</p>
            </td>
            <td>
                <p>-</p>
            </td>
            <td>
                <p>负号运算符</p>
            </td>
            <td>
                <p>-表达式</p>
            </td>
            <td rowspan="9">
                <p><b>右到左</b></p>
            </td>
            <td rowspan="7">
                <p>单目运算符</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>~</p>
            </td>
            <td>
                <p>按位取反运算符</p>
            </td>
            <td>
                <p>~表达式</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>++</p>
            </td>
            <td>
                <p>自增运算符</p>
            </td>
            <td>
                <p>++变量名/变量名++</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>--</p>
            </td>
            <td>
                <p>自减运算符</p>
            </td>
            <td>
                <p>--变量名/变量名--</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>*</p>
            </td>
            <td>
                <p>取值运算符</p>
            </td>
            <td>
                <p>*指针变量</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>&amp;</p>
            </td>
            <td>
                <p>取地址运算符</p>
            </td>
            <td>
                <p>&amp;变量名</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>!</p>
            </td>
            <td>
                <p>逻辑非运算符</p>
            </td>
            <td>
                <p>!表达式</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>(类型)</p>
            </td>
            <td>
                <p>强制类型转换</p>
            </td>
            <td>
                <p>(数据类型)表达式</p>
            </td>
            <td>
                <p>--</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>sizeof</p>
            </td>
            <td>
                <p>长度运算符</p>
            </td>
            <td>
                <p>sizeof(表达式)</p>
            </td>
            <td>
                <p>--</p>
            </td>
        </tr>
        <tr>
            <td rowspan="3">
                <p>3</p>
            </td>
            <td>
                <p>/</p>
            </td>
            <td>
                <p>除</p>
            </td>
            <td>
                <p>表达式/表达式</p>
            </td>
            <td rowspan="3">
                <p>左到右</p>
            </td>
            <td rowspan="3">
                <p>双目运算符</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>*</p>
            </td>
            <td>
                <p>乘</p>
            </td>
            <td>
                <p>表达式*表达式</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>%</p>
            </td>
            <td>
                <p>余数（取模）</p>
            </td>
            <td>
                <p>整型表达式%整型表达式</p>
            </td>
        </tr>
        <tr>
            <td rowspan="2">
                <p>4</p>
            </td>
            <td>
                <p>+</p>
            </td>
            <td>
                <p>加</p>
            </td>
            <td>
                <p>表达式+表达式</p>
            </td>
            <td rowspan="2">
                <p>左到右</p>
            </td>
            <td rowspan="2">
                <p>双目运算符</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>-</p>
            </td>
            <td>
                <p>减</p>
            </td>
            <td>
                <p>表达式-表达式</p>
            </td>
        </tr>
        <tr>
            <td rowspan="2">
                <p>5</p>
            </td>
            <td>
                <p>&lt;&lt;&nbsp;</p>
            </td>
            <td>
                <p>左移</p>
            </td>
            <td>
                <p>变量&lt;&lt;表达式</p>
            </td>
            <td rowspan="2">
                <p>左到右</p>
            </td>
            <td rowspan="2">
                <p>双目运算符</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>&gt;&gt;&nbsp;</p>
            </td>
            <td>
                <p>右移</p>
            </td>
            <td>
                <p>变量&gt;&gt;表达式</p>
            </td>
        </tr>
        <tr>
            <td rowspan="4">
                <p>6</p>
            </td>
            <td>
                <p>&gt;&nbsp;</p>
            </td>
            <td>
                <p>大于</p>
            </td>
            <td>
                <p>表达式&gt;表达式</p>
            </td>
            <td rowspan="4">
                <p>左到右</p>
            </td>
            <td rowspan="4">
                <p>双目运算符</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>&gt;=</p>
            </td>
            <td>
                <p>大于等于</p>
            </td>
            <td>
                <p>表达式&gt;=表达式</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>&lt;&nbsp;</p>
            </td>
            <td>
                <p>小于</p>
            </td>
            <td>
                <p>表达式&lt;表达式</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>&lt;=</p>
            </td>
            <td>
                <p>小于等于</p>
            </td>
            <td>
                <p>表达式&lt;=表达式</p>
            </td>
        </tr>
        <tr>
            <td rowspan="2">
                <p>7</p>
            </td>
            <td>
                <p>==</p>
            </td>
            <td>
                <p>等于</p>
            </td>
            <td>
                <p>表达式==表达式</p>
            </td>
            <td rowspan="2">
                <p>左到右</p>
            </td>
            <td rowspan="2">
                <p>双目运算符</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>!=</p>
            </td>
            <td>
                <p>不等于</p>
            </td>
            <td>
                <p>表达式!= 表达式</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>8</p>
            </td>
            <td>
                <p>&amp;</p>
            </td>
            <td>
                <p>按位与</p>
            </td>
            <td>
                <p>表达式&amp;表达式</p>
            </td>
            <td>
                <p>左到右</p>
            </td>
            <td>
                <p>双目运算符</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>9</p>
            </td>
            <td>
                <p>^</p>
            </td>
            <td>
                <p>按位异或</p>
            </td>
            <td>
                <p>表达式^表达式</p>
            </td>
            <td>
                <p>左到右</p>
            </td>
            <td>
                <p>双目运算符</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>10</p>
            </td>
            <td>
                <p>|</p>
            </td>
            <td>
                <p>按位或</p>
            </td>
            <td>
                <p>表达式|表达式</p>
            </td>
            <td>
                <p>左到右</p>
            </td>
            <td>
                <p>双目运算符</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>11</p>
            </td>
            <td>
                <p>&amp;&amp;</p>
            </td>
            <td>
                <p>逻辑与</p>
            </td>
            <td>
                <p>表达式&amp;&amp;表达式</p>
            </td>
            <td>
                <p>左到右</p>
            </td>
            <td>
                <p>双目运算符</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>12</p>
            </td>
            <td>
                <p>||</p>
            </td>
            <td>
                <p>逻辑或</p>
            </td>
            <td>
                <p>表达式||表达式</p>
            </td>
            <td>
                <p>左到右</p>
            </td>
            <td>
                <p>双目运算符</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>13</p>
            </td>
            <td>
                <p>?:</p>
            </td>
            <td>
                <p>条件运算符</a></p>
            </td>
            <td>
                <p>表达式1?</p>
                <p>表达式2: 表达式3</p>
            </td>
            <td>
                <p><b>右到左</b></p>
            </td>
            <td>
                <p>三目运算符</p>
            </td>
        </tr>
        <tr>
            <td rowspan="11">
                <p>14</p>
            </td>
            <td>
                <p>=</p>
            </td>
            <td>
                <p>赋值运算符</p>
            </td>
            <td>
                <p>变量=表达式</p>
            </td>
            <td rowspan="11">
                <p><b>右到左</b></p>
            </td>
            <td>
                <p>双目运算符</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>/=</p>
            </td>
            <td>
                <p>除后赋值</p>
            </td>
            <td>
                <p>变量/=表达式</p>
            </td>
            <td>
                <p>双目运算符</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>*=</p>
            </td>
            <td>
                <p>乘后赋值</p>
            </td>
            <td>
                <p>变量*=表达式</p>
            </td>
            <td>
                <p>双目运算符</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>%=</p>
            </td>
            <td>
                <p>取模后赋值</p>
            </td>
            <td>
                <p>变量%=表达式</p>
            </td>
            <td>
                <p>双目运算符</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>+=</p>
            </td>
            <td>
                <p>加后赋值</p>
            </td>
            <td>
                <p>变量+=表达式</p>
            </td>
            <td>
                <p>双目运算符</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>-=</p>
            </td>
            <td>
                <p>减后赋值</p>
            </td>
            <td>
                <p>变量-=表达式</p>
            </td>
            <td>
                <p>双目运算符</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>&lt;&lt;=</p>
            </td>
            <td>
                <p>左移后赋值</p>
            </td>
            <td>
                <p>变量&lt;&lt;=表达式</p>
            </td>
            <td>
                <p>双目运算符</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>&gt;&gt;=</p>
            </td>
            <td>
                <p>右移后赋值</p>
            </td>
            <td>
                <p>变量&gt;&gt;=表达式</p>
            </td>
            <td>
                <p>双目运算符</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>&amp;=</p>
            </td>
            <td>
                <p>按位与后赋值</p>
            </td>
            <td>
                <p>变量&amp;=表达式</p>
            </td>
            <td>
                <p>双目运算符</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>^=</p>
            </td>
            <td>
                <p>按位异或后赋值</p>
            </td>
            <td>
                <p>变量^=表达式</p>
            </td>
            <td>
                <p>双目运算符</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>|=</p>
            </td>
            <td>
                <p>按位或后赋值</p>
            </td>
            <td>
                <p>变量|=表达式</p>
            </td>
            <td>
                <p>双目运算符</p>
            </td>
        </tr>
        <tr>
            <td>
                <p>15</p>
            </td>
            <td>
                <p>，</p>
            </td>
            <td>
                <p>逗号运算符</a></p>
            </td>
            <td>
                <p>表达式,表达式,…</p>
            </td>
            <td>
                <p>左到右</p>
            </td>
            <td>
                <p>--</p>
            </td>
        </tr>
    </tbody>
</table>

## 表达式

表达式可以包含有关的运算符，也可以是不包含任何运算符的初等量，如常数是算数表达式的最简单形式。

1. 算术表达式

   整型表达式：参与运算的是整型量

   实型表达式：参与运算的是实型量，运算自动转为double类型。

2. 逻辑表达式

   用**逻辑运算符**连接，结果类型为整型int；可认为是整型表达式的一种特殊形式。

3. 字位表达式

   用**位运算符**连接，结果类型为整型变量；可认为是整型表达式的一种特殊形式。

4. 强制类型转换

   用“(类型)”运算符进行强制类型转换；

5. 逗号表达式

   形式为表达式1，表达式2，...，表达式n；计算方法为依次求出各个表达式的值，取最后一个值作为结果

6. 赋值表达式

7. 条件表达式

8. 指针表达式

9. **sizeof与strlen()的区别**

   1. sizeof是运算符，strlen()是函数；

   2. sizeof计算实际占用存储空间，不受初始化影响；

      strlen计算有效字符串的长度，不包括'\0'，受初始化影响；

   3. sizeof可以用类型做参数，计算类型占内存的大小；

      strlen只能以char*作参数，且必须以'\0'结尾，用来计算字符串的长度。

      特别地，数组作sizeof的参数不变化，而传递给strlen时就变化成指针了。

   4. sizeof在编译时计算，strlen在运行时才计算。

10. 左值与右值

    左值指的是允许出现在赋值表达式左侧的值，它是可修改的值，如变量；

    右值指的是允许出现在赋值表达式右侧的值，它包括常量、表达式等；

    左值可作右值，右值不一定能作左值。

11. **常量表达式**

    即参与运算的均为常量，不允许有变量，也不允许函数调用；

    个人推测常量表达式的值在编译时就已经确定。 

## 预处理语句

以`#`号开头的命令称为预处理命令，均由**预处理器**处理。

### 包含指令

包含指令`#include`原理：将该头文件包括到用户源文件中。

```c
#include <stdio.h> //从C语言编译系统的目录寻找
#include "stdio.h" //从用户的当前目录寻找，未找到则再去编译系统目录查找
```

### 条件编译指令

根据不同情况编译不同代码、产生不同目标文件的机制，称为条件编译。

条件编译主要用于在不同环境或条件下启用不同的语句。

#### #if

```c
//不同的平台下引入不同的头文件
#if _WIN32  //识别windows平台
#include <windows.h>
#elif __linux__  //识别linux平台
#include <unistd.h>
#else //识别其他平台
#endif
```

#### #ifdef

该条件编译指令通常用于Debug/Release程序发布。

```c
#ifdef _DEBUG
	printf("正在使用 Debug 模式编译程序...\n");
#else
	printf("正在使用 Release 模式编译程序...\n");
#endif
	system("pause");
```

#### #ifndef

该条件编译指令通常用于多文件结构的单次编译。

```c
#ifndef Function1_H
#define Function1_H
//some declaration codes
#endif
```

特别注意：

\#if 后面跟的是“整型常量表达式”，而 #ifdef 和 #ifndef 后面跟的只能是一个宏名，不能是其他的。

#### #undef

用于取消已定义的宏。

### 宏定义指令

#### 宏定义指令概念

宏定义指令`#define`，用一个标识符来表示一个字符串，如果在后面的代码中出现了该标识符，那么就全部替换成指定的字符串。例如：

```c
#define M (n*n+3*n)
...
#undef M //结束该宏的作用域
```

注意：

1. 宏定义中表达式**两边的括号不能少**，否则在宏展开以后可能会由于运算符的优先级产生歧义。
2. 宏定义是简单替换，预处理程序不会检查，如有错误，只可能在编译时（展开宏）发现；
3. 宏定义不是说明或语句，在行末不必加分号，如加上分号则连分号也一起替换；
4. 引号括起来的视为字符串常量，不会产生宏替换；
5. 宏定义允许嵌套使用，即可以在宏定义中使用已定义的宏名；
6. 宏定义可用于表示数据类型

#### 宏定义与typedef

特别注意**宏定义与typedef定义的区别**：

1. 宏定义只是**简单的字符串替换**，**以实参代换形参**。由预处理器来处理；
2. typedef 是在编译阶段由编译器处理的，它并不是简单的字符串替换，而给原有的数据类型起一个新的名字，将它作为一种新的数据类型。

```c
#define PIN1 int *
typedef int *PIN2;  //也可以写作typedef int (*PIN2);
PIN1 a, b;//宏替换后成为int *a,b;表示a是指针，b是整型；
printf("%d,%d",sizeof(a),sizeof(b));//输出8，4
PIN2 a, b;//typedef定义则a和b均为int*类型
printf("%d,%d",sizeof(a),sizeof(b));//输出8.8
```

#### 带参数的宏定义指令

C语言允许宏带有参数。

在宏定义中的参数称为“形式参数”，在宏调用中的参数称为“实际参数”，这点和函数有些类似。

例1：

```c
#define M(y) y*y+3*y  //宏定义
// TODO:
k=M(5);  //宏调用
```

例2：

```c
#define MAX(a,b) (a>b) ? a : b
// TODO：
max = MAX(x, y);
```

注意：**宏调用在预处理时采用简单替换**，这与函数的调用是不同的，函数调用时要把实参表达式的值求出来再传递给形参，而宏展开中对实参表达式不作计算，直接按照原样替换。

例3：

```c
#define SQ(y) (y)*(y)
// TODO:
sq = SQ(a+1);//预处理后得到 sq=(a+1)*(a+1);
```

注意：对于带参宏定义不仅要在**参数两侧加括号**，还应该在**整个字符串外加括号**。

例4：

```c
#define SQ(y) (y)*(y)
// TODO:
sq = 100/SQ(a+1);
//预处理后得到 sq=100/(a+1)*(a+1);按运算符次序得到的与预期不相符。
```

```c
#define SQ(y) ((y)*(y))
// TODO:
sq = 100/SQ(a+1);
//预处理后得到 sq=100/((a+1)*(a+1));现在能得到正确答案。
```

进一步体会宏定义与函数调用的区别：

**※ 例5：**

```c
#include <stdio.h>
int SQ(int y){
  return ((y)*(y));
}
int main(){
    int i=1;
    while(i<=5){
        printf("%d^2 = %d\n", (i-1), SQ(i++));
    }
    return 0;
}
```

分析：

在printf函数处，调用函数SQ(i++)，此时**传入SQ函数的参数为i，而printf函数内i=i+1。**

输出为$1^2 = 1,2^2 = 4,3^2 = 9,4^2 = 16,5^2 = 25$

**※ 例6：**

```c
#include <stdio.h>
#define SQ(y) ((y)*(y))
int main(){
    int i=1;
    while(i<=5){
        printf("%d^2 = %d\n", i, SQ(i++));
    }
    return 0;
}
```

分析：

在printf函数处SQ(i++)会被简单替换为(i++)*(i++)；此时依次计算两次自增，i从3开始，依次为3，5，7。

输出为$3^2=2,5^2 = 12,7^2 = 30$。

带参数的宏也可以定义多个语句。始终记住宏是简单替换即可。

## 总结

### 宏和typedef的区别

见 [宏定义与typedef](/#宏定义与typedef) 内容。

### 带参数的宏调用和函数的区别

1. 函数调用时，若实参为表达式，先求表达式的值，再带入形参；而宏调用则是简单字符替换，如果未加入足够的括号声明优先级，可能由于优先级顺序不当使得运算结果不正确；
2. 函数调用是在运行时处理，而宏则是在编译前进行预处理的时候完成；
3. 函数的实参和形参有严格的类型限制，宏是字符替换，无类型限制；
4. 宏会使得实际程序变长，函数调用则无此情况；
5. 宏不占用运行时间，只消耗预处理时间和编译时间，函数调用则消耗运行时间；
6. 在不利用指针作值传递的情况下，函数调用最多修改一个值，宏则可以修改多个值；
