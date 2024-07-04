---
title: Arch Linux 桌面环境配置
toc: true
authors:
  - EndlessPeak
date: 2020-02-18 20:00:00
hidden: false
draft: false
weight: 1
---

如果现在让我选择一个我心目中最好的Linux发行版，同时也是最简单的Linux发行版，作为长期甚至终身使用的Linux，我会选择的发行版是：Arch Linux！

<!--more-->

尽管入门可能会有难度，但它比任何其他的发行版都要好，它可以避免管理其他任何系统时所不得不忍受的痛苦。人们通常会想到入门难度，但最重要的其实是**终身难度**。同时，Arch Linux比其他发行版**更有可能改变人们对Linux发行版的看法**。——Luke Smith

下面我结合我这段时间的学习，谈谈如何在Arch Linux上打造属于我自己的工作环境。

## Initialization

在刚安装完Arch Linux的电脑上依次运行下面的命令。

> 注：如果是Manjaro发行版，由于开源驱动nouveau比较弱智，需要在启动选项中调参设置。
>
> 具体的做法是在进入grub菜单后选择Manjaro按`e`进入启动参数设置，搜索第一个`quiet`并在后面加入`nouveau.modeset=0`之后按Ctrl+X启动；
>
> 正常进入系统之后记得输入命令`sudo vim /boot/grub/grub.cfg` ，然后把上面的操作重复一遍。

*命令约定：无`$`标识符的命令代表以`root`身份执行；通常它们在终端中以`#`开头。*

```bash
archlinux login:root #以root方式登录
Password:
dhcpcd #有线网络连接时，自动分配IP地址
pacman -S vim #安装编辑器之神VIM
vim /etc/pacman.conf
```

查找`Color`并删去注释，然后在文件尾添加以下内容：

```bash
[archlinuxcn]
SigLevel = Never #或者Optional TrustedOnly
Include = /etc/pacman.d/archlinuxcn
```
```bash
vim /etc/pacman.d/archlinuxcn
#使用Ctrl+Shift+C/V向文件中加入以下内容
## 浙江大学 (浙江杭州) (ipv4, ipv6, http, https)
## Added: 2017-06-05[archlinuxcn]
Server= https://mirrors.zju.edu.cn/archlinuxcn/$arch
## 中国科学技术大学 (ipv4, ipv6, http, https)[archlinuxcn]
Server= https://mirrors.ustc.edu.cn/archlinuxcn/$arch
## 清华大学 (ipv4, ipv6, http, https)[archlinuxcn]
Server= https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
## xTom (Hong Kong) (ipv4, ipv6, http, https)
## Added: 2017-09-18
## xTom Hong Kong Mirror[archlinuxcn]
Server= https://mirror.xtom.com.hk/archlinuxcn/$arch
## Unique Studio (湖北武汉) (ipv4, http, https)
## Added: 2017-08-02[archlinuxcn]
Server= https://mirrors.hustunique.com/archlinuxcn/$arch
## 上海科技大学 (上海) (ipv4, http, https)
## Added: 2016-04-07[archlinuxcn]
Server= https://mirrors-wan.geekpie.org/archlinuxcn/$arch
## 中国科学院开源软件协会 (北京) (ipv4, http)
## Added: 2017-02-09[archlinuxcn]
Server= http://mirrors.opencas.org/archlinuxcn/$arch
## 电子科技大学凝聚网络安全工作室 (ipv4, http)
## Added: 2016-05-28[archlinuxcn]
Server= http://mirrors.cnssuestc.org/archlinuxcn/$arch
## 网易 (ipv4, http)[archlinuxcn]
Server= http://mirrors.163.com/archlinux-cn/$arch
## 重庆大学 (ipv4, http)[archlinuxcn]
Server= http://mirrors.cqu.edu.cn/archlinuxcn/$arch
```

然后再继续执行下面的命令：

```bash
pacman -S archlinuxcn-keyring #安装密钥
```

> 可能遇到**Unable to lock database**错误，执行下面的命令作为解决方案：
> ```bash
> rm /var/lib/pacman/db.lck
> ```


```bash
pacman -Syyu #强制更新软件源列表并更新本机软件
```
> 注1：你可能会在以后的使用过程中遇到更新出错的情况。但是请注意，用户应当对自己的滚动升级的系统稳定性负责任。用户自己决定何时升级、修改配置。Arch与其他发行版的一个不同是，Arch是真正的“DIY”发行版。抱怨系统损坏是无意义的，毕竟上游的改动不是Arch开发者的责任。
>
> 注2：如果是Manjaro发行版，初始执行更新软件源列表出错，运行下面命令：
> ```bash
> pacman-mirrors -i -c China -m rank
> ```
> 
> 或者`sudo vim /etc/pacman.d/mirrorlist`并向其中添加下列内容：
> 
> ```bash
> ## 中科大
> Server = https://mirrors.ustc.edu.cn/manjaro/stable/$repo/$arch
> ##  清华大学
> Server = https://mirrors.tuna.tsinghua.edu.cn/manjaro/stable/$repo/$arch
> ## 上海交通大学
> Server = https://mirrors.sjtug.sjtu.edu.cn/manjaro/stable/$repo/$arch
> ## 浙江大学
> Server = https://mirrors.zju.edu.cn/manjaro/stable/$repo/$arch
> ```

