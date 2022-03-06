translate for CDR
17/100
保存草稿
发布文章
weixin_46438576
未选择任何文件
   ![enter image description here](https://img-blog.csdnimg.cn/7007a6ec9d584018bdf289bd8987c45d.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBA6YOt5bu65rSL,size_20,color_FFFFFF,t_70,g_se,x_16)
#   [English] | [[中文]](https://github.com/guojianyang/cv-detect-robot)
#  CDR(cv-detect-robot)Project Introduction🔥🔥🔥（Jetson side-end optimized deployment of industrial-grade vision algorithms）
**CDR Project purpose**：High-performance visual inspection and its related algorithms empower the robotics industry and build a bridge for technology implementation。
### **Project Description**:
- For x_86 and nvidia-jetson platforms, this project uses tensorRT optimization and builds visual detection algorithms such as yolov5, yolox and resnet based on the deepstream video streaming AI inference framework, and configures deepsort, DCF and IOU trackers for each algorithm. The detection and tracking data are transmitted by means of shared memory. Real-time data can be read in three ways: rostopic, python script and c++ program. This project provides zero-based introductory configuration and debugging tutorials, as well as docker images based on the x_86 platform and the nvidia-jetson platform, which can save the trouble of configuring the environment and import and run with one click. The image contains a full set of operating environments for the source code of the yolov5 project and a full set of operating environments for the source code of the yolox project. deepstream full set of operating environment and ros operating system (melodic)

> （ **Note 1**）:This project has configured a full set of docker images for the ubuntu-x_86 platform and the nvidia-jetson platform. There is no need to configure a complicated software environment. One-click import and operation saves time and effort.。

>   （ **Note 2**）:In the future, this project will use Tencent Youtu's ncnn acceleration library to optimize and deploy domestic AI chips such as Huawei HiSilicon 3559, Rockchip 3399pro, Kanzhi K210 and other domestic AI chips. Please look forward to it.！！！。

>   （ **Note 3**）:With the learning and growth of myself and the team, the project will be maintained and updated from time to time. Due to the limited ability, there are errors and deficiencies in the project. Please criticize and correct or leave a message in `issue`。

>   （ **Note 4**）:In order to facilitate everyone to learn and communicate, a **CDR (cv-detect-robot) project** communication WeChat group has been established. Please add the group leader `Xiao Guo` WeChat account `17370042325` to facilitate pulling you into the group。
***
***
# CDR~ The -v4.0 version of the standard docker image of the whole system is updated as follows🔥🔥🔥🔥🔥：
- The deepstream framework in CDR is upgraded to version 6.0 (tensorRT 8.0.1)
- All sub-projects are adapted to the deepsort tracker (IOU, DCF and deepsort three trackers can be switched at will), and the target tracking IDs of all sub-projects can be obtained through rostopic, python scripts and cpp programs。
- The whole system comes standard with docker mirroring. The project author has configured a full set of mirroring environments based on the x_86 platform and the nvidia-jetson platform for the CDR project, and comes with project mirroring operations and sub-project testing tutorials。
    - [CDR x86 docker image usage and testing tutorial](https://github.com/guojianyang/cv-detect-robot/wiki/CDR-x86-docker%E9%95%9C%E5%83%8F%E4%BD%BF%E7%94%A8%E5%8F%8A%E6%B5%8B%E8%AF%95%E6%95%99%E7%A8%8B)
    - [CDR jetson docker image usage and testing tutorial](https://github.com/guojianyang/cv-detect-robot/wiki/CDR-jetson-docker%E9%95%9C%E5%83%8F%E4%BD%BF%E7%94%A8%E5%8F%8A%E6%B5%8B%E8%AF%95%E6%95%99%E7%A8%8B)
- The CDR image has pt->wts->trt function (yolov5) and onnx-trt function (yolox)。
- Each sub-project in the CDR image can have multi-stream detection. For details, please refer to the following link。
   - [Multiple video stream detection method in docker image CDR project
](https://github.com/guojianyang/cv-detect-robot/wiki/docker%E9%95%9C%E5%83%8FCDR%E9%A1%B9%E7%9B%AE%E4%B8%AD%E5%A4%9A%E8%A7%86%E9%A2%91%E6%B5%81%E6%A3%80%E6%B5%8B%E6%96%B9%E6%B3%95)
-  Each sub-project in the CDR image has the functions of video file detection, usb camera detection and rtsp real-time stream detection.。
- The CDR image has been configured with the complete operating environment of the yolov5 project source code, the complete operating environment of the yolox project source code, the complete operating environment of the deepstream and the complete operating environment of ros-melodic. For the specific environment configuration, please refer to the following link：
   - [Introduction to the existing environment and corresponding version in the docker image CDR project](https://github.com/guojianyang/cv-detect-robot/wiki/docker%E9%95%9C%E5%83%8FCDR%E9%A1%B9%E7%9B%AE%E4%B8%AD%E5%B7%B2%E6%9C%89%E7%8E%AF%E5%A2%83%E5%8F%8A%E7%9B%B8%E5%BA%94%E7%89%88%E6%9C%AC%E4%BB%8B%E7%BB%8D)
***
***
- **`CDR x86 docker`镜像和`CDR jetson docker`镜像环境配置和算法调试极其复杂，耗时巨大，但本着开源共享的精神，项目作者决定供全行业免费使用**：
    -  [CDR x86 docker镜像](https://github.com/guojianyang/cv-detect-robot/wiki/CDR-x86-docker%E9%95%9C%E5%83%8F%E4%BD%BF%E7%94%A8%E5%8F%8A%E6%B5%8B%E8%AF%95%E6%95%99%E7%A8%8B)(28G左右)下载链接如下(不限速)：
       -   链接:`http://112.74.111.51:1212/down/Dcyn8UvJ81Lg` 提取码:`Z78Din`
       
     - [CDR x86 docker镜像](https://github.com/guojianyang/cv-detect-robot/wiki/CDR-x86-docker%E9%95%9C%E5%83%8F%E4%BD%BF%E7%94%A8%E5%8F%8A%E6%B5%8B%E8%AF%95%E6%95%99%E7%A8%8B)dockerhub下载(14.54 GB)命令：
        > `docker pull gjy123456/cv-detect-robot:CDR-x86-v4.02`
     ***
    -  [CDR jetson docker镜像](https://github.com/guojianyang/cv-detect-robot/wiki/CDR-jetson-docker%E9%95%9C%E5%83%8F%E4%BD%BF%E7%94%A8%E5%8F%8A%E6%B5%8B%E8%AF%95%E6%95%99%E7%A8%8B)(10G左右)下载链接如下(不限速)：
       - 链接:`http://112.74.111.51:1212/down/tSpLJEbUHvQC` 提取码:`nKTzyp`
       
  -  [CDR jetson docker镜像](https://github.com/guojianyang/cv-detect-robot/wiki/CDR-jetson-docker%E9%95%9C%E5%83%8F%E4%BD%BF%E7%94%A8%E5%8F%8A%E6%B5%8B%E8%AF%95%E6%95%99%E7%A8%8B)(4.58G左右)dockerhub下载命令：
      >`docker pull gjy123456/cv-detect-robot:CDR-jetson-v4.18`
   
   
***
***
#  ！！！若使用docker镜像，本行以下内容只作了解即可,若想从零开始配置环境则可参照以下内容！！！
***
#  CDR子项目(一)（yolov5-ros-deepstream）
-  yolov5-ros-deepstream 子项目简介
> 该项目是将yolov5视觉检测算法与神经网络加速引擎tensorRT结合，并在英伟达的deepstream框架下运行，结合ros1通信机制，将检测数据实时通过ros topic 发布出去。以供基于ROS机器人操作系统的开发人员及相关科研人员使用。

>详细教程请进入[yolov5-ros-deepstream](https://github.com/guojianyang/cv-detect-robot/blob/main/yolov5-ros-deepstream)

>最终视频检测效果请进入[yolov5-ros-deepstream检测](https://www.bilibili.com/video/BV1Lo4y1Q79C/)
>
>加入目标跟踪器视频检测效果请进入[Jetson NX yolov5-ros-deepstream+目标跟踪](https://www.bilibili.com/video/BV1u34y1673W?spm_id_from=333.999.0.0)
>
>加入目标跟踪器视频检测效果请进入[Jetson Nano yolov5-ros-deepstream+目标跟踪](https://www.bilibili.com/video/BV1pS4y1Z7cX?spm_id_from=333.999.0.0)

#  CDR子项目(二)（yolov5-deepstream-python）
-  yolov5-deepstream-python 子项目简介
> 该项目是将视觉检测算法yolov5与神经网络加速引擎tensorRT结合,利用共享内存技术将检测所得到的数据实时储存到事先定义好的物理内存中（物理地址是唯一的），在同一硬件平台上的任意软件目录中，建立一个读取物理内存的`client.py`脚本文件（里面只包含一个读取内存的代码段），将指定好的物理内存中的数据读取出来，在读取成功的前提下，可将该代码段插入到任意需要目标检测数据的python项目中，从而使该python项目能顺利获取目标检测数据。

> 详细教程请进入[yolov5-deepstream-python](https://github.com/guojianyang/cv-detect-robot/tree/main/yolov5-deepstream-python)

> 最终视频检测效果请进入[yolov5-deepstream-python检测](https://www.bilibili.com/video/BV1Uv411E755/)
> 
>加入目标跟踪器视频检测效果请进入[Jetson NX yolov5-python-deepstream+目标跟踪器](https://www.bilibili.com/video/BV1u34y1673W?spm_id_from=333.999.0.0)
>
>加入目标跟踪器视频检测效果请进入[Jetson Nano yolov5-python-deepstream+目标跟踪器](https://www.bilibili.com/video/BV1pS4y1Z7cX?spm_id_from=333.999.0.0)

#  CDR子项目(三)（yolov5-deepstream-cpp）
- yolov5-deepstream-cpp 子项目简介
> 该项目是将视觉检测算法yolov5与神经网络加速引擎tensorRT结合,利用共享内存技术将检测所得到的数据实时储存到事先定义好的物理内存中（物理地址是唯一的），在同一硬件平台上的任意软件目录中，建立一个读取物理内存的`yolov5_tensor.cpp`文件（里面只包含一个读取内存的代码段），编译后可将指定好的物理内存中的数据读取出来，在读取成功的前提下，可将该代码段插入到任意需要目标检测数据的C++项目中，从而使该C++项目能顺利获取目标检测数据。

> 详细教程请进入[yolov5-deepstream-cpp](https://github.com/guojianyang/cv-detect-robot/tree/main/yolov5-deepstream-cpp)

> 最终视频检测效果请进入[yolov5-deepstream-cpp检测](https://www.bilibili.com/video/BV1yV411p7Dx/)
> 
> 加入目标跟踪器视频检测效果请进入[Jetson NX yolov5-cpp-deepstream+目标跟踪器](https://www.bilibili.com/video/BV1u34y1673W?spm_id_from=333.999.0.0)
> 
> 加入目标跟踪器视频检测效果请进入[Jetson Nano yolov5-cpp-deepstream+目标跟踪器](https://www.bilibili.com/video/BV1pS4y1Z7cX?spm_id_from=333.999.0.0)

#  CDR子项目(四)（yolox-ros-deepstream）
- yolox-ros-deepstream 子项目简介
> 该项目是将yolox视觉检测算法与神经网络加速引擎tensorRT结合，本子项目采另一种引擎文件生成方法，通过onnx转到engine，此方法更具灵活性，也越来越稳定，符合行业主流发展趋势，在英伟达的deepstream框架下运行，结合ros通信机制，将检测数据实时通过ros topic 发布出去。以供基于ROS机器人操作系统的开发人员及相关科研人员使用。

> 详细教程请进入[yolox-ros-deepstream](https://github.com/guojianyang/cv-detect-robot/tree/main/yolox-ros-deepstream)

> 最终视频检测效果请进入[yolox-ros-deepstream检测](https://www.bilibili.com/video/BV1k34y1o7Ck/)
> 
> 加入目标跟踪器视频检测效果请进入[Jetson NX yolox-ros-deepstream+目标跟踪器](https://www.bilibili.com/video/BV1W34y1B7YB?spm_id_from=333.999.0.0)
> 
> 加入目标跟踪器视频检测效果请进入[Jetson Nano yolox-ros-deepstream+目标跟踪器](https://www.bilibili.com/video/BV1Tq4y1A7km?spm_id_from=333.999.0.0)

#  CDR子项目(五)（resnet10+ros+deepstream `for python` ）----(Jetson Nano `and` X_86) 
> 该项目利用`deepstream`的python接口，基于英伟达针对性优化的`resnet10.caffemodel`模型,可利用英伟达新推出的`(TAO) Toolkit `工具包进行自定义数据集训练及模型优化，并继承CDR项目祖传的ros接口。不仅能在Jetson系列平台使用，通过docker容器技术，也可在Linux-x_86平台(Ubuntu)实现快速部署。经测试，该模型在Jetson Nano上可实现在检测算法和多目标跟踪算法同时加持情况下高达30fps的帧率(检测四种目标)，准确率可达90%以上(接近yolov5)。

> 详细教程请进入[resnet10-ros-deepstream](https://github.com/guojianyang/cv-detect-robot/blob/main/resnet10-ros-deepstream/README.md)

> 最终视频检测效果请进入[resnet10-ros-deepstream检测](https://www.bilibili.com/video/BV1Xg411w78P/)
> 
> 加入目标跟踪器视频检测效果请进入[Jetson NX resnet10-ros-deepstream+目标跟踪器](https://www.bilibili.com/video/BV1Fr4y1v7AM?spm_id_from=333.999.0.0)
> 
> 加入目标跟踪器视频检测效果请进入[Jetson Nano resnet10-ros-deepstream+目标跟踪器](https://www.bilibili.com/video/BV1p34y1B7Vx?spm_id_from=333.999.0.0)

#  CDR子项目(六)（yolox-deepstream-python）
- yolox-deepstream-python 子项目简介
> 该项目是将yolox视觉检测算法与神经网络加速引擎tensorRT结合，本子项目采另一种引擎文件生成方法，通过onnx转到engine，此方法更具灵活性，也越来越稳定，符合行业主流发展趋势，在英伟达的deepstream框架下运行，在同一硬件平台上的任意软件目录中，建立一个读取物理内存的`client.py`脚本文件（里面只包含一个读取内存的代码段），将指定好的物理内存中的数据读取出来，在读取成功的前提下，可将该代码段插入到任意需要目标检测数据的python项目中，从而使该python项目能顺利获取目标检测数据。

> 详细教程请进入[yolox-deepstream-python](https://github.com/guojianyang/cv-detect-robot/tree/main/yolox-deepstream-python)

> 最终视频检测效果请进入[yolox-deepstream-python检测](https://www.bilibili.com/video/BV1k34y1o7Ck/)
> 
> 加入目标跟踪器视频检测效果请进入[Jetson NX yolox-ros-deepstream+目标跟踪器](https://www.bilibili.com/video/BV1W34y1B7YB?spm_id_from=333.999.0.0)
> 
> 加入目标跟踪器视频检测效果请进入[Jetson Nano yolox-ros-deepstream+目标跟踪器](https://www.bilibili.com/video/BV1Tq4y1A7km?spm_id_from=333.999.0.0)

#  CDR子项目(七)（yolox-deepstream-cpp）
- yolox-deepstream-cpp 子项目简介
> 该项目是将yolox视觉检测算法与神经网络加速引擎tensorRT结合，本子项目采另一种引擎文件生成方法，通过onnx转到engine，此方法更具灵活性，也越来越稳定，符合行业主流发展趋势，在英伟达的deepstream框架下运行，在同一硬件平台上的任意软件目录中，建立一个读取物理内存的`yolox_tensor.cpp`文件（里面只包含一个读取内存的代码段），编译后可将指定好的物理内存中的数据读取出来，在读取成功的前提下，可将该代码段插入到任意需要目标检测数据的C++项目中，从而使该C++项目能顺利获取目标检测数据。

> 详细教程请进入[yolox-deepstream-cpp](https://github.com/guojianyang/cv-detect-robot/tree/main/yolox-deepstream-cpp)

> 最终视频检测效果请进入[yolox-deepstream-cpp检测](https://www.bilibili.com/video/BV1k34y1o7Ck/)
> 
> 加入目标跟踪器视频检测效果请进入[Jetson NX yolox-ros-deepstream+目标跟踪器](https://www.bilibili.com/video/BV1W34y1B7YB?spm_id_from=333.999.0.0)
> 
> 加入目标跟踪器视频检测效果请进入[Jetson Nano yolox-ros-deepstream+目标跟踪器](https://www.bilibili.com/video/BV1Tq4y1A7km?spm_id_from=333.999.0.0)

#  [CDR项目常见问题及其解决方案(Common problems and solutions)](https://github.com/guojianyang/cv-detect-robot/wiki/CDR%E9%A1%B9%E7%9B%AE%E5%B8%B8%E8%A7%81%E9%97%AE%E9%A2%98%E5%8F%8A%E5%85%B6%E8%A7%A3%E5%86%B3%E6%96%B9%E6%A1%88(Common-problems-and-solutions))
#  [Jetson Nano和 NX在运行CDR项目时注意事项](https://github.com/guojianyang/cv-detect-robot/wiki/Jetson-Nano%E5%92%8C-NX%E5%9C%A8%E8%BF%90%E8%A1%8CCDR%E9%A1%B9%E7%9B%AE%E6%97%B6%E6%B3%A8%E6%84%8F%E4%BA%8B%E9%A1%B9)
#  [wts文件生成engine文件的方法](https://github.com/guojianyang/cv-detect-robot/wiki/wts%E6%96%87%E4%BB%B6%E7%94%9F%E6%88%90engine%E6%96%87%E4%BB%B6%E7%9A%84%E6%96%B9%E6%B3%95)
#  [对多类目标中指定目标类别进行识别与跟踪](https://github.com/guojianyang/cv-detect-robot/wiki/%E5%AF%B9%E5%A4%9A%E7%B1%BB%E7%9B%AE%E6%A0%87%E4%B8%AD%E6%8C%87%E5%AE%9A%E7%9B%AE%E6%A0%87%E7%B1%BB%E5%88%AB%E8%BF%9B%E8%A1%8C%E8%AF%86%E5%88%AB%E4%B8%8E%E8%B7%9F%E8%B8%AA)


enter image description here

[English] | [中文]
CDR(cv-detect-robot)Project Introduction🔥🔥🔥（Jetson side-end optimized deployment of industrial-grade vision algorithms）
CDR Project purpose：High-performance visual inspection and its related algorithms empower the robotics industry and build a bridge for technology implementation。

Project Description:
For x_86 and nvidia-jetson platforms, this project uses tensorRT optimization and builds visual detection algorithms such as yolov5, yolox and resnet based on the deepstream video streaming AI inference framework, and configures deepsort, DCF and IOU trackers for each algorithm. The detection and tracking data are transmitted by means of shared memory. Real-time data can be read in three ways: rostopic, python script and c++ program. This project provides zero-based introductory configuration and debugging tutorials, as well as docker images based on the x_86 platform and the nvidia-jetson platform, which can save the trouble of configuring the environment and import and run with one click. The image contains a full set of operating environments for the source code of the yolov5 project and a full set of operating environments for the source code of the yolox project. deepstream full set of operating environment and ros operating system (melodic)
（ Note 1）:This project has configured a full set of docker images for the ubuntu-x_86 platform and the nvidia-jetson platform. There is no need to configure a complicated software environment. One-click import and operation saves time and effort.。

（ Note 2）:In the future, this project will use Tencent Youtu’s ncnn acceleration library to optimize and deploy domestic AI chips such as Huawei HiSilicon 3559, Rockchip 3399pro, Kanzhi K210 and other domestic AI chips. Please look forward to it.！！！。

（ Note 3）:With the learning and growth of myself and the team, the project will be maintained and updated from time to time. Due to the limited ability, there are errors and deficiencies in the project. Please criticize and correct or leave a message in issue。

（ Note 4）:In order to facilitate everyone to learn and communicate, a CDR (cv-detect-robot) project communication WeChat group has been established. Please add the group leader Xiao Guo WeChat account 17370042325 to facilitate pulling you into the group。

CDR~ The -v4.0 version of the standard docker image of the whole system is updated as follows🔥🔥🔥🔥🔥：
The deepstream framework in CDR is upgraded to version 6.0 (tensorRT 8.0.1)
All sub-projects are adapted to the deepsort tracker (IOU, DCF and deepsort three trackers can be switched at will), and the target tracking IDs of all sub-projects can be obtained through rostopic, python scripts and cpp programs。
The whole system comes standard with docker mirroring. The project author has configured a full set of mirroring environments based on the x_86 platform and the nvidia-jetson platform for the CDR project, and comes with project mirroring operations and sub-project testing tutorials。
CDR x86 docker image usage and testing tutorial
CDR jetson docker image usage and testing tutorial
The CDR image has pt->wts->trt function (yolov5) and onnx-trt function (yolox)。
Each sub-project in the CDR image can have multi-stream detection. For details, please refer to the following link。
Multiple video stream detection method in docker image CDR project
Each sub-project in the CDR image has the functions of video file detection, usb camera detection and rtsp real-time stream detection.。
The CDR image has been configured with the complete operating environment of the yolov5 project source code, the complete operating environment of the yolox project source code, the complete operating environment of the deepstream and the complete operating environment of ros-melodic. For the specific environment configuration, please refer to the following link：
Introduction to the existing environment and corresponding version in the docker image CDR project
CDR x86 docker镜像和CDR jetson docker镜像环境配置和算法调试极其复杂，耗时巨大，但本着开源共享的精神，项目作者决定供全行业免费使用：
CDR x86 docker镜像(28G左右)下载链接如下(不限速)：

链接:http://112.74.111.51:1212/down/Dcyn8UvJ81Lg 提取码:Z78Din
CDR x86 docker镜像dockerhub下载(14.54 GB)命令：

docker pull gjy123456/cv-detect-robot:CDR-x86-v4.02

CDR jetson docker镜像(10G左右)下载链接如下(不限速)：

链接:http://112.74.111.51:1212/down/tSpLJEbUHvQC 提取码:nKTzyp
CDR jetson docker镜像(4.58G左右)dockerhub下载命令：

docker pull gjy123456/cv-detect-robot:CDR-jetson-v4.18

！！！若使用docker镜像，本行以下内容只作了解即可,若想从零开始配置环境则可参照以下内容！！！
CDR子项目(一)（yolov5-ros-deepstream）
yolov5-ros-deepstream 子项目简介
该项目是将yolov5视觉检测算法与神经网络加速引擎tensorRT结合，并在英伟达的deepstream框架下运行，结合ros1通信机制，将检测数据实时通过ros topic 发布出去。以供基于ROS机器人操作系统的开发人员及相关科研人员使用。

详细教程请进入yolov5-ros-deepstream

最终视频检测效果请进入yolov5-ros-deepstream检测

加入目标跟踪器视频检测效果请进入Jetson NX yolov5-ros-deepstream+目标跟踪

加入目标跟踪器视频检测效果请进入Jetson Nano yolov5-ros-deepstream+目标跟踪

CDR子项目(二)（yolov5-deepstream-python）
yolov5-deepstream-python 子项目简介
该项目是将视觉检测算法yolov5与神经网络加速引擎tensorRT结合,利用共享内存技术将检测所得到的数据实时储存到事先定义好的物理内存中（物理地址是唯一的），在同一硬件平台上的任意软件目录中，建立一个读取物理内存的client.py脚本文件（里面只包含一个读取内存的代码段），将指定好的物理内存中的数据读取出来，在读取成功的前提下，可将该代码段插入到任意需要目标检测数据的python项目中，从而使该python项目能顺利获取目标检测数据。

详细教程请进入yolov5-deepstream-python

最终视频检测效果请进入yolov5-deepstream-python检测

加入目标跟踪器视频检测效果请进入Jetson NX yolov5-python-deepstream+目标跟踪器

加入目标跟踪器视频检测效果请进入Jetson Nano yolov5-python-deepstream+目标跟踪器

CDR子项目(三)（yolov5-deepstream-cpp）
yolov5-deepstream-cpp 子项目简介
该项目是将视觉检测算法yolov5与神经网络加速引擎tensorRT结合,利用共享内存技术将检测所得到的数据实时储存到事先定义好的物理内存中（物理地址是唯一的），在同一硬件平台上的任意软件目录中，建立一个读取物理内存的yolov5_tensor.cpp文件（里面只包含一个读取内存的代码段），编译后可将指定好的物理内存中的数据读取出来，在读取成功的前提下，可将该代码段插入到任意需要目标检测数据的C++项目中，从而使该C++项目能顺利获取目标检测数据。

详细教程请进入yolov5-deepstream-cpp

最终视频检测效果请进入yolov5-deepstream-cpp检测

加入目标跟踪器视频检测效果请进入Jetson NX yolov5-cpp-deepstream+目标跟踪器

加入目标跟踪器视频检测效果请进入Jetson Nano yolov5-cpp-deepstream+目标跟踪器

CDR子项目(四)（yolox-ros-deepstream）
yolox-ros-deepstream 子项目简介
该项目是将yolox视觉检测算法与神经网络加速引擎tensorRT结合，本子项目采另一种引擎文件生成方法，通过onnx转到engine，此方法更具灵活性，也越来越稳定，符合行业主流发展趋势，在英伟达的deepstream框架下运行，结合ros通信机制，将检测数据实时通过ros topic 发布出去。以供基于ROS机器人操作系统的开发人员及相关科研人员使用。

详细教程请进入yolox-ros-deepstream

最终视频检测效果请进入yolox-ros-deepstream检测

加入目标跟踪器视频检测效果请进入Jetson NX yolox-ros-deepstream+目标跟踪器

加入目标跟踪器视频检测效果请进入Jetson Nano yolox-ros-deepstream+目标跟踪器

CDR子项目(五)（resnet10+ros+deepstream for python ）----(Jetson Nano and X_86)
该项目利用deepstream的python接口，基于英伟达针对性优化的resnet10.caffemodel模型,可利用英伟达新推出的(TAO) Toolkit工具包进行自定义数据集训练及模型优化，并继承CDR项目祖传的ros接口。不仅能在Jetson系列平台使用，通过docker容器技术，也可在Linux-x_86平台(Ubuntu)实现快速部署。经测试，该模型在Jetson Nano上可实现在检测算法和多目标跟踪算法同时加持情况下高达30fps的帧率(检测四种目标)，准确率可达90%以上(接近yolov5)。

详细教程请进入resnet10-ros-deepstream

最终视频检测效果请进入resnet10-ros-deepstream检测

加入目标跟踪器视频检测效果请进入Jetson NX resnet10-ros-deepstream+目标跟踪器

加入目标跟踪器视频检测效果请进入Jetson Nano resnet10-ros-deepstream+目标跟踪器

CDR子项目(六)（yolox-deepstream-python）
yolox-deepstream-python 子项目简介
该项目是将yolox视觉检测算法与神经网络加速引擎tensorRT结合，本子项目采另一种引擎文件生成方法，通过onnx转到engine，此方法更具灵活性，也越来越稳定，符合行业主流发展趋势，在英伟达的deepstream框架下运行，在同一硬件平台上的任意软件目录中，建立一个读取物理内存的client.py脚本文件（里面只包含一个读取内存的代码段），将指定好的物理内存中的数据读取出来，在读取成功的前提下，可将该代码段插入到任意需要目标检测数据的python项目中，从而使该python项目能顺利获取目标检测数据。

详细教程请进入yolox-deepstream-python

最终视频检测效果请进入yolox-deepstream-python检测

加入目标跟踪器视频检测效果请进入Jetson NX yolox-ros-deepstream+目标跟踪器

加入目标跟踪器视频检测效果请进入Jetson Nano yolox-ros-deepstream+目标跟踪器

CDR子项目(七)（yolox-deepstream-cpp）
yolox-deepstream-cpp 子项目简介
该项目是将yolox视觉检测算法与神经网络加速引擎tensorRT结合，本子项目采另一种引擎文件生成方法，通过onnx转到engine，此方法更具灵活性，也越来越稳定，符合行业主流发展趋势，在英伟达的deepstream框架下运行，在同一硬件平台上的任意软件目录中，建立一个读取物理内存的yolox_tensor.cpp文件（里面只包含一个读取内存的代码段），编译后可将指定好的物理内存中的数据读取出来，在读取成功的前提下，可将该代码段插入到任意需要目标检测数据的C++项目中，从而使该C++项目能顺利获取目标检测数据。

详细教程请进入yolox-deepstream-cpp

最终视频检测效果请进入yolox-deepstream-cpp检测

加入目标跟踪器视频检测效果请进入Jetson NX yolox-ros-deepstream+目标跟踪器

加入目标跟踪器视频检测效果请进入Jetson Nano yolox-ros-deepstream+目标跟踪器

CDR项目常见问题及其解决方案(Common problems and solutions)
Jetson Nano和 NX在运行CDR项目时注意事项
wts文件生成engine文件的方法
对多类目标中指定目标类别进行识别与跟踪
发文助手
发文助手会对标题提出优化建议，避免出现不恰当文字从而影响文章推荐。【标题规范】
