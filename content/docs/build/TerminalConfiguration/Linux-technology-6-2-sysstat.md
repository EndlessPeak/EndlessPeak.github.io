---
title: System Management
toc: true
authors:
  - EndlessPeak
date: 2024-06-09 20:00:00
hidden: false
draft: false
weight: 1
description: 本文主要介绍 Linux 系统管理。
---

## Mem management {#mem-management}


### All Mem statistic {#all-mem-statistic}

统计本机所有内存使用量。

```shell
free -h
```


### Sort by all user {#sort-by-all-user}

统计所有用户的内存使用量。

```shell
ps aux --sort=-%mem | head -n 10 | awk 'NR==1 {print $0; next} { $5=int($5/1024) "M"; $6=int($6/1024) "M"; $11=substr($11, 1, 100); print $0; }'
```

其中，~$11=substr($11, 1, 100);~ 是因为某些命令过长需要进行限制，如 `pycharm` 或 `distrobox` 等。


### Sort by someone {#sort-by-someone}

统计指定用户的内存使用量。
方法一：首先提取表头，然后显示内容及排序。

```shell
ps aux --sort=-%mem | head -n 1 && ps aux --sort=-%mem | grep '^chan' | head -n 10 | awk '{ $5=int($5/1024) "M"; $6=int($6/1024) "M"; print $0; }'
```

方法二：手动输出表头，然后显示内容及排序。

```shell
echo "USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND"
ps aux --sort=-%mem | grep '^chan' | head -n 10 | awk '{ $5=int($5/1024) "M"; $6=int($6/1024) "M"; print $0; }'
```


### Monitor {#monitor}

实时监控内存，可以将上述命令编为脚本，然后使用watch循环输出。

```shell
watch -n 1 ./top_10_mem.sh
```


### Swapfile {#swapfile}

内存不够时可以通过添加 `swapfile` 或者开启 `swap partion` 解决。

生成交换文件。

```shell
fallocate -l 32G /swapfile
dd if=/dev/zero of=/swapfile bs=1M count=32768
```

设置权限并格式化文件。

```shell
chmod 600 /swapfile
mkswap /swapfile
```

开启交换文件。

```shell
swapon /swapfile
swapon --show
```

关闭交换文件

```shell
swapoff /swapfile
```

如果需要用大交换文件替换小交换文件，建议先开后关。
