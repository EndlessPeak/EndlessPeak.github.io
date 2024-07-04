---
title: SLAM Evaluation
authors: 
    - EndlessPeak
toc: true
date: 2024-03-30
featuredImage: 
hidden: false
draft: false
weight: 120
description: 本文记录了SLAM中的EVO轨迹评估工具的使用方法。
---

## EVO {#evo}

在使用evo对ORB-SLAM或OpenVSLAM等SLAM系统在KITTI数据集上以双目模式运行的结果进行评估时，你首先需要确保你的轨迹文件和基准轨迹（ground truth）文件格式是一致的。KITTI数据集的data_odometry_poses提供了基准轨迹，通常这些文件是按照KITTI轨迹格式给出的。


### KITTI {#kitti}

KITTI轨迹格式是一种特定的格式，用于存储车辆或相机在3D空间中的位置和姿态。每行包含12个浮点数，表示一个4x4的变换矩阵（仅前三行，因为最后一行总是\\(0, 0, 0, 1\\)），按照如下排列：

```text
r11 r12 r13 tx r21 r22 r23 ty r31 r32 r33 tz
```

这12个元素分别对应于旋转矩阵的前三行和平移向量，描述了从世界坐标系到车辆坐标系的变换。


### TUM {#tum}

另一种常见的格式是TUM格式，它通常用于表示相机的轨迹。每行包含8个元素：

```text
timestamp tx ty tz qx qy qz qw
```

其中，tx ty tz是平移部分，qx qy qz qw是四元数形式的旋转部分，timestamp是时间戳。


### Traj {#traj}

使用evo评估，假设你已经有了SLAM系统生成的轨迹文件和KITTI的data_odometry_poses基准轨迹文件，你可以使用evo进行评估。下面是一个使用evo对KITTI格式的轨迹进行评估的基本命令示例：

```shell
evo_traj kitti /path/to/your_trajectory.txt --ref=/path/to/KITTI_ground_truth.txt -p --plot_mode=xyz
```

这个命令会加载你的轨迹文件(/path/to/your_trajectory.txt)和参考轨迹(/path/to/KITTI_ground_truth.txt)，并生成一个XYZ平面上的轨迹对比图。这里-p参数表示要生成图表，--plot_mode=xyz指定了图表的模式。


### APE {#ape}

如果你需要进行更深入的评估，比如计算轨迹的APE（Absolute Pose Error）或RPE（Relative Pose Error），你可以使用evo_ape或evo_rpe命令。例如，计算APE的命令如下：

```shell
evo_ape kitti /path/to/KITTI_ground_truth.txt /path/to/your_trajectory.txt -va
```

这将计算并显示绝对位姿误差的统计数据和图表。

确保在运行这些命令之前，你的轨迹文件和基准轨迹文件都是正确的格式，并且已经正确安装了evo。如果你的轨迹文件不是KITTI格式，evo也支持其他格式，如TUM，你只需在命令中相应地更改格式参数。
