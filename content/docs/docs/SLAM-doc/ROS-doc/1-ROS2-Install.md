---
title: ROS2 Installation
authors:
    - EndlessPeak
toc: true
date: 2023-10-08
hidden: false
draft: false
weight: 2
description: 本文记录了ROS2安装过程。
---

## Install ROS2 by one command {#install-ros2-by-one-command}


### fishros {#fishros}

可用 `fishros` 提供的实用程序一行代码在 `ubuntu` 上安装 ROS2。

```shell
wget http://fishros.com/install -O fishros && . fishros
```


### global view {#global-view}

总体来看，它的安装流程包含如下命令:

```shell
mkdir -p /tmp/fishinstall/tools
wget http://fishros.com/install/install1s/install.py -O /tmp/fishinstall/install.py 2>>/dev/null
source /etc/profile
sudo apt install python3-distro python3-yaml  -y
if [ $UID -eq 0 ];then
    apt-get install sudo
fi
sudo python3 /tmp/fishinstall/install.py
sudo rm -rf /tmp/fishinstall/
sudo rm fishros
. ~/.bashrc
```


### install steps {#install-steps}

安装步骤是下载 `install.py` 文件，执行它的过程中会自动下载两个以上的python文件：

1.  `base.py` 在该文件中定义了下载的各项命令，它会执行 `wget / curl / apt` 等命令
2.  用户请求的功能文件，当用户请求下载ROS2，则它会下载 `tool_install_ros.py` 文件


## Install ROS2 Manually {#install-ros2-manually}


### add software source {#add-software-source}

1.  `dpkg --print-architecture` 会显示当前操作系统的架构
2.  `lsb-release -cs` 会显示当前操作系统(Linux发行版)的代码名称
3.  `/usr/share/keyrings` 保存的是密钥环文件，软件在安装之前都需要密钥环签名才能验证软件是可信的，否则可能拒绝软件的安装。

使用下面的命令获取密钥环文件：

```shell
sudo apt install curl gnupg2
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg
```

使用下面的命令添加软件源：

```shell
echo "deb [arch=$(dpkg --print-architecture)] signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] https://mirrors.tuna.tsinghua.edu.cn/ros2/ubuntu $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

sudo apt update
```


### install ROS2 {#install-ros2}

1.  安装针对ROS的开发工具，这一步是可选的
    ```shell
    sudo apt install ros-dev-tools
    ```

2.  安装 ROS2的桌面版软件包组
    ```shell
    sudo apt update
    sudo apt upgrade
    # iron now is the latest distribution
    # galactic is also available
    sudo apt install ros-humble-desktop-full
    ```


### setup environment {#setup-environment}

每次执行诸如 `ros2` 等相关命令时，需要提前将其可执行目录导入到环境中。

1.  手动执行下面的命令
2.  将命令添加到 `bashrc` 或 `zshrc` 中

<!--listend-->

```shell
source /opt/ros/humble/setup.bash
source /opt/ros/humble/setup.zsh
```

也可以将它的快捷执行命令添加到 `shell` 的配置文件中。

```shell
alias sros2='source /opt/ros/humble/setup.zsh'
```


## Try ROS2 {#try-ros2}

以下内容中的操作命令均需要在不同的终端页(tab)中执行，或者使用终端复用工具。


### demo nodes test {#demo-nodes-test}

打开两个进程，一个用于接受信息，一个用于发送信息。

```shell
ros2 run demo_nodes_py listener
ros2 run demo_nodes_py speaker
```

可以将 `demo_nodes_py` 改为 `demo_nodes_cpp`


### turtlesim {#turtlesim}

首先运行小海龟的节点，然后运行键盘控制程序。

```shell
ros2 run turtlesim turtlesim_node
ros2 run turtlesim turtle_teleop_key
```


### rqt {#rqt}

打开 `rqt` ，选择 `introspection` -&gt; `Node Graph` 插件。
