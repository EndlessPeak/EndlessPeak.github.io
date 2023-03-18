---
title: 标准输入输出
authors:
  - EndlessPeak
toc: true
featuredImage: 
date: 2022-03-23
hidden: false
draft: false
weight: 90
---

## Output

1. puts()：只能输出字符串，并且输出结束后会自动换行；
2. putchar()：只能输出单个字符；
3. printf()：可以输出各种类型的数据；

### Printf()

```c
int printf(const char *format, ...) 
```

功能：发送格式化输出到标准输出 stdout。

#### 格式控制

<style>
	table,table tr th, table tr td { border:1px solid #000000;text-align:center; }
    table tr td { vertical-align:middle;}
</style>
<table>
	<tbody>
    	<tr>
            <td>
        		<p><b>格式控制符</b></p>
            </td>
            <td>
            	<p><b>说明</b></p>
            </td>
        </tr>
        <tr>
			<td>
        		<p>%hd、%d、%ld</p>
            </td>
            <td>
            	<p>以十进制、有符号的形式输出 short、int、long 类型的整数</p>
            </td>
        </tr>
        <tr>
			<td>
        		<p>%hu、%u、%lu</p>
            </td>
            <td>
            	<p>以十进制、无符号的形式输出 short、int、long 类型的整数</p>
            </td>
        </tr>
        <tr>
			<td>
        		<p>%ho、%o、%lo</p>
            </td>
            <td>
            	<p>以八进制、<b>不带前缀</b>、无符号的形式输出 short、int、long 类型的整数</b></p>
            </td>
        </tr>
        <tr>
			<td>
        		<p>%#ho、%#o、%#lo</p>
            </td>
            <td>
            	<p>以八进制、<b>带前缀</b>、无符号的形式输出 short、int、long 类型的整数</p>
            </td>
        </tr>
        <tr>
			<td>
        		<p>%hx、%x、%lx、%hX、%X、%lX</p>
            </td>
            <td>
            	<p>以十六进制、<b>不带前缀</b>、无符号的形式输出 short、int、long 类型的整数。如果 x 小写，那么输出的十六进制数字也小写；如果 X 大写，那么输出的十六进制数字也大写。</p>
            </td>
        </tr>
		<tr>
            <td>
            	<p>%#hx、%#x、%#lx、%#hX、%#X、%#lX</p>
            </td>
            <td>
            	<p>以十六进制、<b>带前缀</b>、无符号的形式输出 short、int、long 类型的整数。如果 x 小写，那么输出的十六进制数字和前缀都小写；如果 X 大写，那么输出的十六进制数字和前缀都大写。</p>
            </td>
		</tr>
		<tr>
            <td>
            	<p>%f、%lf</p>
            </td>
            <td>
            	<p>以十进制的形式输出 float、double 类型的小数</p>
            </td>
		</tr>
<tr>
            <td>
            	<p>%e、%le、%E、%lE</p>
            </td>
            <td>
            	<p>以指数的形式输出 float、double 类型的小数。如果 e 小写，那么输出结果中的 e 也小写；如果 E 大写，那么输出结果中的 E 也大写。</p>
            </td>
		</tr>
		</tr>
<tr>
            <td>
            	<p>%g、%lg、%G、%lG</p>
            </td>
            <td>
            	<p>以十进制和指数中较短的形式输出 float、double 类型的小数，并且小数部分的最后不会添加多余的 0。如果 g 小写，那么当以指数形式输出时 e 也小写；如果 G 大写，那么当以指数形式输出时 E 也大写。</p>
            </td>
		</tr>
		<tr>
			<td>
	    		<p>%c</p>
	        </td>
	        <td>
	        	<p>输出一个单一的字符</b></p>
	        </td>
	    </tr>
		<tr>
	        <td>
	        	<p>%s</p>
	        </td>
	        <td>
	        	<p>输出一个字符串</p>
	        </td>
		</tr>
	</tbody>
</table>

#### 高级用法

```c
%[flag][width][.precision]type
```

注释：

1. type表示输出类型，如d、f、c等；

2. width表示最小输出宽度，即至少占用多少字符

   当输出结果小于最小宽度，则左对齐时右补空格，右对齐时左补空格（默认）。

   当输出结果大于最小宽度，该限制失效。

3. precision表示只取输出的左边字符数（保留有效数字位数）。

4. flag指示左右对齐方式，默认为右对齐，**-为左对齐**；**+为输出数据的符号**。

下面是一些应用举例(m为常数)：

1. 可以用`%m.nf`指定数据宽度和小数位数，m表示浮点数所占的列数，n表示小数所占的位数。

2. 可以用`%md`进行右对齐；

   可以用`%-md`进行右对齐；

3. 可以用`%ms`指定输出字符串占的列数，少则左补空格，多则突破限制；

4. 可以用`%m.ns`指定输出字符串占的列数及只取字符串左边n个字符输出在m列的右侧，左补空格

#### 补充

如果需要输出%，则需要额外用一个%转义。

### puts()

```c
int puts(const char *str) 
```

功能：把一个字符串写入到标准输出 stdout，直到空字符，但不包括空字符。换行符会被追加到输出中。

### putchar()

```c
int putchar(int char) 
```

功能：把参数 char 指定的字符（一个无符号字符）写入到标准输出 stdout 中。

### 输出缓冲区

见下面的例子：

```c
#include<stdio.h>
#if linux
#include<unistd.h>
#elif _WIN32
#include<windows.h>
#endif
int main()
{
    printf("Before sleep.");
    #if linux
    sleep(5);//该函数以秒为单位
    #elif _WIN32
    Sleep(5000);//该函数以毫秒为单位
    #endif
    printf("After sleep.\n");
    return 0;
}
```

printf函数执行结束以后数据并没有直接输出到显示器上，而是放入了缓冲区，直到遇见换行符`\n`才将缓冲区中的数据输出到显示器上。

## Input

1. scanf()：和 printf() 类似，scanf() 可以输入多种类型的数据。
2. getchar()、getche()、getch()：这三个函数都用于输入单个字符。
3. gets()：获取一行数据，并作为字符串处理。

### scanf()

最重要的事情：**等待输入的变量必须加`&`**。

特别地，输入字符串的变量不加`&`，因为字符串的名字会自动转换为字符串的地址。加上&会产生警告。

#### 格式控制

<style>
	table,table tr th, table tr td { border:1px solid #000000;text-align:center; }
    table tr td { vertical-align:middle;}
</style>
<table>
	<tbody>
    	<tr>
            <td>
        		<p><b>格式控制符</b></p>
            </td>
            <td>
            	<p><b>说明</b></p>
            </td>
        </tr>
        <tr>
            <td>
        		<p>%c</p>
            </td>
            <td>
            	<p>读取一个单一的字符</p>
            </td>
        </tr>
        <tr>
        	<td>
            	<p>
                   %s
                </p>
            </td>
            <td>
            	<p>
                    读取一个字符串（以空白符为结束）
                </p>
            </td>
        </tr>
        <tr>
            <td>
        		<p>%hd、%d、%ld</p>
            </td>
            <td>
            	<p>读取一个十进制整数，并分别赋值给 short、int、long 类型</p>
            </td>
        </tr>
        <tr>
            <td>
        		<p>%ho、%o、%lo</p>
            </td>
            <td>
            	<p>读取一个八进制整数（可带前缀也可不带），并分别赋值给 short、int、long 类型</p>
            </td>
        </tr>
        <tr>
            <td>
        		<p>%hx、%x、%lx</p>
            </td>
            <td>
            	<p>读取一个十六进制整数（可带前缀也可不带），并分别赋值给 short、int、long 类型</p>
            </td>
        </tr>
        <tr>
            <td>
        		<p>%hu、%u、%lu</p>
            </td>
            <td>
            	<p>读取一个无符号十进制整数，并分别赋值给 unsigned short、unsigned int、unsigned long 类型</p>
            </td>
        </tr>
        <tr>
            <td>
        		<p>%f、%lf</p>
            </td>
            <td>
            	<p>读取一个十进制形式的小数，并分别赋值给 float、double 类型</p>
            </td>
        </tr>
        <tr>
        	<td>
            	<p>
                    %e、%le
                </p>
            </td>
            <td>
            	<p>
                    读取一个指数形式的小数，并分别赋值给 float、double 类型
                </p>
            </td>
        </tr>
        <tr>
        	<td>
            	<p>
                    %g、%lg
                </p>
            </td>
            <td>
            	<p>
                    既可以读取一个十进制形式的小数，也可以读取一个指数形式的小数，并分别赋值给 float、double 类型
                </p>
            </td>
        </tr>
        <tr>
        	<td>
            	<p>
                    %p
                </p>
            </td>
            <td>
            	<p>
                    读入一个指针
                </p>
            </td>
        </tr>
        <tr>
        	<td>
            	<p>
                    %[]
                </p>
            </td>
            <td>
            	<p>
                    扫描字符集合
                </p>
            </td>
        </tr>
        <tr>
        	<td>
            	<p>
                    %%
                </p>
            </td>
            <td>
            	<p>
                    读入%符号
                </p>
            </td>
        </tr>
    </tbody>
</table>

scanf() 读取字符串时以空格为分隔，遇到空格就认为当前字符串结束了，所以**无法读取含有空格的字符串。**

### 输入缓冲区

当遇到 scanf() 函数时，程序会先检查输入缓冲区中是否有数据：

1. 无数据，就等待用户输入。直到产生换行符，输入结束；

2. 有数据，是否符合控制字符串的规则：

   1. 匹配控制字符串，读取；

   2. 仅匹配前半部分控制字符串，则等待用户输入剩下的数据；

   3. 不符合，尝试忽略一些空白符，如空格、制表符、换行符；

      特别地，仅控制字符串是`%d、%c、%f`等开头时，可以忽略空白符。

      1. 尝试成功，重复匹配过程；
      2. 尝试不成功，读取失败。

例1，scanf()输入读取失败

```c
#include<stdio.h>
int main(){
    int a,b=999;
    char str[30];
    printf("b=%d\n",b);
    scanf("%d",&a);
    scanf("%d",&b);
    scanf("%s",str);
    printf("a=%d,b=%d,str=%s\n",a,b,str);
    return 0;
}
```

程序分析：

1. 第一个 scanf() 时等待用户输入，从键盘输入内容`100 testScanf`，按下回车键，scanf() 匹配到 100，赋值给变量a，同时将内部的位置指针移动到 100 后面。
2. 第二个 scanf()，缓冲区中有数据，直接读取。此时缓冲区中的内容为`testScanf\n`，忽略开头的空格，不是 scanf() 想要的整数，匹配失败。不会给变量 b 赋值，b 的值保持不变。
3. 第三个 scanf() 时，控制字符串要求输入一个字符串，而缓冲区的位置指针由于匹配失败而未发生改变，正好将`testScanf`赋给str。此时缓冲区仅剩`\n`，它在下次控制字符串符合要求时会被忽略。

例2，scanf()无法忽略空白符的情形

```c
#include<stdio.h>
int main(){
	int a=1,b=2;
    scanf("a=%d",&a);
    scanf("b=%d",&b);
    printf("a=%d,b=%d\n",a,b);
    return 0;
}
```

程序分析：

1. 若输入`a=10`，按下回车键，程序直接运行结束。只有第一个 scanf() 成功读取了数据，第二个 scanf() 没有给用户任何机会去输入数据。
2. 当控制字符串不是以格式控制符`%d、%c、%f `等开头时，空白符就不能忽略了，它会参与匹配过程，如果匹配失败，就意味着 scanf() 读取失败。
3. 若输入`a=10 b=20`，按下回车键，程序运行结束。第二个 scanf() 又读取失败。执行到第二个 scanf() 时，缓冲区中剩下 `b=200\n`，开头的空格依然不能忽略，然而空格与控制字符串不匹配，所以读取失败。

程序修改：

1. 考虑输入两个变量的时候中间不留空白符号；
2. 考虑不在scanf()中添加多余的控制字符，仅保留格式控制符；
