---
title: 语句
authors:
  - EndlessPeak
toc: true
featuredImage: 
date: 2022-03-21
hidden: false
draft: false
weight: 3
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
