# 一、CDR-x86-docker镜像使用及测试教程：
  （备注）：有效下载链接请联系微信群主(17370042325)获取.
##  1.根据如下链接下载`CDR-v4.0.tar`镜像文件：
- 链接:`http://112.74.111.51:1212/down/Dcyn8UvJ81Lg` 提取码:`Z78Din`,如下图：
![在这里插入图片描述](https://img-blog.csdnimg.cn/d5849d11d71946a3b5796e29a1ac36d8.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA6YOt5bu65rSL,size_20,color_FFFFFF,t_70,g_se,x_16)
##  2.将下载的`CDR-v4.0.tar`镜像文件导入docker：
（备注）：在镜像导入docker前,需在`ubuntu_x86`平台安装`docker`和`nvidia-docker2`，可参考如下链接：
      	[ubuntu安装docker](https://docs.docker.com/engine/install/ubuntu/)
	    [ubuntu安装nvidia-docker2](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#nvidia-drivers)
- 在镜像文件所在目录下，右键打开终端命令行
- 运行docker镜像加载命令(大致需5分钟左右加载完成)：
  > docker load -i  CDR-v4.0.tar  
 	- 加载完成后可通过在终端输入`docker images`查看已加载的镜像，如下图：
 	![在这里插入图片描述](https://img-blog.csdnimg.cn/3ecb7ff428574a148c3139100a476feb.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA6YOt5bu65rSL,size_20,color_FFFFFF,t_70,g_se,x_16)

- 在终端输入以下命令创建CDR-x86容器:
  - 命令如下： 
  > sudo docker run -it --net=host --device=/dev/video0 -e QT_X11_NO_MITSHM=1 --gpus '"'device=0'"' --name="guo02" --privileged=true -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -w /opt/nvidia/deepstream/deepstream-6.0 cv-detect-robot:v4.02 /bin/bash
  
   - 指令解释： 
      > --net=host   -----------------------------生成的容器与宿主机使用同一网络
      > --device=/dev/video0  ---------------`video0`表示摄像头ID，指将宿主机摄像头接入容器(需在宿主机上插上USB摄像头)
      > QT_X11_NO_MITSHM=1  ------------容器图形化界面设置
      > --gpus '"'device=0'"'  -----------------指定容器所使用的gpu
      > --name="guo02	"  ----------------------自定义容器名称`guo18`
      > --privileged=true  ----------------------使容器内的root拥有真正的root权限
      > -v /tmp/.X11-unix:/tmp/.X11-unix --------------- 容器图形化界面设置
      >  -e DISPLAY=$DISPLAY  ---------------容器图形化界面设置
      >  -w /opt/nvidia/deepstream/deepstream-6.0 ---------- 刚进入容器时所在的目录      
      >  cv-detect-robot:v4.02 ----------------`cv-detect-robot`为镜像仓库名称，`v4.02`为镜像标签(tag)
      >  /bin/bash --------------------------------启动容器后启动bash(docker后台必须运行一个进程，否则容器就会退出)
      
    - 运行以上指令后可从终端进入容器。如下图所示：
     ![在这里插入图片描述](https://img-blog.csdnimg.cn/d60663490f6348f4b5724e86f7f89904.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA6YOt5bu65rSL,size_20,color_FFFFFF,t_70,g_se,x_16)

## 3.安装x86版本的vscode(基于CDR的二次开发及子项目测试均可在vscode中进行)
- 在vscode[官方网站](https://code.visualstudio.com/#)下载amd64版本
- 通过以下命令安装vscode(在安装包所在目录下打开终端)：
  > sudo dpkg -i code_1.62.3-1637137107_amd64.deb
  
  安装完成后，在应用程序中可看到`vscode`图标
 - 打开`vscode`，并在扩展栏里面安装`docker`和`remote-container`插件，安装成功后重启vscode,进入docker图标，可在容器(containers)目录栏查看到步骤2中建立的容器`cv-detect-robot:v4.02`，光标移至该处并点击右键进入`Attach Visual Studio Code`后(会自动新建一窗口)，便可远程连接该容器(container)。 

##  4.在vscode中测试deepstream-test7相关功能
- 运行如下命令，测试视频文件检测功能：
  > python3 deepstream-test_7_file.py /opt/nvidia/deepstream/deepstream-6.0/samples/streams/sample_qHD.mp4
  
- 运行如下命令，测试usb摄像头实时检测功能：
  >  python3 deepstream-test_7_cam.py  /dev/video0
 
 - 运行如下命令，测试rtsp流实时检测功能：
   > python3 deepstream-test_7_rtsp_osd.py rtsp://admin:ak123456@192.168.0.123:554/ch1/main/av_stream
   

- 以上三种检测模式都配置了跟踪器(默认为`deepsort`跟踪器)，检测框右上角显示跟踪ID号， 可通过共享内存(internal_memory.txt)方式获得跟踪ID及跟踪目标的像素坐标.读取共享内存内部动态数据方式有三种：rostopic形式读取、python 接口读取，c++接口读取，下面对三种读取方式进行介绍。
   - rostopic 读取方式： 
   在三种检测模式其中一种运行的情况下，检测数据会动态写入`internal_memory.txt`所指向的内存中，首先新建一终端运行`roscore`，再新建终端运行`client_ros.py`(完成内存数据读取和数据topic发布功能)，最后新建一终端运`rostopic echo /BoundingBoxes_tensor`实时查看话题(topic)内容。
   - python接口读取:
   在三种检测模式其中一种运行的情况下，检测数据会动态写入`internal_memory.txt`所指向的内存中，通过python直接循环读取内存动态数据的方式获取实时检测数据，运行`client.py`即可实现。
   - c++接口读取方式:
   在三种检测模式其中一种运行的情况下，检测数据会动态写入`internal_memory.txt`所指向的内存中，通过cpp程序直接循环读取内存动态数据的方式获取实时检测数据，编译运行`cpp_io`文件夹下的`test_7.cpp`程序
   
   
##  5.在vscode中测试deepstream-yolov5相关功能
- 运行如下命令，测试视频文件检测功能：
  > python3 deepstream_yolov5_file.py file:///opt/nvidia/deepstream/deepstream-6.0/samples/streams/sample_qHD.h264
  
- 运行如下命令，测试usb摄像头实时检测功能：
  >  python3 deepstream_yolov5_cam.py /dev/video0
 
 - 运行如下命令，测试rtsp流实时检测功能：
   > python3 deepstream_yolov5_rtsp.py rtsp://admin:ak123456@192.168.0.123:554/ch1/main/av_stream

- 以上三种检测模式都配置了跟踪器(默认为`deepsort`跟踪器)，检测框右上角显示跟踪ID号， 可通过共享内存(internal_memory.txt)方式获得跟踪ID及跟踪目标的像素坐标.读取共享内存内部动态数据方式有三种：rostopic形式读取、python 接口读取，c++接口读取，下面对三种读取方式进行介绍。
   - rostopic 读取方式： 
   在三种检测模式其中一种运行的情况下，检测数据会动态写入`internal_memory.txt`所指向的内存中，首先新建一终端运行`roscore`，再新建终端运行`client_ros.py`(完成内存数据读取和数据topic发布功能)，最后新建一终端运`rostopic echo /BoundingBoxes_tensor`实时查看话题(topic)内容。
   - python接口读取:
   在三种检测模式其中一种运行的情况下，检测数据会动态写入`internal_memory.txt`所指向的内存中，通过python直接循环读取内存动态数据的方式获取实时检测数据，运行`client.py`即可实现。
   - c++接口读取方式:
   在三种检测模式其中一种运行的情况下，检测数据会动态写入`internal_memory.txt`所指向的内存中，通过cpp程序直接循环读取内存动态数据的方式获取实时检测数据，编译运行`cpp_io`文件夹下的`testv5.cpp`程序。
   
   
##  6.在vscode中测试deepstream-yolox需相关功能
- 运行如下命令，测试视频文件检测功能：
  > python3 deepstream_yolox_file.py file:///opt/nvidia/deepstream/deepstream-6.0/samples/streams/sample_qHD.h264

- 运行如下命令，测试usb摄像头实时检测功能：
  >  python3 deepstream_yolox_cam.py /dev/video0
 
 - 运行如下命令，测试rtsp流实时检测功能：
   > python3 deepstream_yolox_rtsp.py rtsp://admin:ak123456@192.168.0.123:554/ch1/main/av_stream

- 以上三种检测模式都配置了跟踪器(默认为`deepsort`跟踪器)，检测框右上角显示跟踪ID号， 可通过共享内存(internal_memory.txt)方式获得跟踪ID及跟踪目标的像素坐标.读取共享内存内部动态数据方式有三种：rostopic形式读取、python 接口读取，c++接口读取，下面对三种读取方式进行介绍。
   - rostopic 读取方式： 
   在三种检测模式其中一种运行的情况下，检测数据会动态写入`internal_memory.txt`所指向的内存中，首先新建一终端运行`roscore`，再新建终端运行`client_ros.py`(完成内存数据读取和数据topic发布功能)，最后新建一终端运`rostopic echo /BoundingBoxes_tensor`实时查看话题(topic)内容。
   - python接口读取:
   在三种检测模式其中一种运行的情况下，检测数据会动态写入`internal_memory.txt`所指向的内存中，通过python直接循环读取内存动态数据的方式获取实时检测数据，运行`client.py`即可实现。
   - c++接口读取方式:
   在三种检测模式其中一种运行的情况下，检测数据会动态写入`internal_memory.txt`所指向的内存中，通过cpp程序直接循环读取内存动态数据的方式获取实时检测数据，编译运行`cpp_io`文件夹下的`yolox.cpp`程序。
