---
title: Parrot Linux物理机的安装、引导与配置
authors:
  - EndlessPeak
toc: true
tags:
  - Linux
categories: 
  - Linux Basic
date: 2020-01-11 20:00:00
hidden: false
draft: false
---

![](https://s2.ax1x.com/2020/01/12/loiVVU.jpg)

Parrot Sec OS是Linux发行版中十大渗透测试系统之一，为广大渗透测试工作者提供了大量已经集成好的测试工具。桌面采用的是基于Gnome的Mate桌面，外观上非常炫酷，科技感十足。系统中编程环境完善，支持C++、Java、Python等多种语言编程，官方还提供了多种版本以适应不同电脑下载。

<!--more-->

本文拟以Parrot Sec OS为例，讲解如何在物理机上安装Linux发行版。

选择Parrot Linux的主要原因是Windows 10+Linux双系统中Parrot Linux对`NVIDIA`显卡的“支持”比较好——在未安装对应显卡驱动前，可以选择不使用`NVIDIA`显卡，这样就不会出现无法进入Linux系统的情况。

> 注：
>
> 我曾经尝试安装Ubuntu 18.04 LTS，由于显卡支持的原因，在Logo加载界面始终无法进入系统。
>
> 当然显卡支持的问题早有解决方案。如果存有这方面的顾虑，可以先了解有关自己电脑的详细配置，而后在社区中寻找解决方案。

在开始讲Linux的安装之前，必须明确一个先决条件：**你的计算机中已经安装有一个或多个Windows版本**。这是因为如果你在没有任何操作系统的空物理机上安装Linux，以后再要安装Windows系统，那么Windows的引导程序就会将Linux的引导程序**覆盖**。引导覆盖会使得你无法再进入Linux系统，即使它事实上还是存在于你的计算机之中的。

> 当然，这个问题可以修复；但如果确实这么做，解决方法很麻烦。

## 安装前的准备

### 浅析引导

当一块硬盘接驳主机之后，它的首要任务是建立分区列表，分区列表有MBR和GPT两种，其中MBR分区模式只能分4个主分区，分区列表最大为**2.1TB**的硬盘，GPT分区列表则支持 **9.4ZB硬盘（9.4ZB=1024EB=94亿TB）** 。NTFS，FAT32，EXT4等属于文件系统，就像是给分好区的硬盘上打上格子，方便填充数据。至于打成什么样的格子由文件系统决定。 

**MBR分区表**(Master Boot Record):即硬盘的主引导记录分区列表，在主引导扇区，只支持容量在 2.1TB 以下的硬盘，超过2.1TB的硬盘只能管理2.1TB，最多只支持4个主分区或三个主分区和一个扩展分区，扩展分区下可以有多个逻辑分区。 

**GPT分区表**(GUID Partition Table):即全局唯一标识分区列表，是一个物理硬盘的分区结构。它用来替代BIOS中的主引导记录分区表（MBR）。Windows最大仅支持**128**个GPT分区，GPT可管理硬盘大小达到了**18EB**( **1*EB*=1024PB ,1PB=1024TB**)。

注：**只有基于UEFI平台的主板才支持GPT分区引导启动。**

**UEFI**(Unified Extensible Firmware Interface):全称“统一的可扩展固件接口”， 是一种详细描述全新类型接口的标准。这种接口用于操作系统自动从预启动的操作环境，加载到一种操作系统上，从而使开机程序化繁为简，节省时间。

**ESP分区**(EFI system partition):该分区用于采用了EFI BIOS的电脑系统，用来启动操作系统。分区内存放引导管理程序、驱动程序、系统维护工具等。如果电脑采用了EFI系统，或当前磁盘用于在EFI平台上启动操作系统，则应建议ESP分区。 

**MSR分区**：即微软保留分区，是GPT磁盘上用于保留空间以备用的分区，例如在将磁盘转换为动态磁盘时需要使用这些分区空间。 

**归纳1：**传统BIOS不支持GPT分区列表，仅支持MBR格式。新型引导方式UEFI则取代传统BIOS，它加入了对新硬件的支持，其中就有2TB以上硬盘。它不支持MBR模式，仅支持GPT格式。

近两年出现的UEFI主板，采用UEFI+BIOS共存模式，并且在BIOS中集成UEFI启动项。BIOS+MBR已经趋于淘汰，UEFI+GPT是大势所趋。

GPT这种新型磁盘模式，与常用的MBR磁盘相比更稳定，自纠错能力更强。 WinXP系统无法识别GPT磁盘，对Win7、Win8来说GPT磁盘可以任意读写，但无法安装操作系统。GPT磁盘必须在使用支持FEI的主板后才可以安装Win7、Win8。

GPT磁盘的保留分区（隐藏分区）又称为EFI保留分区（ESP），可以防止将该磁盘挂接到XP系统中被误认为是未格式化的磁盘而格式化，导致数据丢失。该保留分区在将硬盘初始化（或转化）为GPT模式时自动创建，大小随硬盘总容量而定。 

一般来说，GPT格式的磁盘至少有三个区，**第一个是EFI系统保护区（默认隐藏不加载）第二个是MSR微软保留分区，第三个是系统数据分区**。 

**归纳2：**如果你的电脑是Win10系统，那么一般是GPT分区，使用UEFI引导；如果是Win7、8的系统，那么也是GPT分区，而引导方式则有待商榷(不排除是MBR)；如果是WinXP或者Win98系统，那一定是MBR分区引导。(话说回来这年头真的还有人用Win98吗？)

> 注：
>
> 判断电脑的BIOS引导模式，在运行对话框中输入msinfo32，回车打开系统信息(或在控制面板/系统与安全/管理工具/系统信息)。寻找到BIOS模式项，观察是否是UEFI。

### 硬盘空间

磁盘分区是Linux安装中重要的部分，也是最困难的部分，因为Linux的文件系统和Windows有别。

首先要明确的是，你的电脑已安装有Windows系统。那么，你选择要安装Linux，你必须划分出一块空间用于Linux的安装。

划分的方法：右击我的电脑，在弹出的菜单中选择管理，在弹出的对话框中选择存储，在存储栏下选择磁盘管理，以加载虚拟磁盘服务。

选择一块空间充足(推荐40GB空闲空间以上)的分区，右键选择压缩卷，然后压缩出至少40960MB空间(**最好是和已有的分区大小不同，原因见下**)。

> 需要记住该压缩卷的空间大小，且最好是和已有的分区大小不同，因为在Linux下各个分区的标识符和Windows下完全不同。所以届时可能需要通过空间大小来识别你分配的用于Linux安装的是哪一部分空间。

压缩卷的意思是实际要从该卷中分多少空间出来作为新卷(即新分区)用。

### 安装介质

第一，在所选择的发行版官网上下载ISO镜像文件。

Parrot Sec OS下载地址为：https://parrotlinux.org 

官网上的ISO镜像文件一般分为多种版本，目前Parrot Linux分为Security、Home/Workstation、Other Builds三种版本。个人用户一般选择Security或者Home均可。*如果希望拥有完整的编程环境和渗透测试工具集的话，选择Security版本。*

在接下来的Installer ISO分类中选择Parrot Security(Mate)或者KDE Edition(KDE Plasma)均可。Mate桌面环境基于Gnome，而KDE Plasma顾名思义是Kit Desktop Environment。如果要安装在虚拟机上，可以选择Parrot Security也可以选择Virtual Appliance。

第二，在下载完成ISO后，使用UItraISO(软碟通)工具制作U盘启动盘(即安装所需的启动媒体)。

第三，重启电脑进入BIOS，进行Boot设置。

BIOS的进入，不同的电脑按键不一样。一般来说，在开机的时候**连按**Del键(Del键位于小键盘上)进入BIOS。进入后设置启动顺序。

1. HDD代表的是硬盘启动；
2. USB代表从USB接口启动；
3. FDD、CD/DVD、NetWork代表是软盘，光驱和网卡，一般不使用。

将从硬盘启动设置到从U盘启动，然后保存退出即可。

由于U盘启动是临时安装时使用，也可以不进入BIOS设置启动顺序，而是在开机的时候**连按**ESC键，在弹出的设备启动界面中选择从U盘启动即可。

> 注意：
>
> 1. 部分电脑可能设置有Security Boot，如果切换为U盘启动，会提示： 
>     **Secure Boot Violation**:Invalid signature detected,check secure boot policy in setup. 
>
>     这种情况需要进入BIOS设置界面，在Security选项卡下选择secure boot control选项，调整该选项的属性为disable，保存并退出。
>
> 2. 部分电脑可能在开机时按ESC键不会出现设备启动界面，这可能是由于电脑所使用的主板默认设置的并不是ESC键呼出设备启动界面；也可能是主板根本没有设备启动界面这一项设置。具体需要自行查阅自己电脑的主板信息。(尤其是淘换来的二手主板或寨板等等)

## 安装中的操作

下面以Parrot Linux为例，说明如何安装Linux发行版。

1. 确认一切安装准备都就绪后，插入作为启动媒体的U盘，并重启电脑，选择从U盘启动，以进入Live环境。

2. 进入到如下图所示的安装界面，选择Install.
   ![](https://s2.ax1x.com/2020/01/12/lTrrqJ.png)
   
> 注意：从上图可以清楚的看到有一个模式是"**Live Mode**"启动模式，这个选项表示用户可以直接启动预载于启动媒体中的Linux系统，不需要经过安装步骤。该模式的作用是给用户预览一下此系统是怎么样的，是否符合用户预期。试用系统一般不会改变计算机中的内容。

3. 选择安装模式，选择Install with GTK GUI以提供图形用户界面的配置。

4. 语言选择中文(简体)，当然其他也无所谓。
   ![](https://s2.ax1x.com/2020/01/12/lTsGQO.png)
   
5. 选择区域为中国。
   ![](https://s2.ax1x.com/2020/01/12/lTsaTA.png)

6. 选择键盘映射为汉语，等待其加载组件完成。

7. 设置**管理员**用户名与密码，默认的管理员用户名是root，密码自行设置。

   ![](https://s2.ax1x.com/2020/01/12/lTs8SK.png)

8. 设置普通用户的用户名和密码

   > 注意：普通用户的密码和管理员用户密码不要填写同一个密码！关于普通用户与管理员用户的关系以后会详细讨论。

9. 磁盘分区——这是最关键的一步，一定要慎之又慎。

   ![](https://s2.ax1x.com/2020/01/12/lTsgmQ.png)

   如果是安装仅Linux系统而无Windows系统，可以选择向导(使用整个磁盘)；如果是计算机先已安装有Windows，再安装Linux，则应当选择手动分区，然后单击继续按钮。

   > 对于Linux系统而言，必须有**根分区**(简称一切的根)"root"和**交换分区**"swap"。
   >
   > 根分区被用来存放系统所必须的文件，它被挂载到根目录(/)下。
   >
   > 交换分区则相当于Windows中的虚拟内存概念。该交换分区被当做低速RAM使用。Parrot Linux允许用户不显式地指派交换分区，如果你的系统不是很忙而内存又很充裕的话。

   手动分区界面中，用户可以自行建立分区方案。缺省的分区方案如下：

   1. 将所有文件放在同一个分区中(推荐新手使用)；
   2. 将/home放在单独的分区
   3. 将/home、/var和/temp都分别放在单独的分区。

   选定分区方案后继续，手动分区可能需要自行创建各个分区，故下面以建立根分区为例介绍建立各个分区的过程：

   1. 选定之前划分的特定空间，创建一个新分区。

   2. 由于创建的是根分区，分区容量默认为全部剩余空间。

   3. 挂载点设置为"/"表示将该分区挂载至根目录下。

      > swap分区不需要挂载点，其大小指派4G-8G均可。

   4. 主分区和逻辑分区的文件系统一般都设置为EXT4日志文件系统，当然为了更好的扩展性，你也可以选择btrfs文件系统。EXT4和btrfs文件系统可以转换，因此不必过分纠结。如果某些分区有默认文件系统，就选择默认。

      > 文件系统似乎是内核中比较稳定的部分，人们一直使用的 ext2/3在近年来暴露出了一些扩展性问题，于是便催生了 ext4 。然而很多目前有关 ext4 的文章都不约而同地提到了 btrfs，并认为 ext4 将是一个过渡的文件系统。 ext4 的作者 Theodore Tso 也盛赞 btrfs 并认为 btrfs 将成为下一代 Linux 标准文件系统。

   分区完毕后在分区表中还可以单击各分区对其进行修改。

   一般来说，分区可设置为两个"/"(主分区),"swap"(逻辑分区)，也可以划分的更加详细一些。

   ![](https://s2.ax1x.com/2020/01/12/lTsfkn.png)

10. 完成了磁盘分区的操作后，需要将GRUB安装至硬盘。

    ![](https://s2.ax1x.com/2020/01/12/lTsolT.png)

    不论电脑上是Windows+Linux，还是仅有Linux，都需要安装GRUB。GRUB用于引导Linux的启动。单击继续后在接下来的界面中选择将GRUB安装到手动输入设备/dev/sda上。然后耐心等待安装完成。

11. 出现如图所示的界面则证明安装成功。

    ![](https://s2.ax1x.com/2020/01/13/lT4END.png)

    > 注：安装介质就是插入的U盘，在点击重启的时候，应当拔出。

## 安装后的配置

### GNU Grub Version 2.02

重启系统后**最可能遇到问题**是出现GNU Grub Version 2.02界面。

> 注：
>
> GNU Grub Version 2.02界面是指电脑会卡在开机自检后的一个黑屏界面上，电脑要求输入命令。命令行会提示grub>
>
> 命令行也有可能提示unknown file system，进而显示grub rescue>

出现该界面表明Grub引导出现了问题，需要手动引导电脑进入操作系统。(不同的电脑可能出现的Grub的版本号不相同) 

出现该界面，请考虑本机是否有固态硬盘：

1. 如果有固态硬盘，且Linux安装在固态硬盘上，或者没有固态硬盘，则可以选择解决方案一；
2. 如果有固态硬盘，但Linux没有安装在固态硬盘上，或者想迅速解决问题，请选择解决方案二。

解决方案一：

1. 通过设置参数手动从grub引导电脑进入操作系统

   先使用ls命令，找到你的Linux安装在哪个分区(*grub>为电脑显示，后面是输入的命令*)

   ```bash
   grub>ls
   ```

   该命令会会罗列所有的磁盘分区信息，比如显示：(hd0,1),(hd0,5),(hd0,3),(hd0,2)

2. 然后依次调用如下命令： X表示每个分区的标识符。

   如果之前安装Linux时/boot没有进行单独分区，则用以下命令：

   ```bash
   grub>ls (hd0,X)/boot/grub
   ```

   如果之前安装Linux时对/boot进行了单独分区，则用下列命令：

   ```bash
   grub>ls (hd0,X)/grub
   ```

3. 找到包含/boot的分区后，系统会列出很多文件，这表明Linux安装在该分区。

   假设找到（hd0,5）时，显示了文件，现在设法临时性将grub的两部分关联起来：

   ```bash
   grub>set root=(hd0,5)
   grub>set prefix=(hd0,5)/boot/grub #若/boot没有进行单独分区，则执行这条命令
   grub>set prefix=(hd0,5)/grub #若/boot进行了单独分区，则执行这条命令
   ```

4. 调用如下命令，就可以加载出grub引导菜单。

   ```bash
   grub>insmod normal #启动normal启动
   grub>normal
   ```

5. 见方案二第2步。

> 注：
>
> grub shell中的ls命令查看的并不是你电脑上的所有磁盘分区，如果你有固态硬盘，（一般固态硬盘位于磁盘读取顺序中的第一个）ls只会查看固态硬盘上的分区，很显然，如果你有固态且Linux没有安装在固态硬盘上，那么无论你ls哪个分区，都不会显示文件，只会提示文件系统未知，在这种情况下想将grub临时关联起来，只能是无稽之谈。

解决方案二：

1. 重启，然后在开机的时候**连按**ESC键，在弹出的设备启动界面中选择Linux。

2. 成功进入Linux后，在终端执行(*$为命令行显示，表示目前是普通用户，后面是输入的命令*)：

	```bash
$ sudo update-grub
$ sudo grub-install /dev/sda #如果你的第一块硬盘是机械硬盘则执行该命令
$ sudo grub-install /dev/nvme0n1 #如果你的第一块硬盘是固态硬盘则执行该命令[见注2]
	$ reboot #重启
	```

> 注1：
>
> 1. $ 标识符是命令行中默认的提示，输入时不必加上。
> 2. sudo命令会提示输入管理员密码，输入密码时屏幕是没有显示的，此处要注意。

![](https://s2.ax1x.com/2020/01/13/lT57wV.png)

> 注2：
>
> 对仅机械硬盘的电脑来说，**sda是你的第一块硬盘的硬盘号**，输入sdb,sdc等都不对；
>
> 对有固态硬盘的电脑来说，建议进入Linux后先执行命令 sudo fdisk -l命令查看磁盘情况，然后将第一块显示的磁盘(它类似nvme0n1这种名称)作为你将要输入grub-install的位置。
>
> **分区号码不要指定**，对机械硬盘来说，输入sda1，sda5等都不对；对固态硬盘来说，输入nvme0n1p1,nvme0n1p2等等都不对。注意要在重启后检查是否已经恢复了grub的启动菜单。

即使重启后能顺利地进入Linux系统，我也建议在终端执行上述三条命令，因为笔者自己电脑的Grub是在进入Windows后重启再进入Linux的时候失效的。所以更新Grub是必须的操作，除非你每次开机的时候都调出设备启动界面手动选择要启动的操作系统。

> 注3：
>
> 即使你已经按照上面的步骤正确地做过一遍，你仍有可能会在进入Windows后再关闭再启动，在进入Grub时出现GNU Grub Version 2.02的引导问题，并且有可能会反复出现。这种情况笔者在安装manjaro、deepin等发行版的时候发生过。
>
> 目前还没有找到有效的**自动化**解决方案，所以只能默认把Windows 置EFI启动项首位，并在每次开机想要进入Linux时连按ESC进入启动管理手动选择Linux系统。

### Wlan0 : No Wireless connection

在终端输入下面的命令，检查返回结果：

```bash
$ iwconfig
#一般(没有无线网卡的电脑)会出现下面的返回结果。
eth0:no wireless connection
lo:no wireless connection
#如果(有无线网卡的电脑)出现的结果同上，那么说明无线网络配置有问题，需要重新进行配置
```

类似eth0的名称表示的是以太网(有线网络)，lo表示的是本地环回，类似wlan0的名称表示的是以太网(无线网络)。必须出现类似wlan0的名称才表示有无线网络连接。如果没有显示类似wlan0的项，则可能说明驱动安装不正确。应当进行下列操作：

1. 检查电脑是否有无线网卡，且无线网卡是否插好(笔记本略过此步骤)

2. 输入下面两条命令中的任意一条。

   ```bash
   $ lspci | grep Network 
   $ lspci | grep -i net
   ```

   在返回的结果中寻找wireless Network Adapter的版本信息。例如，笔者自己的电脑无线网卡版本在终端中显示为 RTL8821CE。

   部分Linux发行版显示无线网卡版本的信息可能不全，可以用Windows协助查看，在Windows下查看网络驱动的版本信息方法是：进入控制面板/网络和Internet/网络和共享中心/更改适配器设置→进入网络连接，查看WLAN下的属性信息，如下图所示：

   ![](https://s2.ax1x.com/2020/01/13/lHKcX8.png)

3.  在github网站上下载驱动。对于RTL8821CE，这里使用tomaspinho/rtl882ce。 

4.  下载解压缩，在下载的文件夹中(/home/download)右键→在终端中打开，执行：

   ```bash
   $ sudo ./dkms-install.sh
   ```

5. 如果Arch系提示有错误，则按照错误信息安装对应的依赖。一般可能要安装的依赖有：bc、dkms、linux-headers等等。

6. 命令执行完成后再次执行iwconfig命令，如果出现了wlan0，说明驱动安装成功。

7. 点击无线网图标，即可连接到无线网。

### 更新源配置

1. 查看当前的Parrot Security镜像源，执行：

    ```bash
    $ parrot-mirror-selector
    ```
    ![](https://s2.ax1x.com/2020/01/13/l775RO.png)

2. 修改Parrot Security更新源

    众所周知，Linux发行版一般为国外公司(使用Deepin OS/Red Flag等国产发行版的例外)，一般它们的更新源都部署在国外的服务器上，国内访问会很缓慢。故此，需要修改发行版的更新源为国内的镜像，以提高更新速度。当然，这并不是必须的。

    在终端执行以下命令：

    > 注，Parrot Linux有相当多配置文件的存放位置与其他Debian发行版位置不同！

    ```bash
    $ vim /etc/apt/sources.list.d/parrot.list
    ```

    ![](https://s2.ax1x.com/2020/01/13/l7O8De.png)

    使用#注释掉之前的更新源，而后将下面的代码根据地理位置任选一二拷贝到文件尾。

    ```csharp
    #中科大和USTCLUG
    deb http://mirrors.ustc.edu.cn/parrot parrot main contrib non-free
    #北京清华大学，TUNA协会
    deb https://mirrors.tuna.tsinghua.edu.cn/parrot/ parrot main contrib non-free
    #上海大学
    deb https://mirrors.shu.edu.cn/parrot/ parrot main contrib non-free
    #上海交通大学 NIX用户组
    deb https://mirrors.sjtug.sjtu.edu.cn/parrot/ parrot main contrib non-free
    ```

    按**ESC**键，输入“ **:wq**” 回车，以保存配置文件并退出。

3. 执行下面两条更新命令，第二和第三条命令任选一条执行即可。
	
   ```bash
    $ sudo apt-get update
    $ sudo apt-get upgrade
    $ sudo apt-get dist-upgrade
   ```
   
   > 注：
   >
   > 1. update是更新软件的**列表信息**,包括版本,依赖关系等
   >
   > 2. upgrade在不改变现有软件设置的基础上更新**软件**
   > 3. dist-upgrade在会改变配置文件和改变旧的依赖关系基础上更新**软件**
   
   更新版本实际上就是更新软件包，由于Debian系列发行版都采用的是滚动升级，所以dist-upgrade仅用来升级软件，而dist-upgrade则用来更新版本。(版本升级会修改大量配置文件) 

### 安装中文输入法

1. 安装Google拼音输入法，在终端输入命令：

    ```bash
    $ sudo apt-get install fcitx-googlepinyin
    $ reboot
    ```

2. 安装IBUS拼音输入法，在终端输入命令：

    ```bash
    $ sudo apt-get install ibus ibus-clutter ibus-gtk ibus-gtk3 ibus-qt4
    $ im-config -s ibus #启动iBus框架
    $ sudo apt-get install ibus-pinyin
    $ sudo ibus-setup #打开iBus设置
    $ reboot
    ```

3. 安装搜狗拼音输入法，在终端依次输入下列命令：

    ```bash
    $ sudo apt --fix-broken install
    $ sudo apt-get update
    $ sudo apt-get dist-upgrade
    $ sudo apt-get install fcitx fcitx-frontend-gtk2 fcitx-module-dbus fcitx-bin fcitx-frontend-gtk3 fcitx-module-kimpanel fcitx-config-common fcitx-frontend-qt4 fcitx-module-lua fcitx-config-gtk fcitx-frontend-qt5 fcitx-modules fcitx-data fcitx-module-x11 fcitx-frontend-all fcitx-libs-dev fcitx-ui-classic
    $ reboot
    ```

    如果安装任何软件的过程中提示依赖关系有错误 ，则在终端尝试输入命令解决：

    ```bash
    $ sudo apt-get install -f
    ```

4. 安装搜狗拼音输入法也可以尝试在搜狗官网上下载deb安装包，然后在下载位置打开终端，执行下面的命令：（最后的字符串是安装包名，请自行替换）

    ```bash
    $ sudo dpkg -i sogoupinyin_2.2.0.0108_amd64.deb
    $ reboot
    ```

    ![](https://s2.ax1x.com/2020/01/13/lHpLwT.png)

### DIY桌面环境

1. Mate桌面下更换主题

    可以在系统自带的主题中选择选择喜欢的主题；可以访问下面的网址。 

    Parrot系统 访问：https://www.mate-look.org/  (需要VPN)
    Kali系统 访问：https://www.gnome-look.org/browse/cat/135/ord/latest/  (访问缓慢)

    注：一定要选择3.x版本的主题才适合，因目前的Mate桌面环境是基于Gnome 3的。 

2. Mate桌面环境更换为KDE桌面环境

    ```bash
    $ sudo apt-get update
    $ sudo apt-get dist-upgrade
    $ sudo apt-get install parrot-kde
    ```
    
    执行第三条命令后系统会提示选择默认会话窗口，需要从lightdm改为sddm。
    
    ```bash
    $ sudo apt autoremove parrot-mate* 
    $ reboot
    ```
    
    重启后，在登录系统时，在界面上的session中选择plasma，输入口令进入。

3. 安装Cairo-Dock

   依次执行下面的命令。
   
   ```bash
   $ sudo apt-get update
   $ sudo apt-get install cairo-dock cairo-dock-plug-ins
   ```
   
4. 安装 screenfetch 

    ```bash
    $ sudo apt-get update
    $ sudo apt-get install screenfetch
    ```

    