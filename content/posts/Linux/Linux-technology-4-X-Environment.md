---
title: Linux的桌面环境
toc: true
authors:
  - EndlessPeak
tags:
  - Linux
categories: 
  - Linux Basic
date: 2020-01-28 20:15:32
hidden: false
draft: false
---

Linux中”桌面“的概念——由X窗口系统组成的，可以卸载的图形环境——复杂且抽象，好在那些试图解释清楚这件事情的人也有同样的感受。

图形用户界面是可以为Linux工作站提供图形化工作界面的强大工具，但许多新用户会碰到一个令他们十分惊奇的事实： 如此强大的工具只不过是运行在系统上的一个应用程序。它不是Linux内核的一部分，也并非集成在Linux系统中。它需要额外安装，只不过一些发行版将这种安装过程自动化了而已。

UNIX like操作系统需要图形界面(Graphical User Interface)。由于标准的重要性，有人为窗口的绘制和移动、通过鼠标的移动和键盘实现程序和用户间的互动，以及其它重要的方面创建了一种标准，这种标准就叫做**X 窗口系统**，它通常缩写为 X11 或者X。它广泛应用于Unix，Linux，以及其他类Unix操作系统上。

<!--more-->

## X窗口系统概述

X窗口系统，是一种以**位图方式**显示的软件窗口系统。它是Linux图形用户环境的基础。 X窗口系统作为UNIX、类UNIX、OpenVMS等操作系统所一致适用的标准化软件工具包及显示架构的运作协议。 

X窗口系统通过软件工具及架构协议来创建操作系统所用的图形用户界面，而且是利用**网络架构**来进行图形界面的运行与绘制的。此后其逐渐扩展适用到各形各色的其他操作系统上。现在几乎所有的操作系统都能支持与使用X。如今一些知名的桌面环境，例如GNOME和KDE，都是以X窗口系统为基础建构而成的。 

总体来说，X窗口系统由以下若干重要部分组成：

- X Server (X服务器，其中包括重要内容：X session)

- X Client (X客户端程序)

- Window Manager (窗口管理器)

- Display Manager (显示管理器)

- widget library (widget 库)

- Desktop Environment (桌面环境)

### X Server

X Server，译作X服务器，是**X的核心**。**X Server驱动硬件**，提供基本的图形显示能力。X Server用于实际控制输入设备(例如鼠标和键盘)和位图式输出设备(例如显示器)。合理但并不十分科学地，可以把它看作视频卡的驱动程序。只有在运行了X Server的Linux系统上X Client才能利用X Server绘出相应的图像。准确地说，X Server定义了给X客户机使用这些设备的抽象接口。 

> 和大部分人的想法不同，X Server没有定义高级实体的编程接口，这意味着它不能理解“画一个按钮”这样的语句，而必须告诉它：“嗯……画一个方块，这个方块周围要有阴影，当用户按下鼠标左键的时候，这些阴影应该消失……对了，这个方块上还应该写一些字……”
>
> 这种设计的意义在于，X Server能够做到**最大程度上的与平台无关**。用户可以自由选择窗口管理器和widget库来定制自己的桌面，而不需要改变窗口系统的底层配置。

X Server早期使用的是XFree86，自4.4版本后，XFree86改用GPL发布的分支在此开始被称为**Xorg**。

### widget library

widget库又被称为GUI程序使用的库函数，如GTK+和QT。它定义了一套图形用户界面的编程接口。应用程序开发人员通过调用widget库来实现具体的用户界面，如按钮、菜单、滚动条、文本框等。程序员不需要理解X服务器的语言，因为widget库会把“画一个按钮”这句话翻译成X服务器能够理解的表述方式。

### X Client

X Client泛指在X下实际执行的所有应用程序。X Client只负责和X server交互，由X server管理显示界面与在屏幕上绘图，然后将输入设备的行为告知X Client，由X Client依据输入设备的行为开始处理，然后将图示的显示数据回传给X Server，X Server根据X Client传来的绘图子类将它描绘在自己的屏幕上，来得到显示的结果。例如Firefox，gedit，kate等等都属于X Client程序。

### Display Manager

