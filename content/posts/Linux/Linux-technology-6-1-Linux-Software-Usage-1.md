---
title: Linux软件使用问题与解决方案
toc: true
authors:
  - EndlessPeak
tags:
  - Linux
categories:
  - Linux Basic
  - 解决方案
date: 2020-04-03 02:00:00
hidden: false
draft: false
---

最近课程较少，于是我又花费了相当多的时间折腾Linux。这一部分我尝试讲述常用软件的安装过程中遇到的问题，以及我自己探索的解决思路。这是一个大坑，我挖开是想慢慢填补。

可能我遇到问题不会有任何的规律，而我撰文的目的也只是为了满足我自己的需求。本节主要讨论的是家目录和QQ的解决方案汇总。

<!--more-->

## XDG user directories

问题的提出：我的实体机Linux每次进入用户目录的时候需要输入类似如下的命令：

```bash
$ cd 下载/
```

进入用户目录需要切换两次输入法，相当麻烦。于是萌生了将家目录下的用户目录整体改为英文。

> Arch Wiki的定义：用户目录指位于 $HOME 下的一系列常用目录，例如 Documents，Downloads，Music，还有 Desktop。用户目录会在文件管理器中显示为不同的图标，且被多种应用程序所参照。可以使用 `xdg-user-dirs`命令自动生成这些目录。

### Gnome解决办法

我不知道是因为Ubuntu还是因为Gnome作为桌面环境的缘故，总之这些Linux用户可以采用以下办法：

1. 输入命令`export LANG=en_US` 和`xdg-user-dirs-gtk-update`

2. 在弹出的窗口中询问是否将目录转化为英文路径，同意并关闭

3. 使用命令`epxort LANG=zh_CN`

### KDE解决办法

由于我是Manjaro Linux，基于Arch，同时安装的是KDE桌面环境，故命令`xdg-user-dirs-gtk-update`会提示找不到。查阅Arch Wiki内容如下：

#### 创建默认目录

可以用 `xdg-user-dirs` 命令在 `$HOME` 下创建一整套默认的经本地化的用户目录。运行：

```
$ xdg-user-dirs-update
```

运行后该命令还会自动地：

- 创建一个本地的 `~/.config/user-dirs.dirs` 配置文件：应用程序通过他来查找使用特定帐号指定的用户目录。
- 创建一个本地的 `~/.config/user-dirs.locale` 配置文件：根据使用的 locale 指定语言。

由于我的发行版Manjaro在安装的时候Manjaro Installation软件已经自动帮我完成了上述工作，因此这里我不需要做任何操作。其实Arch Linux也不需要做这一步操作，上述内容只是在解释`xdg-user-dirs-update`命令的工作原理。

Arch Wiki注明说使用 `LC_ALL=C xdg-user-dirs-update --force` 命令可以强制创建英语目录。但就我个人实践情况来看，这条命令并不起作用。我想可能必须在刚安装完的Arch系统上，尚未创建用户目录的系统，使用该命令才可以，或者需要先手动将所有用户目录先改成英文。

#### 创建自定义目录

本地的 `~/.config/user-dirs.dirs` 和全局的 `/etc/xdg/user-dirs.defaults` 配置文件都使用如下的环境变量格式： `XDG_DIRNAME_DIR="$HOME/目录名"`。

比如，我原先家目录下的配置如下所示：

```text
~/.config/user-dirs.dirs
XDG_DESKTOP_DIR="$HOME/桌面"
XDG_DOCUMENTS_DIR="$HOME/文档"
XDG_DOWNLOAD_DIR="$HOME/下载"
XDG_MUSIC_DIR="$HOME/音乐"
XDG_PICTURES_DIR="$HOME/图片"
XDG_PUBLICSHARE_DIR="$HOME/公共"
XDG_TEMPLATES_DIR="$HOME/模板"
XDG_VIDEOS_DIR="$HOME/视频"
```

Linux本地化后目录都会是中文，而我想将其改为英文，故我应该先将`~/.config/user-dirs.dirs`中的内容改为如下形式：

