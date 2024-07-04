---
title: Intergrate Environment
authors:
    - EndlessPeak
toc: true
date: 2022-10-25
hidden: false
draft: false
weight: 3
description: 本文主要讨论ROS例程以及如何构建ROS集成开发环境。
---

## ROS HelloWorld {#ros-helloworld}


### Create Project {#create-project}

创建项目的顺序如下：

1.  创建工作空间
    将工作空间命名为 `ROSRace`
    ```shell
    mkdir -p ROSRace/src
    cd ROSRace
    catkin_make
    ```
2.  创建功能包
    将功能包命名为 `helloworld` ，并添加所需的依赖。

    1.  roscpp 是用 C++ 实现的库；
    2.  rospy 是用 python 实现的库；
    3.  std_msgs 是标准消息库

    <!--listend-->

    ```shell
    cd src
    catkin_create_pkg helloworld roscpp rospy std_msgs
    ```


### Edit Source File {#edit-source-file}

1.  编辑源文件(C++)
    ```shell
    cd helloworld/src
    vim helloworld_c.cpp
    ```
    输入以下内容：
    ```cpp
    //包含ros的头文件
    #include "ros/ros.h"
    //编写main函数
    int main(int argc,char* argv[]){
        //执行ros节点初始化
        ros::init(argc,argv,"hello_node");
        //创建ros节点句柄，非必须
        ros::NodeHandle n;
        //控制台输出日志
        ROS_INFO("hello world!");
        return 0;
    }
    ```

2.  编辑源文件(Python)
    ```shell
    cd helloworld
    mkdir scripts # python 文件必须在该文件夹下
    ```
    输入以下内容：
    ```python
    #! /usr/bin/env python

    """
        Python 版 HelloWorld

    """
    import rospy

    if __name__ == "__main__":
        rospy.init_node("Hello")
        rospy.loginfo("Hello World!!!!")

    ```

    ```shell
    chmod +x helloworld_py.py
    ```
3.  编辑配置文件(C++)
    编辑功能包下的 cmake 文件，~vim CMakeLists.txt~ ，修改以下内容:
    ```text
    add_executable( ${PROJECT_NAME}_node
      src/helloworld_c.cpp
    )
    target_link_libraries( ${PROJECT_NAME}_node
      ${catkin_LIBRARIES}
    )
    ```
    注意：

    1.  如 `add_dependencies` 未注释，则注释该项
    2.  需要修改源文件名与 `add_executable` 中的内容一致
    3.  如需修改生成的可执行文件名，可修改 `project(helloworld)` 中的内容

4.  编辑配置文件(Python)
    ```shell
    catkin_install_python(PROGRAMS scripts/helloworld_py.py
      DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
    )
    ```


### Compile and Excute {#compile-and-excute}

编译并执行步骤如下：

1.  回到工作空间目录
2.  输入 `catkin_make` 编译所有 C++ 内容，python 文件是即时解释执行不需要编译
3.  执行下面的命令，特别地，如不执行第二行，则会报找不到 `helloworld` 包。
    ```shell
    roscore
    source ./devel/setup.bash # use zsh if you need
    # C++
    rosrun helloworld helloworld_node # Package_name + target_name
    # Python
    rosrun helloworld helloworld_py.py
    ```


### Locale {#locale}

解决乱码问题，以下方法任选一种。

1.  在 cpp 源文件中加入一行 `setlocale(LC_ALL,"");`
2.  在 cpp 源文件中加入一行 `setlocale(LC_ALL,"zh_CN.utf8");`


## Terminal Reuse {#terminal-reuse}

在 ROS 中，需要频繁的使用到终端，且需要同时开启多个进程，因此需要用到终端复用工具。

1.  terminator
2.  tmux


## VSCode {#vscode}


### Extensions {#extensions}

首先建议 VSCode 安装原版而非开源的社区驱动版本，便于下载插件。

其次建议安装下列插件：

1.  C/C++
2.  Python
3.  ROS
4.  CMake

为使界面显示正常，=Arch Linux= 建议安装 `ttf-ms-font`


### Usage {#usage}

1.  创建工作空间和 HelloWorld 的步骤一样。
2.  编译 ROS 可使用快捷键 `Ctrl+Shift+B` 调用，选择 `catkin_make:build` ，点击右侧的齿轮，会自动生成 `.vscode/task.json` ，点击修改

    注意：如修改为下列内容
    ```js
    "type" : "shell",
    "command" : "catkin_make",
    ```
    则表示执行命令为 `/usr/bin/zsh -c '...'` ，通常该形式的命令不会从 .zshrc 中加载，因而不包含 `/opt/ros/noetic/bin` 环境变量

3.  对工作空间的 src 右键点击 `create catkin packages` 可以创建功能包，回答包名和依赖即可
4.  修改 `.vscode/c_cpp_properties.json` 的内容
    ```js
    "cStandard" : "gnu17",
    "cppStandard" : "c++17"
    ```


### Launch {#launch}

使用 launch 一次性启动多个 ros 节点

1.  选择功能包，右击，添加一个 launch 文件夹
2.  选定 launch 文件夹，右击，添加一个 launch 文件，如 `start_turtle.launch`
3.  编辑 launch 文件内容
    ```cfg
    <launch>
        <!--添加被执行的节点-->
        <!--乌龟GUI-->
        <node pkg="turtlesim" type="turtlesim_node" name="turtle_GUI" />
        <!--乌龟键盘控制-->
        <node pkg="turtlesim" type="turtle_teleop_key" name="turtle_key" />
        <!--HelloWorld-->
        <node pkg="helloworld" type="helloworld_node" name="hello" output="screen" />
    </launch>
    ```
    其中：

    1.  node 是包含的某个节点
    2.  pkg 是功能包
    3.  type 是被运行的节点文件
    4.  name 是为节点命名
    5.  output 设置日志的输出目标
4.  运行 launch 文件
    ```shell
    roslaunch helloworld start_turtle.launch
    ```
