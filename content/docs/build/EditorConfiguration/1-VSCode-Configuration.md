---
title: VSCode Configuration
date: 2024-01-19 22:00:00
authors:
  - EndlessPeak
toc: true
hidden: false
draft: false
weight: 1
description: 本文主要讨论在 Linux 下如何配置 VSCode 。
---

## Installation {#installation}

参考 [Visual Studio Code Installation](https://code.visualstudio.com/docs/setup/linux)


### Deb install {#deb-install}

从官网下载 deb 包，使用命令安装

```shell
sudo dpkg -i code_XXX_amd64.deb
sudo apt install ./code_XXX_amd64.deb
```

使用 `apt install` 命令安装后会自动将该软件的 apt 存储库和签名密钥添加到系统包管理器中，其位于 `/etc/apt/keyrings/packages.microsoft.gpg` 。

也可以从官网手动添加 apt 存储库和签名密钥，然后更新包缓存安装。


### Rpm install {#rpm-install}

从官网下载 rpm 包，使用命令安装

```shell
sudo dnf install code_XXX_amd64.rpm
```

也可以从官网手动添加，注意 `dnf` 和 `yum` 并不支持自动识别和添加存储库及密钥。


### Package Manager {#package-manager}

建议从软件包管理器提供的软件安装。


## Open with Code {#open-with-code}


### Gnome {#gnome}

Gnome 环境的文件管理器是 `nautilus` ，有两种方法配置：


#### Python Extension For Nautilus {#python-extension-for-nautilus}

运行命令：

```shell
wget -qO- https://raw.githubusercontent.com/harry-cpp/code-nautilus/master/install.sh | bash
```

或首先手动下载 [Github:harry-cpp/code-nautilus](https://github.com/harry-cpp/code-nautilus) 仓库，然后本地执行。


#### Filemanager Actions {#filemanager-actions}

安装 `filemanager-actions` ，使用 `fma-config-tool` 进行配置。

需要注意目前该包由于缺乏更新已被归档，替代产品见 [Actions for nautilus](https://github.com/bassmanitram/actions-for-nautilus) 。


### KDE {#kde}

在 `~/.local/share/kservices5/ServiceMenus/` 下添加 `.desktop` 文件并编辑。

对于 `edit code here` ，内容为：

```desktop
[Desktop Action opencodeossfile]
Exec=code %F
Icon=vscode
Name=Edit with Code - OSS

[Desktop Entry]
Actions=opencodeossfile
MimeType=text/plain;application/octet-stream;
ServiceTypes=KonqPopupMenu/Plugin
Type=Service
X-KDE-Priority=TopLevel
```

对于 `open code here` ，内容为：

```desktop
[Desktop Action opencodeossdir]
Exec=code %F
Icon=vscode
Name=Open with Code - OSS

[Desktop Entry]
Actions=opencodeossdir
MimeType=inode/directory;
ServiceTypes=KonqPopupMenu/Plugin
Type=Service
X-KDE-Priority=TopLevel
```


## Configuration {#configuration}


### Trust {#trust}

该功能位于 Security→Workspace→Trust

1.  Enable 选项控制是否开启信任功能
    ```json
    "security.workspace.trust.enabled": false,
    ```
2.  Empty Window 选项控制是否默认信任空窗口
3.  Untrusted Files 选项控制如何打开默认不信任的文件


### Title {#title}

该功能位于 Window 部分

1.  标题栏组成：Title ，包含多个组件
2.  标题栏显示样式：Title Bar Style ，包含 native 和 custom 两种


### Font {#font}


#### Zoom {#zoom}

此部分用于更改全局缩放大小。


#### Editor Font {#editor-font}

此部分更改字体大小仅对编辑区的字体生效，且需要字体本身支持以下属性。

1.  font Ligatures
    字体连字通常用于美化代码和提高可读性，如 Fira Code 和 Operator Mono，都支持连字特性。
    ```json
    "editor.fontLigatures": true,
    ```

2.  Font Variations（字体变化）
    字体变化是指使用不同的字体变体来显示不同的字形或字符，需要可变字体。
    ```json
    "editor.fontVariations": "'wdth' 93, 'wght' 90, 'GRAD' 88",
    ```
3.  Font Weight（字体粗细）
    字体粗细是指字体的粗细程度，可以通过 `normal` 或 `bold` 等关键字或从 1-1000 的数字值控制。
