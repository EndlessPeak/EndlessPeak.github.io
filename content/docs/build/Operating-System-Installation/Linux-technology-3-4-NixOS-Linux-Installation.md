---
title: NixOS Linux 物理机安装与配置
toc: true
authors:
  - EndlessPeak
date: 2023-12-19
hidden: false
draft: false
weight: 4
description: 本文主要介绍了如何在物理机中安装NixOS Linux。
---

NixOS Linux是一个精确、纯净、可信赖、可重部署的发行版，它的设计包含一些独立的特性。

## Reference {#reference}

参考资料如下：

1.  [NixOS 中文网](https://nixos-cn.org/tutorials/installation/Subsystem.html)
2.  [NixOS Manual](https://nixos.org/manual/nixos/stable/)


## Start {#start}


### Network Configuration {#network-configuration}

NixOS 使用 `wpa_supplicant` 作为无线守护程序，因此可以使用交互式命令行或配置文件的形式进行网络连接


#### Passphrase {#passphrase}

可以用 `wpa_passphrase` 生成一个用于连接 WIFI 的配置文件

```shell
wpa_passphrase XXX_wifi password > ~/.internet.conf
```

而后使用 `wpa_supplicant` 连接网络

```shell
wpa_supplicant -c internet.conf -i wlan0 &
```

如果需要额外指定网卡，可以使用 `-D` 选项指定。


#### Command Line {#command-line}

使用下面的命令进入命令行交互模式：

```shell
sudo systemctl start wpa_supplicant
sudo wpa_cli
```

在交互模式下使用如下步骤连接：

```shell
> add_network #0
> set_network 0 ssid "WIFI's SSID" #OK
> set_network 0 psk "WIFI's password" #OK
> set_network 0 key_mgmt WPA-PSK #OK
> enable_network 0 #OK
```


### Change Channel {#change-channel}

更换频道的目的是用国内源先把NixOS跑起来。

```shell
sudo -i
nix-channel --add https://mirrors.ustc.edu.cn/nix-channels/nixpkgs-unstable nixpkgs  # 订阅镜像仓库频道
nix-channel --add https://mirrors.ustc.edu.cn/nix-channels/nixos-23.11 nixos  # 请注意系统版本
nix-channel --list  # 列出频道
nix-channel --update  # 更新并解包频道
nixos-rebuild --option substituters "https://mirror.sjtu.edu.cn/nix-channels/store" switch --upgrade  # 临时切换二进制缓存源，并更新生成
```

最后一步也可以不执行，而是在安装系统时一并执行。特别地，即使使用国内源，也可能存在特定的依赖关系致使没有对应的二进制包存在，建议使用手机热点的方式进行连接。


### Partition {#partition}

可以使用下面的命令查看磁盘和文件系统情况：

1.  `du` 查看指定目录或文件的磁盘使用情况，若不给定参数则显示当前目录
    1.  `du -h` 显示友好信息，会递归地显示每个目录的大小
    2.  `du -h --max-depth=1` 可以限定深度显示
2.  `df` 查看文件系统磁盘使用情况和剩余空间
    1.  `df -h` 显示友好信息
    2.  `df -T` 显示各分区的类型
    3.  `df -t ext4` 限制显示类型
    4.  `df -x tmpfs` 排除显示类型
    5.  `df -h | grep -v "/dev/loop"` 排除 `/dev/loop` 使用情况
3.  `lsblk` 用于列出系统中所有的块设备，这包括sysfs 文件系统和udev 数据库
    1.  `lsblk -a` 显示所有块设备，主要会增添显示逻辑块设备
    2.  `lsblk -f` 显示更详细的信息
4.  `fdisk` 用于操作分区表
    1.  `fdisk -l` 显示分区表信息
    2.  `fdisk -x` 更详细地显示
    3.  `fdisk [device]` 对指定分区进行交互式操作

挂载分区后，对分区进行格式化操作

```shell
mkfs.ext4 -L NixOS /dev/nvme0n1p8
mkfs.fat -F 32 /dev/nvme0n1p7
```

如果忘记给根分区打上标签，可以事后使用 `e2label` 补上。

```shell
e2label /dev/nvme0n1p8 -L NixOS
e2label /dev/nvme0n1p8
```


## Settings {#settings}


### Basic Configuration {#basic-configuration}

在新机器上生成默认配置的命令如下：

```shell
nixos-generate-config --root /mnt
```

如果仅需要硬件配置，可以将其从标准输入输出重定向到文件

```shell
nixos-generate-config --show-hardware-config > /etc/nixos/hardware-configuration.nix
```


### Driver Configuration {#driver-configuration}

1.  Nvidia
    参考 [NixOS Wiki Nvidia](https://nixos.wiki/wiki/Nvidia) 的配置，错误的显卡配置会导致无法进入图形界面
    1.  仅含独立显卡的机器只需要安装独立显卡驱动
    2.  核显与独显组合则需要配置PRIME方案
2.  UUID
    1.  硬盘的UUID在每次格式化后都会刷新
    2.  注意区分 `FileSystem UUID` 和 `Partition UUID` ，NixOS使用前者
    3.  挂载所需的分区后建议由NixOS自动生成硬件配置
3.  Software
    至少需要保证重建后的NixOS网络连通
    ```nix
    network.wireless.enable = true; # use wpa_supplicant
    network.networkmanager.enable = true; # use networkmanager
    environment.systemPackage = with pkgs;[
      git # flakes required
      firefox
      neovim
      curl # flakes required
      pciutils
      usbutils
      nix-prefetch-git # nix-prefetch-url already installed
    ];
    ```


### Build System {#build-system}

一般运行两次重建命令：

1.  使用默认配置把系统先跑起来，然后打开实验性质的选项：
    ```nix
    nix.settings = {
      substituters = lib.mkForce [
        "https://mirrors.cernet.edu.cn/nix-channels/store"
      ];
      experimental-features = ["nix-command" "flakes"];
    };
    ```

2.  导入配置，重建系统
