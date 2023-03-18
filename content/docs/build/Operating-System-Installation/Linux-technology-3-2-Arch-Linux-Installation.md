---
title: Arch Linux 物理机的安装与引导
toc: true
date: 2020-01-16 22:00:00
featuredImage: https://s1.ax1x.com/2020/04/04/GdMk1x.md.png
authors:
  - EndlessPeak
categories: 
  - Linux Basic
tags:
  - Linux
draft: false
weight: 2
---

Arch Linux 是通用 x86-64 GNU/Linux 发行版，初始安装仅提供命令行环境：用户不需要删除大量不需要的软件包，而是可以从**官方软件仓库**成千上万的高质量软件包中进行选择，搭建自己的系统。支持x86-64架构。Arch采用滚动升级模式，尽全力提供最新的稳定版软件。

本文拟以[Arch Wiki](https://wiki.archlinux.org/)与[Installation guide](https://wiki.archlinux.org/index.php/installation_guide)为原本，附带一些自己的理解，尝试说明在物理机上安装Arch Linux。

<!--more-->

Arch 之道，或者叫Arch哲学，一言以蔽之，Keep It Simple, Stupid.(保持简单，一目了然)

**简洁**：Arch Linux 将简洁定义为：**避免任何不必要的添加、修改和复杂增加**。它提供的软件都来自原始开发者(上游)，仅进行和发行版(下游)相关的最小修改。

**现代**：Arch尽全力保持软件处于最新的稳定版本，只要不出现系统软件包破损，都尽量用最新版本。

**实用**：Arch 注重实用性，避免意识形态之争。

**以用户为中心**：许多 Linux 发行版都试图变得更“用户友好”，Arch Linux 则一直是，且永远会是“以用户为中心”。Arch是为了满足贡献者的需求，而不是为了吸引尽可能多的用户。

一般来说，安装Arch最好的也是最完备的教程就是官方的[Installation guide](https://wiki.archlinux.org/index.php/installation_guide)与[Arch Wiki](https://wiki.archlinux.org/)，虽然部分内容有中文版，但是中文的翻译有些时候会落后于英文版，所以不推荐完全依赖于中文Wiki。另外， 官方Wiki的写作方式更偏向于文档，没有我们所习惯的按步骤编排的安装过程，给不熟悉这种写作方式的人们造成了阅读与使用上的困难。

![](https://s2.ax1x.com/2020/02/02/1YadTU.jpg) 

## 安装前准备

*命令约定：无`$`标识符的命令代表以`root`身份执行；通常它们在终端中以`#`开头。*

### 准备硬盘空间

检查硬盘，需要有一块空闲的磁盘空间来进行安装，大小在30GiB以上。

### 准备安装介质

安装之前需要准备安装介质，这里推荐U盘作为安装介质。对于Arch Linux来说，不能使用UltraISO (软碟通)制作U盘启动盘。因为软碟通制作启动盘使用的是ISO镜像，而Arch Linux制作启动盘需要**DD镜像**。

1. 安装镜像的官方下载地址可参阅[下载页](https://www.archlinux.org/download/)

2. Windows系统下制作安装介质，推荐使用`usbwrite`，参阅[下载页](https://sourceforge.net/projects/usbwriter/)。
3. Linux系统下制作安装介质，要使用`dd`命令制作，可参阅[教程](http://www.runoob.com/linux/linux-comm-dd.html) 

### 启动Live环境

选择U盘启动的顺序(参阅上一篇博客)，在出现Arch Linux启动界面后选择Boot Arch Linux。

然后将会以 root 身份登录进入虚拟控制台，默认的shell是zsh。

### 检查引导方式

目前的引导方式主要分为EFI引导+GPT分区表与BIOS(LEGACY)引导+MBR分区表两种。具体可参见上一篇博客中关于引导的内容。

在终端中输入(注：命令前的**`#`**表示目前是root用户身份，命令后的**`#`**表示命令注释)：

```bash
ls /sys/firmware/efi/efivars
```

> 注：Arch Linux Live环境默认集成了类似bash- completion的软件包，在输入命令的时候**Tab键**可以对命令进行自动补全。
>
> 方法：键入命令或文件名的前几个字符，然后按**Tab键**，它会自动补全命令或显示匹配你键入字符的所有命令，此时为终端提供你所需命令的更多信息并按Tab键可使得终端识别你所需要的命令。
>
> 其他提示：
>
> 1. 方向键↑(或Ctrl+p) 显示上一条命令
>
> 2. 方向键↓(或Ctrl+n) 显示下一条命令
>
> 3. Ctrl+C: 终止当前正在执行的命令

输入命令并回车执行后，如果提示：

```bash
ls: cannot access '/sys/firmware/efi/efivars': No such file or directory
```

表明你是以`BIOS`方式引导，否则为以`EFI`方式引导。 

当然，这种方法不能100%确认是`BIOS`还是`EFI`方式引导的，更加保险的方法是执行`fdisk -l`查看分区表，如果**你的硬盘**(将以 `rom`，`loop` 或者 `airoot` 结束的结果忽略掉)的`Disklabel type`属性为`gpt`并且有一个`Type`为`EFI System`的分区（一般为256M左右），那么你应该是`EFI`引导的。 

### 改变显示字体

所有的字体都安装在/usr/share/kbd/consolefonts/下，在输入到此处时按Tab查看所有可选字体，然后选择你喜欢的字体。此处选择的是**LatGrkCyr-12x22.psfu.gz**。

```bash
setfont /usr/share/kbd/consolefonts/LatGrkCyr-12x22.psfu.gz
```

### 改变键盘布局

如果键盘布局不是普通的布局，例如是colemak布局等，输入以下命令：

```bash
loadkeys colemak
```

当然，一般使用的键盘都是通用105键(国际)，不必更改。

### 连接网络环境

Arch Linux并不能离线安装，它需要联网来下载需要的组件，所以此时需要连接网络。 

```shell
ip link #查看网络设备
```
对笔记本电脑来说网络设备一般有三种，名称分别应该类似于lo,wlan0,eth0。查看网络连接可以参阅[Network configuration (简体中文)](https://wiki.archlinux.org/index.php/Network_configuration_(简体中文))

1. lo是本地环回；
2. wlan0是无线网络，参阅[Wireless network configuration(简体中文)](https://wiki.archlinux.org/index.php/Wireless_network_configuration_(简体中文)) 
3. eth0是有线网络，参阅[Ethernet](https://wiki.archlinux.org/index.php/Network_configuration/Ethernet) 

Arch Linux在网络工具上已经弃用了**net-tools**转而使用**iproute2**。其详细命令变化如下：

<table border="1">
	<tr>
		<td><B>已弃用命令</B></td>
		<td><B>替换命令</B></td>
	</tr>
	<tr>
        <td>arp</td>
		<td>ip neighbor</td>
    </tr>
    <tr>
        <td>ifconfig</td>
		<td>ip address,ip link</td>
    </tr>
    <tr>
        <td>netstat</td>
		<td>ss</td>
    </tr>
    <tr>
        <td>route</td>
		<td>ip route</td>
    </tr>
</table>

更多更完整的总结，请参阅[这篇文章](https://dougvitale.wordpress.com/2011/12/21/deprecated-linux-networking-commands-and-their-replacements/)。 

使用下面的命令连接有线网络并测试：

```bash
ip link
dhcpcd #动态分配IP地址
ping www.baidu.com
```

> 注：Arch Linux在启动后，守护进程dhcpcd已被默认启用以探测有线设备，会自动连接有线网络，一般不需要配置。同时，由于Arch在硬件集成上对有线网卡的适配性更好，因此，如果是在物理机上安装的话，更推荐使用有线网络。 

依次使用下列命令连接无线网络并测试：

```bash
ip link
ip link wlan0 up
iwlist wlan0 scan | grep ESSID
```


> 注：连接wifi可以用WiFimenu，但是WiFimenu一般不支持企业网络和校园网络协议。
>

```bash
wpa_passphrase 网络 密码 > 文件名(如internet.conf)
wpa_supplicant -c internet.conf -i wlan0 & #注："&"表示后台运行
dhcpcd #动态分配IP地址
ping www.baidu.com 
```

出现类似`64 bytes from...`的内容说明成功连接网络，此时使用使用ctrl+c结束Ping命令。

### 更新系统时间

使用下面的命令查看系统时间是否正常。

```bash
timedatectl status
```

使用 timedatectl命令更新系统时间以确保系统时间是准确的：

```bash
timedatectl set-ntp true
```

正常情况下这样的命令并没有输出，所谓没有消息就是最好的消息。

### 建立硬盘分区

系统识别磁盘后会将其分配为一个块设备，为固态硬盘分配的ID类似于`/dev/nvme0n1`,为机械硬盘分配的ID类似于`/dev/sda`。输入：

```bash
fdisk -l
```

需要忽略的内容：形如以 `rom`，`loop` 或者 `airoot` 结束的内容。

需要记录的内容：形如/dev/sda，/dev/nvme0n1等等之类的分区内容，最好拍照一张留以备用。

---

- 如果你是BIOS/MBR方式引导，**跳过创建引导分区**的步骤。
- 如果你是EFI/GPT方式引导，并且同时安装了其他系统，那么你应该可以在分区列表中发现一个较小的并且类型为EFI的分区，这是你的引导分区，请记下它的路径（/dev/sdxY)备用，**跳过创建引导分区**的步骤。
- 如果你是EFI/GPT方式引导，但是没有这个较小的并且类型为EFI的引导分区（这种情况一般只会出现在新电脑+新硬盘时），那么需要**先创建一个引导分区**。

分区示例：

<table border="1" >
	<tr>
		<td colspan="4"><B>BIOS</B> with <B>MBR</B></td>
	</tr>
	<tr>
		<td><B>挂载点</B></td>
		<td><B>分区</td>
		<td><B>分区类型</B></td>
		<td><B>建议大小</B></td>
	</tr>
	<tr>
		<td>/mnt</td>
		<td>/dev/sdX1</td>
		<td>Linux filesystem</td>
		<td>30GiB以上</td>
	</tr>
	<tr>
		<td>[SWAP]</td>
		<td>/dev/sdX2</td>
		<td>Linux swap</td>
		<td>大于512MiB，建议4GiB</td>
	</tr>
	<tr>
		<td colspan="4"><B>UEFI</B> with <B>GPT</B></td>
	</tr>
	<tr>
		<td><B>挂载点</B></td>
		<td><B>分区</td>
		<td><B>分区类型</B></td>
		<td><B>建议大小</B></td>
	</tr>
	<tr>
		<td>/mnt/boot OR /mnt/efi</td>
		<td>/dev/sdX1</td>
		<td><B>EFI system partition</B></td>
		<td>260MiB-512MiB</td>
	</tr>
	<tr>
		<td>/mnt</td>
		<td>/dev/sdX2</td>
		<td>Linux x86-64 根目录 (/)</td>
		<td>30GiB以上</td>
	</tr>
	<tr>
		<td>[SWAP]</td>
		<td>/dev/sdX3</td>
		<td>Linux swap</td>
		<td>大于512MiB，建议4GiB</td>
	</tr>
</table>

如果文件系统支持，此处也可以不设交换空间，而是用交换文件代替。

能够创建分区的命令很多，如fdisk，parted，cfdisk，此处展开讲fdisk命令和带GUI的cfdisk命令。

> 注：在物理机上分区时，要认真检查硬盘是否选择正确，如果有多个硬盘，可能用来安装Linux的硬盘并不是如下所写的/dev/sda，而是/dev/sdb，因此必须反复核对需要操作的硬盘的ID号。

---

#### 创建引导分区

执行命令：

```bash
fdisk /dev/sda #如果是机械硬盘，将sda替换成之前输出的磁盘ID如sda,sdb,sdc等
```

```bash
fdisk /dev/nvme0n1 #如果有固态硬盘且引导在固态上，将nvme0n1替换成之前输出的固态硬盘ID
```

下面进入了`fdisk`的操作环境， 输入`m`并回车可以查看各命令的作用。

1. **如果你是一块全新的硬盘**：输入`g`来创建一个全新的gpt分区表，**否则直接进行第2步**。
2. 输入`n`创建一个新的分区，首先会让你选择起始扇区，一般直接回车使用默认数值即可，然后可以输入结束扇区或是分区大小，这里我们输入`+512M`来创建一个512M的引导分区。
3. 这时我们可以输入`p`来查看新创建的分区。
4. 输入`t`并选择新创建的分区序号来更改分区的类型，输入`L`可以查看所有支持的类型，输入`1`更改分区的类型为`EFI`。
5. 输入`w`来将之前所有的操作写入磁盘生效，在这之前可以输入`p`来确认自己的分区表没有错误。
6. 输入以下命令来格式化刚刚创建的引导分区：

```bash
mkfs.fat -F32 /dev/sda1 #机械硬盘执行该命令并将sda替换为输出的磁盘ID如sda1等对应的分区
```

```bash
mkfs.fat -F32 /dev/nvme0n1p1 #固态硬盘执行该命令并将nvme0n1p1替换为刚创建的分区
```

格式化完成，引导分区就创建好了。

#### 创建根分区及交换分区

输入下面的命令：

```bash
fdisk /dev/sdx #如果要将Linux安装在机械硬盘中则将sdx替换成你要操作的磁盘如sdb sdc等
```

```bash
fdisk /dev/nvme0n1 #如果要将Linux安装在固态硬盘中则将其替换为之前输出的固态硬盘ID
```

1. **如果是一块全新的硬盘，则依次考虑下面的步骤**（否则直接进行第2步）：
   1. **如果在之前新建了分区表并创建了引导分区**：直接进行第2步。
   2. **如果是`BIOS/MBR`引导方式**：输入`o`来创建一个全新的`MBR`分区表。
   3. **如果在另一块硬盘中已经有引导分区**(譬如在机械硬盘中安装`Arch Linux`，而引导分区在固态硬盘中)： 输入`g`来创建一个全新的`gpt`分区表。
2. 输入`n`创建一个新的分区作为交换分区。

   1. 要求输入分区编号，一般按默认(直接回车)，也可以指定。
   2. 要求选择起始扇区，按之前记录的磁盘数据选择计划的磁盘块起始扇区，也可以直接回车使用默认数值；
   3. 要求输入结束扇区或是分区大小，按之前记录的磁盘数据选择所计划的磁盘块大小或结束扇区；交换分区设512MiB-4GiB均可(输入格式写`+4G`即可)。
3. 循上面的过程创建一个新分区作为根分区，如果我们想要使创建的分区完全占满空闲的空间，可以在要求输入结束扇区或分区大小时直接回车使用默认结束扇区。
4. (可选)循上面的过程再创建Home分区及其他分区，用来挂载/home和其他挂载点。
5. 输入`p`来查看新创建的分区，如果不正确则输入`d`将之前的分区删除并重新操作。
6. 输入`t`分别更改交换分区和根分区的类型为Linux swap和Linux filesystem，它们对应的编号分别是19和20，依次更改它们的类型。
7. 检查完成后，通过输入`w`来将之前所有的操作写入磁盘生效。
8. 在终端输入以下命令来格式化并开启刚刚创建的**交换分区**：

```bash
mkswap /dev/sdxY #将sdxY替换为刚创建的分区
swapon /dev/sdxY  #开启交换空间
```

9. 在终端输入以下命令来格式化刚刚创建的**根分区**：

```bash
mkfs.ext4 /dev/sdxZ #将sdxZ替换为刚创建的分区
```

10. 如果刚才有创建Home等分区，则还需要输入类似于格式化根分区的命令来格式化这些分区。

如果无法根据上面的步骤完成分区，也可以使用GUI界面的cfdisk命令。

1. 使用cfdisk后选择分区表类型，选择对应自己电脑磁盘的类型(EFI引导选GPT选项，MBR引导选DOS选项)
2. 分区内容大体如上所述，分区大小可以用界面底端的Resize命令，分区类型用界面底端的Type命令。
3. 分区设置完毕后，用底端的Write命令写入磁盘，然后退出cfdisk，最后使用上面提到的mkfs命令格式化分区。

### 选择镜像服务

该步需要进行编辑配置文件的操作，所以需要掌握命令行下非常著名的数款编辑器的基本操作。此处以`Vim`为例，当然也可以用`nano`等其他编辑器。具体学习过程参阅[VIM教程](https://coolshell.cn/articles/5426.html)，此处尽可能详细地论述整个操作过程：

1. 执行以下命令，用`Vim`编辑`/etc/pacman.conf`，该文件记录了`Arch Linux`的软件包`pacman`的所有配置，包括记录所有镜像源的配置文件的存储地址。

```bash
vim /etc/pacman.conf
```

输入`/Color`并回车以找到写有`color`的那一行，光标选中它前面的`#`并按Del键删除以使其从注释变为可用，而后输入`:wq`回车保存并退出。

2. 执行以下命令，用`Vim`编辑`/etc/pacman.d/mirrorlist`，该文件记录了`Arch Linux`在全球范围内部署的所有服务器。 

```bash
vim /etc/pacman.d/mirrorlist
```

按照下面的操作配置以使中国镜像源服务器地址在更新中优先使用。

初始时保持光标在页面最顶层，是普通模式；

输入`qa`回车以开启一个寄存器a，它表示你之后的操作都会记录到录制的宏中；

输入`/^\n`回车以寻找文件的第一个空行，光标从这里开始；

输入`/China`回车以从光标起始点往下寻找中国镜像源，按`V`进入(行)可视模式，再按`↓`键选中这两行，按`d`键剪切选中的内容，输入`:1`回车使光标返回到最顶端，；

输入`/^\n`回车以寻找文件的第一个空行，按`P`将剪切的内容以向前插入的方式粘贴到此。

输入`q`停止录制，现在你手动制作了一个自动寻找中国镜像源地址的宏，它存在vim的寄存器a中。

输入`7@a` 即可将刚才录制的这个宏循环执行7次，将7个中国镜像源服务器地址转移到文件首。

输入`:wq`保存退出该文件。

### 挂载磁盘分区

执行下面的命令，将根分区挂载到/mnt下：

```bash
mount /dev/sdxY /mnt #将sdxY替换为之前创建的根分区
```

**如果是EFI/GPT引导方式**，还需执行以下命令创建/boot文件夹并将引导分区挂载到/mnt/boot下。**BIOS/MBR引导方式则无需进行这步。**如果对家目录进行了分区，还需要挂载家目录。

```bash
mkdir /mnt/boot
mount /dev/sdxY /mnt/boot #将sdxY替换为之前创建或是已经存在的引导分区

mkdir /mnt/home
mount /dev/sdxZ /mnt/home
```

## 安装中的操作

### 安装基本包组

下面的命令将安装基本的Arch Linux包组到磁盘上。这是一个联网下载并安装的过程。

通过pacstrap这个脚本来安装基本包组，执行以下命令：

```bash
pacstrap /mnt base linux linux-firmware #见下面的注释
```

> 注：19年10月底Arch Linux替换了base包组，如果说原来的base包组是完善的建筑，那么现在的base包只能算是一个脚手架，所以官方文档上只安装base软件包，linux内核与linux-frmware常规硬件的固件就显得有些太过简略了一些，下面的包组请考虑按需追加：
>
> 1. **base-devel**(包含源码安装的支持软件)对大多数人来说都是需要追加安装的，除非明确地知道自己的需求；
> 2. visudo，调整sudo权限依赖于**vi**或**vim**，所以你需要加入这两个软件包之一；
> 3. **nano**默认也不再提供了，所以需要的话请追加这个包；
> 4. 动态分配IP的**dhcpcd**同样需要追加。

### 配置挂载文件

安装完成后，需要生成自动挂载分区的`fstab`文件，执行以下命令：

```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

注：-U表示通过UUID记录，不加参数会通过label记录

由于这步比较**重要**，所以需要输出生成的文件来检查是否正确，执行以下命令：

```bash
cat /mnt/etc/fstab
```

从输出结果中应该可以看到之前格式化的磁盘分区被挂载到了根分区/下；**如果是`EFI/GPT`引导的还应该有引导分区被挂载到`/boot`目录**。

如果输出的结果不正确，说明前面的操作出现了致命错误，很可能是分区错误或是挂载错误。应当立即解除挂载，然后返回前面分区步骤重新分区格式化。 解除挂载需要执行下面的命令：

```bash
#注：仅在配置挂载文件出错时执行下面的命令并返回前面的步骤重新格式化！
umount /mnt/boot #如果是EFI/GPT引导先执行本命令
umount /mnt 
```

### 更改操作位置

`Chroot`意为`Change root`，相当于把操纵权交给新安装（或已经存在）的`Linux`系统，**执行了这步以后的操作都相当于在磁盘上新装的系统中进行**。

执行如下命令：

```bash
arch-chroot /mnt
```

> 注：如果以后系统出现了问题，只要插入U盘启动盘并启动， 将系统根分区挂载到了`/mnt`下（如果有`efi`分区则`efi`要挂载到`/mnt/boot`下），再通过这条命令就可以进入系统进行修复操作。 
>

### 设置系统时区

依次执行如下命令设置时区为亚洲上海并生成相关配置文件：

```bash
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc 
```

### 作本地化修改

执行下面的命令以安装一些必须的软件包。`Arch Linux`拥有非常强大的包管理工具`pacman`，大部分情况下，一行命令就可以搞定包与依赖的问题。  安装包的命令格式为`pacman -S 包名`，`pacman`会自动检查这个包所需要的其他包（即为依赖）并一起安装。

```bash
pacman -S vim dialog wpa_supplicant ntfs-3g networkmanager
```

执行下面的命令以编辑语言配置文件：

```bash
vim /etc/locale.gen
```

在文件中通过输入**/+查找关键字+回车**找到`zh_CN.UTF-8 UTF-8` `zh_HK.UTF-8 UTF-8` `zh_TW.UTF-8 UTF-8` `en_US.UTF-8 UTF-8`这四行，光标选中后按`Del`键去掉行首的#号，输入`:wq`保存并退出。 

然后执行：

```bash
locale-gen
vim /etc/locale.conf
```

按`i`键进入插入模式，输入 `LANG=en_US.UTF-8`，按`ESC`键返回普通模式，保存退出。

### 更改键盘布局

如果使用的键盘不是通用105键，在`arch-chroot`之后需要重新配置键盘布局，先输入`exit`命令从已经安装的`Arch`环境回退到`Live`环境，然后执行`vim /mnt/etc/vconsole.conf`，输入下面的内容并保存，然后再`arch-chroot`进入`Arch`环境。

```bash
KEYMAP=colemak #使键盘布局为colemak布局
keycode 1=Caps_Lock #可选，使大写锁定键和ESC键互换。
keycode 58=Escape
```

### 设置主机名称

打开(不存在会自动创建）`/etc/hostname`文件：

```bash
vim /etc/hostname
```

在文件的第一行输入设定的`myhostname`，保存并退出。

再编辑`/etc/hosts`文件：

```bash
vim /etc/hosts
```

在文件末添加如下内容(将`myhostname`替换成设定的主机名)，保存退出

```bash
#缩进不必对齐
127.0.0.1	localhost 
::1		localhost
127.0.1.1	myhostname.localdomain	myhostname
```

### 设置Root密码

`Root`是`Linux`中具有最高权限帐户，很多操作必须通过`Root`用户进行，比如使用`pacman`，我们之前进行所有的操作也都是以`Root`用户进行的，也正是因为`Root`的权限过高，如果使用不当会造成安全问题，所以我们之后会新建一个普通用户来进行日常的操作。在这里我们需要为`Root`帐户设置一个密码：

```bash
passwd
```

Linux下命令均以`#`或`$`开头，这两个符号对应着命令行中的命令提示符，`#`代表以`Root`用户执行命令，`$`代表以普通用户执行命令。 

### 安装微码引导

Intel CPU使用`pacman`命令安装：

```bash
pacman -S intel-ucode
```

AMD CPU使用`pacman`命令安装：

```bash
pacman -S amd-ucode
```

### 安装启动引导

安装最流行的`Grub2`。**（如果曾经装过`Linux`，要删掉原来的`Grub`，否则不可能成功启动）**

首先安装`os-prober`和`ntfs-3g`这两个包，它可以配合`Grub`检测已经存在的系统，并自动设置启动选项。

```bash
pacman -S os-prober ntfs-3g
```

---

#### 如果为BIOS/MBR引导方式：

- 安装`grub`包：

```bash
pacman -S grub
```

- 部署`grub`：

```bash
grub-install --target=i386-pc /dev/sdx #将sdx换成你安装的硬盘
```

注意这里的`sdx`应该为硬盘（例如`/dev/sda`），**而不是**形如`/dev/sda1`这样的分区。

- 生成配置文件：

```bash
grub-mkconfig -o /boot/grub/grub.cfg
```

**如果你没有看到提示信息或提示出错，请仔细检查是否正确完成上面的过程。常见问题如下：**

1. 如果报`warning failed to connect to lvmetad，falling back to device scanning.`错误。参照[Arch wiki](https://wiki.archlinux.org/index.php/Install_from_existing_Linux)中搜索关键词`use_lvmetad`所在位置，简单的方法是编辑`/etc/lvm/lvm.conf`这个文件，找到`use_lvmetad = 1`将`1`修改为`0`，保存，重新配置grub。
2. 如果报`Warning: this GPT partition label contains no BIOS Boot Part；Warning: Embedding is not possible. GRUB can noly be install.Error: will not proceed with blocklists`错误， 是因为实际是`UEFI`引导的系统没有正确挂载`boot`分区。首先检查是不是按照`BIOS`方式安装的系统，二是检查是否正确挂载`/mnt/boot`。正确配置好`boot`分区之后从“挂载分区”这步开始重做。 

---

#### 如果为EFI/GPT引导方式：

- 安装`grub`与`efibootmgr`两个包：

```bash
pacman -S grub efibootmgr
```


- 部署`grub`：

```bash
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub
```


- 生成配置文件：

```bash
grub-mkconfig -o /boot/grub/grub.cfg
```

**提示信息中如果你发现错误，请仔细检查是否正确完成上面的过程，常见问题如下：**

如果报`warning failed to connect to lvmetad，falling back to device scanning.`错误。可参阅[这篇文章](https://www.pckr.co.uk/arch-grub-mkconfig-lvmetad-failures-inside-chroot-install/)，简单的方法是编辑`/etc/lvm/lvm.conf`这个文件，找到`use_lvmetad = 1`将`1`修改为`0`，保存，重新配置grub。

如果报`grub-probe: error: cannot find a GRUB drive for /dev/sdb1, check your device.map`类似错误，并且`sdb1`这个地方是你的u盘，这是u盘`uefi`分区造成的错误，对我们的正常安装没有影响，可以不用理会这条错误。

### 检查启动引导

建议使用如下命令检查是否成功生成各系统的入口，如果没有正常生成会出现开机没有系统入口的情况：

```bash
vim /boot/grub/grub.cfg
```

检查接近末尾的`menuentry`部分是否有`windows`或其他系统名入口，检查是否符合安装的预期。

---

**如果没有看到`Arch Linux`系统入口或者该文件不存在**，请先检查`/boot`目录是否正确部署`linux`内核：

```bash
cd /bootls
```

查看是否有`initramfs-linux-fallback.img initramfs-linux.img intel-ucode.img vmlinuz-linux`这几个文件，如果都没有，说明`linux`内核没有被正确部署，很有可能是`/boot`目录没有被正确挂载导致的，确认`/boot`目录无误后，可以重新部署`linux`内核：

```bash
pacman -S linux
```

再重新生成配置文件，就可以找到系统入口。

如果你已经安装`os-prober`包并生成配置文件后还是没有生成其他系统的入口，则可能是**由于目前处于U盘安装环境下，而无法检测到其他系统的入口**，可在下一步中重启登陆之后重新运行下面的命令：

```bash
grub-mkconfig -o /boot/grub/grub.cfg
```

如果还没有生成其他系统的入口，请参照[Arch wiki GRUB](https://wiki.archlinux.org/index.php/GRUB/Tips_and_tricks#Combining_the_use_of_UUIDs_and_basic_scripting)来编辑和配置该文件并手动添加引导的分区入口。

---

### 进入新的系统

接下来，你需要进行重启来进入已经安装好的新系统，执行如下命令：

```bash
exit
```

**如果挂载了`/mnt/boot`，先`umount /mnt/boot`**，否则直接`umount /mnt`：

```bash
umount /mnt/boot
umount /mntreboot
```

注意这个时候可能会卡在有两行提示的地方无法正常关机，长按电源键强制关机即可，没有影响。注意在重启后拔掉U盘启动盘。

开机如果提示Arch Linux 版本号-Arch (tty1)，并且在输入root及设置的密码后出现命令提示符，则说明`Arch Linux`已成功安装。

## 安装中的问题

### 安装分区警告

问题描述：分区时出现警告：逻辑分区和物理分区不对齐

可能原因：SSD或者是HDD上原来装过Windows，则硬盘最开始的32M空间（图形界面下使用`Gparted`可以看到）是默认空白的。这样就会导致分区的不对齐。但其实对于SSD来说只是影响到速度，使用还是比较正常的

解决方法：(未试验)使用`shred`命令彻底清洗磁盘，但耗时一般较长。

```bash
shred -v /dev/sda
```

### 混合引导方式

事实上，Arch Linux支持三种启动方式，但启动方式分区和`grub`的安装略有不同。

1. `UEFI + GPT`

   这是我采用的方式。具体对于`grub`的操作见上文。较新的主板推荐采用这种方式。

2. `BIOS + MBR`

   这是较老的主板支持的分区方式，但在某些新的主板上已经不支持了。值得注意的是这种分区方式支持的硬盘是小于`2T`的。

3. `BIOS + GPT`

   个人感觉这种分区方法的好处是方便后续在这块硬盘上安装别的Linux发行版并提高设备的兼容性。因为最好保证一块硬盘的分区表前后都是一致的，否则会出现兼容性的问题(这是我的猜想，有错误还请指正)。

下面是关于第三种方法的安装和说明：

1. 在格式化分区时创建的分区表是**GPT**分区表而不能是**DOS**分区表。
2. 制作文件系统时会弹出磁盘性能的警告，不需要在意。
3. 安装系统引导步安装的包为`grub`和`os-prober`，然后依次执行：

```bash
#先寻找本机已安装的操作系统
os-prober 
mkdir /boot/grub              
grub-install --force --target=i386-pc /dev/sda
#生成grub配置文件
grub-mkconfig > /boot/grub/grub.cfg
#敲入这条命令即可，使用BIOS的在grub-install时--target参数统一是i386-pc
#这里也需要使用--force参数强制安装grub，因为无参数情况下的两个警告会使得grub安装失败
#这里grub安装的位置选择的直接是硬盘/dev/sdx，而不是任何一个分区,这已经强调多次了。
```

