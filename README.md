#  CDR(cv-detect-robot)项目介绍
**CDR项目的立项宗旨**：高性能视觉检测及其相关算法赋能机器人行业，搭建起技术落地的桥梁。
> （ **备注(1)**）:已接入本项目的`yolov5-ros-deepstream`已做好了ROS系统的适配，待相关软硬件环境搭建好后即可直接调用已定义好的ros话题消息获取目标检测实时数据。

>   （ **备注(2)**）:后续将接入**百度paddle的ppyolo算法**、**旷世科技的YOLOX算法**和**一系列像素级目标检测及追踪算法**。

>   （ **备注(３)**）:随着本人的学习成长，该项目会不定期进行维护和更新，由于个人能力有限，项目中存在错误和不足之处望各位批评指正或在`issue`中留言。

>   （ **备注(4)**）:为方便大家学习交流，已建立**CDR(cv-detect-robot)项目**交流微信群，请添加群负责人`小郭`微信号`17370042325`,以方便拉您进群。
***
***
#  CDR子项目(一)（yolov5-ros-deepstream）
-  yolov5-ros-deepstream 子项目简介
> 该项目是将yolov5视觉检测算法与神经网络加速引擎tensorRT结合，并在英伟达的deepstream框架下运行，结合ros通信机制，将检测数据实时通过ros topic 发布出去。以供基于ROS机器人操作系统的开发人员及相关科研人员使用。

>详细教程请进入[yolov5-ros-deepstream](https://github.com/guojianyang/cv-detect-ros/wiki/yolov5-ros-deepstream)

>最终视频检测效果请进入[yolov5-ros-deepstream检测](https://www.bilibili.com/video/BV1Lo4y1Q79C/)

#  CDR子项目(二)（yolov5-deepstream-python）
-  yolov5-deepstream-python 子项目简介
> 该项目是将视觉检测算法yolov5与神经网络加速引擎tensorRT结合,利用共享内存技术将检测所得到的数据实时储存到事先定义好的物理内存中（物理地址是唯一的），在同一硬件平台上的任意软件目录中，建立一个读取物理内存的`client.py`脚本文件（里面只包含一个读取内存的代码段），将指定好的物理内存中的数据读取出来，在读取成功的前提下，可将该代码段插入到任意需要目标检测数据的python项目中，从而使该python项目能顺利获取目标检测数据。

> 详细教程请进入[yolov5-deepstream-python](https://github.com/guojianyang/cv-detect-ros/wiki/yolov5-deepstream-python)

> 最终视频检测效果请进入[yolov5-deepstream-python检测](https://www.bilibili.com/video/BV1Uv411E755/)
#  CDR子项目(三)（yolov5-deepstream-cpp）
- yolov5-deepstream-python 子项目简介
> 该项目是将视觉检测算法yolov5与神经网络加速引擎tensorRT结合,利用共享内存技术将检测所得到的数据实时储存到事先定义好的物理内存中（物理地址是唯一的），在同一硬件平台上的任意软件目录中，建立一个读取物理内存的`yolov5_tensor.cpp`文件（里面只包含一个读取内存的代码段），编译后可将指定好的物理内存中的数据读取出来，在读取成功的前提下，可将该代码段插入到任意需要目标检测数据的C++项目中，从而使该C++项目能顺利获取目标检测数据。

> 详细教程请进入[yolov5-deepstream-cpp](https://github.com/guojianyang/cv-detect-ros/wiki/yolov5-deepstream-cpp)

> 最终视频检测效果请进入[yolov5-deepstream-cpp检测](https://www.bilibili.com/video/BV1yV411p7Dx/)
