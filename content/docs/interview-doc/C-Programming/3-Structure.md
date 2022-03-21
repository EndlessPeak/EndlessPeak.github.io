---
title: 语句与结构
authors:
  - EndlessPeak
toc: true
featuredImage: 
date: 2022-03-21
hidden: false
draft: false
weight: 3
---

## 循环结构

### continue&break

注意continue和break关键字的用法：

1. continue指的是结束本次循环，进行下一次循环；
2. break指的是结束本次循环并跳出循环体；

```c
for(int i = 0; i < 3; i++){
    if (i == 0)
        continue;
    printf("Count,%d",i);
}
```

如果循环1万次，需要循环到1000次后遇到断点进入调试模式，可考虑使用条件判断+断点：

```c
for(int i = 0; i < 10000; i++){
    if (i == 1000)
        ;//在这里下断点
   	...
}
```

如果希望在某个特定的地方终止程序的运行，可考虑使用断言：

```c
#include<assert.h>
for(int i = 0; i < 10000; i++){
    assert(i=1000);
   	...
}
```

### while&do...while

while是先判断再执行；（可能一次都不执行）

do...while是先执行再判断；（至少执行一次）

## 分支结构

### 条件结构

如果if关键字禁止使用，可考虑：

1. 使用三目运算符实现；
2. 使用函数指针数组实现：

```c
int ifconsq(){
    /*if的执行内容*/
}
int elseconsq(){
    /*else的执行内容*/
}
int main(){
    int (*branch[2])()={elseconsq,ifconsq};
    branch[2<3]();//等价于if(2<3) ifconsq();else elseconsq(); 
}
```

另外，可以使用存储函数指针的指针代替函数指针数组：

```c
#incldue<stdlib.h>
//malloc函数需要该头文件
int main(){
    int (**branch)()=(int(**)())malloc(2*sizeof(int(**)()));
    *branch=elseconsq;
    *(branch+1)=ifconsq;
    branch[2<3]();
}
```

如果else关键字禁止使用，可考虑使用反条件：

```c
if(!(2<3))
```

### 选择结构

使用switch语句进行多分支选择。

```c
switch(x){
    case 1:
    case 2:
        /* 1和2可以同组 */
        break;
    case 3:
        /* 使用break跳出switch */
        break;
    default:
        /*如果均不符合*/
}
```

其中，

1. default可以没有，均不符合则均不执行；
2. case后接常量表达式，常量表达式的值必须均不相同，在都有break的情况下次序不影响执行结果；
3. break跳出当前选择结构

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

