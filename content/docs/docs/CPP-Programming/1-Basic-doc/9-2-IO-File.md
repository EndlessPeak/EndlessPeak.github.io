---
title: File I/O
authors:
  - EndlessPeak
toc: true
featuredImage: 
date: 2022-03-23
hidden: false
draft: false
weight: 91
---

## 概述

文件输入输出主要包括：

1. 文件打开与关闭
   1. 打开函数`fopen()`
   2. 关闭函数`fclose()`
2. 文件状态
   1. 是否到文件尾函数`feof()`
   2. 检查错误函数`ferror()`
3. 文件读写
   1. 读取函数`fread()`
   2. 写入函数`fwrite()`
4. 文件输入输出
   1. 输入函数`fscanf()`，`fgetc()`
   2. 输出函数`fprintf()`，`fputc()`
5. 文件定位
   1. `rewind()`
   2. `fseek()`
   3. `ftell()`

## 文件的打开与关闭

### fopen

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

### fclose()

```c
int fclose(FILE *fp)
```

如果成功关闭文件，`fclose( )` 函数返回零，如果关闭文件时发生错误，函数返回**EOF**(-1)。

该函数实际上，会清空缓冲区中的数据，关闭文件，并释放用于该文件的所有内存。

### open()

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

### fopen与open的区别

1. 缓冲文件系统与非缓冲系统的区别

   1. 缓冲文件系统(fopen) 在内存为每个文件开辟一个缓存区，当执行读操作，从磁盘文件将数据读入内存缓冲区，装满后从内存缓冲区依次读取数据。写操作同理；

      借助文件结构体指针对文件管理，可读写字符串、格式化数据、二进制数据；

   2. 非缓冲文件系统(open)：通过操作系统的功能对文件进行读写，是系统级的输入输出。 **不设文件结构体指针**，**只能读写二进制文件**；

2. open属于低级IO，fopen属于高级IO；

3. fopen返回**文件指针**，在用户态缓存，减少了内核态和用户态的切换；

   open返回**文件描述符**，读写需进行用户态与内核态切换；

4. open是系统函数，不可移植；

   fopen是标准C函数，可移植（猜测是用open封装操作）；

5. 一般地，fopen打开普通文件，open打开设备文件（因为设备文件不可作为流式文件处理）；

6. fopen适合**顺序访问**文件；

   open适合**随机访问**文件；

## 文件状态

`feof(FILE *fp)`判断文件是否到末尾，若到达文件末尾返回非0；

`ferror(FILE *fp)`用来检查错误，若为0则未出错，否则出错。

## 文件的读取与写入

### 文件写入

```c
int fputc(int c,FILE *fp);
```

函数`fputc()`把<u>参数 c 的字符值</u>写入到 fp 所指向的输出流中。

如果写入成功，它会返回写入的字符，如果发生错误，则会返回 **EOF**。

```c
int fputs(const char *s,FILE *fp)
```

函数`fputs()`把一个以 null 结尾的字符串写入到 fp 所指向的输出流中。

```c
int fprintf(FILE *fp,const char *format, ...) 
```

函数`fprintf()`把一个字符串写入到文件中。

见下面的例子：

```c
#include <stdio.h>
int main()
{
    FILE *fp = NULL;
    fp = fopen("/tmp/test.txt", "w+");
    fprintf(fp, "This is testing for fprintf...\n");
    fputs("This is testing for fputs...\n", fp);
    fclose(fp);
}
```

### 文件读取

```c
int fgetc(FILE *fp);
```

函数`fgetc()`从 fp 所指向的输入文件中读取一个字符。

返回值是读取的字符，如果发生错误则返回 **EOF**。

```c
char *fgets(char *buf,int n,FILE *fp)
```

函数 `fgets()` 从 fp 所指向的输入流中读取 n - 1 个字符。它会把读取的字符串复制到缓冲区 `buf`，并在最后追加一个 `null` 字符来终止字符串。

t特别地，如果这个函数在读取最后一个字符之前就遇到一个换行符 `'\n'` 或文件的末尾 EOF，则只会返回读取到的字符，包括换行符。

```c
int fscanf(FILE *fp,const char *format, ...) 
```

函数`fscanf()`从文件中读取字符串，但是在遇到**第一个空格**和**换行符**时，它会停止读取。

见下面的例子：

```c
#include <stdio.h>
 
int main()
{
   FILE *fp = NULL;
   char buff[255];
 
   fp = fopen("/tmp/test.txt", "r");
   fscanf(fp, "%s", buff);
   printf("1: %s\n", buff );//只读取This
 
   fgets(buff, 255, (FILE*)fp);
   printf("2: %s\n", buff );//读取is testing for fprintf...
   
   fgets(buff, 255, (FILE*)fp);
   printf("3: %s\n", buff );//This is testing for fputs...
   fclose(fp);
 
}
```

### 二进制文件读写

下面两个函数用于二进制输入和输出：

```c
size_t fread(void *ptr, size_t size_of_elements,size_t number_of_elements, FILE *a_file); size_t fwrite(const void *ptr, size_t size_of_elements,size_t number_of_elements, FILE *a_file);
```

这两个函数都是用于存储块的读写，通常是数组或结构体。简单记法：

```c
fread(buffer,size,count,fp);
fwrite(buffer,size,count,fp)
```

1. `void *ptr`指向的是被写入/被读出的元素（或它的数组的首对象）的指针；
2. `size_t size`说明被写入/被读出的元素的大小，大小是字节；
3. `size_t num`说明操作的元素的个数；
4. `FILE *fp`是指向`FILE`对象的指针；

## 文件定位

### rewind()

```c
void rewind(FILE *stream)
```

设置文件位置为给定流stream的文件的开头。

### fseek()

```c
int fseek(FILE *stream,long offset,int fromwhere)
```

函数设置文件指针stream的位置:

1. 如果执行成功，stream将指向以`fromwhere`为基准，偏移`offset`个字节的位置。
2. 如果执行失败(比如`offset`超过文件自身大小)，则不改变stream指向的位置。
3. 取值：SEEK_CUR(当前位置)、 SEEK_END(结尾位置) 或 SEEK_SET(起始位置)

### ftell()

```c
long int ftell(FILE *stream)
```

返回给定流 stream 的当前文件位置。
