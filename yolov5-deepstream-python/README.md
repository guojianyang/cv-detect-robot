#  CDR子项目(二)（yolov5-deepstream-python）
## [中文] | [[English]](https://github.com/guojianyang/cv-detect-robot/blob/main/yolov5-deepstream-python/README_EN.md)
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
**备注**：（以下操作最好在搭建梯子或者更换国内源的情况下进行，否则下载速度很慢）

请参考ROS官方安装连接： [官方安装教程](http://wiki.ros.org/ROS/Installation)
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

 （１）进入[官方DeepStream SDK](https://developer.nvidia.com/embedded/deepstream-on-jetson-downloads-archived)选择`DeepStream 5.0 for Jetson`并下载(Jetpack 4.5 向下兼容)
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
***
## 三、从github克隆`cv-detect-robot`项目，并将本人设计好的`yolov5-deepstream-python`子项目的相关子文件夹拷贝到相应目录下进行编译

 1. **从github克隆`cv-detect-robot`项目**（建议在搭建梯子的环境下进行git clone）
 > 先按　`ctrl + alt +t` 进入终端（默认克隆的文件在家目录下）

> git clone  -b v3.0 https://github.com/guojianyang/cv-detect-ros.git

 2. **首先对我们所要操作的文件夹赋予权限**

> sudo chmod -R 777 /opt/nvidia/deepstream/deepstream-5.0/sources/
 3. **再拷贝cv-detect-ros/yolov5-deepstream-python/yolov5-io-python文件夹到opt/nvidia/deepstream/deepstream-5.０/sources/**
>sudo cp ~/cv-detect-ros/yolov5-deepstream-python/yolov5-io-python /opt/nvidia/deepstream/deepstream-5.０/sources/
 4. **然后进入拷贝的目标文件夹 /opt/nvidia/deepstream/deepstream-5.０/sources/**
 > cd /opt/nvidia/deepstream/deepstream-5.0/sources

> 在该文件夹下有yolov5-io-python目录，但是打开目录后没有发现下图中的`video`文件夹，这是由于`video`体量大，受到github上传容量限制，`video`视频文件可自行在以下百度网盘链接下载：

> 链接: https://pan.baidu.com/s/1V_AftufqGdym4EEKJ0RnpQ  密码: fr8u
 5. **yolov5-io-python文件夹下的内容如下图所示：**


 ![yolov5-ros-deepstream-dir](https://img-blog.csdnimg.cn/2021073014310356.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NjQzODU3Ng==,size_16,color_FFFFFF,t_70)
 - 文件夹下内容相关解释如下:

>vdsinfer_custom_impl_Yolo--------------------------存放yolov5-deepstream-python子项目的源码及被编译文件夹

>client_ros.py-------------------------------------------存放python版本的发布目标检测数据的ros节点

>video----------------------------------------------------存放被检测的相关视频文件

>config_infer_number_sv30.txt------------------------自定义的数字检测引擎number_v30.engnine的基础配置文件

>deepstream_app_number_sv30.txt------------------启动数字检测引擎number_v30.engnine的启动配置文件

>config_infer_primary.txt-------------------------------官方提供的yolov5s.engine引擎的基础配置文件

>deepstream_app_config.txt---------------------------官方提供的yolov5s.engine引擎的启动配置文件

>abels.txt-------------------------------------------------官方提供的yolov5s.engine引擎的标签配置文件

>number_v30.txt----------------------------------------自定义的数字检测引擎number_v30.engnin的标签配置文件 

> download_engine.txt ---------------------------------通过里面的链接下载“number_v30.engnine”和“yolov5s.engine”

>source1_csi_dec_infer_yolov5.txt--------------------启动csi摄像头实时检测

>source1_usb_dec_infer_yolov5.txt--------------------启动csi摄像头实时检测

6. **下载引擎文件**

 > 由于受到github上传容量限制
>
> `请通过以下百度网盘链接下载引擎文件夹Jetson_engine(包含Nano_engine和NX_engine)：

- **备注**：生成引擎文件的原模型pt或wts文件放于以下链接中，因为引擎文件在非同一硬件平台可能会出现问题，如以上下载的引擎文件运行报错，可通过pt和wts文件生成新的engine引擎文件。
链接: https://pan.baidu.com/s/11AadDRDod8zlmlye5w4Msg?pwd=6a76  密码: 6a76


 7. **编译yolov5-deepstream-python/yolov5-io-python源码**
 > cd /opt/nvidia/deepstream/deepstream-5.0/sources/yolov5-io-python/

 > CUDA_VER=10.2 make -C nvdsinfer_custom_impl_Yolo



##  四、运行测试
###  １.运行number_v30.engine引擎测试视频文件夹video内的视频文件内的视频
> cd /opt/nvidia/deepstream/deepstream-5.0/sources/yolov5-io-python
> deepstream-app -c deepstream_app_number_sv30.txt
- 正常运行`number_v30.engine`引擎后，会出现实时检测数字的视频流，在命令框里可看到运行帧率(FPS)
- 启动 client.py脚本读取目标检测数据并打印出来(建议使用python2做运行 client.py)
> python2 client.py
> 正常运行时如下图所示：
![enter image description here](https://img-blog.csdnimg.cn/20210730113208984.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NjQzODU3Ng==,size_16,color_FFFFFF,t_70)

###  ２.运行yolov5s.engine引擎测试视频文件夹video内的视频文件内的视频
> cd /opt/nvidia/deepstream/deepstream-5.0/sources/yolov5-io-python
> deepstream-app -c deepstream_app_config.txt
###  3.YOLOv5 USB摄像头视频测试命令
> deepstream-app -c source1_usb_dec_infer_yolov5.txt
###  4.YOLOv5 CSI 摄像头视频测试命令
> deepstream-app -c source1_csi_dec_infer_yolov5.txt
