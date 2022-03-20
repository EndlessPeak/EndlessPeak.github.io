---
title: 数据类型
authors:
  - EndlessPeak
toc: true
featuredImage: 
date: 2022-02-10
hidden: false
draft: false
weight: 3
---

## 概述

数据类型包括基本类型、派生类型、枚举类型(enum)和空类型(void)。

1. 基本类型
   1. 整型
   2. 浮点类型
2. 派生类型
   1. 指针类型
   2. 数组类型
   3. 结构体类型(struct)
   4. 共用体类型(union)
   5. 函数类型

其中：

1. 基本类型和枚举类型变量都是都是值，统称为算数类型；
2. 算数类型和指针类型变量的值都是以数字表示的，统称为纯量类型；
3. 数组类型和结构体类型统称为组合类型，共用体类型不属于组合类型因为同一时间只有一个值。

注意：共用体类型与枚举类型的区别：

1. 共用体类型是多变量共享存储空间的派生类型，其中的元素是变量；共用体空间等于最大成员变量占据的空间，共用体不能赋初值；
2. 枚举类型是多常量共享存储空间的数据类型，其中的元素是常量；因此枚举类型变量的值定义时确定，可以全部列出；

## 变量类型

### 整型

1. 基本整型int 

   输出格式：十进制`%d`，八进制`%o`或`%#o`，十六进制`%x`或`%#x`；

   16位机器上2字节，32位机器上4字节，64位机器上4字节；

2. 短整型short int 

   输出格式：十进制`%hd`，八进制`%ho`或`%#ho`，十六进制`%hx`或`%#hx`；

   简记为16位int，因此占2字节；

3. 长整型long int

   输出格式：十进制`%ld`，八进制`%lo`或`%#lo`，十六进制`%lx`或`%#lx；`

   简记为32位int，因此占4字节；

4. 双长型long long int

   输出格式：十进制`%ll`，八进制`%llo`或`%#llo`，十六进制`%llx`或`%#llx`；

   至少分配8个字节；

5. 无符号数变体

   当存在`unsigned`前缀且需要用十进制表示时用`%u`替换`%d`，其他时候均不变；

### 实型数据

利用浮点表示法表示实型数据。浮点表示法指的是小数点位置可以浮动，又称IEEE754标准。

浮点数用数符、阶码(移码)和尾数(隐藏首位的原码)表示。

1. 单精度浮点型float

   输出格式：`%f`

   分配4个字节；

2. 双精度浮点型double

   输出格式：`%f`或`%lf`或指数记数法`%e`，十六进制`%a`

   分配8个字节；

3. 长双精度浮点型long double

   输出格式：`%Lf`或指数记数法`%Le`，十六进制`%La`

   可能是8个字节，12字节，16字节；

注意：

1. 浮点型常量写法

   有符号数字(包括小数点)+e/E+有符号数字(指数)。

   1. 可以省略正号，可以省略小数点(2E5)或指数部分(19.28)，但不能同时省略两者；
   2. 可以省略小数部分(3.E16)或整数部分(.45E-6)，但不能同时省略两者。

   **不能在浮点型常量中加空格**！

2. 浮点型变量比较

   **不可将浮点变量用“==”或“!=”与任何数字比较!**

   而应该设法转化成两数相减后用“> =”或“ <=”形式。

3. 上溢与下溢

   1. 上溢时显示inf或infinity(无穷大)
   2. 下溢时损失精度(尾数的末尾被舍去)

### 字符型数据

- char或unsigned char

  输出格式：`%c`

  分配1个字节，且该字节中第一位置为0。

- char*类型

  输出格式：`%s`

  分配N个字节(存储N个字符时)

字符常量是用**单括号**括起来的**一个字符**；

字符串常量是用**一对双括号**括起来的零个或多个字符组成的**字符序列**，结尾不需要加'\0'。

字符数组是用一对大括号括起来的零个或多个字符组成的**字符序列**，结尾不需要加'\0'。

注意：

1. 使用整型输出格式可以输出字符型数据的ASCII码；

2. 字符常量中，'101'是八进制字符；'x41'是十六进制字符；他们都指代ASCII码为65的字符，即A；

   特别地，'101'可写为'0101'，'x41'可写为'0x41'；

3. 字符串常量中，\101是八进制字符；\x41是十六进制字符；他们都指代ASCII码为65的字符，即A；

   特别地，'\101'**不可写为**'\0101'，'x41'可写为'\0x41'；

## 运算符与表达式

### 运算符

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
                <p>[]]</p>
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
                <p>！=</p>
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
                <p>;</p>
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

### 表达式

1. 算术表达式
2. 逻辑表达式
3. 字位表达式
4. 强制类型转换
5. 逗号表达式
6. 赋值表达式
7. 条件表达式
8. 指针表达式
9. sizeof与strlen()的区别
   1. sizeof是运算符，strlen()是函数；
   2. strlen是有效字符串的长度，不包括'\0'，受初始化影响，而sizeof则计算实际占用存储空间，不受初始化影响；