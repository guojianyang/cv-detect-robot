#  CDR子项目(四)（yolox-ros-deepstream）
## [中文] | [[English]](https://github.com/guojianyang/cv-detect-robot/blob/main/yolox-ros-deepstream/README_EN.md)
##  硬件环境
- 英伟达jetson nano 板载计算机(原则上jetson 系列产品都能适配此项目)
- 鼠标键盘（推荐使用有线连接方式）
##  软件环境
- Jetpack  4.5.1 （ubuntu 18.04）
- TensorRT  7.1
- CUDA  10.2
- cuDNN  8.0
- OpenCV  4.1.1
- deepstream  5.1
##  相关资源百度云盘链接如下：
链接: https://pan.baidu.com/s/1SFwk4iSxwLZmOUcp4mqJUg  密码: 0l0u

如下图所示：
![enter image description here](https://img-blog.csdnimg.cn/e9bd7814a70240d4b8256b73a890e0ac.jpg?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBA6YOt5bu65rSL,size_20,color_FFFFFF,t_70,g_se,x_16)

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
##  二、安装DeepStream on Nano(Jetpack 4.5.1)
(**备注**):若使用SDKManager软件对Nano进行刷机，且刷入系统时选择了DeepStream 5.１选项，便会自动安装		DeepStream，无需进行以下手动安装。
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

 （１）进入[官方DeepStream SDK](https://developer.nvidia.com/embedded/deepstream-on-jetson-downloads-archived)选择`DeepStream 5.1 for Jetson`并下载(Jetpack 4.5.1 向下兼容)
 （**备注**）：也可在本人提供**相关资源百度云盘链接**中下载deepstream_sdk_5.1_jetson.tbz2文件包
![enter image description here](https://img-blog.csdnimg.cn/9c5c7cd9a99b434db493350a0d207638.jpg?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBA6YOt5bu65rSL,size_20,color_FFFFFF,t_70,g_se,x_16)

 （２）下载后得到压缩文件`deepstream_sdk_5.1_jetson.tbz2`，输入以下命令以提取并安装DeepStream SDK:

    sudo tar -xvf deepstream_sdk_5.1_jetson.tbz2 -C /
    cd /opt/nvidia/deepstream/deepstream-5.1
    sudo ./install.sh
    sudo ldconfig
    

 （３） DeepStream测试
 - 执行以下命令：

> cd /opt/nvidia/deepstream/deepstream-5.1/sources/objectDetector_Yolo
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
##  三、安装onnx2trt（在jetson nano 上完成）

 1. 查看TensoRT版本
 > dpkg -l |grep TensorRT
 
 2. 安装cmake
	-  删除原来的cmake
	> 	sudo apt remove cmake 
	> sudo apt purge --auto-remove cmake
	- 下载所需版本,解压
	> tar -xzvf cmake-3.21.2.tar.gz
	> cd ~/cmake-3.21.2
	- 编译安装
		执行命令......
	> ./bootstrap
	> make -j4
	> sudo make install
	
	- 如果编译安装cmake时如果出现错误:could not find OpenSSL,执行
	> sudo apt install libssl-dev
	- 移动路径
	> sudo cp ./bin/cmake /usr/bin/
	- 验证安装结果
	> cmake --version
	
 3. 安装protobuf
	 - 下载protobuf-3.17.3.zip并解压
		 > unzip protobuf-3.17.3.zip

	-  	执行以下命令（其中`sudo make install` 等待时间较长）
	
			    cd protobuf-3.17.3
		        ./autogen.sh
		        ./configuremake
		        sudo make install
		        sudo ldconfig
		        protoc --version
	  

 4. 安装onnx-tensorrt
	 > git clone -b 7.1 https://github.com/onnx/onnx-tensorrt.git	
	 
	-  克隆后onnx-tensorrt/third_party/onnx中内容是空的,需要下载与tensorrt7.1匹配的onnx1.6
	 下载地址为：https://github.com/onnx/onnx/releases　，也可在百度网盘中下载。
	 将下载后的内容,解压放置到`onnx-tensorrt/third_party/`
	 
			tar -xzvf onnx-1.6.0.tar.gz 
			mv onnx-1.6.0 onnx
	 - 执行以下命令
	 
		    cd onnx-tensorrt
			mkdir build
			cd build
			cmake .. -DTENSORRT_ROOT=/usr/src/tensorrt
			make -j4
			sudo make install
			onnx2trt -V
	
	

 5. 生成yolox的TensorRT engine 文件（必须在同一jetson nano 上完成！！！）
	- 从**相关资源百度云盘链接**中将yolox_s.onnx、yolox_tiny.onnx、yolox_nano.onnx到Jetson Nano上，可放置于home目录下，并依次执行	   以下命令：
		> onnx2trt yolox_s.onnx -o yolox_s.engine
		
		> onnx2trt yolox_tiny.onnx -o yolox_tiny.engine

		>onnx2trt yolox_nano.onnx -o yolox_nano.engine
		
		若要自己生成.onnx文件，请进入以下链接：
		[yolox导出onnx](https://blog.csdn.net/weixin_46438576/article/details/121138774)
 

## 四、从github克隆`cv-detect-ros`项目，并将本人设计好的`yolox-ros-deepstream`子项目的相关子文件夹拷贝到相应目录下进行编译
1.  **从github克隆`cv-detect-ros`项目**（建议在搭建梯子的环境下进行git clone）

> 先按　`ctrl + alt +t`  进入终端（默认克隆的文件在家目录下）

> git clone  [https://github.com/guojianyang/cv-detect-ros.git](https://github.com/guojianyang/cv-detect-ros.git)

2.  **首先对我们所要操作的文件夹赋予权限**

> sudo chmod -R 777 /opt/nvidia/deepstream/deepstream-5.1/sources/

3.  **再拷贝cv-detect-ros/yolox-ros-deepstream/yolox-ros文件夹到opt/nvidia/deepstream/deepstream-5.1/sources/**
yolox-ros中的文件内容如下图所示：
![enter image description here](https://img-blog.csdnimg.cn/2c11fb5e4f0249468a3c6a7e6106f21e.jpg?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBA6YOt5bu65rSL,size_20,color_FFFFFF,t_70,g_se,x_16)

> sudo cp ~/cv-detect-ros/yolox-ros-deepstream/yolox-ros /opt/nvidia/deepstream/deepstream-5.1/sources/

4.  **拷贝步骤（三）中生成的yolox、yolox-tiny和yolox-nano的engine文件到opt/nvidia/deepstream/deepstream-5.1/sources/yolox-ros**
> cp ~/yolox_s.engine /opt/nvidia/deepstream/deepstream-5.1/sources/yolox-ros

> cp ~/yolox_tiny.engine /opt/nvidia/deepstream/deepstream-5.1/sources/yolox-ros

>cp ~/yolox_nano.engine /opt/nvidia/deepstream/deepstream-5.1/sources/yolox-ros

  - 以上三个引擎文件相关信息如下：
  
	| 文件名称  | 文件大小(M)  | 帧率(FPS)  |
	| ------------ | ------------ | ------------ |
	|  yolox_s.engine  | 64  | 4-5 |
	|  yolox_nano  | 6 | 16-17  |
	|  yolox_tiny  | 37.5  | 13-14  |
 
 

 5. **编译**

	     cd /opt/nvidia/deepstream/deepstream-5.1/sources/yolox-ros
	     CUDA_VER=10.2 make -C nvdsinfer_custom_impl_yolox
		
	对于yolox-tiny和yolox-nano的部署， nvdsparsebbox_yolox.cpp中先修改
	
	    static const int INPUT_W = 416; //640;
	    static const int INPUT_H = 416; //640;
	然后在进行编译
  6. **搭建自定义的rostpoic话题消息的工作空间boxes_ws，建立ros接口**
  - 将git clone 的文件夹cv-detect-robot/yolovx-ros-deepstream/boxes_ws复制到home目录下
  > sudo cp -r ~/cv-detect-robot/yolox-ros-deepstream/boxes_ws ~/
  - 进入boxes_ws文件夹，编译ros工作空间
  > cd ~/boxes_ws

  - boxes_ws目录下若有 build和devel文件,则需删除后再编译,否则无需执行本步骤
  > rm -r build devel 
  - 编译
  > catkin_make
  - 编译成功后，需将boxes_ws工作空间添加环境变量
  > sudo gedit ~/.bashrc

  > echo  "source ~/boxes_ws/devel/setup.bash" >> ~/.bashrc

  > source ~/.bashrc
  - 将src下功能包darknet_ros_msgs建立软连接至/opt/nvidia/deepstream/deepstream-5.1/sources/yolovx-ros/目录下
  > cd ~/boxes_ws/src 
  > ln -s ~/boxes_ws/src/ darknet_ros_msgs  /opt/nvidia/deepstream/deepstream-5.1/sources/yolovx-ros/
  - 测试ros接口是否成功建立
  > cd /opt/nvidia/deepstream/deepstream-5.1/sources/yolox-ros/
  
	  在当前目录终端下运行`python2`(一定要python2),并导入以下功能包：
  
  >  from darknet_ros_msgs.msg import BoundingBox_tensor,BoundingBoxes_tensor
  
       若以上导入没有报错，则说明ros接口创建成功！！！  
  

##  五、落地部署测试
- 测试推理视频文件
  
  - 启动检测程序(启动成功后会出现检测画面)

	    cd /opt/nvidia/deepstream/deepstream-5.1/sources/yolox-ros
	    
	    deepstream-app -c deepstream_app_config.txt

  - 将yolox-ros-deepstream中的client_ros.py文件复制到/opt/nvidia/deepstream/deepstream-5.1/sources/yolox-ros/中
	  > cp -r ~/cv-detect-ros/yolox-ros-deepstream/client_ros.py /opt/nvidia/deepstream/deepstream-5.1/sources/yolox-ros/
  - `ctrl + alt +t` 新建终端，启动`roscore`
	  > roscore
  - 再`ctrl + alt +t`新建一个终端,并进入目录/opt/nvidia/deepstream/deepstream-5.1/sources/yolox-ros/
	  > cd /opt/nvidia/deepstream/deepstream-5.1/sources/yolox-ros/
	  > python2 client_ros.py
  - client_ros.py文件启动后，检测到的目标数据以topic的形式发布出来，可通过订阅话题`boundingboxes_tensor`实时查看目标检测的数据
  - 如下图所示：
  ![enter image description here](https://img-blog.csdnimg.cn/8e09705f3d254048b1eefaee4f211c0d.jpg?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBA6YOt5bu65rSL,size_20,color_FFFFFF,t_70,g_se,x_16)
	    
- USB摄像头视频测试
	- 摄像头简单检测指令(ros的接入与上述一样):
	
		    ls /dev/video*
	- 安装v4l-utils工具:

		    sudo apt install v4l-utils
		    
	- 检测摄像头比较完整信息的指令:
	

		    v4l2-ctl --list-devices
	- 摄像头更细致规格的查看指令:
	

		    v4l2-ctl --device=/dev/video0 --list-formats-ext
			v4l2-ctl --device=/dev/video1 --list-formats-ext
	- yolox usb摄像头测试指令：
	

		    deepstream-app -c source1_usb_dec_infer_yolox.txt

- CSI摄像头视频测试(ros的接入与上述一样)：

	    deepstream-app -c source1_csi_dec_infer_yolox.txt

##  六、针对自定义数据模型的修改
- 修改config_infer_primary.txt中的参数(num-detected-classes为自定义的类别数)

		    num-detected-classes=80
- 在labels.txt中修改类别名称文件，换成自定义的类别名称
