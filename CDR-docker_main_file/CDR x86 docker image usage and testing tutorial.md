# 一、CDR-x86-docker image usage and testing tutorial:
  (Remarks): Please contact the WeChat group owner (17370042325) for valid download links. The image of the x_86 version needs to be used with the Ampere architecture NVIDIA graphics card (30 series graphics cards belong to the Ampere architecture), and the graphics card needs to be installed on the x_86 host first. drive.
##  1.Download the `CDR-v4.0.tar` image file according to the following link:
- Link: `http://112.74.111.51:1212/down/Dcyn8UvJ81Lg` Extraction code: `Z78Din`, as shown below:
![在这里插入图片描述](https://img-blog.csdnimg.cn/d5849d11d71946a3b5796e29a1ac36d8.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA6YOt5bu65rSL,size_20,color_FFFFFF,t_70,g_se,x_16)
##  2.Import the downloaded `CDR-v4.0.tar` image file into docker:
(Note): Before importing the image into docker, you need to install `docker` and `nvidia-docker2` on the `ubuntu_x86` platform, please refer to the following link:
      	[ubuntu安装docker](https://docs.docker.com/engine/install/ubuntu/)
	    [ubuntu安装nvidia-docker2](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#nvidia-drivers)
- In the directory where the image file is located, right-click to open the terminal command line
- Run the docker image load command (it takes about 5 minutes to load):
  > docker load -i  CDR-v4.0.tar  
 	- After the loading is complete, you can view the loaded image by entering `docker images` in the terminal, as shown below:
 	![在这里插入图片描述](https://img-blog.csdnimg.cn/3ecb7ff428574a148c3139100a476feb.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA6YOt5bu65rSL,size_20,color_FFFFFF,t_70,g_se,x_16)

- Create the CDR-x86 container by entering the following command in the terminal:
  - The command is as follows: 
  > sudo docker run -it --net=host --device=/dev/video0 -e QT_X11_NO_MITSHM=1 --gpus '"'device=0'"' --name="guo02" --privileged=true -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -w /opt/nvidia/deepstream/deepstream-6.0 cv-detect-robot:v4.02 /bin/bash
  
   - Instruction explanation: 
      > --net=host   -----------------------------The generated container uses the same network as the host

      > --device=/dev/video0  ---------------`video0` indicates the camera ID, which means to connect the host camera to the container (the USB camera needs to be plugged into the host)

      > QT_X11_NO_MITSHM=1  ------------Container GUI Settings

      > --gpus '"'device=0'"'  -----------------Specifies the gpu used by the container

      > --name="guo02	"  ----------------------Custom container name `guo18`

      > --privileged=true  ----------------------Make root inside the container have real root privileges

      > -v /tmp/.X11-unix:/tmp/.X11-unix --------------- Container GUI Settings

      >  -e DISPLAY=$DISPLAY  ---------------Container GUI Settings

      >  -w /opt/nvidia/deepstream/deepstream-6.0 ---------- The directory you were in when you first entered the container      

      >  cv-detect-robot:v4.02 ----------------`cv-detect-robot` is the image warehouse name, `v4.02` is the image tag (tag)

      >  /bin/bash --------------------------------Start bash after starting the container (a process must be running in the docker background, otherwise the container will exit)
      
    - After running the above command, you can enter the container from the terminal. As shown below:
     ![在这里插入图片描述](https://img-blog.csdnimg.cn/d60663490f6348f4b5724e86f7f89904.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA6YOt5bu65rSL,size_20,color_FFFFFF,t_70,g_se,x_16)

## 3.Install the x86 version of vscode (CDR-based secondary development and sub-project testing can be performed in vscode)
- Download the amd64 version at vscode[official website](https://code.visualstudio.com/#)
- Install vscode with the following command (open a terminal in the directory where the installation package is located):
  > sudo dpkg -i code_1.62.3-1637137107_amd64.deb
  
  After installation, you will see the `vscode` icon in the application
 - Open `vscode`, and install `docker` and `remote-container` plugins in the extension bar, restart vscode after successful installation, enter the docker icon, you can view the container `cv created in step 2 in the container (containers) directory bar -detect-robot:v4.02`, move the cursor there and right-click to enter `Attach Visual Studio Code` (a new window will be created automatically), you can connect to the container remotely. 

##  4. Test deepstream-test7 related functions in vscode
(Note): deepstream_test7 folder is in the following path:

> ~/opt/nvidia/deepstream/sources/deepstream_python_apps/deepstream_test7/

- Run the following command to test the video file detection function:
  > python3 deepstream-test_7_file.py /opt/nvidia/deepstream/deepstream-6.0/samples/streams/sample_qHD.mp4
  
- Run the following command to test the real-time detection function of the usb camera:
  >  python3 deepstream-test_7_cam.py  /dev/video0
 
 - Run the following command to test the real-time detection function of rtsp stream:
   > python3 deepstream-test_7_rtsp_osd.py rtsp://admin:ak123456@192.168.0.123:554/ch1/main/av_stream
   

- The above three detection modes are all configured with a tracker (the default is `deepsort` tracker), and the tracking ID number is displayed in the upper right corner of the detection box. The tracking ID and the pixel coordinates of the tracking target can be obtained through the shared memory (internal_memory.txt). Read There are three ways to access dynamic data in shared memory: rostopic reading, python interface reading, and c++ interface reading. The three reading methods are described below.
   - rostopic reading method: 
   When one of the three detection modes is running, the detection data will be dynamically written to the memory pointed to by `internal_memory.txt`. First, create a new terminal to run `roscore`, and then create a new terminal to run `client_ros.py` (complete Memory data reading and data topic publishing functions), and finally create a new terminal and run `rostopic echo /BoundingBoxes_tensor` to view the topic content in real time.
   - The python interface reads:
   When one of the three detection modes is running, the detection data will be dynamically written into the memory pointed to by `internal_memory.txt`, and the real-time detection data will be obtained by directly reading the dynamic data of the memory through python, and run `client. py` can do it.
   - C++ interface reading method:
   When one of the three detection modes is running, the detection data will be dynamically written into the memory pointed to by `internal_memory.txt`, and the real-time detection data will be obtained by directly cyclically reading the dynamic data of the memory through the cpp program, compile and run` The `test_7.cpp` program under the cpp_io` folder 
   
   
##  5.Test deepstream-yolov5 related functions in vscode
(Note): deepstream-yolo5 folder is in the following path:

> ~/opt/nvidia/deepstream/sources/deepstream_python_apps/deepstream-yolov5/

-Run the following command to test the video file detection function:
  > python3 deepstream_yolov5_file.py file:///opt/nvidia/deepstream/deepstream-6.0/samples/streams/sample_qHD.h264
  
- Run the following command to test the real-time detection function of the usb camera:
  >  python3 deepstream_yolov5_cam.py /dev/video0
 
 - Run the following command to test the real-time detection function of rtsp stream:
   > python3 deepstream_yolov5_rtsp.py rtsp://admin:ak123456@192.168.0.123:554/ch1/main/av_stream

- The above three detection modes are all configured with a tracker (the default is `deepsort` tracker), and the tracking ID number is displayed in the upper right corner of the detection frame. The tracking ID and the pixel coordinates of the tracking target can be obtained through the shared memory (internal_memory.txt). Read There are three ways to access dynamic data in shared memory: rostopic reading, python interface reading, and c++ interface reading. The three reading methods are described below.
   - rostopic reading method: 
   When one of the three detection modes is running, the detection data will be dynamically written to the memory pointed to by `internal_memory.txt`, first create a new terminal to run `roscore`, and then create a new terminal to run `client_ros.py` (complete Memory data reading and data topic publishing functions), and finally create a new terminal and run `rostopic echo /BoundingBoxes_tensor` to view the topic content in real time.
   - python interface read:
   When one of the three detection modes is running, the detection data will be dynamically written into the memory pointed to by `internal_memory.txt`, and the real-time detection data will be obtained by directly reading the dynamic data of the memory through python, and run `client. py` can do it.
   - C++ interface reading method:
   When one of the three detection modes is running, the detection data will be dynamically written into the memory pointed to by `internal_memory.txt`, and the real-time detection data will be obtained by directly reading the dynamic data of the memory through the cpp program, compiling and running` The `testv5.cpp` program under the cpp_io` folder.
   
   
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