```text
~/.config/user-dirs.dirs
XDG_DESKTOP_DIR="$HOME/Desktop"
XDG_DOCUMENTS_DIR="$HOME/Documents"
XDG_DOWNLOAD_DIR="$HOME/Downloads"
XDG_MUSIC_DIR="$HOME/Music"
XDG_PICTURES_DIR="$HOME/Pictures"
XDG_PUBLICSHARE_DIR="$HOME/Public"
XDG_TEMPLATES_DIR="$HOME/Templetes"
XDG_VIDEOS_DIR="$HOME/videos"
```

然后切记不要立刻执行`xdg-user-dirs-update`，否则会提示：

```text
(用户目录) has been removed,($用户目录) has been renamed.
```

紧接着你会发现你刚才编辑的文件内容全都被改回原样了，别问我是怎么知道的。

出现这样的原因就是此时本地的文件夹还没有重命名，只是更改了配置文件。家目录下的常用目录必须**被手动重命名**之后再行更新命令。

于是我在`Dolphin`(KDE File Manager)中为各个用户目录手动重命名，顺便提一句，重命名的快捷键是F2。

> 值得注意的是，KDE中可能设置有单击文件夹视为直接进入的选项，故如果在KDE中，需要点击文件夹左上角的加号以选中文件夹或文件。其他桌面环境的文件管理器如Gnome的Nautilus，XFCE的Thunar等等或在窗口管理器运行的Dolphin都不需要考虑这段。

手动重命名完成后，使用如下命令更新：

```bash
$ LANG=en_US.UTF-8 xdg-user-dirs-update
```

## Deepin QQ Install

问题的提出：我希望在Linux上安装QQ。

QQ 是腾讯公司开发的即时通讯软件，为 ICQ 的仿制品，是中国最流行的 IM 软件。关于QQ的内容，Arch wiki中总共有两种大体的解决思路：

1. 虚拟机
2. Wine

虚拟机自不必多说，主要是资源占用过高，而我的实体机Linux安装的时候分配的磁盘空间又过小，故无法安装虚拟机，只能用Wine的思路。