依次执行下面的命令：

```bash
pacman -S nvidia #安装NVIDIA驱动
```

> 注：关于驱动的内容，请详细地参考：[Arch NVIDIA](https://wiki.archlinux.org/index.php/NVIDIA)
>

```bash
pacman -S xorg xorg-sever #首先安装Xorg，如果使用NVIDIA闭源驱动还需要追加Xorg-xrandr
pacman -S xf86-input-synaptics #笔记本的触摸板驱动
pacman -S ttf-dejavu wqy-microhei #安装中文字体包 #注，本条见后面的中文输入法
```

新增一个普通用户，养成良好的安全习惯，日常事务用普通用户进行：

```bash
useradd -m -g users -G wheel -s /bin/bash <username> 
#上述命令为添加用户，-m表示添加用户的登入目录（即家目录），用户名<username>,-G表示所属的附加群组wheel，-g指定用户所属的群组，值可以是组名，也可以是GID，用户组必须已经存在，默认值100，即users，-s指定用户登入后所使用的shell
passwd <username> #设置该用户的密码
ln -s /usr/bin/vim /usr/bin/vi #把vim编辑器链接到vi上（当然习惯使用vi也可以不链接，或者链接nano都行）
visudo #使用该命令为你的用户进行提权
```

使用`visudo`进入sudo file后，查找到`# %wheel ALL=(ALL) ALL`，去除前面的`#`号。完成这一切后，输入`exit`退出管理员用户，并以新添加的用户身份登录。

## Deepin

※安装DDE (Deepin Desktop Environment)桌面环境是最重要的一步，命令如下：

```bash
$ sudo pacman -S deepin deepin-extra
```

> 注：DDE 桌面我个人理解是Gnome系的设计理念，KDE系的外观。(注：Gnome是为对抗KDE应运而生的桌面环境)；DDE 的显示管理器默认为 `lightdm`，如果你需要安装多个桌面环境，例如将KDE Plasma和DDE 同时安装，则用下面的命令查询正在起作用的显示管理器：

```bash
$ sudo systemctl status sddm
$ sudo systemctl status lightdm
```

> 如果登录管理器不能正常运作，使用下面的命令检查报错信息：

```bash
$ sudo journalctl -u lightdm 
```

可以选择自己喜欢的显示管理器启用，并弃用另一个显示管理器。简要命令如下：

```bash
$ sudo systemctl enable lightdm
$ sudo systemctl disable sddm
```

为Deepin切换Deepin风格的登录界面：

```bash
$ sudo vim /etc/lightdm/lightdm.conf
```

将`/greeter-session=example-gtk-gnome`改为`/greeter-session=lightdm-deepin-greeter`并去掉前面的`#`号。

## KDE Plasma

※如果选用KDE Plasma，则安装KDE桌面环境是最重要的一步。如果觉得整体安装包过大，可以安装虚包：

```bash
$ sudo pacman -S plasma kde-applications #完整包
$ sudo pacman -S plasma-meta kde-applications-meta #虚包
```

安装图形登录界面：

```bash
$ sudo pacman -S sddm sddm-kcm
$ sudo systemctl enable sddm #开启sddm服务，以自动登录到显示管理器
```

## Basic Apps

安装日常使用的软件命令如下：

### NVIDIA

如果是使用NVIDIA闭源驱动，则使用下列命令编辑启动管理器的脚本：

```bash
$ sudo vim /usr/share/sddm/scripts/Xsetup
```

加入下列内容：

```bash
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
```

输入下列命令获知本机的显卡型号及PCI地址：

```bash
$ lspci -k | grep -A 2 -E "(VGA|3D)"
$ sudo vim /etc/X11/xorg.conf
```

在该文件(没有会自动创建一个)中输入下列内容：

```bash
Section "Module"
	Load "modesetting"
EndSection

Section "Device"
	Indentifier "nvidia"
	Driver "nvidia"
	BusID "1:0:0" #填入刚才获得的显卡PCI地址，注意每部分均为个位数
	Option "AllowEmptyInitialConfiguration"
EndSection
```

配置以上部分，重启之后Arch Linux应该就能顺利进入`sddm`登录管理器了。

**问题：配备`intel`集成显卡和`NVIDIA`独立显卡的机器登入图形界面时机器挂起/关机**

首先，需要注明的是，这是Linux对于`NVIDIA`显卡驱动支持不完善的问题引起的。但硬件驱动支持不完善是典型的**上游错误**(NVIDIA显卡没有发挥它的作用是NVIDIA团队的问题，而不是Arch开发者的责任)。

如果不启动图形界面，只用`tty`，是没有问题的。

解决方法：

- 如果你将你的`Display Manager`加入了守护进程(即每次会自动登入`Display Manager`)，那么我目前能想到的方法是使用`Live CD`，将你的Arch Linux挂载在`Live CD`上，然后使用`arch-chroot`操作。

- 如果你开机进入的是`tty`(即你每次都是手动启动图形界面)，那么就按照平时在终端中的操作来进行操作即可。

- 操作如下：

```bash
$ sudo pacman -S bumblebee   # 安装bumblebee
$ sudo nano /etc/modprobe.d/modprobe.conf
#在文件中添加“options nvidia NVreg_Mobile=1”，然后保存退出，重启机器
```

### 安装图形网络管理工具：

```bash
$ sudo pacman -S networkmanager #一般来说你应该已经安装过了，此处以防万一。
$ sudo pacman -S net-tools
$ sudo systemctl enable NetworkManager #开启网络管理服务
$ sudo systemctl enable dhcpcd
```

### 安装声音相关的软件：

```bash
$ sudo pacman -S alsa-utils pulseaudio pulseaudio-alsa
```

### 安装Yay：

Yay是AUR的包管理器。(也可以使用yaourt，见下)

```bash
$ git clone https://aur.archlinux.org/yay.git --depth=1
$ cd yay
$ makepkg -si #编译安装
$ sudo pacman -Qs yay #安装完成后可以通过这条命令查看yay是否安装
```

> 注意1：
>
> 在安装yay时要改为普通用户，否则Manjaro发行版在makepkg的时候可能报错。因为root在makepkg时可能会造成毁灭性灾难，因此是不被允许的。但如果先以root账户克隆文件，再以普通用户安装时，又会提示权限不够，还需要sudo chown，相当麻烦。
>
> 注意2：
>
> 在makepkg时出现`==>错误： Cannot find the fakeroot binary. ==> 错误： Cannot find the strip binary required for object file stripping.` 是因为缺少打包基本工具，即`base-devel`，需要先安装这个软件包组。
>
> 注意3：
>
> 其实，直接执行`sudo pacman -S yay`也能得到yay。构建是为了熟悉这种从源代码开始打包安装的过程。任何从AUR软件仓库上下载软件的用户都应该会这种构建过程，否则可能在安装软件中出现毁灭性灾难。

配置中国镜像：

```bash
$ yay --aururl "https://aur.tuna.tsinghua.edu.cn" --save
```

配置文件的位置位于`~/.config/yay/config.json`，也可通过下面的命令查看修改过的配置：

```bash
$ yay -P -g
```

### 安装Yaourt

Yaourt也是AUR的包管理器，但已经停止更新，故建议使用yay。

```
sudo pacman -S yaourt #安装Yaourt
#配置Yaourt
#添加之前首先备份原文件（这是可选的）
cp /etc/yaourtrc /etc/yaourtrc.backup
#修改 /etc/yaourtrc配置文件
vim /etc/yaourtrc
#去掉#AURURL 的注释,并修改
AURURL=“https://aur.tuna.tsinghua.edu.cn”
```

### 安装中文输入法：

#### ※Fcitx

如果安装的是中州韵、谷歌拼音、sun拼音、cloud拼音等非搜狗输入法，具体命令如下：

```bash
$ sudo pacman -S fcitx fcitx-im fcitx-configtool #输入法框架及管理器
$ sudo pacman -S fcitx-rime #中州韵输入法
$ sudo pacman -S fcitx-googlepinyin #谷歌拼音输入法
$ sudo pacman -S fcitx-cloudpinyin #cloud拼音输入法
```

> 注：可以用这些输入法组合搜狗输入法的词库，相比直接使用搜狗拼音输入法来说，稳定性更好。

如果安装搜狗拼音输入法，则输入法框架选用的是`fcitx-lilydjwg-git`(这是fcitx-qt4的archlinuxcn源包名)；可以先查询一下：

```shell
$ sudo pacman -S fcitx fcitx-im fcitx-configtool
$ pacman -Ss fcitx-qt4 #该命令是查询软件包命令，会返回软件包名，以该名为准。
```

如果没有像前文一样正确配置archlinuxcn源，则上述查询命令不会有返回结果，需要用yay安装或者正确配置archlinuxcn源。

```shell
$ sudo pacman -S fcitx-qt4 #该软件包以上个命令返回为准
$ sudo pacman -S fcitx-sogoupinyin #安装搜狗拼音输入法
```

注：据说Gnome(GTK)用户要安装fcitx-qt5，其可选依赖于fcitx-configtool；而KDE(QT)用户则需要安装软件包kcm-fcitx；该包中包含qt5；如果完全根据情境安装，非常复杂，我的建议是：小孩子才做选择，大人我全都要。遇到软件包冲突后再根据提示进行卸载操作。

编辑相关文档：

```bash
$ vim /home/<username>/.xprofile #激活fcitx和桌面环境语言设定
```

编辑内容如下：

```bash
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
```

> 注1：`.xprofile`文件生成后需要注销或重启级别的操作才能生效。未生成该文件或该文件未生效，则中文输入法不会出现汉字候选框。
>
> 注2：如果提示搜狗拼音输入法出现问题，请按提示删除`~/.config/sogouPY*`两个文件夹后重启`fcitx`。

#### 中文字体包及emoji

```bash
$ yay -S ttf-linux-libertine ttf-inconsolata ttf-joypixels ttf-twemoji-color noto-fonts-emoji ttf-liberation ttf-droid   #Emoji安装

$ yay -S wqy-bitmapfont wqy-microhei wqy-microhei-lite wqy-zenhei adobe-source-han-mono-cn-fonts adobe-source-han-sans-cn-fonts adobe-source-han-serif-cn-fonts #中文字体
```

#### IBUS

IBUS输入法管理器是`fcitx`的替代品，自行查找安装方式。

### 安装Git

```bash
$ sudo pacman -S git #Manjaro Linux发行版已经安装了git
```

### 安装浏览器

浏览器的可选项比较多，下面列举几个以供参考。

**FireFox**：火狐浏览器，支持多扩展。

**Google-Chrome**：谷歌浏览器，它类似Linux中的Arch，具体优点不赘述。

**Chromium**：开源、支持多扩展的谷歌浏览器(工程版)。

**Midori**：轻量、快速的浏览器。

```bash
$ yay -S google-chrome #或者google-chrome-stable
$ sudo pacman -S firefox
$ sudo pacman -S chromium
$ sudo pacman -S midori
```

## Advanced Apps

### 社交软件

#### 安装QQ和TIM

```bash
$ sudo pacman -S deepin.com.qq.im
$ sudo pacman -S deepin.com.qq.office
```

#### 安装微信

```bash
$ sudo pacman -S electronic-wechat   # 基于Electron的微信，本质上是网页版的微信
$ sudo pacman -S wine-wechat         # Wine集成的Windows平台的微信
# wine-wechat可能需要安装wine-mono字体，它建议使用pacman进行管理：
# sudo pacman -S wine-mono
```

至于它们运行所遇到的问题，建议阅读下一篇博客。

### 音乐播放器

```bash
$ yay -S netease-cloud-music
```

### 下载工具

Transmission

```bash
$ sudo pacman -S transmission-qt    # 基于Qt的图形化界面
$ sudo pacman -S transmission-gtk   # 基于GTK的图形化界面
# 两种皆可
```

qBittorrent

```bash
$ sudo pacman -S qbittorrent
```

### 视频播放工具

VLC

```bash
$ sudo pacman -S vlc
```

### 磁盘无损分区工具

Gparted

``` bash
$ sudo pacman -S gparted
```

### 安装电池选项

TLP，提供优秀的 Linux 高级电源管理功能,不需要你了解所有的技术细节。默认配置已经对电池使用时间进行了优化，只要安装即可享受更长的使用时间。除此之外，TLP 也是高度可配置的，可以满足各种特定需求。

参考[官方文档](gitHub.com/linrunner/TLP)，等待补充。

```bash
$ sudo pacman -S tlp
```

### 安装蓝牙设备管理器

Blueman

```bash
$ sudo pacman -S blueman
```

使用之前需要将`bluetooth`添加至守护进程：

```bash
$ sudo systemctl enable bluetooth
```

### 文件系统NTFS挂载工具

NTFS-3G

```bash
$ sudo pacman -S ntfs-3g
```

### 系统托盘工具

Trayer，注意，该工具只适合在未配系统托盘的窗口管理器（如dwm）中使用。

```bash
$ sudo pacman -S trayer
```

`trayer`有很多的选项。对于只使用窗口管理器的人来说，可以参考如下启动选项：

```bash
trayer --transparent true --expand false --align right --width 20 --SetDockType false --tint 0x88888888 &
```

### 电池状况监控工具

ACPI

```bash
$ sudo pacman -S acpi
```

### 图形化的解压缩软件

Xarchiver

```bash
$ sudo pacman -S xarchiver
```
