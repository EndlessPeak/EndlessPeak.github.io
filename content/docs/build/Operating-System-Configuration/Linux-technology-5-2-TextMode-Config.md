---
title: Arch Linux 文本环境配置
toc: true
authors:
  - EndlessPeak
date: 2020-02-27 20:00:00
hidden: false
draft: false
weight: 3
---

如果是经常从事文本工作(如软件工作者进行代码编辑、学生进行笔记整理、文字工作者的撰写、校对等工作)的用户建议选用窗口管理器作为日常工作环境。

<!--more-->

独立的窗口管理器可以和KDE、Gnome等桌面环境搭配使用，一来可以起到工作环境转换的适应作用；二来集成化的桌面环境可以应对各种不时之需。所以我将之放在本篇介绍；当然，熟练地使用窗口管理器，原则上可以不借助其他任何桌面环境就能完成所需的各种工作。

## Shell

查看系统当前使用的shell。

```bash
$ echo $SHELL
/bin/bash
```

查看系统是否安装了zsh (有些发行版可能自带zsh，而fish一般不会自带)

```bash
$ cat /etc/shells #列出当前可用的终端
/bin/sh
/bin/bash
/sbin/nologin
/usr/bin/sh
/usr/bin/bash
/usr/sbin/nologin
/bin/tcsh
/bin/csh
/bin/zsh
```

安装功能强大、智能友好的终端命令解析器Fish Shell和Z Shell的具体内容见下。

### Fish Shell

#### 安装Fish Shell

```bash
$ sudo pacman -S fish
$ which fish #查看fish Shell的安装位置
$ chsh -l #列出当前可用的终端(另一种命令方式)
$ chsh -s /usr/bin/fish #为当前用户切换终端
```

#### 安装Oh-my-fish

```bash
$ git clone https://github.com/oh-my-fish/oh-my-fish
$ cd oh-my-fish
$ bin/install --offline
$ fish_config #Colors:Dracula Prompt:Terlar 完成后点选set theme和set prompt
#最后回车得到fish和oh-my-fish
```

#### 配置Oh-my-fish

```bash
$ omf install wttr #安装fish shell下的天气显示插件
$ alias c clear #定义快捷命令
$ funcsave c #记录快捷命令到配置文件
$ alias l "ls -la" 
$ funcsave l
```

**注意！**如果不小心定义了错误的快捷命令，可能会导致严重的后果。最典型的例子就是定义循环的命令，例如输入`alias A B` 和`alias B A`(A和B分别代表一条命令)，然后再输入A或者B，那么计算机可能会输出大量function错误，也可能直接崩溃宕机关闭。

如果已经定义了错误的命令，如`alias fuck ls`,有以下两种修复办法：

1. 在`~/.config/fish/functions`中查找之前定义的别名的文件，本例中文件名为`fuck.fish`，删除之即可。
2. 再定义一次命令，将`fuck`转义回原来的语义。输入`alias fuck fuck`即可。

### Z Shell

#### 安装Z shell

```bash
$ sudo pacman -S zsh
```

#### 安装Oh-my-zsh

```bash
#方法一，通过curl下载安装
$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" 
#方法二，通过wget下载安装
$ sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

由于诸位都懂的原因， 使用`curl`和`wget`从github上下载的安装方式通常可能报错port 443拒绝访问。这个时候就需要使用 ~~工具云托管平台~~ 码云托管平台了。

在码云极速下载这个镜像账号中找到oh-my-zsh的仓库，链接如下：https://gitee.com/mirrors/oh-my-zsh

方法一：更改脚本中的克隆位置，运行脚本：

在tools文件夹中复制install.sh的全部内容到Linux下的任一编辑器。GVIM、NeoVim和Emacs等终端下编辑器需要使用`Ctrl+Shift+C/V`或`"+p`粘贴。其他如Kate，Gedit，VScode等则不用改变键位。

修改该文件的Default settings部分：

```text
- # Default settings
- ZSH=${ZSH:-~/.oh-my-zsh}
- REPO=${REPO:-mirrors/oh-my-zsh}
- REMOTE=${REMOTE:-https://gitee.com/${REPO}.git}
- BRANCH=${BRANCH:-master}
+ # Default settings
+ ZSH=${ZSH:-~/.oh-my-zsh}
+ REPO=${REPO:-mirrors/oh-my-zsh}
+ REMOTE=${REMOTE:-https://gitee.com/${REPO}.git}
+ BRANCH=${BRANCH:-master}
```

然后在终端中运行命令：

```bash
$ cd /path/to/install.sh  #注意先切换到文件存放位置
$ ./install.sh #再运行安装脚本，即可从码云镜像站下载oh-my-zsh的源代码。
```

方法二：先克隆整个项目到~/.config/oh-my-zsh。克隆命令如下：

```
 git clone -c core.eol=lf -c core.autocrlf=false \
	 -c fsck.zeroPaddedFilemode=ignore \
     -c fetch.fsck.zeroPaddedFilemode=ignore \
	 -c receive.fsck.zeroPaddedFilemode=ignore \
	 --depth=1 --branch "master" https://gitee.com/mirrors/oh-my-zsh ~/.oh-my-zsh
```

然后对仓库中的install.sh脚本进行修改：删去main函数中调用setup_ohmyzsh函数的行。

```bash
$ cd /path/to/install.sh  #注意先切换到文件存放位置
$ ./install.sh #再运行安装脚本，即可从码云镜像站下载oh-my-zsh的源代码。
```

