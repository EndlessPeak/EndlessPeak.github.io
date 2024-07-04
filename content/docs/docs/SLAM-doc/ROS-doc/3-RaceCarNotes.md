---
title: Race Car Project
authors:
    - EndlessPeak
toc: true
date: 2022-11-11
hidden: false
draft: false
weight: 3
description: 本文主要记录ROS小车比赛项目的进展和相关笔记。
---

## Project {#project}


### Init Project {#init-project}

从 github 上克隆代码，以此作为工作目录，克隆完成后进入工作目录。

```shell
git clone https://github.com/endlesspeak/rosracecar Racecar_ws
cd Racecar_ws
```

配置环境变量，以便每次启动项目不必切换到工作目录。编辑 `~/.bashrc`

```shell
source ~/Racecar_ws/devel/setup.bash
```


### Run Project {#run-project}

通过键盘控制测试小车，开启三个标签终端，依次执行下面的命令。

```shell
roslaunch bringup racecar.launch
rosrun racecar_description servo_commands.py
rosrun racecar_description keyboard_teleop.py
```
