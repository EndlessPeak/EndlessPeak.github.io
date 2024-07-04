---
title: ORB SLAM Adjustments
authors: 
    - EndlessPeak
toc: true
date: 2024-01-27
featuredImage: 
hidden: false
draft: false
weight: 100
description: 本文记录了 ORB-SLAM 系列框架在 ArchLinux 和 NixOS 上的编译适配过程。
---

## ORB SLAM3 {#orb-slam3}

orb-slam3 的项目地址：<https://github.com/UZ-SLAMLab/ORB_SLAM3>
目前 orb-slam3 的代码直接编译会报错，因此需要解决一些冲突。


### Opencv {#opencv}

orb-slam 系列要求 opencv 版本包含了对 gtk 的支持，这一点尤其重要。

在 NixOS 中可以使用下面的代码开启对 gtk 的支持。

```nix
let
    pkgs = nixpkgs.legacyPackages.${system};
    opencv = pkgs.opencv;
    opencvGtk = opencv.override( old:{
      enableGtk2 = true;
      gtk2 = pkgs.gtk2;
      enableGtk3 = true;
      gtk3 = pkgs.gtk3;
      enableDocs = true;
    });
in
  {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        opencvGtk
      ];
    }
  }
```


### Eigen {#eigen}

Eigen 是一个矩阵运算库，可以直接从系统包管理器安装，也可以从源码编译。