此处推荐`Deepin`社区的`deepin-wine-qq`/`deepin-wine-tim`或`deepin.com.qq.im`/`deepin.com.qq.office`,至于手动实现wine方案等等，我推荐参考[官方文档](https://wiki.archlinux.org/index.php/Tencent_QQ_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))。说实话，耗时耗力还不一定讨好，比如之前很出名的清风老师的解决方案已经近两年没更新了，再比如那个手动实现wine方案，光配置代码就超过一个屏幕了。

### 安装Deepin-wine-qq/tim

#### 安装及配置

结合我自己尝试的经历，我并不是很推荐deepin-wine-qq/tim，主要原因就是安装的依赖过多。一个聊天软件居然要占800多MiB的空间，在我看来是不敢想象的。但是既然已经尝试过了，就说一说：

```bash
$ yay -S deepin-wine-qq #或者deepin-wine-tim，二者任选其一
```

依次等待安装依赖，下载构建文件，从源代码编译，打包，安装最后结束。

很可能打开QQ或TIM会发现字体全部显示为□，而且巨卡无比，别问我是怎么知道的。

在Linux的`/usr/share/fonts`中查找`wqy-microhei.ttc`字体。

> 之前试着用的是微软的simsun宋体字体，结果因为日常文件往来里面字体很多是宋体，不安装宋体会造成排版不一致，但是安装上宋体后wine QQ就又会巨卡，并且聊天窗口标题栏字体还是有概率显示成方框，令人自闭。

如果你没有装文泉驿的字体，那就pacman把这个装上；如果对文泉驿不放心，还可以选择微软雅黑`msyh.ttc`。因为我是双系统，很容易就从C:\Windows\System\Fonts中找到这个字体。

(可选的步骤)修改wine系统注册表，输入命令：

```bash
$ vim ~/.deepinwine/Deepin-WeChat/system.reg
```

更改下面两行内容为：

```
"MS Shell Dlg"="msyh" 
"MS Shell Dlg 2"="msyh"
```

我说这一步是可选的，原因就是我当时就并没有做这一步。

注册字体，输入命令：

```bash
$ vim msyh_config.reg
```

添加如下内容：

```text
REGEDIT4
[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\FontLink\SystemLink]
"Lucida Sans Unicode"="msyh.ttc"
"Microsoft Sans Serif"="msyh.ttc"
"MS Sans Serif"="msyh.ttc"
"Tahoma"="msyh.ttc"
"Tahoma Bold"="msyhbd.ttc"
"msyh"="msyh.ttc"
"Arial"="msyh.ttc"
"Arial Black"="msyh.ttc"
```

最后输入命令完成字体注册：

```bash
$ deepin-wine regedit msyh_config.reg
```

然后应该就可以正常使用了，当然，图片和头像应该还是加载不出来，这一点见后文。

### 安装Deepin.com.qq.im/office

#### 安装及配置

```bash
$ sudo pacman -S deepin.com.qq.office deepin.com.qq.im #需要ArchLinuxCN源才能安装
#或者直接yay安装
$ yay -S deepin.com.qq.office deepin.com.qq.im
```

检查安装包gnome-settings-daemon是否存在，如果不存在，就安装该包。

```bash
$ sudo pacman -Qs gnome-settings-daemon
$ sudo pacman -S gnome-settings-daemon
```

可通过以下命令来启动 `gnome-settings-daemon`

```bash
$ /usr/lib/gsd-xsettings
```

在QQ/TIM的执行脚本中添加语句使其在软件启动前自动启动。

```bash
$ vim /opt/deepwine/apps/Deepin-QQ/run.sh #或者为Deepin-TIM
```

在文件首添加下面的内容：`/usr/lib/gsd-xsettings &`

### 问题与解决方案

#### 问题1：Tim和QQ可能会在点击好友图像时卡死

原因是pulseaudio进程的问题。可以考虑结束，但会影响到声音的调整。

(鬼知道这两个千里之外的包为什么会产生冲突，就像我不知道为什么deepin社区在打包QQ和TIM的时候需要加上gnome-settings-daemon依赖一样。)

#### 问题2：在i3wm中图标可能无法正常使用

i3wm的system tray实现方式比较特殊，QQ/TIM的托盘为`wine system trayer`。不过天无绝人之路，deepin-TIM和deepin-QQ在目录/opt/deepinwine/tools中有工具sendkeys.exe，使用时需要指定wine路径，运行下面的代码会向qq和TIM进程发送ctrl+alt+z，QQ和TIM如果使用默认的快捷键会被弹出：

```bash
$ env WINEPREFIX=/home/<username>/.deepinwine/Deepin-QQ deepin-wine /opt/deepinwine/tools/sendkeys.exe $3 z
```

释义：env是外部命令，用于列出环境变量或赋值；此处即给环境变量`WINEPREFIX`赋值为/home/<username>/.deepinwine/Deepin-QQ，而后启动deep-wine容器(其环境变量前面已定义)，在其中执行/opt/deepinwine/tools/sendkeys.exe，sendkeys.exe需要传入参数，此处传入`$3`和`z`两个参数($3被定义为宏 `Ctrl+Alt` )。

> 注：同一文件目录下sendkeys.sh 文件做了封装，直接运行sendkeys.sh z在有的环境下会出bug。(因为环境变量可能无法识别)

执行：通常情况下会报错，但QQ/TIM界面会收到快捷键并弹出。

```shell
Wine cannot find the ncurses library (libncurses.so.5).
key down: (ctrl+alt+Z), 3, 0
key up: (ctrl+alt+Z), 3, 0
```

#### 问题3：QQ、TIM、微信的图标可能显示不正确

下面以微信为例说明这个问题。

在Linux下面桌面图标快捷方式是由一个desktop文件配置，比如微信的内容基本上如下：

```shell
#!/usr/bin/env xdg-open
[Desktop Entry]
Encoding=UTF-8
Type=Application
X-Created-By=Deepin WINE Team
Categories=chat;
Icon=deepin.com.wechat
Exec="/opt/deepinwine/apps/Deepin-WeChat/run.sh" -u %u
Name=WeChat
Name[zh_CN]=微信
Comment=Tencent WeChat Client on Deepin Wine
StartupWMClass=WeChat.exe
MimeType=
```

其中比较关键的地方，是Icon，Exec，Name和**StartupWMClass** 。默认情况下，Linux是根据可执行文件的名称判定是属于哪个desktop文件配置的，大部分desktop文件的Exec配置的可执行文件刚好就是实际执行的文件名，所以很多没有StartupWMClass配置项。但这个配置项其实很重要，比如说在上面的微信的配置里面这个值是”WeChat.exe“，但是为什么还是不行呢？

通过`xprop WM_CLASS`获取窗口的属性值，在命令行下执行这个命令，鼠标会变成+，然后点击要微信的窗口，输入和输出如下：

```bash
$ xprop WM_CLASS
WM_CLASS(STRING) = "wechat.exe", "Wine"
```

检查`WM_CLASS(STRING)`字段和`desktop`文件配置中的区别，然后修正。这**可能**可以解决图标问题。

#### 问题4：Deepin QQ无法加载头像和图片

这是IPV6的问题，我先提一下IPV6：

> 理想情况下，由IPV4向IPv6过渡的进程不应该被最终的用户所看见，但是IPv4/IPv6混合环境有时会让你碰到各种源于IPv4和IPv6之间不经意间的相互碰撞的问题。举个例子，你会碰到应用程序超时的问题，比如pacman或ssh尝试通过IPv6连接失败、DNS服务器意外清空了IPv6的记录、或者你支持IPv6的设备不兼容你的互联网服务提供商遗留下的IPv4网络，等等。
>
> 当然这不意味着你应该盲目地在你的Linux机器上禁用IPv6。鉴于IPv6许诺的种种好处，作为社会的一份子我们最终还是要充分拥抱它的，但是作为给最终用户进行故障排除过程的一部分，如果IPv6确实是罪魁祸首，那你可以尝试去关闭它。

再提一下我对于QFL的观点：

> 19年10月24日QQ推出了QQ for linux，大部分人以为这是腾讯对Linux的支持，必须指出，这是幻想。推出QFL的原因应该是QQ的图片传输开始使用ipv6传输，原先在Linux上运行的八仙过海QQ版本基本上图片加载都成了问题。
>
> 个人观点：QFL太过敷衍，无良软件注定得不到使用者的认可。

##### 法一：禁用IPV6

禁用IPV6分为三种办法，分述如下：

一是输入下列三个命令将Linux上的ipv6全部禁用即可。

```bash
$ sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
$ sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
$ sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=1
```

> 注：这种方法是永久禁用；禁用后开启很简单，把命令的1改为0即可。

第二种禁用IPV6的办法是：写文件以禁用

```bash
$ sudo sh -c 'echo 1 > /proc/sys/net/ipv6/conf/<interface-name>/disable_ipv6'
```

举个例子，你的Linux通过eth0接口访问网络，那么禁用IPv6代码如下:

```bash
$ sudo sh -c 'echo 1 > /proc/sys/net/ipv6/conf/eth0/disable_ipv6'
```

重新启用eth0接口的IPv6：

```bash
$ sudo sh -c 'echo 0 > /proc/sys/net/ipv6/conf/eth0/disable_ipv6'
```

如果你想要将整个系统所有接口包括回环接口禁用IPv6，使用以下命令：

```bash
$ sudo sh -c 'echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6'
```

注：这种方法不是永久禁用IPv6，你一旦重启系统IPv6还是会被启用。

三是在开机的时候传递一个必要的内核参数：

这种实现思路与开源驱动nouveau在开机的时候自动禁用同理。

> Manjaro Linux和Arch Linux在具有独显却未安装独显驱动的时候，需要在boot的时候按`e`，在第一个`quiet`字符串后面输入一串开机神秘代码：`nouveau.modest=0`；或者将之保存到`grub.cfg`文件中。

输入下面的命令编辑文件：

```bash
$ vim /boot/grub/grub.cfg
```

向文件中添加如下内容： 

```bash
GRUB_CMDLINE_LINUX="xxxxx ipv6.disable=1"
```

上面的"xxxxx"代表任何已有的内核参数，注意是在它后面添加"ipv6.disable=1"。修改完后，使用下面的命令保存对grub的更改(这应该是可选的)。

```bash
$ sudo update-grub #Debian，Ubuntu，Linux Mint，Arch Linux系统使用该命令
$ sudo grub2-mkconfig -o /boot/grub2/grub.cfg #Fedora、CentOS/RHEL系统：
```

现在只要你重启你的Linux系统，IPv6就会完全被禁用。重新开启的方法也很简单，就是从文件中将此参数删去。

##### 法二：http代理

安装privoxy，并查看默认监听端口。

```bash
$ pacman -S privoxy
$ vim /etc/privoxy/config
```

在文件中搜索搜索listen-address，默认为：

```bash
listen-address 127.0.0.1:8118
```

输入下面的命令启动privoxy

```bash
$ systemctl start privoxy
```

然后设置http代理：即在QQ/TIM的登录界面点击右上角的设置，然后选择http代理，输入之前记录下的信息和端口，默认为127.0.0.1和8118。再登录就能看到图片和头像了。

## Netease-Cloud-Music

问题：想听个歌放松一下，打开网易云却不能在搜索框输入中文以搜索歌曲。

查找问题：

第一反应是`DWM(dynamic window manager)`标签的设定，使得我只能在单个程序上使用`fcitx`而不能多个程序均使用`fcitx`，故右击`fcitx`打开配置，选择全局配置，调整在多个窗口之间共享显示从`None`到`All`。

然后我发现在不同标签处打开不同的程序都可以呼出`fcitx`，但是唯独网易云音乐不行。

第二反应是网易云音乐不支持fcitx，百度一下果然有很多人遇到了和我一样的问题。

### 失效的解决办法

**2020年1月以前**可以用如下解决方案：

1. 查看本机是否安装有qcef软件包

    ```bash
    $ pacman -Q qcef
    ```
    
    如果查询发现没有，那就安装一个包。

    ```bash
    $ sudo pacman -S qcef
    ```

2. 编辑网易云音乐的脚本

   ```bash
   $ vim /opt/netease/netease-cloud-music/netease-cloud-music.bash
   ```
   

  变化内容如下：

   ```
   - export LD_LIBRARY_PATH="${HERE}"/libs
   #注释原有的LD_LIBRARY_PATH，以下是修改过的
   + export LD_LIBRARY_PATH=/usr/libs
   ```

**但是现在这个方案已经不起作用了**，原因是qcef软件包已经被Arch社区移出了软件仓库。

### 目前的解决办法

#### 法一，构建，编译，安装网易云音乐的qcef

经过在AUR上查找，两名受信任的开发者用户提供了如下的解决思路，分享如下：

首先感谢这两名开发者：@springzfx和@laomocode。据@springzfx分析，网易云音乐linux版v1.2.1，在arch和manjaro中无法输入中文，是软件自带库qcef所导致的，具体为以下目录和文件：

```
/opt/netease/netease-cloud-music/libs/qcef
/opt/netease/netease-cloud-music/libs/libqcef.so
/opt/netease/netease-cloud-music/libs/libqcef.so.1
/opt/netease/netease-cloud-music/libs/libqcef.so.1.1.4
```

输入如下的命令编辑启动文件。

```bash
$ sudo vim /opt/netease/netease-cloud-music/netease-cloud-music.bash
```

内容变化如下：

```shell
#!/bin/sh
HERE="$(dirname "$(readlink -f "${0}")")"
- export LD_LIBRARY_PATH="${HERE}"/libs
- export QT_PLUGIN_PATH="${HERE}"/plugins 
- export QT_QPA_PLATFORM_PLUGIN_PATH="${HERE}"/plugins/platforms
+ export XDG_CURRENT_DESKTOP=DDE
+ export LD_LIBRARY_PATH=/usr/lib
+ exec "${HERE}"/netease-cloud-music $@
```

然后安装qcef，由于aur已经移除qcef，所以只能自己构建安装包。

这个包能还在github上找到，需要克隆下来自己构建。构建见后面的内容。如果有人上传已经构建好的软件包，则直接安装：

```bash
$ sudo pacman -U qcef-1.1.6-1-x86_64.pkg.tar.xz
```

#### 法二：构建，编译，安装整个软件

操作步骤、输入的命令如下：

```bash
$ yay -Rsn netease-cloud-music
$ git clone https://github.com/springzfx/archlinux
# compile qcef 1.1.6 and build it
$ cd qcef
makepkg -si
# compile netease-cloud-music and build it
$ cd netease-cloud-music
makepkg -si
```

注意：安装运行时的依赖包括gconf、gtk2、libxss、nss、libpulse、qt5-webchannel、qt5-x11extras。你可能会缺少`gconf`这个软件包。

安装编译时的依赖cmake、qt5-tools。你应该不缺少这些打包工具，除非你从未用过yay安装软件。安装`base-devel`软件包组以解决编译打包的问题。

> 还有一位大佬提出的观点是：Linux版网易云由Deepin和网易合作开发，无法输入中文是因为软件使用了deepin魔改过的cogl，安装deepin-cogl就解决了，但是其他使用cogl的软件又会出问题……所以这种安装deepin-cogl的方法仅供参考。

#### 法三，以wine为兼容层安装windows版网易云

虽然网易云音乐已经推出了 linux 版，但是诸如本地歌曲扫描、心动模式等功能有所缺失，并且更新相对较慢，因此这里介绍使用 `wine` 完美运行网易云音乐`windows`版本的方法。

PS：我试着用Deepin-Wine安装和运行网易云音乐，测试发现安装和卸载都可以正常进行，这些过程没什么大问题，但是运行就不行了，所以还是得安装wine版本。

```bash
$ sudo pacman -S wine
```

然后一个非常关键的步骤：你需要将windows系统中的字体拷贝到你的wine容器中，否则启动网易云会提示崩溃。

由于我是实体机双系统，因此直接切换到Windows系统下`C:\Windows\Fonts`，将之复制到Linux系统的家目录中wine目录Windows文件夹下`~/.wine/Windows/Fonts`

> 在Linux下你的Windows磁盘的字体文件应该被挂载为如下的路径：
>
> ```text
> /run/media/\<user name>/C:/Windows/Fonts
> ```

直接下载网易云的客户端(Win可执行文件exe)，然后切换到终端用wine安装该软件：

```bash
$ wine <your package setup>.exe
```

wine提示安装三个软件以提供支持，这是可选的，由于众所周知的原因，安装异常的缓慢。

安装完毕后运行如下的设置：

```bash
$ wine winecfg
```

1. 关闭允许桌面管理器装饰窗口：

   运行 `winecfg` 在 **显示** 选项卡中取消勾选 **允许窗口管理器装饰窗口**以修复网易云音乐最大化后超出屏幕边界的问题

2. 调整屏幕分辨率：

   将屏幕分辨率调整至 105 以上，以修复托盘图标无法点击的问题（在屏幕分辨率大于一定值后即可点击，但不确定具体为多少，可以自行尝试）

3. 修改 windows 版本:

   网易云音乐只能在 Windows XP 容器中运行。

启动网易云时只需要输入:(命令可能在不同机器上不同)

```bash
$ wine ~/.wine/c:/Program\ Files (x86)\\Netease\\Cloudmusic\\cloudmusic.exe
```