显示管理器(简称DM)是管理X session的程序。DM提供了一个登录界面，其任务就是验证用户的身份，让用户登录到系统。可以说，图形界面的一切（除了它自己）都是由这个显示管理器启动的，包括X服务器。用户也可以选择关闭显示管理器，如果这样做，就必须通过命令行运行startx命令(或者使用.login脚本)来启动X服务器。

> 注：这里所说的“脚本”是指Shell脚本，它是一段能够被Linux理解的程序。

### Window Manager

X Server提供了基本的图形显示能力。然而具体怎么绘制应用程序的界面，却是要由应用程序自己解决的。Window Manager(窗口管理器，简称WM)提供统一的GUI组件(窗口、外框、菜单、按钮等)，负责控制应用程序窗口的各种行为，例如移动、缩放、最大化和最小化窗口，在多个窗口间切换等。**从本质上来说，窗口管理器是一种特殊的X客户端程序**，负责管理其他所有的X Client软件。因为这些功能都是通过向X Server发送指令实现的。Window Maker、FVWM、IceWM、Sawfish等是目前比较常见的窗口管理器。

WM的启动由DM控制，一般在DM的登录窗口可以进行选择。常见的WM有:Metacity(Gnome默认的WM),KWin(KDE默认的WM)等。 

从本质上来说，窗口管理器是一种特殊的X客户端程序，因为这些功能也都是通过向X服务器发送指令实现的。

### Desktop Environment

如前所述，要启动X window system，主机上必须要有 Xorg 的X server核心，才能提供屏幕绘制；为了使用更方便，在上面加装了X Client(它们是窗口应用软件，与X server交互以提供自己的图形界面)；为了让窗口管理更方便，在上面加装了window manager；为了取得X window的控制，使用Display Manager提供图形接口登入。

现在终于到了问题的关键，究竟什么是桌面环境？以KDE和Gnome为代表的Linux桌面环境都是集成的工作环境，是完整X window system的一个组成部分。换句话说，它们是一整套从DM到WM到一揽子X Client的程序集合，是把各种与X有关的东西（除了X服务器）整合在一起的大杂烩，这些程序包括普通的应用软件、窗口管理器、显示管理器和widget库。以GNOME为例：DM是gdm，WM有多种选择，比如可以是metacity，等等；以KDE为例，DM是sddm(KDE4以前是kdm)，WM是KWin，等等。但是，无论桌面环境如何复杂，最后处理图形输出的仍然是X服务器。

不过要注意到，即使没有这些组件，我们像Linux的前辈们一样用startx登录X，用fvwm做窗口管理器，用那些最最原始的应用程序，仍然可以实现一个高效的X工作环境。GNOME/KDE的出现只是让这一切整合地更好而已。 

## X窗口系统的启动流程

基本上目前都是使用Window Manager来管理窗口界面风格的。取得X窗口系统的方法有两种，一种是通过登录到文本模式界面(terminal)，输入startx来启动X窗口；或者通过登录管理器(Display Manager)提供的登录界面来登录取得X窗口。

### 控制台终端

Linux系统中计算机显示器通常被成为控制台终端(console)，有一些设备特殊文件与之相关联，它们被称为tty0、tty1等等。当在控制台上登录时，一般使用的是tty1(如果Linux已安装有X窗口系统则tty1转为X窗口系统)。使用Ctrl+Alt+[F1—F6]组合键时，可以切换到tty2、tty3等上面去。tty2–tty6等称为文本模式下的虚拟终端，tty1称为图形虚拟终端；tty0则是当前所使用虚拟终端的一个别名(它也叫控制台终端)，不管当前正在使用哪个虚拟终端，系统信息都会发送到控制台终端。

**归纳**：tty2-6是文本型控制台,tty1是x-window(图形)控制台，不论使用何种控制台，当前所使用的控制台可以用它的tty序号表示，也可以用tty0表示。

### 通过文本模式启动(选阅)

#### startx

在文本模式，且首次登录X窗口时，可通过输入startx命令在文本模式启动X窗口系统。

