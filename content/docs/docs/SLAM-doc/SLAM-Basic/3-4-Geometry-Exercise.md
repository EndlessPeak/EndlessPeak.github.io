---
title: Geometry Exercise
authors: 
    - EndlessPeak
toc: true
date: 2024-06-19
featuredImage: 
hidden: false
draft: false
weight: 34
description: 本文记录了Eigen的几何模块的使用。
---

### Geometry
#### Declaration

四元数，旋转矩阵和旋转向量的声明：

```cpp
// 3D 旋转矩阵直接使用 Matrix3d 或 Matrix3f
Eigen::Matrix3d rotation_matrix;
// 旋转向量使用 AngleAxis, 它底层不直接是Matrix，但运算可以当作矩阵（因为重载了运算符）
Eigen::AngleAxisd rotation_vector;

Eigen::Vector3d v(1, 0, 0);
// 向量v的旋转后坐标
Eigen::Vector3d v_rotated;
// 欧拉角: 可以将旋转矩阵直接转换成欧拉角
Eigen::Vector3d euler_angles;
// 四元数
Eigen::Quaterniond q;
```


#### Rotation and translation
旋转矩阵和旋转向量：

```cpp
// Eigen/Geometry 模块提供了各种旋转和平移的表示
// 旋转矩阵初始化
rotation_matrix = Eigen::Matrix3d::Identity();
// 旋转向量初始化，沿 Z 轴旋转 45 度
rotation_vector = Eigen::AngleAxisd(M_PI / 4, Eigen::Vector3d(0, 0, 1));
std::cout.precision(3);
std::cout << "rotation matrix =\n" << rotation_vector.matrix() << "\n";   //用matrix()转换成矩阵
// 也可以直接赋值
// 由旋转向量转为旋转矩阵
rotation_matrix = rotation_vector.toRotationMatrix();
// 用 AngleAxis 可以进行坐标变换
v_rotated = rotation_vector * v;
std::cout << "(1,0,0) after rotation (by angle axis) = " << v_rotated.transpose() << "\n";
// 或者用旋转矩阵
v_rotated = rotation_matrix * v;
std::cout << "(1,0,0) after rotation (by matrix) = " << v_rotated.transpose() << "\n";
```


#### Euler angle
欧拉角和旋转矩阵、旋转向量之间的转换

```cpp
// 可以将旋转矩阵直接转换成欧拉角
euler_angles = rotation_matrix.eulerAngles(2, 1, 0); // ZYX顺序，即 yaw-pitch-roll 顺序
std::cout << "yaw pitch roll = " << euler_angles.transpose() << "\n";

// 可以将旋转向量直接转换成欧拉角
euler_angles = rotation_vector.eulerAngles(0, 1, 2); // XYZ 顺序，即 pitch-roll-yaw 顺序
std::cout << "pitch roll yaw = " << euler_angles.transpose() << "\n";

// 欧氏变换矩阵使用 Eigen::Isometry
// 虽然称为3d，实质上是4＊4的矩阵
Eigen::Isometry3d T = Eigen::Isometry3d::Identity();
// 按照rotation_vector进行旋转
T.rotate(rotation_vector);
// 把平移向量设成(1,3,4)
T.pretranslate(Eigen::Vector3d(1, 3, 4));
std::cout << "Transform matrix = \n" << T.matrix() << "\n";

// 用变换矩阵进行坐标变换
Eigen::Vector3d v_transformed = T * v;// 相当于R*v+t
std::cout << "v tranformed = " << v_transformed.transpose() << "\n";

// 对于仿射和射影变换，使用 Eigen::Affine3d 和 Eigen::Projective3d 即可，略
```


#### Quaternion
四元数的相关操作：

```cpp
// 可以直接把AngleAxis赋值给四元数，反之亦然
Eigen::Quaterniond q = Eigen::Quaterniond(rotation_vector);
// coeffs 方法返回一个包含四元数系数的 Eigen::Map<Eigen::Vector4d> 对象
std::cout << "quaternion from rotation vector = " << q.coeffs().transpose()
   << std::endl;   // 请注意coeffs的顺序是(x,y,z,w),w为实部，前三者为虚部
// 也可以把旋转矩阵赋给它
q = Eigen::Quaterniond(rotation_matrix);
std::cout << "quaternion from rotation matrix = " << q.coeffs().transpose() << "\n";
// 使用四元数旋转一个向量，使用重载的乘法即可
v_rotated = q * v; // 注意数学上是qvq^{-1}
std::cout << "(1,0,0) after rotation = " << v_rotated.transpose() << "\n";
// 用常规向量乘法表示，则应该如下计算
std::cout << "should be equal to " << (q * Eigen::Quaterniond(0, 1, 0, 0) * q.inverse()).coeffs().transpose() << "\n";
```


### Transform
#### Coordinate transform

四元数的坐标变换：
注意：

1.  四元数需要满足模长为1才能表示一个有效的旋转，而实际计算中由于运算的误差累积，四元数可能会丢失单位长度
2.  仿射变换可以由单位矩阵初始化，然后使用 `pretranslate` 设置平移，使用 `rotate` 设置旋转；也可以直接由表示平移的向量或四元数初始化它。

```cpp
Eigen::Quaterniond q1(0.35, 0.2, 0.3, 0.1), q2(-0.5, 0.4, -0.1, 0.2);
q1.normalize(); // 归一化
q2.normalize();
Eigen::Vector3d t1(0.3, 0.1, 0.1), t2(-0.1, 0.5, 0.3);
Eigen::Vector3d p1(0.5, 0, 0.2);

Eigen::Isometry3d T1w(q1), T2w(q2); // 表示仿射变换的类
T1w.pretranslate(t1); // 进行平移变换
T2w.pretranslate(t2);

// 对欧式变换矩阵求逆
Eigen::Vector3d p2 = T2w * T1w.inverse() * p1;
std::cout << "\n" << p2.transpose() << "\n";
```