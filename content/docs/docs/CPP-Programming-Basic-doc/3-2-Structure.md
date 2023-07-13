---
title: Structure
authors:
  - EndlessPeak
toc: true
featuredImage: 
date: 2022-03-21
hidden: false
draft: false
weight: 31
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