1.  官方项目地址：<https://gitlab.com/libeigen/eigen>
2.  官方文档地址：<https://eigen.tuxfamily.org/index.php?title=Main_Page>
    有关如何在 CMake 项目中使用 Eigen，可以在对应版本的 Eigen 文档中参考 [Using Eigen in CMake Projects](https://eigen.tuxfamily.org/dox/TopicCMakeGuide.html)


### Sophus {#sophus}

Sophus 是一个李群李代数库，一般发行版不提供安装，可以从源码编译，但是 **编译测试部分时会报错误** 。

1.  官方项目地址：<https://github.com/strasdat/Sophus>
2.  该项目可选依赖于 `fmt` ，可以通过包管理器安装该库。

安装说明：

1.  若安装到系统环境下，为以后所有依赖 Sophus 的项目使用，可以添加参数去除测试部分的编译（仅对较新的版本有效）
    ```shell
    cmake .. -DBUILD_SOPHUS_TESTS=OFF -DBUILD_SOPHUS_EXAMPLES=OFF
    ```
2.  若作为项目依赖，仅为单个项目使用，可以在 `CMakeLists.txt` 中添加如下代码
    ```cmake
    add_compile_options(-Wno-error=array-bounds)
    ```

NixOS 上可以通过编写 `sophus.nix` 的方式安装到系统

```nix
{ lib
, stdenv
, fetchFromGitHub
, cmake
, pkgs
, ...
}:

stdenv.mkDerivation rec {
  pname = "sophus";
  version = "1.22.10";

  src = fetchFromGitHub {
    owner = "strasdat";
    repo = "Sophus";
    rev = "d270df2be6e46501b1e7efc09b107517e0be0645";
    sha256 = "sha256-t0PkXdXO+2PChlsMeKK3IPxudurqrDD4oOllNKphglk=";
  };

  buildInputs = with pkgs;[
    eigen
    fmt
  ];

  nativeBuildInputs = [ cmake ];
  cmakeFlags = [
    "-DBUILD_SOPHUS_TESTS=OFF"
    "-DBUILD_SOPHUS_EXAMPLES=OFF"
  ];
  meta = with lib; {
    homepage = "https://strasdat.github.io/Sophus";
    description = "C++ implementation of Lie groups commonly used for 2d and 3d geometric problems";
    license = licenses.lgpl3Plus;
    maintainers = with maintainers; [ endlesspeak ];
    platforms = platforms.unix;
  };
}
```


### Pangolin {#pangolin}

Pangolin 是一个轻量可移植的 OpenGL 显示管理图形库。
Pangolin 可以直接从系统包管理器安装，也可以从源码安装。

1.  官方项目地址：<https://github.com/stevenlovegrove/Pangolin>
2.  该项目建议安装到系统环境，因为各 SLAM 框架基本都依赖 Pangolin 。

由于 Gcc13 不再包含 `cstdint` 头文件，在 NixOS 中需要显式指明：

```nix
(pangolin.overrideAttrs(old:{
  env.CXXFLAGS = toString [
    # GCC 13: error: 'uint32_t' does not name a type
    "-include cstdint"
  ];
}))
```


### Other Dependencies {#other-dependencies}


#### realsense2 {#realsense2}

orb-slam3 可选依赖于该库，去掉该依赖项仅会导致与 realsense2 有关的测试代码不能正确生成


#### dependencies {#dependencies}

1.  orb-slam3 的运行需要 qt 界面显示运行结果，可以安装 Qt5 或 Qt6 。
2.  orb-slam3 的 `src/System.cc` 引入了 `openssl` 的头文件。
3.  orb-slam3 的 `DBoW2` 模块要求 `boost` 库。


#### NixOS configuration {#nixos-configuration}

```nix
devShells.default = pkgs.mkShell {
  packages = with pkgs; [
    qt6.full
    boost
    openssl
  ];
}

```


#### ROS support {#ros-support}

orb-slam3 可选依赖于 ROS，但是 ROS 在非 Ubuntu 上的安装并不容易，因此该部分建议使用 docker 或虚拟机部署。


### C++14 support {#c-plus-plus-14-support}

orb-slam3 需要 C++ 14 的支持， **即使 Readme 上说只需要 C++ 11** 。为此，需要修改所有和 C++11 有关的内容，这包括 `CMakeLists.txt` 和代码中的宏。

可以使用下面的代码替换掉 `CMakeLists.txt` 中的内容

```shell
sed -i 's/++11/++14/g' CMakeLists.txt
```

代码中还需要手动将 `COMPILEDWITHC11` 替换为 `COMPILEDWITHC14` 宏。


### Compile {#compile}

给它一个编译核心，它能从 1.8GiB 干到 6.1GiB。如果不想内存寄掉就别 `make -j`


## ORB SLAM2 {#orb-slam2}

ORB SLAM2 需要的依赖同上，例外的是不需要 `Sophus` 和 `realsence2` 。
项目地址：<https://github.com/raulmur/ORB_SLAM2/>


### Problems {#problems}


#### C++ 14 support {#c-plus-plus-14-support}

根据“保持最新”理念，升级到 C++14 已成必然。步骤与 ORB SLAM3 类似。


#### CMake Modules {#cmake-modules}

删除 `cmake_modules` 文件夹，因为它指示了错误的 `Eigen` 依赖寻找方法。


#### static assert std map {#static-assert-std-map}

Corrected typedef so that map value_type and allocator are the same. 参考 [PullRequest #585](https://github.com/raulmur/ORB_SLAM2/pull/585/commits/d5c04468ce85d600f8a0a23fa280b0153fe115e0) 或 [Repo](https://github.com/craymichael/ORB_SLAM2/)

更改 `include/LoopClosing.h` 第 50 行。

```cpp
typedef map<KeyFrame*,g2o::Sim3,std::less<KeyFrame*>,
    Eigen::aligned_allocator<std::pair<KeyFrame* const, g2o::Sim3> > > KeyFrameAndPose;//原来是 const KeyFrame*
```


#### double free or corruption {#double-free-or-corruption}

这是由于 `-march=native` 导致的，这个问题在 orb-slam3 上不存在，具体原因尚不明确。

修改时，需要为 **所有** 依赖的构建都取消该编译选项。


### OpenCV Version {#opencv-version}

关于 OpenCV 的 PullRequest，参考 [PullRequest #1076](https://github.com/raulmur/ORB_SLAM2/pull/1076/commits/966ac5e218820248f353b86fa4406d530a9e9585) 或 [Repo](https://github.com/aaronxavier/ORB_SLAM2/)


#### cmake {#cmake}

1.  将所有 cmake 文件中的 `find_package` 中的 opencv 版本更正到 OpenCV 4 。
2.  如果需要与 ROS 集成调试，需要在 `Examples/ROS/ORB_SLAM2/CMakeLists.txt` 中添加 `-lboost_system` 链接选项


#### header {#header}

1.  将所有 `#include<opencv/cv.h>` 更正为 `#include<opencv2/opencv.hpp>`
2.  在下列文件范围内进行操作。
    操作内容：

    1.  新增 `#include<opencv2/imgproc/types_c.h>`
    2.  新增 `#include<opencv2/opencv.hpp>`
    3.  [deprecated]新增命名空间标识符或 `using namespace cv;`

    文件范围：

    1.  `include/PnPsolver.h`
    2.  `include/Sim3Solver.h`
    3.  `include/System.h`
    4.  `src/FrameDrawer.cc`
    5.  `src/LoopClosing.cc`
    6.  `src/Optimizer.cc`
    7.  `src/Tracking.cc`
3.  在下列文件中新增 `#include<opencv2/core/core_c.h>`
    1.  `src/Sim3Solver.cc`
4.  在头文件 `System.h` 中新增 `#include <unistd.h>`
    需要说明的是：
    1.  这是为了解决 `usleep()` 函数未定义的问题
    2.  相当一部分 PullRequest 给每个使用到 `usleep()` 的函数都添加了该头文件，个人认为这是没有必要的


#### cv macro {#cv-macro}

1.  更改下列标识符
    1.  `CvMat` → `cv::Mat`
        由于：

        1.  `cvCreate(rows,cols,type)` 返回的是 `CvMat` 类型的指针
        2.  `cv::Mat(rows,cols,type)` 返回的是 `cv::Mat` 类型的对象

        因此：

        1.  形参中，~CvMat \*~ 改为 `cv::Mat *` ，到时候实参传 `&M` 进去
        2.  函数内 `CvMat *` 或 `CvMat` 都改为 `cv::Mat` ，同时 `cvCreateMat()` 也改为 `cv::Mat`
        3.  经过 2 的修改，函数内临时变量变为 `cv::Mat` 类型，在进行其他函数运算时可以去掉 `&`
    2.  `cvMulTransposed()` → `cv::mulTransposed()`
        ```cpp
        cvMulTransposed(PW0,&PW0tPW0,1);
        cv::mulTransposed(PW0,PW0tPW0,1);
        ```
    3.  `cvSVD()` → `cv::SVD::compute()`
        ```cpp
        cvSVD(&PW0tPW0, &DC, &UCt, 0, CV_SVD_MODIFY_A | CV_SVD_U_T);
        cv::SVD::compute(PW0tPW0,DC,UCt,cv::Mat(), cv::SVD::MODIFY_A | cv::SVD::NO_UV);
        cvSVD(&ABt, &ABt_D, &ABt_U, &ABt_V, CV_SVD_MODIFY_A);
        cv::SVD::compute(ABt, ABt_D, ABt_U, ABt_V, cv::SVD::MODIFY_A);
        ```
    4.  `cvInvert` → `cv::invert()`
        ```cpp
        cvInvert(&CC, &CC_inv, CV_SVD);
        cv::invert(CC, CC_inv, cv::DECOMP_SVD);
        ```
    5.  `(CvMat *)M->data.db + x` → `(cv::Mat *)M->ptr<double>(x)`
        ```cpp
        //data成员的db数组是double数组
        double * M1 = M->data.db + row * 12;
        //使用cv::Mat::ptr 成员函数访问矩阵某行的指针，该行是double
        double * M1 = M->ptr<double>(row * 12);
        ```
    6.  `cvSetZero(CvMat *)` → `cv::Mat.setTo(0)`
        ```cpp
        cvSetZero(&ABt);
        ABt.setTo(0);
        ```
    7.  `cvmSet()` → `cv::Mat->at<double>`
        ```cpp
        cvmSet(&L_6x4, i, 0, cvmGet(L_6x10, i, 0));
        cvmSet(&L_6x4, i, 1, cvmGet(L_6x10, i, 1));
        cvmSet(&L_6x4, i, 2, cvmGet(L_6x10, i, 3));
        cvmSet(&L_6x4, i, 3, cvmGet(L_6x10, i, 6));
        L_6x4.at<double>(i, 0) = L_6x10->at<double>(i, 0);
        L_6x4.at<double>(i, 1) = L_6x10->at<double>(i, 1);
        L_6x4.at<double>(i, 1) = L_6x10->at<double>(i, 3);
        L_6x4.at<double>(i, 1) = L_6x10->at<double>(i, 6);
        ```
    8.  `cvSolve()` → `cv::solve()`
        ```cpp
        cvSolve(&L_6x4, Rho, &B4, CV_SVD);
        cv::solve(L_6x4, *Rho, B4, cv::DECOMP_SVD);
        ```
2.  更正下列 OpenCV 颜色宏
    1.  将 `CV_BGR2GRAY` 更正为 `cv::COLOR_BGR2GRAY`
    2.  将 `CV_RGB2GRAY` 更正为 `cv::COLOR_RGB2GRAY`
    3.  将 `CV_BGRA2GRAY` 更正为 `cv::COLOR_BGRA2GRAY`
    4.  将 `CV_RGBA2GRAY` 更正为 `cv::COLOR_RGBA2GRAY`
3.  更正下列 OpenCV 加载宏
    1.  将 `CV_LOAD_IMAGE_UNCHANGED` 更正为 `cv::IMREAD_UNCHANGED`
    2.  将 `CV_REDUCE_SUM` 更正为 `cv::REDUCE_SUM`