本质上startx是一个shell script，它是一个“用户友好”的脚本，会主动建立X所需要引用的设置文件。startx最重要的作用是找出用户或者系统默认的 X server 与 X Client 的设置文件，当然用户也能够使用startx外接参数来取代设置文件的内容。即startx可以直接启动，也能够外接参数。

startx的语法和使用例如下：

```bash
$ startx [x client parameter] -- [x server parameter]
# For example
$ startx -- -depth 16
```

> 注：startx 后面接的参数以两个减号"--"隔开，前面是X client的设置，后面是X server的设置。上面的范例是让X server以色彩深度16 bit色(即每一像素占用16bit，共65536色)显示，因为色彩深度与X server有关，故参数写在--后面。

事实上，启动 X 的是xinit这个程序，startx只是在找出X Server/X Client的设置值。

※ startx 寻找设置值的可用顺序：

- X Server parameter
  1. 使用startx后接参数
  2. 若无参数，则查找用户根目录的文件，即~/.xserverrc
  3. 若无上述两者，则以/etc/X11/xinit/xserverrc
  4. 若无上述三者，则仅执行/usr/bin/X (此即X server可执行文件)

- X Client parameter
  1. 使用startx后接参数
  2. 若无参数，则查找用户根目录的文件，即~/.xinitrc
  3. 若无上述两者，则以/etc/X11/xinit/xinitrc
  4. 若无上述三者，则仅执行xterm (此为X下面的终端软件)

#### xinit

当 startx 找到需要的设定值后，就将获取的参数传递给xinit，并呼叫 xinit 实际启动X。xinit 主要的工作是启动 X server 与 X client，其语法如下： 

```bash
$ xinit [client options] -- [server or display options]
```

注1：上面[client]和[server]代表的是程序的具体路径，其必须以/或者./开头。 

注2：client option 与 server option 两个参数由 startx 获取。 通过 startx 找到适当的 xinitrc 与 xserverrc 后，启动 X 交给 xinit 来执行。 在预设的情况下 (使用者初次登录，尚未有 ~/.xinitrc 等档案时)，输入 startx ， 就等于执行：

```bash
$ xinit /etc/X11/xinit/xinitrc -- /etc/X11/xinit/xserverrc 
```

初次登录的时候， 由于`xserverrc` 也不存在，参考之前的参数搜寻顺序，实际上的指令是：

```bash
$ xinit /etc/X11/xinit/xinitrc -- /usr/bin/X
```

注：不直接执行 xinit 而是使用 startx 来呼叫 xinit 就是因为 xinit 需要取得参数，而 startx 这个脚本可以快速地找到这些参数而不必手动输入。如果只是单纯执行 xinit ，系统的默认 X Client 与 X Server 的内容如下：

```bash
xinit xterm -geometry +1+1 -n login -display :0 -- X :0
```

分析：

1. 在 X client 方面： xterm 是 X Window底下的虚拟终端机，后面接的参数是这个终端机的位置与是否登入， 最后面会接一个 `-display :0` 表示这个虚拟终端机是启动在**第 :0 号的 X 显示接口**的意思，且 xterm 在加载时，必须要使用 `-display` 参数来说明。
2. 在 X Server 方面， 启动的 X server 程序是 X 。 X 在此即是 X Server 的主程序， 所以启动 X 挺简单，直接执行 X 即可，同时还指定 X 启动在**第 :0 个 X 显示接口**。 如果单纯以上面的内容来启动你的 X 系统时，你就会发现tty1有画面了，但是很丑，因为还没有启动 window manager。

前面提到，启动 X Server 需要由 startx 获取 xserverrc ;启动 X Client 需要由 startx 获取 xinitrc ，故下面展开叙述 xserverrc 和 xinitrc 。

#### xserverrc

X 窗口最先需要启动的就是 X server ，而 X server 启动的脚本与参数是通过 /etc/X11/xinit/ 里面的 xserverrc 得到的 。如果Linux中没有 xserverrc 这个档案， 用户家目录也没有 ~/.xserverrc ，则系统会直接执行 /usr/bin/X 这个指令。 这个指令也是系统最原始的 X server 执行命令。

以Deepin OS 15.11 desktop为例，/etc/X11/xinit/xserverrc文件内容如下：

