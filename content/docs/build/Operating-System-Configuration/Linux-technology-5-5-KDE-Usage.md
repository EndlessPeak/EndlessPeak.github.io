---
title: Linux KDE 桌面使用指南
date: 2023-03-18 22:00:00
authors:
  - EndlessPeak
toc: true
hidden: false
draft: false
weight: 5
description: 本文记录在Linux KDE桌面环境下的一些常用配置过程。
---

## Plasma Configuration {#plasma-configuration}

如果 KDE 的外观设置下载缓慢，可以在 [KDE 商店](https://store.kde.org/) 中下载。


### Global Theme {#global-theme}

1.  全局主题安装在 `~/.local/share/plasma/look-and-feel` 下，其包括 `layouts` 和 `splash` 等部分
2.  一般地，安装全局主题后会自动配置 Plasma 主题和 Colors 等部分


### Plasma Theme {#plasma-theme}

Plasma 主题安装在 `~/.local/share/plasma/desktoptheme` 下


### Colors {#colors}

Colors 安装在 `~/.local/share/color-schemes` 下


### Splash Screen {#splash-screen}

1.  开机加载画面安装在 `~/.local/share/plasma/look-and-feel` 的全局主题包中 `splash` 下
2.  其中 `background.png` 是加载画面的背景图，=logo.svg= 是图片中心的图标


### Icon {#icon}

1.  NixOS 的主题图标在 `/nix/store/<sha256>-nixos-icons-<date>/share/icons` 下，可以用 `fuzzy file finder` 寻找
2.  plasma 的图标在 `~/.local/share/icons` 下


### Backgrounds {#backgrounds}

1.  记录壁纸的配置文件在 `~/.config/plasmarc` 中
2.  背景可在 [FreePik](https://www.freepik.com/) 中下载。


## Dolphin {#dolphin}


### Mode {#mode}

按空格可以进入多选模式，再按依次推出该模式


### Panel {#panel}

1.  Dolphin 左侧视图为 panel，通过 `"View"-"Show panels"` 可以查看所有的 panel.
    1.  places 提供常用的导航路径；
    2.  folder 提供当前位置的视图；
    3.  information 显示当前 folder 的信息；
2.  places
    1.  提供 `XDG user directories` 导航；
    2.  提供远程位置、最近文件、按类别查找和设备的导航；
    3.  通过右键点击 places 空白处可以新增 Entry，新增导航到指定位置的条目；
    4.  Dolphin 关于 places 的配置文件位于 `/.local/share/user-places.xbel`
    5.  Dolphin 关于 recent files 的配置文件位于 `/.local/share/recently-used.xbel`


### Context menu {#context-menu}

1.  Dolphin 右键菜单的提供的内容称为 `Context Menu` ，通常用户设置的内容归到 `Actions` 中。
2.  Context Menu 配置：
    1.  Dolphin 关于 Context Menu 的配置文件位于 `/usr/share/kservices5/` 中，用户自定义的配置位于 `~/.local/share/kservices5` 中（如不存在可以新建）；
    2.  假如需要新增一项为“在此处打开 Alacritty ”，可以新建 `alacrittyhere.desktop` 文件，并编辑以下内容：
        ```text
        [Desktop Entry]
        Type=Service
        X-KDE-ServiceTypes=KonqPopupMenu/Plugin,inode/directory
        Actions=openAlacrittyHere;
        X-KDE-AuthorizeAction=shell_access

        [Desktop Action openQTerminalHere]
        Name=Open alacritty here
        Icon=Alacritty
        Exec=alacritty --working-directory %f
        ```
        特别地，

        1.  在 `NixOS` 中，alacritty 位于 `/etc/profiles/per-user/<username>/bin` 或 `/run/current-system/sw/bin` 中

        2.  `alacritty` 需要指定的工作目录参数为 `--working-directory` ，而一般的 terminal 则需要指定 `--workdir` 。
3.  Dolphin 对 Context Menu 中的内容修改的方式为 `"Settings"-"Context Menu"` 进行增删。
