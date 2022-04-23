# 一、CDR-jetson-docker Image usage and testing tutorial：
  （Remark）：Please contact the WeChat group owner (17370042325) for valid download links. It is recommended that the jetson host environment be jetpack 4.6.
##  1.Download the `CDR-jetson-v4.18.tar` image file according to the following link：
- Link: `http://112.74.111.51:1212/down/tSpLJEbUHvQC` Extraction code: `nKTzyp`, as shown below：
![在这里插入图片描述](https://img-blog.csdnimg.cn/d5849d11d71946a3b5796e29a1ac36d8.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA6YOt5bu65rSL,size_20,color_FFFFFF,t_70,g_se,x_16)
##  2.Import the downloaded `CDR-jetson-v4.18.tar` image file into docker：
- In the directory where the image file is located, right-click to open the terminal command line
- Run the docker image load command (it takes about 5 minutes to load)：
  > docker load -i  CDR-jetson-v4.18.tar  
 	- After the loading is complete, you can view the loaded image by entering `docker images` in the terminal, as shown below：
 	![在这里插入图片描述](https://img-blog.csdnimg.cn/9e2ac0fd661b4d99b82e886843cd84f1.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA6YOt5bu65rSL,size_20,color_FFFFFF,t_70,g_se,x_16)
- Enter the following command in the terminal to create the CDR-jetson container:
  - The command is as follows： 
  > sudo docker run -it --net=host --device=/dev/video0 -e QT_X11_NO_MITSHM=1 --gpus '"'device=0'"' --name="guo18" --privileged=true -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -w /opt/nvidia/deepstream/deepstream-6.0 cv-detect-robot:v4.18 /bin/bash
  
   - Instruction explanation： 
      > --net=host   -----------------------------The generated container uses the same network as the host
      
      > --device=/dev/video0  ---------------`video0` indicates the camera ID, which means to connect the host camera to the container (the USB camera needs to be plugged into the host)
      
      > QT_X11_NO_MITSHM=1  ------------Container GUI Settings
      
      > --gpus '"'device=0'"'  -----------------Specifies the gpu used by the container
      
      > --name="guo18"  ----------------------Custom container name `guo18`
      
      > --privileged=true  ----------------------Make root inside the container have real root privileges
      
      > -v /tmp/.X11-unix:/tmp/.X11-unix --------------- Container GUI Settings
      
      >  -e DISPLAY=$DISPLAY  ---------------Container GUI Settings
      
      >  -w /opt/nvidia/deepstream/deepstream-6.0 ---------- The directory you were in when you first entered the container  
         
      >  cv-detect-robot:v4.18 ----------------`cv-detect-robot` is the name of the mirror warehouse, `v4.18` is the mirror tag (tag)
      
      >  /bin/bash --------------------------------Start bash after starting the container (a process must be running in the docker background, otherwise the container will exit)
      
    - After running the above command, you can enter the container from the terminal, as shown in the following figure：
![终端](https://img-blog.csdnimg.cn/4d2b1897bbc64643a608b96a28e642a4.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA6YOt5bu65rSL,size_20,color_FFFFFF,t_70,g_se,x_16)
## 3.安装arm64版本的vscode(基于CDR的二次开发及子项目测试均可在vscode中进行)
- 在vscode[官方网站](https://code.visualstudio.com/#alt-downloads)下载arm64版本
- 通过以下命令安装vscode(在安装包所在目录下打开终端)：
  > sudo dpkg -i code_1.63.2-1639561157_arm64.deb
  
  安装完成后，在应用程序中可看到`vscode`图标
 - 打开`vscode`，并在扩展栏里面安装`docker`和`remote-container`插件，安装成功后重启vscode,进入docker图标，可在容器(containers)目录栏查看到步骤2中建立的容器`cv-detect-robot:v4.18`，光标移至该处并点击右键进入`Attach Visual Studio Code`后(会自动新建一窗口)，便可远程连接该容器(container)。 

##  4.在vscode中测试deepstream-test7相关功能
（注意）：deepstream_test7文件夹在以下路径：

> ~/opt/nvidia/deepstream/sources/deepstream_python_apps/deepstream_test7/

- 运行如下命令，测试视频文件检测功能：
  > python3 deepstream-test_7_file.py  file:///opt/nvidia/deepstream/deepstream-6.0/samples/streams/sample_qHD.mp4
  
- 运行如下命令，测试usb摄像头实时检测功能：
  >  python3 deepstream-test_7_cam.py  /dev/video0
 
 - 运行如下命令，测试rtsp流实时检测功能：
   > python3 deepstream-test_7_rtsp.py rtsp://admin:ak123456@192.168.0.123:554/ch1/main/av_stream
   

- 以上三种检测模式都配置了跟踪器(默认为`deepsort`跟踪器)，检测框右上角显示跟踪ID号， 可通过共享内存(internal_memory.txt)方式获得跟踪ID及跟踪目标的像素坐标.读取共享内存内部动态数据方式有三种：rostopic形式读取、python 接口读取，c++接口读取，下面对三种读取方式进行介绍。
   - rostopic 读取方式： 
   在三种检测模式其中一种运行的情况下，检测数据会动态写入`internal_memory.txt`所指向的内存中，首先新建一终端运行`roscore`，再新建终端运行`client_ros.py`(完成内存数据读取和数据topic发布功能)，最后新建一终端运`rostopic echo /BoundingBoxes_tensor`实时查看话题(topic)内容。
   - python接口读取:
   在三种检测模式其中一种运行的情况下，检测数据会动态写入`internal_memory.txt`所指向的内存中，通过python直接循环读取内存动态数据的方式获取实时检测数据，运行`client.py`即可实现。
   - c++接口读取方式:
   在三种检测模式其中一种运行的情况下，检测数据会动态写入`internal_memory.txt`所指向的内存中，通过cpp程序直接循环读取内存动态数据的方式获取实时检测数据，编译运行`cpp_io`文件夹下的`test_7.cpp`程序
   
   
##  5.在vscode中测试deepstream-yolov5相关功能
（注意）：deepstream-yolov5文件夹在以下路径：

> ~/opt/nvidia/deepstream/sources/deepstream_python_apps/deepstream-yolov5/

- 运行如下命令，测试视频文件检测功能：
  > python3 deepstream_yolov5_file.py file:///opt/nvidia/deepstream/deepstream-6.0/samples/streams/sample_qHD.h
  
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
（注意）：deepstream-yolox文件夹在以下路径：

> ~/opt/nvidia/deepstream/sources/deepstream_python_apps/deepstream-yolox/

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

 
