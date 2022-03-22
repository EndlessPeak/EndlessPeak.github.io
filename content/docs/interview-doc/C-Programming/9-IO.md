---
title: 输入输出
authors:
  - EndlessPeak
toc: true
featuredImage: 
date: 2022-03-22
hidden: false
draft: false
weight: 9
---

## Printf

### 格式控制

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
            	<p>以八进制、带前缀、无符号的形式输出 short、int、long 类型的整数</p>
            </td>
        </tr>
        <tr>
			<td>
        		<p>%hx、%x、%lx、%hX、%X、%lX</p>
            </td>
            <td>
            	<p>以十六进制、不带前缀、无符号的形式输出 short、int、long 类型的整数。如果 x 小写，那么输出的十六进制数字也小写；如果 X 大写，那么输出的十六进制数字也大写。</p>
            </td>
        </tr>
		<tr>
            <td>
            	<p>%#hx、%#x、%#lx、%#hX、%#X、%#lX</p>
            </td>
            <td>
            	<p>以十六进制、带前缀、无符号的形式输出 short、int、long 类型的整数。如果 x 小写，那么输出的十六进制数字和前缀都小写；如果 X 大写，那么输出的十六进制数字和前缀都大写。</p>
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

### 高级用法

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

### 缓冲区

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

## open

```c
#include<fcntl.h>
int open(const char *path, int access,int mode)
```

1. path 要打开的文件路径和名称               

2. access 访问模式，宏定义和含义如下：             

   1. O_RDONLY  1 只读打开              
   2. O_WRONLY 2 只写打开              
   3. O_RDWR 4 读写打开            

   还可选择以下模式与以上3种基本模式相与：           

   1. O_CREAT   0x0100  创建一个文件并打开         
   2. O_TRUNC   0x0200  打开一个已存在的文件并将文件长度设置为0，其他属性保持      
   3. O_EXCL   0x0400  未使用               
   4. O_APPEND  0x0800  追加打开文件            
   5. O_TEXT   0x4000  打开文本文件翻译CR-LF控制字符    
   6. O_BINARY  0x8000  打开二进制字符，不作CR-LF翻译                             

3. mode 该参数仅在access=O_CREAT方式下使用。

## fopen

```c
#include<stdio.h>
FILE *fopen(const char *filename, const char *mode)
```

1. filename 要打开的文件路径和名称

2. mode 文件访问模式

   <style>
   	table,table tr th, table tr td { border:1px solid #000000;text-align:center; }
       table tr td { vertical-align:middle;}
   </style>
   <table>
   	<tbody>
       	<tr>
               <td>
           		<p><b>模式</b></p>
               </td>
               <td>
               	<p><b>描述</b></p>
               </td>
           </tr>
           <tr>
   			<td>
           		<p>"r"</p>
               </td>
               <td>
               	<p>打开一个用于读取的文件。<b>该文件必须存在。</b></p>
               </td>
           </tr>
           <tr>
   			<td>
           		<p>"w"</p>
               </td>
               <td>
               	<p>创建一个用于写入的空文件。如果文件名称与已存在的文件相同，则会<b>删除已有文件的内容</b>文件被视为一个新的空文件。</p>
               </td>
           </tr>
           <tr>
   			<td>
           		<p>"a"</p>
               </td>
               <td>
               	<p>追加到一个文件。写操作向文件末尾追加数据。如果文件不存在，则创建文件。</p>
               </td>
           </tr>
           <tr>
   			<td>
           		<p>"r+"</p>
               </td>
               <td>
               	<p>打开一个用于更新的文件，可读取也可写入。<b>该文件必须存在。</b></p>
               </td>
           </tr>
           <tr>
   			<td>
           		<p>"w+"</p>
               </td>
               <td>
               	<p>创建一个用于读写的空文件。</p>
               </td>
           </tr>
           <tr>
   			<td>
           		<p>"a+"</p>
               </td>
               <td>
               	<p>打开一个用于读取和追加的文件。</p>
               </td>
           </tr>
       </tbody>
   </table>
   
   注意：添加b参数可指明操作对象是二进制文件。

## fopen与open的区别

1. 缓冲文件系统与非缓冲系统的区别

   1. 缓冲文件系统(fopen) 在内存为每个文件开辟一个缓存区，当执行读操作，从磁盘文件将数据读入内存缓冲区，装满后从内存缓冲区依次读取数据。写操作同理；

      借助文件结构体指针对文件管理，可读写字符串、格式化数据、二进制数据；

   2. 非缓冲文件系统(open)：通过操作系统的功能对文件进行读写，是系统级的输入输出。**不设文件结构体指针**，**只能读写二进制文件**；

2. open属于低级IO，fopen属于高级IO；

3. fopen返回**文件指针**，在用户态缓存，减少了内核态和用户态的切换；

   open返回**文件描述符**，读写需进行用户态与内核态切换；

4. open是系统函数，不可移植；

   fopen是标准C函数，可移植（猜测是用open封装操作）；

5. 一般地，fopen打开普通文件，open打开设备文件（因为设备文件不可作为流式文件处理）；

6. fopen适合**顺序访问**文件；

   open适合**随机访问**文件；