```bash
exec /usr/bin/X -nolisten tcp "$@"
```

启动 X Server 时，Xorg 会去读取 /etc/X11/xorg.conf 这个配置文件。该配置文件的内容，在后面会提到。如果一切顺利，X 会顺利的在 tty1 的环境中启动。  

> 注：单纯的 X 启动时，画面为一片漆黑，中心有鼠标的光标(也可能没有)。

由前面的说明中，可以发现， X 启动的时候可以指定启动的接口，即 `:0` 这个参数。事实上，Linux 可以**同时启动多个 X**！第一个 X 的画面会在 `:0` 是 tty1 ，第二个 X 则是 `:1` 即 tty2 。 后续还可以有其他的 X 存在。注意： X server 未注明加载的接口时，默认是使用 `:0` 。但是 X client 未注明加载的接口时，就无法执行。 

#### xinitrc

启动了 X server 后，接下来的工作就是加载 X client 到 X server 上面。

假设你的家目录并没有 ~/.xinitrc ，则此时 X Client 会以 /etc/X11/xinit/xinitrc 来作为启动 X Client 的预设脚本。 

仍以Deepin OS 15.11 desktop为例，/etc/X11/xinit/xinitrc文件内容实质如下：

```bash
. /etc/X11/Xsession #执行Xsession脚本
```

> 注：如果需要执行多个 X client，需将除最后一个以外的其他项目都添加 & 以在后台执行。

#### summary

**归纳1**:  Linux启动X的过程/startx脚本工作流程/X window的启动流程(X Client用具体的程序代替)：

