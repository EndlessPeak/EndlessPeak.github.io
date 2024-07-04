---
title: RK3588 移植 Ubuntu 24.04 
toc: true
authors:
  - EndlessPeak
date: 2024-07-01
hidden: false
draft: false
weight: 2
description: 本文记录了如何向 ATK-DLRK3588 移植 Ubuntu24.04 系统。
---

## Ubuntu-base
准备 `ubuntu-base` 镜像，我选择的是24.04镜像。

注意各镜像站存储 `ubuntu-base` 的路径可能不一样：
1. 官方 https://cdimage.ubuntu.com/ubuntu-base/releases/24.04/release
2. 清华大学 https://mirrors.tuna.tsinghua.edu.cn/ubuntu-cdimage/ubuntu-base/releases/24.04/release

## Build Rootfs
构建 ubuntu 根文件系统步骤如下：
1. 创建文件夹，并将下载的根文件系统解压到文件夹中
2. 安装跨架构运行器，以在非 ARM64 架构的主机上设置一个 ARM64 架构的 chroot 环境。
   1. `apt isntall qemu-user-static` 并拷贝到 
   2. `cp /usr/bin/qemu-aarch64-static ./ubuntu-rootfs/usr/bin` 
3. 设置 DNS `cp -L /etc/resolv.conf ./ubuntu-rootfs/etc/resolv.conf`
   1. `-L` 追踪被拷贝目标的真实位置，防止拷贝软链接过去
   2. `-b` 若拷贝到的目标位置已有文件，则备份后拷贝
4. 设置软件源 DEB822 格式
5. 挂载根文件系统，需要写`mount-rootfs.sh`，并赋予可执行权限
   ```bash
   #!/bin/bash

   # Ensure the path ends with a slash
   normalize_path() {
       if [[ "$1" != */ ]]; then
           echo "${1}/"
       else
           echo "$1"
       fi
   }
   
   mnt() {
       MOUNT_PATH=$(normalize_path "$2")
       echo "MOUNTING at $MOUNT_PATH"
   
       sudo mount -t proc /proc "${MOUNT_PATH}proc"
       sudo mount -t sysfs /sys "${MOUNT_PATH}sys"
       sudo mount -o bind /dev "${MOUNT_PATH}dev"
       sudo mount -o bind /dev/pts "${MOUNT_PATH}dev/pts"
       # sudo chroot "${MOUNT_PATH}"
   }
   
   umnt() {
       MOUNT_PATH=$(normalize_path "$2")
       echo "UNMOUNTING from $MOUNT_PATH"
   
       sudo umount "${MOUNT_PATH}proc"
       sudo umount "${MOUNT_PATH}sys"
       sudo umount "${MOUNT_PATH}dev/pts"
       sudo umount "${MOUNT_PATH}dev"
   }
   
   if [ "$1" == "-m" ] && [ -n "$2" ] ;
   then
       mnt $1 $2
   elif [ "$1" == "-u" ] && [ -n "$2" ];
   then
       umnt $1 $2
   else
       echo ""
       echo "Either 1'st, 2'nd or both parameters were missing"
       echo ""
       echo "1'st parameter can be one of these: -m(mount) OR -u(umount)"
       echo "2'nd parameter is the full path of rootfs directory(with trailing '/')"
       echo ""
       echo "For example: ch-mount -m /media/sdcard/"
       echo ""
       echo 1st parameter : ${1}
       echo 2nd parameter : ${2}
   fi
   ```
6. `chroot ubuntu-rootfs` 进入根文件系统
7. 安装一些常见的软件
   ```bash
   apt install dialog apt-utils language-pack-en-base
   apt install sudo vim udev net-tools ethtool udhcpc netplan.io iputils-ping
   locale-gen en_US.UTF-8
   dpkg-reconfigure locales
   dpkg-reconfigure tzdata
   apt install ifupdown language-pack-zh-han* openssh-server
   systemctl set-default graphical.target
   ```
   1. 首先是一些可能抱怨的问题
      1. debconf 会抱怨没有 dialog-like 程序
      2. apt 会建议加上 apt-utils
      3. perl 会抱怨 locale 设置不正确
   2. 其次是需要优先安装网络工具
      1. net-tools 提供 ifconfig netstat route arp 等实用工具
      2. ethtool 是配置以太网的
      3. udhcpc 是轻量 dhcp 客户端
      4. netplan.io 用于配置网络
      5. iputils-ping 提供 ping 命令以测试
   3. 运行一些修复命令
   4. 安装其他的软件，安装前检查 `snap install core`
      1. 可以安装桌面环境 
         1. `ubuntu-desktop-minial`
         2. `lubuntu-desktop` 
         3. `lxqt` 是否是更佳的选择？
         4. `xubuntu-desktop`
      2. 可以在安装桌面环境后裁剪软件，如卸载 libreoffice* lubuntu-update-notifier 等
      3. 如果不需要 ssh 连接，或者只需要 sftp，可改安装 openssh-sftp-server 等
      4. language-pack-zh-han* 包括了 hans 和 hant
