---
title: 函数
authors:
  - EndlessPeak
toc: true
featuredImage: 
date: 2022-03-22
hidden: false
draft: false
weight: 4
---

## 函数组成

### 概念

函数是以固定的格式封装，可以重复使用的代码模块，用于完成特定的功能。

通过调用模块名来重复使用这段代码。

特别地，

1. 函数**不能嵌套定义**。
2. 函数外不能做运算，执行结构语句或调用函数。

### 参数

函数可以具有输入，这些输入被称为参数，一般是数据或变量，指示主调函数与被调函数之间的数据传递关系。

#### 形参与实参

定义函数时函数名后面括号的变量名称称为**形式参数**；

主调函数调用函数时，赋给被调函数的参数称为**实际参数**（实参可以是常量、变量、表达式）；

#### 函数作参数

函数A作被调函数B的参数时，先调用函数A，函数A返回后执行函数B。

特别地，函数A，B，C，...作被调函数Z的参数时，按**某种**顺序依次调用，依次返回后调用函数Z。

顺序具体如何由编译器决定，gcc按照从右往左顺序，猜测实现方式是将参数依次**压栈**，然后依次弹出计算。

特别注意数组作为函数参数的情况：

1. 数组元素作函数参数

   数组元素可以作实际参数，不能作形式参数；当作实参时，向形参传递的是数组元素的**值**。

   因此实参的值传递给形参是**变量作值传递**方式。

2. 数组名作函数参数

   数组名可以作函数的实际或形式参数；当作实参时，向形参传递的是数组首元素的**地址**。

   因此实参的值传递给形参是**指针作值传递**方式。

   （引用传递方式需要慎重，C语言不支持形参引用传递。见值传递和引用传递节。）

最后，尽量避免写如下例形式的代码。

```c
#include<stdio.h>
int funA(int a){
    printf("A function Called.\n");
    a+=1;
    printf("a is %d in A\n ",a);
    return a;
}
int funB(int a){
    printf("B function Called.\n");
    a+=1;
    printf("a is %d in B\n",a);
    return a;
}
int funC(int a){
    printf("C function Called.\n");
    a+=1;
    printf("a is %d in C\n",a);
    return a;
}
int funD(int a,int b,int c){
    return 0;
}
int main(int argc, char *argv[]){
    int a=0;
    printf("Main function Called.\n");
    funD(funA(a++),funB(a++),funC(a++));
}
```

> 假设时刻$t_i$和$t_{i+1}$是前后相继的两个顺序点，那么到了$t_{i+1}$，任何C/C++ 系统都必须实现$t_i$之后发生的所有副作用。
>
> 但是当然它们也可以不等到时刻$t_{i+1}$，而是选择在时段$ [t, t_{i+1}] $之间的任何时刻实现在此期间出现的副作用，C/C++ 语言允许这些选择。
>
> **C/C++ 语言的规定指出，任何依赖于特定计算顺序、依赖于在顺序点之间实现修改效果的表达式，其结果都没有保证。**
>
> 如果在任何“完整表达式”（形成一段由顺序点结束的计算）里存在对同一“变量”的多个引用，那么表达式里就不应该出现对这一“变量”的副作用。否则就不能保证得到预期结果。
>
> ——北京大学数学科学学院教授裘宗燕

### 返回

被调函数向主调函数返回的执行结果称为返回值。

函数声明时必须声明返回值类型，若类型为void则函数也可以不返回任何值。

**return 语句是提前结束函数的唯一办法。**

### 声明

1. 函数定义与函数调用

   原则上函数定义要出现在函数调用之前。

2. 函数声明的概念

   指向编译器传达信息：某函数将会被定义。如果函数调用时函数尚未定义，则需要声明。

3. 函数声明的格式

   去掉函数定义中的函数体，并在最后加上分号。

   **特别地，可以不写形参，只写数据类型。**这是由于声明不需要对函数进行定义。

4. 多文件结构

   函数定义放到源文件，函数的声明放到头文件。

   使用函数时引入对应的头文件就可以，编译器会在链接阶段找到函数体。

## 库函数

### 概念

系统或第三方建立开发的具有一定功能的函数的集合。存放在该集合中的函数称为库函数。

库函数具有明确的功能、入口调用参数和返回值。

### 常见库

1. 标准输入输出库`#include<stdio.h>`

   该库定义了通用输入输出函数。

   1. `int printf(char *format,args)`

   2. `int putchar(char ch)`

   3. `int puts(char *str)`

   4. `int scanf(char *format,args)`

   5. `FILE *fopen(char *filename,char *mode)`

      有关区分fopen和open，参见本篇[输入输出]()节。

   6. `int fread(char *pt,unsigned size,unsigned n,FILE *fp)`

   7. `int fwrite(char *pt,unsigned size,unsigned n,FILE *fp)`

   6. `int fclose(FILE *fp)`

2. 标准库`#include<stdlib.h>`

   该库定义了五种类型、部分宏和通用工具函数。

   1. 类型包括`size_t`

      在64位系统中为`long long unsigned int`，在非64位系统中为`long unsigned int`

   2. 宏包括`EXIT_FAILURE`、`EXIT_SUCCESS`、`RAND_MAX`

   3. 通用工具函数包括：

      1. `void *malloc(unsigned size)`

      2. `void *calloc(unsigned n,unsigend size)`

         通过指定数据类型和个数实现空间分配

      3. `void *free(void *p)`

      4. `void *realloc(void *p,unsigned size)`

      5. `void exit(int state)`

      6. `int rand(void)`
      
         产生0-32767的随机整数。

3. 字符串库`#include<string.h>`

4. 数学库`#include<math.h>`

   1. `int abs(int x)`

   2. `double fabs(double x)`

   3. `double exp(double x)`

   4. `double pow(double x,double y)`

      计算$x^y$的值。

   5. `double sqrt(double x)`

      计算开方。（编程实现开方可用牛顿迭代法，参见算法篇[sqrt]()）

   
