---
title: Linux综合概述
authors:
  - EndlessPeak
toc: true
tags:
  - Linux
categories: 
  - Linux Basic
date: 2020-01-10 14:50:00
hidden: false
draft: false
---

![](https://s2.ax1x.com/2020/01/10/lhY7ad.png)

GNU/Linux，无论你是否相信，它已经成为目前增长最迅速的系统。无论是企业还是个人用户，Linux都是一个足够可靠的选择。我希望本系列文章能够使更多的人完全理解Linux，并热切地尝试去使用甚至探索它。

<!--more-->

## 建立Linux的概念

简而言之，Linux是一个操作系统，可以安装在包括服务器、个人电脑、PAD、手机、打印机等各类电子设备中。

计算机系统是由硬件和系统软件所组成的，它们共同工作来运行程序。

- 从物理结构上来说，计算机是由一个硬件组所组成的。

- 从逻辑结构上来说，操作系统就是为了：

  ​	①更加有效的控制硬件资源，为它们进行分配和回收

  ​	②提供计算机运行所需要的功能

  ​	③提供一组系统调用接口作为程序开发使用。

Linux是一种操作系统，它可以理解为一个软件组。软件可以分为操作系统级和应用软件级，从这个角度来说，Linux这个软件组中的所有软件均处于操作系统级。

如果将整个计算机解剖成为硬件、内核、系统调用和应用程序四层，那么操作系统的层次如图所示： 

![](https://s2.ax1x.com/2020/01/10/lh0YOP.png)

详细阐述Linux的起源与发展，以及与其密切相关的开放源代码许可证协议GPL，甚至追溯它的老大哥UNIX的起源与发展，我认为对于Linux操作系统的学习其实没有太大的帮助，而且这方面的内容网络上俯拾皆是，没有必要重复造轮子，除非你是历史系的学生需要选择这一板块作为毕业论文，或者你是法律系的学生需要将开源协议所涉及的问题用作案例分析。 
在现阶段只需要知道： 

- UNIX是一种稳定，成熟的操作系统。
- GNU是GNU‘s Not Unix，由自由软件基金会发起，本意是一个名为GNU的，同UNIX兼容的操作系统， 开发这个系统的目的就是为了让所有计算机用户都可以自由地获得这个系统。任何人都可以免费 
  地获得这个系统的源代码，并且可以相互自由拷贝。 
- GNU有自己独特的公共许可证，即版权声明：GPL，其目的就是要让GNU永远是免费和公开的。  
- Linux由UNIX发展而来，与UNIX兼容。
- Linux如今使用GPL，所以它是免费和公开的。

有关Linux、UNIX、GNU和GPL的详细内容，请自行百度。 

## Linux的优缺点

### Linux的特色

1. 自由而开放的使用及学习环境 

   由于Linux是基于GPL的授权之下，因此它是自由软件，也就是任何人都可以自由地使用戒者是修改其中的原始代码的意思。 这种开放性架构对科学界来说是相当重要的。因为很多的工程师由于特殊的需求，常常需要修改系统的原始代码， 使该系统可以符合自己的需求！而这个开放性的架构将可以满足不同需求的工程师，因此当然就有可能越来越流行。 

2. 配备需求低廉 

   Linux可以支持个人计算机的x86架构，系统资源不必像早先的Unix系统那般，仅适合于单一公司所出产的设备！ 单就这一点来看，就可以造成很大的流行。不过，如果你想要在Linux下执行X Window系统， 那么硬件的等级不能太低。 

3. 核心功能强大而稳定 

   由于Linux功能并不会输给一些大型的Unix工作站，因此，近年来越来越多的公司或者是团体、 个人投入这一个操作系统的开发与整合工作！例如IBM与升阳公司都有推出x86的Linux服务器。 

4. 独立作业

   由于很多的软件套件逐渐被这套操作系统拿来使用，而很多套件软件也都在 Linux这个操作系统上面进行发展与测试，因此，Linux近来已经可以独立完成几乎所有的工作站或服务器的朋务了，例如 Web, Mail, Proxy, FTP….. 


目前Linux已经是相当成熟的一套操作系统，可以说这给微软造成了相当大的压力。此外，由于它的系统硬件要求很低，Linux在被淘汰的硬件中也可以执行的相当的顺畅、稳定，因此这也造成相当多“垃圾佬”的关注。

### Linux的优点

总体说来，Linux有以下优点：

- 稳定的系统

  Linux是基于UNIX的概念而开发出的操作系统，它具有与UNIX系统相似的程序接口和操作方式，当然它也继承了UNIX稳定且有效率的特点。 

- 免费或少许费用

  任何人都可以免费取得Linux。早些年如果申请Ubuntu(Linux的发行版的一种)，甚至可以免费邮寄安装光盘到家中。与之相反，UNIX和微软可能需要负担庞大的版权费用，而且微软会有频繁的更新。 

- 安全性、漏洞的快速修补

  如果你对网络相当了解的话，你应该知道“没有绝对安全的主机”。但是Linux的社区开发模式可以随时获得最新的安全信息，相对来说更加安全。 

- 多任务、多用户

  Linux主机允许多人上线工作，资源的分配也比较公平，比Windows的单人多任务系统更加稳定。正是因此，Linux比Windows更加适合作为服务器使用。耗费资源更少，更为稳定，虚拟化技术、分布式计算和互联网应用等的支持性更佳。 

- 相对耗费资源小

  目前市面上任何一款能作为个人计算机使用的机器均可顺畅安装Linux，且耗费资源比Windows少，且少得多(前提是你正确安装了Linux及相关问题的解决方案)。

- 适合需要小内核程序的嵌入式系统

  Linux的内核只有数百KB，所以它可以作为家电、小电子用品的操作系统，即嵌入式系统。顺便一提，目前手机中的Android系统正是基于Linux的开源操作系统。 

- 整合度高且多样的图形用户界面

- 用户和用户组使得系统保密性更高

### Linux的缺点

- 需要命令行来管理

  Linux需要使用命令行的终端机模式进行系统的管理，Linux玩家必须接受使用命令管理计算机 

- 无特定的支持厂商

  自由软件使用自由开发，系统的问题只能在网上找答案或自己调试解决。 

- 游戏支持只有轻量

  Linux上最好不做无意义的事情，所以这里不讨论游戏。 

- 专业软件支持不足

  可能存在一些绘图、建模、金融方面的软件不支持Linux操作系统，(这里不得不提一句国内软件厂商鲜有支持Linux操作系统的) 但必须指出，这是商业方面的问题而不是操作系统的问题。 


## Linux的发行版本

*问：“如何选择适合我自己的发行版？”*

*答：“你随意选择就可以了。”*

随着Linux各种支持的完善、稳定性和易用性的提升，现在各个发行版之间的差异性已经愈发的不明显了，可以随意选择。但不可否认的是，各发行版之间的差异确实依旧存在，每个发行版的用户数量、用户质量都不尽相同。

### 发行版的综合介绍

> 概括地讲，Linux的发行版本可以大体分为两类
>
> - 商业公司维护的发行版本
> - 社区组织维护的发行版本
>
> 前者以著名的Redhat Enterprise Linux（RHEL）为代表，后者则以Debian为代表。

以下详细阐述各发行版的类别：

- **主流分支**

  1. **Debian**

     Debian分为三个版本分支 stable, testing 和 unstable。其中，Unstable为最新的测试版本，其中包括最新的软件包，但是也有相对较多的bug，适合桌面用户。Testing的版本都经过Unstable中的测试，相对较为稳定，也支持了不少新技术（比如SMP等）。而Stable一般只用于服务器，上面的软件包大部分都比较过时，但是稳定和安全性都非常的高。

     Debian最具特色的是apt-get / dpkg包管理方式。Debian的资料也很丰富，有很多支持的社区，有问题求教可以在上面提问。

     Debian系的发行版包括以下几种：

     1. Debian

        Debian是社区类Linux的典范，是迄今为止最遵循GNU规范的Linux系统。	

     2. Ubuntu

        Ubuntu是基于Debian的unstable版本加强而来，可以这么说，Ubuntu就是一个拥有Debian所有的优点，以及自己所加强的优点的近乎完美的 Linux桌面系统。 

     3. Deepin OS(由Knoppix发展而来)

        Deepin基于Qt/C++（用于前端）和Go（用于后端），拥有全新而独特的深度桌面环境（DDE）它旨在创造一个全新的简单、易用、美观的 Linux 发行版。 

     4. Google Chrome OS

     5. Linux Mint

  2. **RedHat**

     Redhat应该说是在国内使用人群最多的Linux版本，甚至有人将Redhat等同于Linux，而有些老鸟更是只用这一个版本的Linux。所以这个版本的特点就是使用人群数量大，资料非常多，言下之意就是如果你有什么不明白的地方，很容易找到人来问，而且网上的一般Linux教程都是以Redhat为例来讲解的。

     Redhat系列的包管理方式采用的是基于RPM包的YUM包管理方式，包分发方式是编译好的于进制文件。稳定性方面RHEL和CentOS的稳定性非常好，适合于服务器使用，但是Fedora Core的稳定性较差，最好只用于桌面应用。 

     RedHat系的发行版包括以下几种：

     1. Cent OS(Community Enterprise Operating System)

        CentOS 是一个基于Red Hat Linux 提供的可自由使用源代码的企业级发行版，即RHEL的社区克隆版本。它旨在建立一个安全、低维护、稳定、高预测性、高重复性的 Linux 环境。 

     2. Fedora Core

        由原来的Red hat Desktop发展而来。

     3. RHEL(Redhat Enterprise Linux)

        即所谓的Redhat Advance Server。注：该发行版是收费版本。

     4. Oracle Linux

     5. Mandriva

        是目前全球最优秀的Linux发行版之一，稳居于linux排行榜第一梯队。它是目前最易用的linux发行版，也是众多国际级linux发行版中唯一一个默认即支持中文环境的linux。 

     6. Red Flag

        红旗Linux是中国较大、较成熟的Linux发行版之一。 

  4. **Slackware Linux**

     它坚持KISS（Keep It Simple Stupid）的原则，就是说：

     1. 没有任何配置系统的图形界面工具。一开始，配置系统会有一些困难，但是更有经验的用户会喜欢这种方式的透明性和灵活性。

     2. Slackware没有如RPM之类的成熟的软件包管理器。

     Slackware的软件包都是通常的tgz(tar/gzip)格式文件再加上安装脚本。Tgz对于有经验的用户来说，比RPM更为强大，并避免了RPM之类管理器的依赖性问题。 

     Slackware Linux系的发行版包括：

     1. SUSE Linux

        SUSE”，德文”Software- und System-Entwicklung”，其英文为”Software and system development” 。广义上SUSE Linux是一系列Linux发行版。最典型的即为OpenSUSE。

     2. Vector Linux

        Vector Linux 是一份小巧快捷的、基于Intel处理器的PC机Linux操作系统。Vector Linux的创建者们有一则简单的信条：简单、小巧，并让最终用户决定他们的操作系统成为什么样子。 

- **新兴分支**

  1. Arch Linux

     系统主要由自由和开源软件组成，支持社区参与。系统设计以KISS原则（保持简单和愚蠢）为总体指导原则，注重代码正确、优雅和极简主义，期待用户能够愿意去理解系统的操作。 

     Arch Linux 系统安装、删除和更新软件的软件包管理器叫做 pacman。

     相比其他发行版，Arch Linux 属于轻量级选手，其简单的设计让它容易被轻松扩展和配置成为任何想要的系统类型。 

  2. Gentoo
  
     Gentoo是Linux世界最年轻的发行版本，正因为年轻，所以能吸取在它之前的所有发行版本的优点，这也是Gentoo 被称为伟大、完美的Linux发行版本的原因之一。 


### 笔者个人对选择Linux发行版的理解

既然，本质上来说，Linux出名的就那么几种：Debian系、RedHat系、Arch Linux系、Open SUSE系。其他的发行版基本都是从这几个Linux衍生出来的(当然，也有一些可以说是独自建立的发行版比如英特尔的Clear Linux这种)，它们的唯一区别就在于包管理器的不同，那么，Llinux发行版的优先级建立只有两个因素：基于什么类别的发行版、使用体验怎么样。 

我个人针对Linux初学者的推荐如下：

1. Deepin OS
   优点：
   - 它是一个国内推出的发行版，所以相对于多数发行版来说，其本地化体验会有相当的提升。
     其软件商店包含了很多国内常用的软件如QQ、微信、百度云。
   - 其社区的中文用户量也算是比较庞大的，如果在使用中遇到问题，可以很方便的寻求答案。 
   
   缺点：
   
   - 软件版本更新比较中庸。
   - 系统整体谈不上稳定。
   - 社区的中文用户平均质量不高。
   
2. Ubuntu

   优点：

   - 可以把Ubuntu理解成Linux中的Windows：技术成熟、社区庞大，开箱即用。即使有一些软件在自带的软件商店找不到，同样可以去官方网站搜索。如果这个软件支持Linux，那么它一定会提供deb格式的安装包。

      > 但这个deb很大可能只能装在Ubuntu上而不能装在Ubuntu的父亲Debian上。因为Ubuntu虽然基于Debian，但它拥有自己的软件仓库，相对于Debian同样软件的版本要新。

   - Ubuntu拥有自己的显卡驱动方案，在英伟达和英特尔核显双显卡的笔记本上技术是比较成熟的。

   缺点：

   - 相当一部分Deepin上移植的国内的软件Ubuntu还没有，即使有，其安装过程也比较麻烦。
   - Ubuntu经常会出现恼人的“发送错误报告”窗口。
   - 因为Ubuntu不是滚动更新，所以如果不是用长期支持版本的话，每半年就会有新的版本推送。这个更新是较为危险的，很可能会更新失败而无法使用。

3. Manjaro

   Manjaro是基于Arch Linux的发行版，最大的特点就在于完全图形化和自动化了Arch Linux的安装过程，并且拥有一系列图形化的驱动和内核配置软件，这使得用户既可以享受到Arch Linux分支的各种优势，又可以一键设置驱动，亦能根据不同的使用条件而部署不同类型的内核，还不必花费大量时间阅读Arch Wiki来安装系统及从全文本界面逐步配置起图形界面。

    **注：新兴分支Arch Linux的优势：**

    1. Arch Linux发行版的软件相比其他分支的发行版总是最新的，这得益于Arch近乎简陋的包管理工具，没有版本范围限制的Arch系总是可以毫无顾忌的把软件包更新到最新。 

        > 但Arch Linux更新到最新同样可能出现一些意料之外的bug，所以Manjaro调慢了更新速度，一般是在Arch Linux更新的两个礼拜后Manjaro才会跟进这个版本的更新，如果这过程中出现了问题，Manjaro还会暂停版本的跟进。所以，可以说Manjaro消除了Arch Linux用户“滚挂”的顾虑。 

    2. Arch Linux特有的AUR软件仓库，使得几乎所有你能想到的软件都可以通过一条命令完成安装，而这条命令Manjaro还给图形化了。所以这相对于Ubuntu还需要去网上下载来讲简单了太多。 

4.  Pop！OS

   如果有较多的游戏需求，pop！OS这个基于Ubuntu的发行版可能个不错的选择。相对于前边三个发行版，Pop! OS开箱即配置好了游戏环境——我指的是Windows游戏。要知道，自己在Linux下配置一个完善的Windows游戏环境是很困难的。此时这个系统的优势便体现了出来：通过内置软件一键装好显卡驱动后便可直接运行。 

   当然，读者最好还是按照之前已经提到的态度，那就是不用Linux做无意义的事情。

还有一些关于渗透测试的Linux发行版需要说明：

1. Kali Linux

   Kali 是一个基于 Debian Testing 的 Linux 发行版。该系统里包含了很多高级渗透测试和审计工具。大多数做安全测试的开源工具都被囊括在内。 这是黑客（或者自称黑客）的必备工具之一。它带有一套安全和计算机取证工具。其特色在于及时的安全更新，对ARM架构的支持，有四种流行的桌面环境供选择，以及能平滑升级到新版本。 

   Kali Linux 在渗透测试和白帽子方面是业界领先的。该发行版附带的大量入侵和渗透的工具和软件在全世界都得到了广泛认可，即使在那些甚至可能不知道 Linux 是什么的 Windows 用户中也是如此。 

   > 注：
   >
   > 1. Kali Linux不适合初学者， 每一个工具必须小心使用。
   > 2. Kali 的内核和软件都与Debian有异，即使它是基于Debian的。
   > 3. Kali Linux不适合安装在物理机，因为容易被攻击。

2. Parrot Linux

   Parrot Security OS 是基于 Debian Testing 的面向安全的操作系统，它被设计为用于渗透测试、计算机取证、反向工程、攻击、云计算渗透测试、隐私/匿名、密码等场合。 其特色在于MATE桌面环境。

   Parrot 采用 Kali 的软件库来更新大部分工具，不过也有提供其自己的定制软件的软件库。它不只是一个简单的 Kali 修改版，而是一个建立在 Kali 工具库之上的新系统，因此，它引入了许多新功能和不同的开发选择。 

### 相对客观的选择Linux发行版

你可能会发现我并没有推荐RedHat系的发行版以及openSUSE。这主要是因为我很少接触这两个分支。如果想要较为客观的选择发行版，可以尝试这两种方法。 

1. 参阅[distrowatch.com](https://distrowatch.com/) 

   注：该网站可能受到墙限制而无法打开。 

   该网站聚合了几乎所有的类Unix发行版，并且根据点击量有一个排名列在这里。自然排名越高就说明热度越高，进而也能有一定的参考价值。但可以肯定的是，这里边肯定会有刷榜的情况出现，而且它也仅仅是展现了distrowatch用户的一个倾向，所以对你来说可能仅仅是一个参考作用。

2. 参阅[Distro Chooser](https://distrochooser.de/zh-cn/) 

   这是一个在线调查网站。它拥有中文页面，只需要根据自己的情况回答好16个问题，便可以给出一些适合你的Linux发行版。相对来说可以得到一个比较客观的结果，可以供你参考一下。如果你不喜欢听别人的主观意见，自己又不好决定，那么可以来这个网站来试一试。 

总体来讲，关于如何选择发行版这个问题可能仅仅对刚刚接触的人有参考价值。真正试用过一段时间Linux就应该能明白，在发行版上面纠结其实并没有什么太大的用处。得益于Linux的高度自定义性，你可以把任何一个发行版改造成你想要的样子，提前选择仅仅是为了省去改造的这个过程而已。但如果是初次接触，那么选择一个适合自己的发行版来使用，也许能体会到“一见钟情”的感觉吧。

*注：以下是2020.2.18日的更新内容。*

相信很多Linux初学者在接触Linux伊始都会和我一样折腾很多Linux的发行版，Linux的发行版千差万别。我对于任何刚接触Linux的人对Linux发行版的意见是：任何发行版都没有关系。因为它们是社会结构，一旦你获得了一定的Linux技能，理解人们在谈论发行版的任何问题都会变得非常容易。这是我对Linux发行版的一贯立场。

但现在我不再会这样认为了。如果现在让我选择一个我心目中最好的Linux发行版，同时也是最简单的Linux发行版，作为长期甚至终身使用的Linux——答案可能会让你吃惊，我会选择的发行版是：Arch Linux！

尽管入门可能会有难度，但它比任何其他的发行版都要好，它可以避免管理其他任何系统时所不得不忍受的痛苦。人们通常会想到入门难度，但最重要的其实是**终身难度**。同时，Arch Linux比其他发行版**更有可能改变人们对Linux发行版的看法**。

## UNIX/Linux经典哲学摘录

### UNIX哲学

**Everything (including hardware) is a file.**
所有的事物（甚至硬件本身）都是一个的文件。

**Configuration data stored in text.**
以文本形式储存配置数据。

**Small, single-purpose program.**
程序尽量朝向小而单一的目标设计。

**Avoid captive user interfaces.**
避免过于复杂花哨的界面。

**Ability to chain program together to perform complex tasks.**
将几个程序连结起来，处理大而复杂的工作。

*下面三句是UNIX程序设计的准则。*

**Write programs that do one thing and do it well.**
写“一次只做一件事，并能把这件事做好”的程序。

**Write programs to work together.**
写“互相协作（调用）”的程序。

**Write programs to handle text streams, because that is a universal interface.**
写“处理文件流”的程序。因为这（处理文件流）是一个通用接口。

### *The Art Of Unix Programing* 哲学

**Rule of Modularity: Write simple parts connected by clean interfaces.**
模块化原则：写简单的，能够用清晰的接口连接的代码。

**Rule of Clarity: Clarity is better than cleverness.**
清晰化原则：清晰的代码要好过“聪明”的代码。

**Rule of Composition: Design programs to be connected to other programs.**
组件化原则：设计可以互相关联（拆分）的程序。

**Rule of Separation: Separate policy from mechanism; separate interfaces from engines.**
隔离原则：策略和机制分离，接口和引擎分离。

**Rule of Simplicity: Design for simplicity; add complexity only where you must.**
简洁原则：设计力求简洁，直到无法更简洁。

**Rule of Parsimony: Write a big program only when it is clear by demonstration that nothing else will do.**
小巧原则：不要写大的程序（模块、方法）。除非很明显的，没有别的办法可以完成。

**Rule of Transparency: Design for visibility to make inspection and debugging easier.**
透明原则：为可见性设计，使检查和调试更容易。

**Rule of Robustness: Robustness is the child of transparency and simplicity.**
健壮性原则：健壮性是透明和简单的孩子。

**Rule of Representation: Fold knowledge into data so program logic can be stupid and robust.**
陈述性原则：将认知转化为数据。所以，程序的逻辑可以是愚蠢（简单易懂）的，健壮的。

**Rule of Least Surprise: In interface design, always do the least surprising thing.**
最少的惊讶原则：在界面设计中，少做令人惊讶的设计。（不要标新立异）

**Rule of Silence: When a program has nothing surprising to say, it should say nothing.**
沉默原则：如果一个程序没有什么特别的东西要说（输出），那就什么都别说。

**Rule of Repair: When you must fail, fail noisily and as soon as possible.**
修复原则：如果必须失败，那就尽早。

**Rule of Economy: Programmer time is expensive; conserve it in preference to machine time.**
节约原则：程序员的时间是非常宝贵的。程序员的时间（编程时间）优于机器时间。

**Rule of Generation: Avoid hand-hacking; write programs to write programs when you can.**
生产原则：避免手工编程。如果可以的话，编写可以编写程序的代码。

**Rule of Optimization: Prototype before polishing. Get it working before you optimize it.**
优化原则：建立原型后再去修正。当它能正常工作后，再去优化它。

**Rule of Diversity: Distrust all claims for “one true way”.**
多样性原则：怀疑所有所谓的“不二法门”。

**Rule of Extensibility: Design for the future, because it will be here sooner than you think.**
扩展原则：为未来设计，因为未来来的比你想象的要早。

### X Window哲学

**Small is beautiful.**
小即是美。

**Make each program do one thing well.**
让每个程序（方法）只做一件事情，并把它做好。

**Build a prototype as soon as possible.**
尽早建立原型。

**Choose portability over efficiency.**
注重可移植性，而非效率。

**Store data in flat text files.**
将数据存储在存文本文件中。

**Use software leverage to your advantage.**
利用软件来发挥你的优势。

**Use shell scripts to increase leverage and portability.**
使用Shell脚本提高编程的手段和程序的可移植性。

**Avoid captive user interfaces.**
避免过于复杂花哨的界面。

**Make every program a filter.**
使每个程序（方法）称为一个过滤器（筛选器）。

