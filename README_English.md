#  cv-detect-ros(CDR)项目介绍
**cv-detect-ros项目的立项宗旨**：为基于ROS机器人操作系统开发机器人、无人机、无人车等相关人工智能产品，且有视觉检测需求的开发者提供前沿高性能视觉检测及其相关算法的ros接口。
（ **备注**）:已接入本项目的视觉检测算法都已经做好了ROS系统的适配，待相关软硬件环境搭建好后即可直接调用已定义好的ros话题消息获取目标检测实时数据。
***
***
#  cv-detect-ros子项目(一)（yolov5-ros-deepstream）
##  硬件环境
- 英伟达TX2板载计算机
- 鼠标键盘（推荐使用有线连接方式）
##  软件环境
- Jetpack  4.5 （ubuntu 18.04）
- TensorRT  7.1
- CUDA  10.2
- cuDNN  8.0
- OpenCV  4.1.1
- deepstream  5.0
##  一、安装ROS操作系统
请参考ROS官方安装连接： [官方安装教程](http://wiki.ros.org/ROS/Installation)
也可按以下步骤安装：

    - sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
    - sudo apt install curl # if you haven't already installed curl
    - curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
    - sudo apt update
    - sudo apt install ros-melodic-desktop-full
    - echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
    - source ~/.bashrc
    - source /opt/ros/melodic/setup.bash
    - sudo apt install python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential
    - sudo apt install python-rosdep
    - sudo rosdep init
    - rosdep update
***
##  二、安装DeepStream on TX2(Jetpack 4.5)
(**备注**):若使用SDKManager软件对TX2进行刷机，且刷入系统时选择了DeepStream 5.0选项，便会自动安装		DeepStream，无需进行以下手动安装。
###  １．安装依赖
执行下面命令来安装需要的软件包：

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
###  ２．安装 DeepStream SDK

 （１）进入[官方DeepStream SDK](https://developer.nvidia.com/embedded/deepstream-on-jetson-downloads-archived)选择｀`DeepStream 5.0 for Jetson`并下载(Jetpack 4.5 向下兼容)
![enter image description here](https://img-blog.csdnimg.cn/20210727094413306.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NjQzODU3Ng==,size_16,color_FFFFFF,t_70)
 （２）下载后得到压缩文件`deepstream_sdk_5.0_jetson.tbz2`，输入以下命令以提取并安装DeepStream SDK:

    sudo tar -xvf deepstream_sdk_5.0_jetson.tbz2 -C /
    cd /opt/nvidia/deepstream/deepstream-5.０
    sudo ./install.sh
    sudo ldconfig
    

 （３） DeepStream测试
 - 执行以下命令：

> cd /opt/nvidia/deepstream/deepstream-5.０/sources/objectDetector_Yolo
 - 执行编译命令
> CUDA_VER=10.2 make -C nvdsinfer_custom_impl_Yolo

- 编辑文件prebuild.sh并注释掉除yolov3-tiny的语句
执行以下命令（下载yolov3-tiny.cfg和yolov3-tiny.weights）：

> ./prebuild.sh
- 执行命令：
> deepstream-app -c deepstream_app_config_yoloV3_tiny.txt

若能生成相关engine引擎并启动视频流检测，则说明DeepStream SDK安装成功。
***
## 三、将本人设计好的yolov5-ros-deepstream文件拷贝到相应文件夹下并编译
 1. **首先对我们所要操作的文件夹赋予权限**

> sudo chmod -R 777 /opt/nvidia/deepstream/deepstream-5.0/sources/
 2. **再拷贝yolov5-ros-deepstream文件到opt/nvidia/deepstream/deepstream-5.０/sources/**
>cp yolov5-ros-deepstream /opt/nvidia/deepstream/deepstream-5.０/sources/
 3. **然后进入拷贝的目标文件夹**
 > cd /opt/nvidia/deepstream/deepstream-5.1/sources
 
 4. **yolov5-ros-deepstream文件夹下的内容如下图所示：**
 ![yolov5-ros-deepstream-dir](https://img-blog.csdnimg.cn/20210727110731217.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NjQzODU3Ng==,size_16,color_FFFFFF,t_70)
 - 文件夹下内容相关解释如下:

>vdsinfer_custom_impl_Yolo--------------------------存放yolov5-ros-deepstream子项目的源码及被编译文件夹

>origin_yolov5------------------------------------------存放yolov5相关模型的引擎文件engine

>video----------------------------------------------------存放被检测的相关视频文件

>config_infer_number_sv30.txt------------------------自定义的数字检测引擎number_v30.engnine的基础配置文件

>deepstream_app_number_sv30.txt------------------启动数字检测引擎number_v30.engnine的启动配置文件

>config_infer_primary.txt-------------------------------官方提供的yolov5s.engine引擎的基础配置文件

>deepstream_app_config.txt---------------------------官方提供的yolov5s.engine引擎的启动配置文件

>abels.txt-------------------------------------------------官方提供的yolov5s.engine引擎的标签配置文件

>number_v30.txt----------------------------------------自定义的数字检测引擎number_v30.engnin的标签配置文件 

>yolov5s.engine------------------------------------------yolov5s.pt模型的引擎文件

>number_v30.engine------------------------------------number_v30s.pt模型的引擎文件

>source1_csi_dec_infer_yolov5.txt--------------------启动csi摄像头实时检测

>source1_usb_dec_infer_yolov5.txt--------------------启动csi摄像头实时检测

 5. **编译yolov5-ros-deepstream源码**
 > cd /opt/nvidia/deepstream/deepstream-5.0/sources/yolov5-ros-deepstream
 > CUDA_VER=10.2 make -C nvdsinfer_custom_impl_Yolo
***
##  四、运行测试
###  1.运行yolov5s.engine引擎测试视频文件夹video内的视频文件内的视频
> cd /opt/nvidia/deepstream/deepstream-5.0/sources/yolov5-ros-deepstream
> deepstream-app -c deepstream_app_config.txt
###  2.运行number_v30.engine引擎测试视频文件夹video内的视频文件内的视频
> cd /opt/nvidia/deepstream/deepstream-5.0/sources/yolov5-ros-deepstream
> deepstream-app -c deepstream_app_number_sv30.txt
###  3.YOLOv5 USB摄像头视频测试命令
> deepstream-app -c source1_usb_dec_infer_yolov5.txt
###  4.YOLOv5 CSI 摄像头视频测试命令
> deepstream-app -c source1_csi_dec_infer_yolov5.txt
