---
title: RK3588 远程连接
toc: true
authors:
  - EndlessPeak
date: 2024-07-01
hidden: false
draft: false
weight: 3
description: 本文记录了如何远程连接 RK3588 开发板上的系统。
---

要使用 KRDC（KDE Remote Desktop Client）连接到 RK3588 嵌入式开发板，可以按以下步骤操作：

## XRDP Install
在 RK3588 嵌入式开发板上设置远程桌面服务

首先，安装 xrdp（远程桌面协议服务）：

```bash
sudo apt update
sudo apt install xrdp
```

然后，启动 xrdp 服务：

```bash
sudo systemctl enable xrdp
sudo systemctl start xrdp
```

检查 xrdp 服务状态：

```bash
sudo systemctl status xrdp
```

确认服务正在运行。

配置防火墙（如有必要）：
确保防火墙允许 3389 端口上的流量，这是 xrdp 的默认端口。

```bash
sudo ufw allow 3389
```

## KRDC Connect
安装 KRDC：
如果还没有安装 KRDC，可以使用以下命令进行安装：

```bash
sudo apt update
sudo apt install krdc
```

启动 KRDC：
在终端中运行 krdc 或者从应用程序菜单中找到并启动 KRDC。

连接到开发板：

在 KRDC 界面中，输入开发板的 IP 地址，并选择 RDP 作为协议。例如，输入 rdp://192.168.x.x（替换为开发板的实际 IP 地址）。

点击连接，输入开发板的用户名和密码进行验证。

注意事项
1. IP 地址： 确保你的 PC 和开发板在同一个网络中，并且可以相互通信。可以通过命令 ifconfig 或 ip addr 检查开发板的 IP 地址。
2. 用户权限： 确保远程连接的用户有足够的权限，并且防火墙设置正确以允许远程连接。
通过这些步骤，你应该能够使用 KRDC 从你的 PC 连接到 RK3588 嵌入式开发板的远程桌面。