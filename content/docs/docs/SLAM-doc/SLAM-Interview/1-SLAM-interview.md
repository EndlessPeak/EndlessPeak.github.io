---
title: SLAM Interview
author: 
    - EndlessPeak
date: 2024-05-28
toc: true
featuredImage: 
hidden: false
draft: false
weight: 1
description: SLAM常见问题整理
---

## SLAM Problems
### Matrix and Sophus

1.  求导 $ \frac{\partial R\_1R\_2}{\partial R\_1} $
2.  简述李群和李代数的关系。
3.  给定 \\((H,W)\\) 图像或者 matrix，问如何去访问每一个元素，是先访问行呢？还是先访问列？跟缓存还有关系~


### Sensors Model

1.  除了视觉传感，还用过其他传感器吗？比如 GPS，激光雷达
2.  写出单目相机的投影模型，畸变模型。
3.  你认为室内 SLAM 与自动驾驶 SLAM 有什么区别？
4.  如何标定 IMU 与相机之间的外参数？
5.  在给定一些有噪声的 GPS 信号的时候如何去精准的定位？
6.  如果把一张图像去畸变，写公式，流程。


### Non liear Optimize

1.  熟悉 Ceres 优化库吗？简单描述一下。
2.  描述（扩展）卡尔曼滤波与粒子滤波，你自己在用卡尔曼滤波时遇到什么问题没有？


### Loop Closure

1.  什么是闭环检测？常用的方法有哪些？你用的哪种方法？有没有创新？


### Mapping

1.  地图点的构建方法有哪些？
2.  3D 地图点是怎么存储的？表达方式？


### Visual Odometry

1.  如果对于一个 3D 点，我们在连续帧之间形成了 2D 特征点之间的匹配，但是这个匹配中可能存在错误的匹配。请问你如何去构建 3D 点？
2.  说一下 3D 空间的位姿如何去表达?
3.  什么是 Essential，Fundamental 矩阵？
4.  给两组已经匹配好的 3D 点，计算相对位姿变换。已知匹配的 ICP 问题，写代码。
5.  ORB-SLAM 初始化的时候为什么要同时计算 H 矩阵和 F 矩阵？
6.  计算 H 矩阵和 F 矩阵的时候有什么技巧呢？实际上在问归一化的操作。
7.  ORB-SLAM 中的特征是如何提取的？如何均匀化的？
8.  什么是 ORB 特征，ORB 特征的旋转不变性是如何做的，BRIEF 算子是怎么提取的。


### Backend

1.  有哪几种鲁棒核函数？
2.  RANSAC 在选择最佳模型的时候用的 metric 是什么？
3.  除了 RANSAC 之外，还有什么鲁棒估计的方法？
4.  给你 m 相机 n 个点的 bundle adjustment 当我们在仿真的时候，在迭代的时候，相机的位姿会很快的接近真值。而地图点却不能很快的收敛这是为什么呢？
5.  解释一下 Gauss-Netwon 和 LM 算法。
6.  LM 算法里面那个 $&lambda; $ 是如何变化的呢？


### Other Problems

1.  什么是紧耦合、松耦合？优缺点。
2.  RGB-D 的 SLAM 和 RGB 的 SLAM 有什么区别？
3.  谈谈自己熟悉的 SLAM 算法，Lidar/Visual slam，说优缺点。
4.  读 Maplab，设计室内服务机器人地图更新的方法、流程。
5.  安装 2D lidar 的平台匀速旋转的时候，去激光数据畸变，写代码

说一下 Dog-Leg 算法
什么是边缘化？First Estimate Jacobian？一致性？可观性？
说一下 VINS-Mono 的优缺点
你做的工作在本质上有什么不同，贡献，创新本质上在哪里？
给定几个连续帧的带有位姿的帧，如何去测量车道线相对于世界坐标系的坐标。
给你 xx 误差的 GPS，给你 xx 误差的惯导你怎么得到一个 cm 级别的地图。
给一组点云，从中提取平面。
给一张图片，知道相机与地面之间的相对关系，计算出图的俯视图。
双线性差值如何去做，写公式。
机器人从超市门口出发，前往 3 公里外的小区送货。请你设计一个定位系统，包括传感器的配置、算法的流程，用伪代码写出来。


## Algorithms and Datastructure


### C Plus Plus

1.  多线程的实现方式
2.  std::vector 描述一下，如何动态扩展，如何 shink 内存
3.  Eigen 是行优先还是列优先
4.  unorder 容器与 ordered 容器的区别
5.  说一下 Mat 是如何析构的
6.  说一下智能指针，shared_ptr 与 unique_ptr
7.  说一下什么是虚函数
8.  普通指针如何实现一块内存只能有一个指针指向这种功能
9.  C++ RTTI 是什么东西？
10. C++是如何实现多态的？
11. vector 的 iterator 什么时候失效？
12. 写 CmakeLists.txt，写 gcc 指令


### Data Structure & Algorithms

1.  写一个四叉树的结构
2.  不用递归遍历二叉树
3.  重建二叉树
4.  求最大连通域
5.  一个图，给出两个一对的若干节点对，求两个节点之间的通路。
6.  实现一个稀疏矩阵的数据结构，并实现稀疏矩阵的加法。
7.  棋盘格，每个格子角点上有一个灯，按一下周围四个灯就会取反。开始的时候这个棋盘格上灯状态随机，问如何操作这些按钮可以使得整个棋盘全灭。
8.  编一个二分查找
9.  给你一个数组去排序，说排序算法
10. 给你 2D 平面的两个线段，判断两个线段是否相交
11. 写快速排序、写反转链表
12. 给两个排序数组，升序的。一个大小为 n，一个大小为 m。从中找出第 k 小的数字。


### Frame Structure

1.  ORB-SLAM 的共视图是什么结构？内部如何存储的？


## Learning Resources

1.  [Easy SLAM and Robotic Tutorial](https://github.com/varyshare/easy_slam_tutorial)
2.  [Deep Learning Interview Book(Include Slam)](https://github.com/amusi/Deep-Learning-Interview-Book/tree/master)
3.  未完待续
