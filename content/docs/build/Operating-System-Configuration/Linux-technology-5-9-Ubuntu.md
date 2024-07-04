---
title: Ubuntu Linux 桌面环境
toc: true
authors:
  - EndlessPeak
date: 2024-06-21
hidden: false
draft: false
weight: 9
description: 本文简单提要了 Ubuntu 24.04 的使用注意事项。
---

## Installation
1. 安装镜像：建议选用非官方 Ubuntu 的安装镜像，如 Kubuntu 或 Lubuntu 等；
   1. Ubuntu 安装镜像：5.7 GiB；
   2. Kubuntu 安装镜像：3.8 GiB；
   3. Lubuntu 安装镜像：3.1 GiB；
2. 自 24.04 开始，安装时对于EFI分区：
   1. 可自由选择挂载 `/boot` 或 `/boot/efi` 分区；
   2. 之前只能选择 `bootloader` 安装位置；
   3. 多个 ubuntu 同时安装在一台计算机上稍微需要费点功夫

## Software
### NVIDIA Drivers
1. 自 24.04 开始，对于 Nvidia 驱动，可直接选择 `Try or install Kubuntu` 而不必 `safe graphics`
2. 自 24.04 开始，`third-party` 软件集的选择更加丰富，但更可能在安装时错过图形驱动
   错过后，图形驱动将使用 `nouveau` 驱动而非 `nvidia-driver` 需要手动安装

### Memory Management
内存管理就是依托答辩。

### Fstab
自 24.04 开始，ubuntu **终于可以**使用 fstab 挂载由**其他发行版**格式化得到的 ext4 分区了。
1. 之前的版本你可以使用 `mount` 挂载，但企图写入 `fstab` 后开机自动挂载将会进入 emergency mode
2. 之前的版本使用 fsck 检查硬盘可能得到 feature 不支持问题

### Snap
安装某些程序将自动调用 snap 安装，真是贴心而又感人的设计。

比如安装 `firefox`，将会自动调用 snap 安装该程序，如果安装过程出错，将需要：
1. snap install core
2. snap refresh firefox
3. snap remove firefox && snap install firefox

使用 snap 安装带有 services 的软件时，可以这样管理相关的服务：
1. snap services
2. snap services <package>
3. systemctl status snap.<package>.<service>

## Issue
这里记录一下 ubuntu 十宗罪：
1. 个人使用体验
   1. 临时挂载磁盘在 `/media` ，建议在 `/run/media`
   2. 启动的时候无法看到日志
2. locale 在 `/etc/default/locale` 而不是 `/etc/locale.conf`
   1. 用户不能在安装过程中自己选择需要的 locale
   2. 将生成一个语系的所有 locale
3. 软件源软件太少
   1. snap
   2. flatpak
4. 24.04 推出了 DEB822 格式的软件源
   1. 当然，这个格式非常好
   2. 好就好在除了官方软件源，其他都是传统格式
5. 软件包名命名不统一
   1. 当然这是为了用户的需要
   2. 有些用户只需要命令行工具
   3. 有些用户开发需要相关的库
6. 拆包丧心病狂
   1. 当然这也是为了用户的需要
   2. 模糊匹配将导致搜索结果过多
   3. 一般人不会记忆究竟需要哪些包，libxxx-all-dev 用的更多
7. 虚包/软件包组名称不统一
   1. 对于 boost 是 libboost-all-dev
   2. 对于 opencv 是 libopencv-dev
8. 版本号命名不统一
   1. libgtk-3-dev
   2. libgtk2.0-dev
9. 使用 apt 安装本地包可能出错
   1. sudo apt install ./xxx.deb 可能提示权限不够的情况
   2. sudo dpkg -i ./xxx.deb
10. 系统版本过旧
    1. 软件需要用户手动安装
    2. 可能由于混合软件源产生依赖缺失/依赖错误的情况
       1. 手动编译源码安装
       2. 运行提供的 deb 包安装
11. 提示执行 `apt install -f`
    1. 提示依赖关系已被破坏
    2. 有软件包被要求保持现状导致的
    3. 可能需要手动指定解决办法