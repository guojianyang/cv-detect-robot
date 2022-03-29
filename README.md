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
- **`CDR x86 docker` image and `CDR jetson docker` image environment configuration and algorithm debugging are extremely complex and time-consuming, but in the spirit of open source sharing, the project author decided to make it available to the whole industry for free use**：
    -  [CDR x86 docker image](https://github.com/guojianyang/cv-detect-robot/wiki/CDR-x86-docker%E9%95%9C%E5%83%8F%E4%BD%BF%E7%94%A8%E5%8F%8A%E6%B5%8B%E8%AF%95%E6%95%99%E7%A8%8B)(About 28G)The download link is as follows (unlimited speed)：
       -   Link:`http://112.74.111.51:1212/down/Dcyn8UvJ81Lg` Extraction code:`Z78Din`
       
     - [CDR x86 docker image](https://github.com/guojianyang/cv-detect-robot/wiki/CDR-x86-docker%E9%95%9C%E5%83%8F%E4%BD%BF%E7%94%A8%E5%8F%8A%E6%B5%8B%E8%AF%95%E6%95%99%E7%A8%8B) dockerhub download(14.54 GB)Order：
        > `docker pull gjy123456/cv-detect-robot:CDR-x86-v4.02`
     ***
    -  [CDR jetson docker image](https://github.com/guojianyang/cv-detect-robot/wiki/CDR-jetson-docker%E9%95%9C%E5%83%8F%E4%BD%BF%E7%94%A8%E5%8F%8A%E6%B5%8B%E8%AF%95%E6%95%99%E7%A8%8B)(About 10G) The download link is as follows (unlimited speed)：
       - Link:`http://112.74.111.51:1212/down/tSpLJEbUHvQC` Extraction code:`nKTzyp`
       
  -  [CDR jetson docker image](https://github.com/guojianyang/cv-detect-robot/wiki/CDR-jetson-docker%E9%95%9C%E5%83%8F%E4%BD%BF%E7%94%A8%E5%8F%8A%E6%B5%8B%E8%AF%95%E6%95%99%E7%A8%8B)(about 4.58G)dockerhubdownload command：
      >`docker pull gjy123456/cv-detect-robot:CDR-jetson-v4.18`
   
   
***
***
# ! ! ! If you use docker image, the following content in this line is only for understanding. If you want to configure the environment from scratch, you can refer to the following content! ！！！
***
#  CDR sub-project（1）（yolov5-ros-deepstream）
-  Introduction to the yolov5-ros-deepstream subproject
> This project combines the yolov5 visual detection algorithm with the neural network acceleration engine tensorRT, and runs under the deepstream framework of NVIDIA. Combined with the ros1 communication mechanism, the detection data is released in real time through the ros topic. For developers and related researchers based on ROS robot operating system。

>Please enter the detailed tutorial[yolov5-ros-deepstream](https://github.com/guojianyang/cv-detect-robot/blob/main/yolov5-ros-deepstream)

>Please enter the final video detection effect[yolov5-ros-deepstream detect](https://www.bilibili.com/video/BV1Lo4y1Q79C/)
>
>Add the target tracker video detection effect, please enter[Jetson NX yolov5-ros-deepstream+Target Tracking](https://www.bilibili.com/video/BV1u34y1673W?spm_id_from=333.999.0.0)
>
>Add the target tracker video detection effect, please enter[Jetson Nano yolov5-ros-deepstream+Target Tracking](https://www.bilibili.com/video/BV1pS4y1Z7cX?spm_id_from=333.999.0.0)

# CDR sub-project（2）（yolov5-deepstream-python）
-  Introduction to the yolov5-deepstream-python subproject
> This project combines the visual detection algorithm yolov5 with the neural network acceleration engine tensorRT, and uses the shared memory technology to store the data obtained from the detection in the pre-defined physical memory in real time (the physical address is unique). In any software directory, create a `client.py` script file for reading physical memory (it only contains a code segment for reading memory), and read the data in the specified physical memory. Under the premise, the code segment can be inserted into any python project that needs target detection data, so that the python project can successfully obtain the target detection data。

> Please enter the detailed tutorial[yolov5-deepstream-python](https://github.com/guojianyang/cv-detect-robot/tree/main/yolov5-deepstream-python)

> Please enter the final video detection effect[yolov5-deepstream-python](https://www.bilibili.com/video/BV1Uv411E755/)
> 
>Add the target tracker video detection effect, please enter[Jetson NX yolov5-python-deepstream+target tracker](https://www.bilibili.com/video/BV1u34y1673W?spm_id_from=333.999.0.0)
>
>Add the target tracker video detection effect, please enter[Jetson Nano yolov5-python-deepstream+target tracker](https://www.bilibili.com/video/BV1pS4y1Z7cX?spm_id_from=333.999.0.0)

#  CDR sub-project（3）（yolov5-deepstream-cpp）
- Introduction to the yolov5-deepstream-cpp subproject
> This project combines the visual detection algorithm yolov5 with the neural network acceleration engine tensorRT, and uses the shared memory technology to store the data obtained from the detection in the pre-defined physical memory in real time (the physical address is unique). In any software directory, create a `yolov5_tensor.cpp` file for reading physical memory (it only contains a code segment for reading memory). After compiling, the data in the specified physical memory can be read out. Under the premise of success, the code segment can be inserted into any C++ project that needs target detection data, so that the C++ project can successfully obtain target detection data.

> Please enter the detailed tutorial[yolov5-deepstream-cpp](https://github.com/guojianyang/cv-detect-robot/tree/main/yolov5-deepstream-cpp)

> Please enter the final video detection effect[yolov5-deepstream-cpp-detection](https://www.bilibili.com/video/BV1yV411p7Dx/)
> 
> Add the target tracker video detection effect, please enter[Jetson NX yolov5-cpp-deepstream+target tracker](https://www.bilibili.com/video/BV1u34y1673W?spm_id_from=333.999.0.0)
> 
> Add the target tracker video detection effect, please enter[Jetson Nano yolov5-cpp-deepstream+target tracker](https://www.bilibili.com/video/BV1pS4y1Z7cX?spm_id_from=333.999.0.0)

#  CDR sub-project（4）（yolox-ros-deepstream）
- Introduction to the yolox-ros-deepstream subproject
> This project combines the yolox visual detection algorithm with the neural network acceleration engine tensorRT. This sub-project adopts another engine file generation method, which is transferred to the engine through onnx. This method is more flexible and more stable, which is in line with the mainstream development of the industry. Trend, runs under NVIDIA's deepstream framework, combined with ros communication mechanism, and publishes detection data in real time through ros topic. For developers and related researchers based on ROS robot operating system.

> Please enter the detailed tutorial[yolox-ros-deepstream](https://github.com/guojianyang/cv-detect-robot/tree/main/yolox-ros-deepstream)

> Please enter the final video detection effect[yolox-ros-deepstream-detection](https://www.bilibili.com/video/BV1k34y1o7Ck/)
> 
> Add the target tracker video detection effect, please enter[Jetson NX yolox-ros-deepstream+target tracker]](https://www.bilibili.com/video/BV1W34y1B7YB?spm_id_from=333.999.0.0)
> 
> Add the target tracker video detection effect, please enter[Jetson Nano yolox-ros-deepstream+target tracker]](https://www.bilibili.com/video/BV1Tq4y1A7km?spm_id_from=333.999.0.0)

#  CDR sub-project（5）（resnet10+ros+deepstream `for python` ）----(Jetson Nano `and` X_86) 
> This project uses the python interface of `deepstream`, based on the `resnet10.caffemodel` model optimized by NVIDIA, and can use NVIDIA's new `(TAO) Toolkit` toolkit for custom data set training and model optimization, and inherits CDR The ros interface of the project heirloom. It can not only be used on Jetson series platforms, but also can be quickly deployed on Linux-x_86 platform (Ubuntu) through docker container technology. After testing, the model can achieve a frame rate of up to 30fps (detect four types of targets) on Jetson Nano when the detection algorithm and multi-target tracking algorithm are simultaneously supported, and the accuracy rate can reach more than 90% (close to yolov5)。

>Please enter the detailed tutorial[resnet10-ros-deepstream](https://github.com/guojianyang/cv-detect-robot/blob/main/resnet10-ros-deepstream/README.md)

> Please enter the final video detection effect[resnet10-ros-deepstream-detection](https://www.bilibili.com/video/BV1Xg411w78P/)
> 
> Add the target tracker video detection effect, please enter[Jetson NX resnet10-ros-deepstream+target tracker](https://www.bilibili.com/video/BV1Fr4y1v7AM?spm_id_from=333.999.0.0)
> 
> Add the target tracker video detection effect, please enter[Jetson Nano resnet10-ros-deepstream+target tracker](https://www.bilibili.com/video/BV1p34y1B7Vx?spm_id_from=333.999.0.0)

#  CDR sub-project（6）（yolox-deepstream-python）
- Introduction to the yolox-deepstream-python subproject
> This project combines the yolox visual detection algorithm with the neural network acceleration engine tensorRT. This sub-project adopts another engine file generation method, which is transferred to the engine through onnx. This method is more flexible and more stable, which is in line with the mainstream development of the industry. Trend, run under NVIDIA's deepstream framework, in any software directory on the same hardware platform, create a `client.py` script file that reads physical memory (it only contains a code segment for reading memory), will specify The data in the good physical memory is read out. On the premise of successful reading, the code segment can be inserted into any python project that needs target detection data, so that the python project can successfully obtain the target detection data.

> Please enter the detailed tutorial[yolox-deepstream-python](https://github.com/guojianyang/cv-detect-robot/tree/main/yolox-deepstream-python)

> Please enter the final video detection effect[yolox-deepstream-python-detection](https://www.bilibili.com/video/BV1k34y1o7Ck/)
> 
> Add the target tracker video detection effect, please enter[Jetson NX yolox-ros-deepstream+target tracker器](https://www.bilibili.com/video/BV1W34y1B7YB?spm_id_from=333.999.0.0)
> 
> Add the target tracker video detection effect, please enter[Jetson Nano yolox-ros-deepstream+target tracker](https://www.bilibili.com/video/BV1Tq4y1A7km?spm_id_from=333.999.0.0)

#  CDR sub-project（6）（yolox-deepstream-cpp）
- Introduction to the yolox-deepstream-cpp subproject
> This project combines the yolox visual detection algorithm with the neural network acceleration engine tensorRT. This sub-project adopts another engine file generation method, which is transferred to the engine through onnx. This method is more flexible and more stable, which is in line with the mainstream development of the industry. Trend, run under NVIDIA's deepstream framework, in any software directory on the same hardware platform, create a `yolox_tensor. Read the data in the specified physical memory. On the premise of successful reading, the code segment can be inserted into any C++ project that needs target detection data, so that the C++ project can successfully obtain the target detection data.

> Please enter the detailed tutorial[yolox-deepstream-cpp](https://github.com/guojianyang/cv-detect-robot/tree/main/yolox-deepstream-cpp)

> Please enter the final video detection effect[yolox-deepstream-cpp-detection](https://www.bilibili.com/video/BV1k34y1o7Ck/)
> 
>Add the target tracker video detection effect, please enter[Jetson NX yolox-ros-deepstream+target tracker](https://www.bilibili.com/video/BV1W34y1B7YB?spm_id_from=333.999.0.0)
> 
> Add the target tracker video detection effect, please enter[Jetson Nano yolox-ros-deepstream+target tracker](https://www.bilibili.com/video/BV1Tq4y1A7km?spm_id_from=333.999.0.0)

#  [Common problems and solutions of CDR projects(Common problems and solutions)](https://github.com/guojianyang/cv-detect-robot/wiki/CDR%E9%A1%B9%E7%9B%AE%E5%B8%B8%E8%A7%81%E9%97%AE%E9%A2%98%E5%8F%8A%E5%85%B6%E8%A7%A3%E5%86%B3%E6%96%B9%E6%A1%88(Common-problems-and-solutions))
#  [Jetson Nano and NX for Considerations when running a CDR project](https://github.com/guojianyang/cv-detect-robot/wiki/Jetson-Nano%E5%92%8C-NX%E5%9C%A8%E8%BF%90%E8%A1%8CCDR%E9%A1%B9%E7%9B%AE%E6%97%B6%E6%B3%A8%E6%84%8F%E4%BA%8B%E9%A1%B9)
#  [How to generate engine file from wts file](https://github.com/guojianyang/cv-detect-robot/wiki/wts%E6%96%87%E4%BB%B6%E7%94%9F%E6%88%90engine%E6%96%87%E4%BB%B6%E7%9A%84%E6%96%B9%E6%B3%95)
#  [Identify and track the specified target category in multi-category targets](https://github.com/guojianyang/cv-detect-robot/wiki/%E5%AF%B9%E5%A4%9A%E7%B1%BB%E7%9B%AE%E6%A0%87%E4%B8%AD%E6%8C%87%E5%AE%9A%E7%9B%AE%E6%A0%87%E7%B1%BB%E5%88%AB%E8%BF%9B%E8%A1%8C%E8%AF%86%E5%88%AB%E4%B8%8E%E8%B7%9F%E8%B8%AA)

https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker
