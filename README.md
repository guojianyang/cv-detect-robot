
![enter image description here](https://img-blog.csdnimg.cn/7007a6ec9d584018bdf289bd8987c45d.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBA6YOt5bu65rSL,size_20,color_FFFFFF,t_70,g_se,x_16)
#   [中文] | [[English]](https://github.com/guojianyang/cv-detect-robot/blob/main/README_EN.md)
#  CDR(cv-detect-robot)项目介绍-------（工业级视觉算法侧端部署）
**CDR项目立项宗旨**：高性能视觉检测及其相关算法赋能机器人行业，搭建起技术落地的桥梁。
> （ **备注(1)**）:已接入本项目的`yolov5-ros-deepstream`和`yolox-ros-deepstream`已做好了ROS系统的适配，待相关软硬件环境搭建好后即可直接调用已定义好的ros话题消息获取目标检测实时数据。

>   （ **备注(2)**）:后续将接入**百度paddle的ppyolo算法**、**旷世科技的YOLOX算法**和**一系列像素级目标检测及追踪算法**。

>   （ **备注(３)**）:随着本人及团队《中山大学－MICRO_lab实验室》的学习成长，该项目会不定期进行维护和更新，由于能力有限，项目中存在错误和不足之处望各位批评指正或在`issue`中留言。

>   （ **备注(4)**）:为方便大家学习交流，已建立**CDR(cv-detect-robot)项目**交流微信群，请添加群负责人`小郭`微信号`17370042325`,以方便拉您进群。
***
***
#  CDR子项目(一)（yolov5-ros-deepstream）
-  yolov5-ros-deepstream 子项目简介
> 该项目是将yolov5视觉检测算法与神经网络加速引擎tensorRT结合，并在英伟达的deepstream框架下运行，结合ros通信机制，将检测数据实时通过ros topic 发布出去。以供基于ROS机器人操作系统的开发人员及相关科研人员使用。

>详细教程请进入[yolov5-ros-deepstream](https://github.com/guojianyang/cv-detect-robot/blob/main/yolov5-ros-deepstream)

>最终视频检测效果请进入[yolov5-ros-deepstream检测](https://www.bilibili.com/video/BV1Lo4y1Q79C/)

#  CDR子项目(二)（yolov5-deepstream-python）
-  yolov5-deepstream-python 子项目简介
> 该项目是将视觉检测算法yolov5与神经网络加速引擎tensorRT结合,利用共享内存技术将检测所得到的数据实时储存到事先定义好的物理内存中（物理地址是唯一的），在同一硬件平台上的任意软件目录中，建立一个读取物理内存的`client.py`脚本文件（里面只包含一个读取内存的代码段），将指定好的物理内存中的数据读取出来，在读取成功的前提下，可将该代码段插入到任意需要目标检测数据的python项目中，从而使该python项目能顺利获取目标检测数据。

> 详细教程请进入[yolov5-deepstream-python](https://github.com/guojianyang/cv-detect-robot/tree/main/yolov5-deepstream-python)

> 最终视频检测效果请进入[yolov5-deepstream-python检测](https://www.bilibili.com/video/BV1Uv411E755/)
#  CDR子项目(三)（yolov5-deepstream-cpp）
- yolov5-deepstream-cpp 子项目简介
> 该项目是将视觉检测算法yolov5与神经网络加速引擎tensorRT结合,利用共享内存技术将检测所得到的数据实时储存到事先定义好的物理内存中（物理地址是唯一的），在同一硬件平台上的任意软件目录中，建立一个读取物理内存的`yolov5_tensor.cpp`文件（里面只包含一个读取内存的代码段），编译后可将指定好的物理内存中的数据读取出来，在读取成功的前提下，可将该代码段插入到任意需要目标检测数据的C++项目中，从而使该C++项目能顺利获取目标检测数据。

> 详细教程请进入[yolov5-deepstream-cpp](https://github.com/guojianyang/cv-detect-robot/tree/main/yolov5-deepstream-cpp)

> 最终视频检测效果请进入[yolov5-deepstream-cpp检测](https://www.bilibili.com/video/BV1yV411p7Dx/)

#  CDR子项目(四)（yolox-ros-deepstream）
- yolox-ros-deepstream 子项目简介
> 该项目是将yolox视觉检测算法与神经网络加速引擎tensorRT结合，本子项目采另一种引擎文件生成方法，通过onnx转到engine，此方法更具灵活性，也越来越稳定，符合行业主流发展趋势，在英伟达的deepstream框架下运行，结合ros通信机制，将检测数据实时通过ros topic 发布出去。以供基于ROS机器人操作系统的开发人员及相关科研人员使用。

> 详细教程请进入[yolox-ros-deepstream](https://github.com/guojianyang/cv-detect-robot/tree/main/yolox-ros-deepstream)

> 最终视频检测效果请进入[yolox-ros-deepstream检测](https://www.bilibili.com/video/BV1k34y1o7Ck/)

#  CDR子项目(五)（resnet10+ros+deepstream `for python` ）----(Jetson Nano `and` X_86) 
> 该项目利用`deepstream`的python接口，基于英伟达针对性优化的`resnet10.caffemodel`模型,可利用英伟达新推出的`(TAO) Toolkit `工具包进行自定义数据集训练及模型优化，并继承CDR项目祖传的ros接口。不仅能在Jetson系列平台使用，通过docker容器技术，也可在Linux-x_86平台(Ubuntu)实现快速部署。经测试，该模型在Jetson Nano上可实现在检测算法和多目标跟踪算法同时加持情况下高达30fps的帧率(检测四种目标)，准确率可达90%以上(接近yolov5)。

> 详细教程请进入[resnet10-ros-deepstream](https://github.com/guojianyang/cv-detect-robot/blob/main/resnet10-ros-deepstream/README.md)

> 最终视频检测效果请进入[resnet10-ros-deepstream检测](https://www.bilibili.com/video/BV1Xg411w78P/)

#  [CDR项目常见问题及其解决方案(Common problems and solutions)](https://github.com/guojianyang/cv-detect-robot/wiki/CDR%E9%A1%B9%E7%9B%AE%E5%B8%B8%E8%A7%81%E9%97%AE%E9%A2%98%E5%8F%8A%E5%85%B6%E8%A7%A3%E5%86%B3%E6%96%B9%E6%A1%88(Common-problems-and-solutions))

