#  CDR子项目(五)（resnet10-ros-deepstream）
## [中文] | [[English]](https://github.com/guojianyang/cv-detect-robot/blob/main/yolox-ros-deepstream/README_EN.md)
****
****
## 一、Jetson Nano 平台运行指导教程
### 硬件环境
- 英伟达jetson nano 板载计算机(原则上jetson 系列产品都能适配此项目)
- 鼠标键盘（推荐使用有线连接方式）
- 显示器
###  软件环境
- Jetpack  4.5.1 （ubuntu 18.04）
- TensorRT  7.1
- CUDA  10.2
- cuDNN  8.0
- OpenCV  4.1.1
- deepstream  5.1

###  (一)、安装ROS操作系统
 **备注**：（以下操作最好在搭建梯子或者更换国内源的情况下进行，否则下载速度很慢）

#### 1. 请参考ROS官方安装连接： [官方安装教程](http://wiki.ros.org/ROS/Installation)
     也可按以下步骤安装：

    - sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
    - sudo apt install curl 
    - curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -(**若出现`gpg: no valid OpenPGP data found`可直接跳过 **)
    - sudo apt update
    - sudo apt install ros-melodic-desktop-full
    - echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
    - source ~/.bashrc
    - source /opt/ros/melodic/setup.bash
    - sudo apt install python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential
    - sudo apt install python-rosdep
    - sudo rosdep init
    - rosdep update
