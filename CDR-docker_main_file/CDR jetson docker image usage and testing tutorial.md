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
## 3.Install the arm64 version of vscode (CDR-based secondary development and sub-project testing can be performed in vscode)
- Download the arm64 version at vscode [official website](https://code.visualstudio.com/#alt-downloads)
- Install vscode with the following command (open a terminal in the directory where the installation package is located):
  > sudo dpkg -i code_1.63.2-1639561157_arm64.deb
  
  After installation, you will see the `vscode` icon in the application
 - Open `vscode`, and install the `docker` and `remote-container` plugins in the extension bar. After the installation is successful, restart vscode, enter the docker icon, and you can view the container `cv created in step 2 in the container (containers) directory bar -detect-robot:v4.18`, move the cursor there and right-click to enter `Attach Visual Studio Code` (a new window will be created automatically), you can connect to the container remotely. 

##  4.Test deepstream-test7 related functions in vscode
(Note): deepstream_test7 folder is in the following path:

> ~/opt/nvidia/deepstream/sources/deepstream_python_apps/deepstream_test7/

- Run the following command to test the video file detection function:
  > python3 deepstream-test_7_file.py  file:///opt/nvidia/deepstream/deepstream-6.0/samples/streams/sample_qHD.mp4
  
- Run the following command to test the real-time detection function of the usb camera:
  >  python3 deepstream-test_7_cam.py  /dev/video0
 
 - Run the following command to test the real-time detection function of rtsp stream:
   > python3 deepstream-test_7_rtsp.py rtsp://admin:ak123456@192.168.0.123:554/ch1/main/av_stream
   

- The above three detection modes are all configured with a tracker (the default is `deepsort` tracker), and the tracking ID number is displayed in the upper right corner of the detection box. The tracking ID and the pixel coordinates of the tracking target can be obtained through the shared memory (internal_memory.txt). Read There are three ways to access dynamic data in shared memory: rostopic reading, python interface reading, and c++ interface reading. The three reading methods are described below.
   - rostopic read method： 
   When one of the three detection modes is running, the detection data will be dynamically written to the memory pointed to by `internal_memory.txt`. First, create a new terminal to run `roscore`, and then create a new terminal to run `client_ros.py` (complete Memory data reading and data topic publishing functions), and finally create a new terminal and run `rostopic echo /BoundingBoxes_tensor` to view the topic content in real time.
   - python interface read:
   When one of the three detection modes is running, the detection data will be dynamically written into the memory pointed to by `internal_memory.txt`, and the real-time detection data will be obtained by directly reading the dynamic data of the memory through python, and run `client. py` can do it.
   - C++ interface reading method:
   When one of the three detection modes is running, the detection data will be dynamically written into the memory pointed to by `internal_memory.txt`, and the real-time detection data will be obtained by directly cyclically reading the dynamic data of the memory through the cpp program, compile and run` The `test_7.cpp` program under the cpp_io` folder
   
   
##  5.Test deepstream-yolov5 related functions in vscode
（(Note): deepstream-yolov5 folder is in the following path:

> ~/opt/nvidia/deepstream/sources/deepstream_python_apps/deepstream-yolov5/

- Run the following command to test the video file detection function:
  > python3 deepstream_yolov5_file.py file:///opt/nvidia/deepstream/deepstream-6.0/samples/streams/sample_qHD.h
  
- Run the following command to test the real-time detection function of the usb camera:
  >  python3 deepstream_yolov5_cam.py /dev/video0
 
 - Run the following command to test the real-time detection function of rtsp stream:
   > python3 deepstream_yolov5_rtsp.py rtsp://admin:ak123456@192.168.0.123:554/ch1/main/av_stream

- The above three detection modes are all configured with a tracker (the default is `deepsort` tracker), and the tracking ID number is displayed in the upper right corner of the detection box. The tracking ID and the pixel coordinates of the tracking target can be obtained through the shared memory (internal_memory.txt). Read There are three ways to access dynamic data in shared memory: rostopic reading, python interface reading, and c++ interface reading. The three reading methods are described below.
   - rostopic reading method: 
   When one of the three detection modes is running, the detection data will be dynamically written to the memory pointed to by `internal_memory.txt`, first create a new terminal to run `roscore`, and then create a new terminal to run `client_ros.py` (complete Memory data reading and data topic publishing functions), and finally create a new terminal and run `rostopic echo /BoundingBoxes_tensor` to view the topic content in real time.
   - The python interface reads:
   When one of the three detection modes is running, the detection data will be dynamically written into the memory pointed to by `internal_memory.txt`, and the real-time detection data will be obtained by directly reading the dynamic data of the memory through python, and run `client. py` can do it.
   - C++ interface reading method:
   When one of the three detection modes is running, the detection data will be dynamically written into the memory pointed to by `internal_memory.txt`, and the real-time detection data will be obtained by directly reading the dynamic data of the memory through the cpp program, compiling and running` The `testv5.cpp` program under the cpp_io` folder.
   
   
##  6.Testing deepstream-yolox in vscode requires related functions
（attention）：The deepstream-yolox folder is at the following path:

> ~/opt/nvidia/deepstream/sources/deepstream_python_apps/deepstream-yolox/

- Run the following command to test the video file detection function:
  > python3 deepstream_yolox_file.py file:///opt/nvidia/deepstream/deepstream-6.0/samples/streams/sample_qHD.h264

- Run the following command to test the real-time detection function of the usb camera:
  >  python3 deepstream_yolox_cam.py /dev/video0
 
 - Run the following command to test the real-time detection function of rtsp stream:
   > python3 deepstream_yolox_rtsp.py rtsp://admin:ak123456@192.168.0.123:554/ch1/main/av_stream

- The above three detection modes are all configured with a tracker (the default is `deepsort` tracker), and the tracking ID number is displayed in the upper right corner of the detection frame. The tracking ID and the pixel coordinates of the tracking target can be obtained through the shared memory (internal_memory.txt). Read There are three ways to access dynamic data in shared memory: rostopic reading, python interface reading, and c++ interface reading. The three reading methods are described below.
   - rostopic read method： 
   When one of the three detection modes is running, the detection data will be dynamically written to the memory pointed to by `internal_memory.txt`. First, create a new terminal to run `roscore`, and then create a new terminal to run `client_ros.py` (complete Memory data reading and data topic publishing functions), and finally create a new terminal and run `rostopic echo /BoundingBoxes_tensor` to view the topic content in real time.
   -python interface read:
  When one of the three detection modes is running, the detection data will be dynamically written into the memory pointed to by `internal_memory.txt`, and the real-time detection data will be obtained by directly reading the dynamic data of the memory through python, and run `client. py` can do it.
   - C++ interface reading method:
   When one of the three detection modes is running, the detection data will be dynamically written into the memory pointed to by `internal_memory.txt`, and the real-time detection data will be obtained by directly cyclically reading the dynamic data of the memory through the cpp program, compile and run` The `yolox.cpp` program under the cpp_io` folder.
 
