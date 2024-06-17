---
title: ORB SLAM3 Stereo
authors: 
    - EndlessPeak
toc: true
date: 2024-01-31
featuredImage: 
hidden: false
draft: false
weight: 11
description: 本文记录了 ORB-SLAM3 双目适配。
---

## Stereo Kitti {#stereo-kitti}


### Yaml modification {#yaml-modification}

修改 KITTI00-02.yaml 文件中的 `Viewer.ViewpointY: -100` 改为 `Viewer.ViewpointY: -100.0`


### Settings {#settings}

Orb slam3 在运行 stereo 时，输出第二个摄像头参数位置报 `segment fault`

```cpp
//for(size_t i = 0; i < settings.originalCalib2_->size(); i++){
//    output << " " << settings.originalCalib2_->getParameter(i);
//}
if (settings.cameraType_ == Settings::PinHole) {
    for(size_t i = 0; i < settings.originalCalib2_->size(); i++){
        output << " " << settings.originalCalib2_->getParameter(i);
    }
} else if (settings.cameraType_ == Settings::Rectified) {
    for (size_t i = 0; i < settings.originalCalib1_->size(); i++) {
        output << " " << settings.originalCalib1_->getParameter(i);
    }
}
```
