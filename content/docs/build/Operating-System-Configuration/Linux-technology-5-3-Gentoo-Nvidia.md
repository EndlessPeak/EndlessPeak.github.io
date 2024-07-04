---
title: Gentoo Linux Nvidia 显卡驱动
date: 2022-08-21 22:00:00
authors:
  - EndlessPeak
toc: true
hidden: false
draft: false
weight: 3
description: 本文主要讨论在Gentoo Linux中如何配置Nvidia显卡驱动。
---

由于Gentoo Linux 配置显卡驱动需要额外设置内核，因此记录下配置的内容。

## Kernel {#kernel}


### Dist Kernel {#dist-kernel}

编辑 `x11-drivers/nvidia-drivers` 所需要使用的 use 选项，加入 `dist-kernel` 这一项。


### Custom Kernel {#custom-kernel}

依次开启下列选项：

1.  CONFIG_MODULES
2.  CONFIG_MTRR
3.  CONFIG_VGA_ARB
4.  CONFIG_ACPI_IPMI
5.  CONFIG_AGP
6.  内核版本
    1.  在 5.15 及以前的需开启
        1.  CONFIG_SYSFB_SIMPLEFB
        2.  CONFIG_FB_SIMPLE
            注意开启该选项需要关闭 `Simple framebuffer device`
    2.  在 5.15 以后的需开启
        1.  CONFIG_SYSFB_SIMPLEFB
        2.  CONFIG_FB_SIMPLEDRM

依次关闭下列选项：

1.  CONFIG_FB_NVIDIA
2.  CONFIG_FB_RIVA
3.  CONFIG_DRM_NOUVEAU


## Install {#install}


### Use {#use}

推荐添加 tool 选项，如果为 wayland 安装，也可以加入 wayland 选项。


### Emerge {#emerge}

用此命令安装驱动 `emerge -av x11-drivers/nvidia-drivers`


## Settings {#settings}


### Modules {#modules}

输入 ~sudo vim /etc/modprobe.d/blacklist.conf~。

```cfg
blacklist nouveau
blacklist lbm-nouveau
options nouveau modeset=0
```


### Config {#config}


#### Generate Config {#generate-config}

生成 nvidia prime config 文件

```cfg
mv /etc/X11/xorg.conf /etc/X11/xorg.conf.bak
sudo nvidia-xconfig --prime
```


#### CheckID {#checkid}

检查显卡的 PCI 地址 `lspci` 查找显卡前面的数字，与 `/etc/X11/xorg.conf` 中的是否相符。


#### Launch Config {#launch-config}

1.  若使用启动管理器，则编辑启动管理器的配置
    例如使用 `sddm` ，则 `vim /usr/share/sddm/scripts/Xsetup`
2.  若使用窗口管理器，则 `vim .xinitrc`

然后加入下面的内容。

```cfg
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
```


### Modprobe {#modprobe}


#### Load in kernel as module {#load-in-kernel-as-module}

将 nvidia 模块加入内核，由于该驱动是闭源软件，不能直接编译进内核，而必须作为模块加载。

每次重新编译内核之后，都需要重新部署。

```shell
emerge -av @module-rebuild
```

重新加入内核，若第一次加入内核，只需执行最后的命令。

```shell
lsmod | grep nvidia
sudo rmmod nvidia
sudo modprobe nvidia
```


#### Load at startup {#load-at-startup}

加载 nvidia 模块有多种设置办法。

1.  通过 grub 向内核传递参数
    输入 `sudo vim /etc/default/nvidia` 输入内容
    ```cfg
    # Append parameters to the linux kernel command line
    GRUB_CMDLINE_LINUX="nvidia-drm.modeset=1"
    ```
2.  在配置文件中设置，让内核自动加载
    输入 `sudo vim /etc/modules-load.d/nvidia.conf` 输入内容 `nvidia`
    输入 `sudo vim /etc/modprobe.d/nvidia-drm.conf` 输入内容 `options nvidia-drm modeset=1`
3.  在启动图形界面前加载
    输入 `vim ~~/StartXorg.sh`
    ```sh
    #!/bin/bash
    sudo modprobe nvidia_drm nvidia_modeset nvidia && startx
    ```
    添加执行权限后，每次用该脚本启动。


## Reference {#reference}

<https://wiki.gentoo.org/wiki/NVIDIA/nvidia-drivers>
