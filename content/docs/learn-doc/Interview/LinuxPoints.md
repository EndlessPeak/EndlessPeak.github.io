---
title: Linux知识采撷
authors:
  - EndlessPeak
toc: true
featuredImage: 
date: 2022-03-11
hidden: false
draft: false
weight: 8
---

## 发行版

1. Linux分为哪些发行版？具体而言有什么区别？

   1. 概括地讲，Linux的发行版本可以大体分为两类

      1. 商业公司维护的发行版本，如Redhat Enterprise Linux
      2. 社区组织维护的发行版本，如Debian

   2. 主流分支包括以下部分

      1. Debian

         Debian分为三个版本分支 stable, testing 和 unstable。

         Debian最具特色的是apt-get / dpkg包管理方式。

         1. Ubuntu

            Ubuntu是基于Debian的unstable版本加强而来。

         2. Debian

            Debian是社区类Linux的典范，是迄今为止最遵循GNU规范的Linux系统。

         3. Deepin

            Deepin基于Qt/C++（用于前端）和Go（用于后端）。

         4. Linux Mint

      2. SlackWare

         坚持KISS（Keep It Simple Stupid）的原则。该发行版的软件包都是通常的tgz(tar/gzip)格式文件再加上安装脚本。

         1. SUSE Linux
         2. Vector Linux

      3. RedHat

         1. Cent OS（停止支持）
         2. Fedora
         3. Red Hat Enterprise Linux
         4. Oracle Linux
         5. Red Flag

      4. Arch Linux/Gentoo

   3. Linux发行版的区别在哪里？

      1. 配置文件不同，不同的发行版具有不同的配置文件结构
      2. 包管理器不同，处理依赖的方式不同
      3. 软件源/软件仓库不同

## 常用命令

你在使用Linux的过程中分别使用过哪些命令？

1. 文件管理

   1. cat 查看文件内容

      ```bash
      cat [文件名] 
      ```

   2. chgrp 用于变更文件或目录的所属群组

      ```bash
      chgrp [参数] [群组] [文件名]
      ```

   3. chmod 控制用户对文件的权限

      ```bash
      chmod [+-=] [参数]
      ```

   4. chown

      ```bash
      chown [参数] 用户[用户组][文件名]
      ```

   5. diff

      ```bash
      diff [文件名1] [文件名2]
      ```

   6. find

      ```bash
      find [路径] [参数] [模式]
      ```

   7. less

   8. mv

   9. cp

   10. awk

2. 文档编辑

   1. fgrep
   2. rgrep

3. 磁盘管理

   1. cd
   2. df
   3. du
   4. ls
   5. pwd
   6. mount
   7. tree

4. 磁盘维护

   1. fdisk
   2. mkfs.ext4
   3. mkfs.fat
   4. mkswap

5. 网络通讯

   1. ping
   2. ifconfig
   3. netstat
   4. arp

6. 系统管理

   1. date
   2. kill
   3. who
   4. ps
   5. sudo
   6. uname
   7. chsh

7. 压缩命令

   1. tar
   2. gzip