- 以上步骤执行完成后，可尝试在终端运行`roscore`命令，若出现下图所示，说明ros安装正常：
![enter image description here](https://img-blog.csdnimg.cn/20210728132459897.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NjQzODU3Ng==,size_16,color_FFFFFF,t_70)
***
###  (二)、安装DeepStream on Nano(Jetpack 4.5.1)
(**备注**):若使用SDKManager软件对Nano进行刷机，且刷入系统时选择了DeepStream 5.１选项，便会自动安装DeepStream5.1，无需进行以下手动安装。
####  １．安装依赖
执行下面命令来安装需要的软件包（也可逐个库进行安装，测试时发现一起安装偶尔会出现问题）：
	sudo apt install \
	libssl1.0.0 \
	libgstreamer1.0-0 \
	gstreamer1.0-tools \
	gstreamer1.0-plugins-good \
	gstreamer1.0-plugins-bad \
	gstreamer1.0-plugins-ugly \
	gstreamer1.0-libav \
	libgstrtspserver-1.0-0 \
	libjansson4=2.11-1
####  ２．安装 DeepStream SDK

 - 进入[官方DeepStream SDK](https://developer.nvidia.com/embedded/deepstream-on-jetson-downloads-archived)选择`DeepStream 5.1 for Jetson`并下载(Jetpack 4.5.1 向下兼容)
 （**备注**）：也可在本人提供**相关资源百度云盘链接**中下载deepstream_sdk_5.1_jetson.tbz2文件包
![enter image description here](https://img-blog.csdnimg.cn/9c5c7cd9a99b434db493350a0d207638.jpg?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBA6YOt5bu65rSL,size_20,color_FFFFFF,t_70,g_se,x_16)

 - 下载后得到压缩文件`deepstream_sdk_5.1_jetson.tbz2`，输入以下命令以提取并安装DeepStream SDK:

    sudo tar -xvf deepstream_sdk_5.1_jetson.tbz2 -C /
    cd /opt/nvidia/deepstream/deepstream-5.1
    sudo ./install.sh
    sudo ldconfig
    

 - DeepStream测试
    - 执行以下命令：
    >  cd /opt/nvidia/deepstream/deepstream-5.1/sources/objectDetector_Yolo
    - 执行编译命令(其中`10.2`根据CUDA的版本决定)
     >`sudo  CUDA_VER=10.2 make -C nvdsinfer_custom_impl_Yolo`

	出现如下图所示结果，说明编译成功：
![enter image description here](https://img-blog.csdnimg.cn/20210728140820363.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NjQzODU3Ng==,size_16,color_FFFFFF,t_70)

    - 编辑文件prebuild.sh并注释掉除yolov3-tiny的语句
执行以下命令（下载yolov3-tiny.cfg和yolov3-tiny.weights）：

       > sudo ./prebuild.sh
    - 执行命令：
       > deepstream-app -c deepstream_app_config_yoloV3_tiny.txt

       若能生成相关engine引擎并启动视频流检测，则说明DeepStream SDK安装成功,如下图所示：
![guo](https://img-blog.csdnimg.cn/20210728142452372.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NjQzODU3Ng==,size_16,color_FFFFFF,t_70)![enter image description here](https://img-blog.csdnimg.cn/20210728142507966.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NjQzODU3Ng==,size_16,color_FFFFFF,t_70)

####  3．导入deepstream_python_apps安装包，并配置相关python环境
- 从github下载`cv-detect-robot`文件夹至home目录，并将`resnet10+ros+deepstream`目录下的`deepstream-python-apps`文件夹复制到`/opt/nvidia/deepstream/deepstream-5.1/sources`目录下并赋予该目录权限：
   >  cd ~/
   
   >  git clone https://github.com/guojianyang/cv-detect-robot.git
   
   >  sudo cp -r cv-detect-robot/resnet10-ros-deepstream/deepstream-python-apps /opt/nvidia/deepstream/deepstream-5.1/sources/
   
   >  sudo chmod -R 777 /opt/nvidia/deepstream/deepstream-5.1/sources/
 - 配置deepstream运行的相关python环境
   - 默认情况下，Gst python 已经安装在 Jetson Nano 平台上，如果输入`import gi` 没有反应，则需运行如下命令行进行安装：
     > sudo apt-get install python-gi-dev
     
     > export GST_LIBS="-lgstreamer-1.0 -lgobject-2.0 -lglib-2.0"
     
     > export GST_CFLAGS="-pthread -I/usr/include/gstreamer-1.0 -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include"
     
     > git clone https://github.com/GStreamer/gst-python.git
     
     > cd gst-python
     
     > git checkout 1a8f48a
     
     > ./autogen.sh PYTHON=python3
     
     > ./configure PYTHON=python3
     
     > make
     
     > sudo make install
     
    - 进行运行环境测试
      - 在python终端逐次输入如下命令，无报错则说明安装python环境成功：
         > import cv2
         
         > import numpy
         
         > import gi
         
         > import pyds
         
         >import configparser
         
         >from typing import Container
         
         >import sys
         
         > import os.path
         
         >from os import path
         
         >from gi.repository import GObject, Gst
         
  ####  4．搭建自定义的rostpoic话题消息的工作空间boxes_ws，建立ros接口
   - 将`home`文件夹下的`cv-detect-robot/resnet10-ros-deepstream/boxes_ws`文件夹(boxes_ws)单独复制到home目录下
   
     > sudo cp -r ~/cv-detect-robot/resnet10-ros-deepstream/boxes_ws ~/
     
   - 进入boxes_ws文件夹，编译ros工作空间
      > cd ~/boxes_ws
      
       - boxes_ws目录下若有 build和devel文件,则需删除后再编译,否则无需执行本步骤
            > rm -r build devel
            
   - 编译
      >catkin_make
      
   - 编译成功后，需将boxes_ws工作空间添加环境变量
      > echo "source ~/boxes_ws/devel/setup.bash" >> ~/.bashrc
      
      > source ~/.bashrc
      
   - 将src下功能包darknet_ros_msgs建立软连接至/opt/nvidia/deepstream/deepstream-5.1/sources/deepstream_python_apps/apps/deepstream-test7目录下
      > cd ~/boxes_ws/src
      
      > ln -s ~/boxes_ws/src/darknet_ros_msgs /opt/nvidia/deepstream/deepstream-5.1/sources/deepstream_python_apps/apps/deepstream-test7/
      
   - 测试ros接口是否成功建立
    
      >cd /opt/nvidia/deepstream/deepstream-5.1/sources/deepstream_python_apps/apps/deepstream-test7/
      
      - 在当前目录终端下运行`python2`(一定要python2),并导入以下功能包：
      
        >from darknet_ros_msgs.msg import BoundingBox,BoundingBoxes
        
         若以上导入没有报错，则说明ros接口创建成功！！！  
         
  ####  5．介绍配置文件，并执行deepstream推理程序
 - deepstream-test7目录下文件介绍
 
 ![在这里插入图片描述](https://img-blog.csdnimg.cn/be54c17437a246b4833deabd0755d000.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA6YOt5bu65rSL,size_20,color_FFFFFF,t_70,g_se,x_16)
 
    - ①-- 发布检测的目标及其跟踪数据的ros节点
    - ②-- deepstream推理主程序
    - ③-- 一级推理模型：检测四类目标(行人、自行车、车辆、路标)
    - ④-- 二级推理模型：推理前级已被检测到的目标的颜色
    - ⑤-- 跟踪器配置文件
    - ⑥-- 共享内存txt文件(实时动态储存推理得到的结果数据)
    - ⑦-- 目录解释文件
    - ⑧-- 跟踪器参数配置文件
 
 - 运行`deepstream`推理程序并启动`ros`数据发布节点
   - 运行推理程序
     > cd /opt/nvidia/deepstream/deepstream-5.1/sources/deepstream_python_apps/apps/deepstream-test7/
     
     > python3 deepstream-test_7.py
    
     注意：运行python3 deepstream-test_7.py 命令后，随即出现实时检测视频窗口，终端命令行出现检测数据，如下图：
  ![在这里插入图片描述](https://img-blog.csdnimg.cn/61ee91f170424f57925e091f4fa6f5dd.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA6YOt5bu65rSL,size_20,color_FFFFFF,t_70,g_se,x_16)
   - 运行`roscore`并启动数据发布节点
      >  cd ~/
      > roscore
      
      - 再开一终端，运行如下指令
        > cd /opt/nvidia/deepstream/deepstream-5.1/sources/deepstream_python_apps/apps/deepstream-test7/
        
        > python2 client_ros_7.py
        
    - 检测上述节点发布的话题，并实时打印话题内容
      - 检测是否已发布话题(topic)
        > cd ~/
        > rosropic list
        
        若存名称在为`boundingboxes`的话题，则说明话题发布成功
        
      - 打印上述话题(topic)
        > rostopic echo /boundingboxes
        
        出现如下图所示，说明检测及跟踪数据通过ros节点发布成功
        ![在这里插入图片描述](https://img-blog.csdnimg.cn/eef3c6fac485429c804a6086328020c9.jpg?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA6YOt5bu65rSL,size_20,color_FFFFFF,t_70,g_se,x_16)
    - 视频文件及模型输入接口
      - 视频文件输入接口在推理主程序中第164行左右，如下图所示：
          ![在这里插入图片描述](https://img-blog.csdnimg.cn/0e8ec23a1277424b8e5ea2bd2f3d7b86.jpg?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA6YOt5bu65rSL,size_20,color_FFFFFF,t_70,g_se,x_16)
       - 一二级模型输入接口分别在`dstest7_pgie_config.txt`和`dstest7_sgie1_config.txt`文件中，如下图所示：
       
         - 一级模型![在这里插入图片描述](https://img-blog.csdnimg.cn/30b5c8ae0dd74b0aa365f96868b6740a.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA6YOt5bu65rSL,size_20,color_FFFFFF,t_70,g_se,x_16)
         - 二级模型
      ![在这里插入图片描述](https://img-blog.csdnimg.cn/54619093a67b430cab080a6bd59e4074.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA6YOt5bu65rSL,size_20,color_FFFFFF,t_70,g_se,x_16)
***
***
## （二）X_86 平台运行指导教程（采用docker容器技术）
###  简介：
对于X_86平台的deepstream部署，通过镜像文件，只需十几分钟就能在x_86平台部署并成功运行。本团队已配置好相关镜像文件。在安装显卡驱动、docker和nvidia-docker后，导入镜像，一键运行！！
- 安装显卡驱动（本次测试基于`Ubuntu 18.04-x_86`平台）
   - 若x_86平台上已安装显卡驱动，则无需再次安装。若未安装显卡驱动，可参考以下教程：
   [Ubuntu 18.04 安装 NVIDIA 显卡驱动超详细步骤](https://blog.csdn.net/yaohuan2017/article/details/108670724)
   - 特别注意：nvidia-docker暂时不支持windows平台，本次测试为3060台式机显卡，测试失败的笔记本显卡型号为MX250，其它显卡请大家自行测试。
 - 安装`docker`和`nvidia-docker`
   - 可参考以下两条链接
      - [nvidia-docker2 安装](https://www.cnblogs.com/liudsl/p/15272297.html)
      - [NVidia-Docker2安装与常用命令](https://www.cnblogs.com/jimchen1218/p/14186262.html)
  - 下载团队配置好的镜像文件并导入docker
         镜像链接如下：---------------------------------------------------------------------------------------------------------------
     - 镜像文件为tar文件，在该文件目录下打开终端，并执行如下命令(其中`file_name`为文件名)：
         > sudo docker load -i file_name.tar
        
         没有报错的话说明镜像文件加载成功，可通过`sudo docker images`命令查看镜像文件是否导入成功
  - 使用已导入的镜像文件生成容器
     - 生成容器前，需要宿主机终端运行`xhost +`命令，已确保容器中输出的图像信息能够在宿主机上显示
     - 运行如下指令生成容器：
        > sudo docker run -it -d -p 8888:22 --gpus '"'device=0'"' --name="guo1" --privileged=true -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -w /opt/nvidia/deepstream/deepstream-5.1 deepstream51:v1.0 /sbin/init

        该容器开放22端口，以供有需要的开发人员做ssh远程连接，容器名字为guo1
- 在容器中执行推理程序
   - 在执行推理程序之前，先进入deepstream-test7目录下:
      > cd  /opt/nvidia/deepstream/deepstream-5.1/sources/deepstream_python_apps/apps/deepstream-test7/
    - 运行推理程序
      > python3 deepstream-test_7.py
      
      命令行终端出现目标相关数据输出且跳出实时检测图像说明测试成功，以下时测试效果视频链接：
      [resnet10-ros-deepstream x_86-docker测试](https://www.bilibili.com/video/BV1Xm4y1X7X2/)
- 如何搭建ros接口请参考 本文档第一部分《Jetson Nano 平台运行指导教程》
      
       
         