8. 设置启动图形界面
9.  设置管理员密码和普通用户密码
10. 制作根文件系统镜像 `mk-ubuntu-image.sh`
    ```bash
    #!/bin/bash
    # stage 1
    # 读取输入参数，包括根文件系统目录和目标镜像文件
    rootfs_dir=$1
    rootfs_file=$2
    # 定义临时挂载目录
    rootfs_mnt="mnt"
    # stage 2
    # 检查输入参数时候存在
    if [ ! $rootfs_dir ] || [ ! $rootfs_file ];
    then
        echo "Folder or target is empty."
        exit 0
    fi
    # stage 3
    # 删除已存在的目标镜像文件
    if [ -f "$rootfs_file" ]; then
        echo "-- Delete exist $rootfs_file ..."
        rm -f "$rootfs_file"
    fi
    # stage 4
    # 创建新的目标镜像文件
    echo "-- Create $rootfs_file ..."
    dd if=/dev/zero of="$rootfs_file" bs=1M count=5120
    sudo mkfs.ext4 -F -L linuxroot "$rootfs_file"
    # stage 5
    # 创建挂载点目录
    if [ ! -d "$rootfs_mnt" ]; then
    mkdir $rootfs_mnt
    fi
    # stage 6
    # 将源根文件系统的数据复制到目标镜像文件中
    # 方法是：
    # 1. 将目标镜像文件挂载到挂载点
    # 2. 复制文件到挂载点
    # 3. 同步文件系统缓存
    # 4. 卸载镜像，删除挂载点
    echo "-- Copy data to $rootfs_file ..."
    sudo mount $rootfs_file $rootfs_mnt
    sudo cp -rfp $rootfs_dir/* $rootfs_mnt
    sudo sync
    sudo umount $rootfs_mnt
    rm -r $rootfs_mnt
    # stage 7
    # 检查与调整目标镜像大小
    echo "-- Resize $rootfs_file ..."
    e2fsck -p -f "$rootfs_file"
    resize2fs -M "$rootfs_file"
    echo "-- Done."
    ``` 
   
## Rootfs Post Hooks
### Size
查看制作的根文件系统大小：
```bash
sudo du -sh ubuntu-rootfs --exclude=ubuntu-rootfs/{proc,sys,dev}
```
### Dbus
关于可能遇到的 dbus 错误 `/run/dbus/system_bus_socket`:
```bash
service dbus start
service cron start
```
### User & Group
新建用户和组：
```bash
adduser leesin
usermod -aG sudo leesin
```
### Sleep
禁用睡眠、休眠等：
```bash
systemctl mask sleep.target
systemctl mask suspend.target
systemctl mask hibernate.target
systemctl mask hybrid-sleep.target
```

### Display Manager
检查显示管理器
```bash
cat /etc/X11/default-display-manager
```

## Flash Firmware
### Device
设备连接到系统后在 `/dev/ttyACM0` 位置。

### User & Group
PC 添加用户到 dialout 组，或者 uucp 组
```bash
usermod -aG dialout leesin
```

### Parameter
分区表需要重新设置，原来的分区表是：
```text
CMDLINE: mtdparts=:0x00002000@0x00004000(uboot),0x00002000@0x00006000(misc),0x00020000@0x00008000(boot),0x00040000@0x00028000(recovery),0x00010000@0x00068000(backup),0x01c00000@0x00078000(rootfs),0x00040000@0x01c78000(oem),-@0x01cb8000(userdata:grow)
```

现在需要将分区表改为：
```text
CMDLINE: mtdparts=:0x00002000@0x00004000(uboot),0x00002000@0x00006000(misc),0x00020000@0x00008000(boot),0x00040000@0x00028000(recovery),-@0x00068000(rootfs:grow)
```

特别地，后面写的`uuid`千万**不要**修改。

### Flash
首先进入 Loader 模式或者 Maskrom 模式；然后执行设备检查
```bash
sudo ./upgrade_tool LD
```

识别出设备后执行烧写
```bash
sudo ./upgrade_tool UL MiniLoaderAll.bin -noreset
sudo ./upgrade_tool DI -p parameter.txt
sudo ./upgrade_tool DI -uboot uboot.img
sudo ./upgrade_tool DI -misc misc.img
sudo ./upgrade_tool DI -boot boot.img
sudo ./upgrade_tool DI -recovery recovery.img
```

下面的命令仅在烧录 `buildroot` 系统时会用到
```bash
sudo ./upgrade_tool DI -oem oem.img
sudo ./upgrade_tool DI -rootfs rootfs.img
sudo ./upgrade_tool DI -userdata userdata.img
```

### Resize
烧录之后需要进行磁盘扩容。

由于分区有 uboot,misc,boot,recovery,rootfs 五个，所以扩容需要用 `sudo resize2fs /dev/mmcblk0p5`，否则mmcblk0p5分区只有5GiB。

### Ethernet Network
修改 `/usr/lib/NetworkManager/conf.d/10-globally-managed-devices.conf` 

内容为
```text
unmanaged-devices=*,except:type:ethernet,except:type:wifi,except:type:gsm,except:type:cdma
```

即加入 `except:type:ethernet` 以允许网口连接有线网络。

## Issues
### Graphical Target
如果 sddm 进入之后是空，修改 `/etc/sddm.conf` 脚本
```conf
[X11]
SessionCommand=/etc/sddm/Xsession
```

### ping
在测试网络时报错如下： 
```text
ping: socktype: SOCK_RAW
ping: socket: Operation not permitted
ping: => missing cap_net_raw+p capability or setuid?
```

意思是缺少 cap_net_raw 权能，或未设置 setuid 位：
1. cap_net_raw 是一种 Linux 能力，允许程序创建原始套接字，而不需要拥有 root 权限。
2. setuid 位是文件权限位，允许程序以文件所有者的权限运行。

解决办法：
1. `sudo setcap cap_net_raw+p $(which ping)`
2. `sudo ping www.bing.com` 逆天
3. `sudo set chmod u+s $(which ping)` 逆天无极限