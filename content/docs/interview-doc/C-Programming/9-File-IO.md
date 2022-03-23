---
title: 文件输入输出
authors:
  - EndlessPeak
toc: true
featuredImage: 
date: 2022-03-23
hidden: false
draft: false
weight: 9
---

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

   2. 非缓冲文件系统(open)：通过操作系统的功能对文件进行读写，是系统级的输入输出。 **不设文件结构体指针**，**只能读写二进制文件**；

2. open属于低级IO，fopen属于高级IO；

3. fopen返回**文件指针**，在用户态缓存，减少了内核态和用户态的切换；

   open返回**文件描述符**，读写需进行用户态与内核态切换；

4. open是系统函数，不可移植；

   fopen是标准C函数，可移植（猜测是用open封装操作）；

5. 一般地，fopen打开普通文件，open打开设备文件（因为设备文件不可作为流式文件处理）；

6. fopen适合**顺序访问**文件；

   open适合**随机访问**文件；