#### 配置Oh-my-zsh

##### 修改Oh-my-zsh的主题

```bash
$ vim  ~/.zshrc
ZSH_THEME="robbyrussel"
```

##### 自动提示与命令补全

```bash
$ git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins
```

打开 `~/.zshrc` 文件，找到插件设置命令，修改为

```text
- plugins=(git)
+ plugins=(zsh-autosuggestions git)
```

##### 语法高亮

```bash
$ git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins
```

```text
- plugins=( [plugins...])
+ plugins=( [plugins...] zsh-syntax-highlighting) 
```

如果语法高亮不生效，则考虑zsh-syntax-highlighting放置在插件列表的最后以解决问题。以下是官方文档说明：

> **Why must `zsh-syntax-highlighting.zsh` be sourced at the end of the `.zshrc` file?**
>
> `zsh-syntax-highlighting.zsh` wraps ZLE widgets. It must be sourced after all custom widgets have been created (i.e., after all `zle -N`calls and after running `compinit`). Widgets created later will work, but will not update the syntax highlighting.

##### 使配置生效

```bash
$ source ~/.zshrc
```

## Terminal Applications

关于它们各自的配置以后会提到，这些工具都是完全自定义化的，首先应该参考它们的官方文档。

1. 文件管理器`Ranger`

2. 系统硬件查看器`neofetch`或`screenfetch`

3. 系统资源查看工具`htop`

4. 使用图形渲染的终端模拟器`alacritty`

5. 展示目录下的文件工具`tree`

6. 展示本地或远程的包的结构工具`pactree`

7. 解压缩软件`zip`

8. 将终端输出的内容重定向到剪切板工具`xsel`

9. 终端下的`Todo List`工具`task`

10. 终端命令代理`privoxy`或`proxychains`

11. 来自`Suckless`社区中`X`下的极简终端模拟器st


```bash
$ sudo pacman -S ranger neofetch htop alacritty tree pactree zip task privoxy
$ git clone https://git.suckless.org/st   # 克隆源代码的仓库
$ cd st/
$ sudo make clean install                 # 编译安装
```

## I3 Window Manager

### 安装i3wm：

```bash
$ sudo pacman -S i3 #默认回车即可。由于i3-gaps和i3-wm冲突，因此最后实际安装的是i3-gaps，而这正是我所需要的。
$ sudo pacman -S alacritty
$ sudo pacman -S lxappearance
$ sudo pacman -S feh #安装设置壁纸的软件
lxappearance #打开外观配置
feh --bg-fill /this/path/to/your/picture
```

### 配置i3wm：

输入命令:`xmodmap -pke > ~/.Xmodmap`

> 注：该命令是将键盘布局生成可阅读的文本文件并保存到家目录下。

输入命令:`vim ~/.config/i3/config`，在配置文件中添加下面的内容。

```bash
exec --no-startup-id xrandr -s 1920x1080 #可选项，修改屏幕分辨率
exec xmodmap ~/.Xmodmap #载入当前键盘布局配置文件
bindsym $mod+d exec rofi -show run
bindsym $mod+d exec rofi -show window #该条与上条任选其一
new window 1pixel #窗口仅有1像素单位的边框
gaps inner 15 #窗口边框距离屏幕边缘距离15个单位
```

> 注1：
>
> bindsym表示使用快捷键执行；$mod表示i3下的Super键；
>
> exec表示执行程序；-show run指定为运行程序，-show window指定为显示打开的窗口。故有些情形下两个参数可以混用。
>
> 注2：
>
> 更多其他配置敬请自行探索。我本人的Dotfiles已上传到代码托管平台。

### 安装窗口渲染器

我安装的是自行编译的compton,为顺利安装compton,先安装系统可能缺少的依赖，命令如下：

```bash
$ sudo pacman -S libconfig asciidoc make #安装相关的依赖
```
不过现在已经出现了`picom`，`Xcompmgr`，而`compton`已经不再维护，有需要的完全可以通过官方库安装它们。

```bash
$ git clone https://github.com/tryone144/compton.git
$ cd /path/to/compton #切换到克隆的compton库文件夹中
$ make #可能会有一些警告，忽略
$ make docs #这是可选的，制作帮助文档，使用man compton获取。
$ make clean install #clean是可选参数，可以不加
```

在克隆的`compton`库中有一份配置文件模版，将之拷贝到用户个人的配置文件夹里，并在编译成功之后即可配置该文件：

```bash
$ cp compton.sample.conf ~/.config/compton.conf
$ vim ~/.config/compton.conf
```

### 安装自定义计算机状态栏

我使用的是polybar，如果你喜欢i3status，可以不安装polybar。

```bash
$ sudo pacman -S cmake git python python2 pkg-config wireless_tools 
#安装polybar构建所需的依赖
$ yay -S polybar
```

下面是最重要也是最困难的部分：安装字体。

```bash
$ yay -S tty-unifont siji-git
```

> 此处的困难是对于网络而不是技术层面上来说的，由于软件包取自AUR，速度极慢，极易失败。

新安装的polybar需要拷贝一份配置文件，然后自行修改polybar的配置文件进行配置。

```bash
$ cd ~/.config
$ mkdir polybar
$ cp /usr/share/doc/polybar/config ~/.config/polybar/ #将配置文件拷贝到用户当前目录下
```

默认polybar的名称为example，载入polybar的命令为：

```bash
$ polybar example
```

默认在i3wm中设置自动启动的办法：

```bash
$ exec_always polybar example &
```