![](https://s2.ax1x.com/2020/02/01/1JPhSP.png)

**归纳2**:  Linux启动X的过程实际相当于执行下面的命令:

```bash
xinit /etc/X11/Xsession -- /usr/bin/X11/X -nolisten tcp "$@"
```

**归纳3**: Desktop Environment(桌面环境)启动流程(Gnome或KDE等的启动流程)

![](https://s2.ax1x.com/2020/02/01/1JPHoj.png)

#### X 启动流程测试

到现在为止，关于X window的两个最关键的组件 X Server 和 X Client 及其所做的工作已经阐述的比较明白了(这些知识可能对现在的大多数Linux桌面发行版毫无用武之地，但对Arch Linux或者是安装在服务器而不是个人计算机上的Linux却相当有用)。

##### 例1

由于目前Linux桌面发行版的图形界面(X window)被看做第一个X( :0)，故下面的练习指定到第二个X( :1)。

笔者自己的测试在 Deepin OS Desktop 15.11 上进行，由于Deepin采用DDE桌面环境，自身的窗口管理器Kwin (dde-Kwin)运行在第一个X中，如果在第二个X中调用会报错:`FATAL ERROR while trying to open display`；同时深度终端 Deepin-terminal 在创建的第二个 X 上运行会报错 `Unable to init server: Could not connect: Connection refused; Gtk-WARNING: cannot open display`，故需要安装两个能够在X上“单独”运行轻量软件 (一个窗口管理器，一个终端) 来完成本次小测试。

1. 打开Deepin，进入Deepin Desktop，按`Ctrl+Alt+F2`切换到`tty2`，以root登录，输入命令：

> 注：Deepin默认未设置root，如果没有设置root，请先设置root账户和密码。

```
# apt install xterm twm #xterm是轻量级X终端，twm是轻量级X窗口管理器
```

2. 输入以下命令启动第二个X在`:1`中

```
# X :1 & #注意加上&以在后台执行，防止执行过程中出现问题而无法结束进程
```

3. Linux会在`tty3`处生成第二个X并自动切换到`tty3`，仔细观察屏幕内容(正常情况下是一片漆黑，或者屏幕中心会有一个鼠标的独特标记)，按`Ctrl+Alt+F2`切换到`tty2`，输入命令：

```
#每执行一次指令就应当切到tty3观察，注意执行前后的区别，而后再切回tty2
# xterm -display :1 & #可以执行这条指令两次
# xclock -display :1 &
# xeyes -display :1 &
```

4. 正常情况下会出现一个终端，一个时钟和一双大眼睛。可惜你并不能移动它们，也不能在该终端中输入命令，输入下面的命令加载窗口管理器：

```
# twm -display :1 &
```

5. 现在你就可以随意地移动和放大缩小窗口了，而且每个部分都有标题提示。在黑屏幕处按下鼠标按键(不同Linux有区别，可能是左键也可能是右键)，会出现菜单，你也许可以进行额外的管理。

> 注：你完全可以尝试一下还有哪些程序能在这个“简陋”的X上运行。

6. 解除刚才的所有工作，输入命令：

```
# kill %6
# kill %5
# ……
# kill %1
```

### 通过显示管理器启动

X Window 的启动过程可以基本上由显示管理器（Display Manager）完成。在计算机进入Linux后，会先启动显示管理器，在显示管理器启动后会依次完成下面这些工作。

- 启动X Server。
- 提供一个界面友好的屏幕，等待验证用户的身份。
- 执行用户的引导脚本，这个脚本用于建立用户的桌面环境。

简单提一下“引导脚本”：桌面环境的引导脚本是一段用Linux命令组成的脚本程序，叫做X session。X session通过启动窗口管理器、任务栏，设定应用的默认值、安装标准键绑定等来启动整个桌面环境。例如非常有名的桌面环境KDE和Gnome，它们都有自己的启动脚本，这些通常不需要用户操心。

#### X session

X session(X 会话)是指X server启动后直到X server关闭之间的这段时间。这期间一切跟X相关的动作都属于X session的内容。管理X session的程序称为Display Manager，常听说的gdm或sddm就是gnome/kde所分别对应的Display Manager。

开启一个X session，也就开始了图形界面的使用。在开启的过程中，Display Manager会对用户进行认证(也就是用户名密码的输入)，并运行事先设置好的程序(比如fcitx输入法，比如Deepin的开机音乐就是在这个时候启动的)等等。

X session会一直运行，直到用户退出，或者说，当X session运行结束后，用户就退出了。Window Manager是X session启动的唯一前台程序(其他程序都在后台执行)，**如果没有这个前台程序，那么用户会在登录后又立即退出登录。**

在开启过程中，用户计划执行的一系列操作都可以在/etc/X11/Xseesion或/etc/X11/Xsession.d/目录下看到，其他还有一些配置文件如Xsession.options, Xresources等，都是执行的X session的初始化过程。仔细阅读这些脚本或配置文件，可以帮助更好地理解X。 

Xsession是一个重要的文件，不管是通过Display Manager登录X，还是通过xinit(startx)登录X，它都会被执行。Xsession是一个全局文件。 

#### Xorg.conf

xorg.conf是X Server的主要配置文件，它包含一个当前系统的硬件资源列表。X Server就是根据这些硬件资源“组织”出基本的图形能力。

要获取X Server的版本信息，输入以下命令：

```
$ X -version
```

xorg.conf文件在/etc/X11/xorg.conf，主要包含下面的字段。

- Module: 被加载到X Server中的模块(某些功能的驱动程序)
- InputDevice: 输入设备，如键盘鼠标的信息
- Files: X系统使用的字体存放目录(字体的具体使用由FontConfig工具配置)
- Monitor: 显示器的设置，如分辨率，水平/垂直刷新率等，与硬件有关
- Device: 显示适配器芯片组的相关设定
- Screen:由Monitor和Device组装成一个Screen，表示由它们向这个Screen提供输出能力
- ServerLayout:将一个Screen和InputDevice组装成一个ServerLayout

在具有多个显示设备的系统中，可能有多个Screen和多个ServerLayout，用以实现不同的硬件搭配。在最近的xorg版本中，X Server已经开始自动侦测硬件，现在的xorg.conf已经都成了默认名称。具体细节还待查，但基本原理不变。

在修改该文件之前，注意要将该文件备份，以免修改出错导致X Server无法启动。通用的备份方法是在源文件文件名后添加“.bak”。Xorg.conf 文件的内容分成数个段落，每个段落以`Section`开始，以`EndSection`结束，里面含有该`Section`的相关设定值。

(未完待续)