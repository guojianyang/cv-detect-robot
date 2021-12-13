#  CDR Subitem(3)（yolov5-deepstream-cpp）
## [English] | [[中文]](https://github.com/guojianyang/cv-detect-robot/blob/main/yolov5-deepstream-cpp/README.md)
##  Hardware environment
- NVIDIA TX2 onboard computer
- Mouse and keyboard (wired connection is recommended)
##  Software Environment
- Jetpack  4.5 （ubuntu 18.04）
- TensorRT  7.1
- CUDA  10.2
- cuDNN  8.0
- OpenCV  4.1.1
- deepstream  5.0
##  一、Install ROS operating system
**Remark**：（The following operations are best performed when building a ladder or replacing domestic sources, otherwise the download speed will be very slow, as for china）

Please refer to ROS official installation connection： [Official installation tutorial](http://wiki.ros.org/ROS/Installation)
You can also follow the steps below to install：

    - sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
    - sudo apt install curl 
    - curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -(**If it appears`gpg: no valid OpenPGP data found`Can be skipped directly **)
    - sudo apt update
    - sudo apt install ros-melodic-desktop-full
    - echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
    - source ~/.bashrc
    - source /opt/ros/melodic/setup.bash
    - sudo apt install python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential
    - sudo apt install python-rosdep
    - sudo rosdep init
    - rosdep update
- After the above steps are completed, you can try to run the `roscore` command in the terminal. If the following figure appears, the ros installation is normal：
![enter image description here](https://img-blog.csdnimg.cn/20210728132459897.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NjQzODU3Ng==,size_16,color_FFFFFF,t_70)
***
##  二、	Install DeepStream on TX2(Jetpack 4.5)
(**Remark**): If you use the `SDKManager` software to flash the `TX2` and select the `DeepStream 5.0` option when flashing to the system, the `DeepStream` will be installed automatically, without the following manual installation.
###  １．Installation dependencies
Execute the following command to install the required software package：

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
###  ２．Install `DeepStream SDK`

 （１）Enter[	Office DeepStream SDK](https://developer.nvidia.com/embedded/deepstream-on-jetson-downloads-archived) , select `DeepStream 5.0 for Jetson`and download (Jetpack 4.5 backward compatible)
![enter image description here](https://img-blog.csdnimg.cn/20210727094413306.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NjQzODU3Ng==,size_16,color_FFFFFF,t_70)
 （２）Get the compressed file after downloading`deepstream_sdk_5.0_jetson.tbz2`.Enter the following command to extract and install `DeepStream SDK`:

    sudo tar -xvf deepstream_sdk_5.0_jetson.tbz2 -C /
    cd /opt/nvidia/deepstream/deepstream-5.０
    sudo ./install.sh
    sudo ldconfig
    

 （３） `DeepStream` test
 - Execute the following command：

> `cd /opt/nvidia/deepstream/deepstream-5.０/sources/objectDetector_Yolo`
 - Execute compilation command
>`sudo  CUDA_VER=10.2 make -C nvdsinfer_custom_impl_Yolo`
	The result shown in the figure below appears, indicating that the compilation was successful：
![enter image description here](https://img-blog.csdnimg.cn/20210728140820363.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NjQzODU3Ng==,size_16,color_FFFFFF,t_70)

- Edit the file `prebuild.sh` and comment out the statement except `yolov3-tiny`
>Execute the following commands (download `yolov3-tiny.cfg` and `yolov3-tiny.weights`):

> `sudo ./prebuild.sh`
- Excuting the order：
> `deepstream-app -c deepstream_app_config_yoloV3_tiny.txt`

If the relevant `engine` engine can be generated and the video stream detection can be started, then the `DeepStream SDK` installation is successful, as shown in the following figure:
![guo](https://img-blog.csdnimg.cn/20210728142452372.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NjQzODU3Ng==,size_16,color_FFFFFF,t_70)![enter image description here](https://img-blog.csdnimg.cn/20210728142507966.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NjQzODU3Ng==,size_16,color_FFFFFF,t_70)
***
## 三、Clone the `cv-detect-ros` project from `github`, and copy the relevant subfolders of the `yolov5-deepstream-cpp` sub-project I designed to the corresponding directory for compilation

 1. **Clone the `cv-detect-ros` project from `github`** .
 First press `ctrl + alt +t` to enter the terminal (by default, the cloned file is in the `home` directory).

>` git clone  https://github.com/guojianyang/cv-detect-ros.git`

 2. **First give permissions to the folder we want to operate**

> `sudo chmod -R 777 /opt/nvidia/deepstream/deepstream-5.0/sources/`
 3. **Then copy `cv-detect-ros/yolov5-deepstream-cpp/yolov5-ros` folder to `opt/nvidia/deepstream/deepstream-5.0/sources/`**
>`sudo cp ~/cv-detect-ros/yolov5-deepstream-cpp/yolov5-ros /opt/nvidia/deepstream/deepstream-5.０/sources/`
 4. **Then enter the copy destination folder` /opt/nvidia/deepstream/deepstream-5.０/sources/`**
 > `cd /opt/nvidia/deepstream/deepstream-5.0/sources`

> There is a `yolov5-ros` directory under this folder, but after opening the directory, the `video` folder in the figure below is not found. This is due to the large volume of `video`, which is limited by the upload capacity of `github`, `video`  file can be downloaded from the following Baidu network disk link:

> Link: https://pan.baidu.com/s/1V_AftufqGdym4EEKJ0RnpQ  password: `fr8u`
 5. **The contents of the `yolov5-ros` folder are shown in the figure below:**

- **Remark**：The original model `number_v30.pt` file that generates the `number_v30.engine` engine file is placed in the following link, because the engine file may have problems on different hardware platforms. For example, if the engine file that comes with the project runs an error, you can use ` number_v30.pt` generates a new `number_v30.engine` engine file.
Link: https://pan.baidu.com/s/1DlCddhAIzpLGPwzV_c8_-w  password: `pk1b`

 ![yolov5-ros-deepstream-dir](https://img-blog.csdnimg.cn/20210729113434540.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NjQzODU3Ng==,size_16,color_FFFFFF,t_70)
 - The contents of the folder are explained as follows:

>vdsinfer_custom_impl_Yolo--------------------------Store the source code and compiled folder of the `yolov5-ros-deepstream` subproject

>client_ros.py-------------------------------------------The `ros` node that publish target detection data 

>video----------------------------------------------------Store related video files to be detected

>config_infer_number_sv30.txt-----------------------the configuration file of `number_v30.engnine`

>deepstream_app_number_sv30.txt------------Startup configuration file of `number_v30.engnine`

>config_infer_primary.txt---------------The basic configuration file of the `yolov5s.engine` engine

>deepstream_app_config.txt-------------------Startup configuration file of `yolov5s.engine` engine

>abels.txt----------------------------------The label configuration file of the `yolov5s.engine`engine

>number_v30.txt----------------The label configuration file of the custom number detection engine `number_v30.engnin`

>yolov5s.engine------------------------------------------Engine file of `yolov5s.pt` model

>number_v30.engine------------------------------------Engine file of `number_v30s.pt` model

>source1_csi_dec_infer_yolov5.txt--------------------Start real-time detection of `csi `camera

>source1_usb_dec_infer_yolov5.txt----------------Start the real-time detection of the `usb` camera

 6. **Compile `yolov5-deepstream-cpp/yolov5-ros` source code**
 > cd /opt/nvidia/deepstream/deepstream-5.0/sources/yolov5-ros

 > CUDA_VER=10.2 make -C nvdsinfer_custom_impl_Yolo


##  四、Run test
###  １.Run the `number_v30.engine` engine to test the video file in the `video` folder 
> cd /opt/nvidia/deepstream/deepstream-5.0/sources/yolov5-ros
> deepstream-app -c deepstream_app_number_sv30.txt
- After running the `number_v30.engine` engine normally, a real-time digital video stream will appear, and the frame rate (FPS) can be seen in the command box
- After compiling yolov5_tensor.cpp, just run
>g++ yolov5_tensor.cpp -o yolov5_tensor
>./yolov5_tensor
 - The following figure appears, indicating that the operation is successful
![enter image description here](https://img-blog.csdnimg.cn/20210730113220564.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NjQzODU3Ng==,size_16,color_FFFFFF,t_70)


###  ２.Run the `yolov5s.engine` engine to test the video in the `video` folder 
> cd /opt/nvidia/deepstream/deepstream-5.0/sources/yolov5-ros
> deepstream-app -c deepstream_app_config.txt
- The access of `ros` is the same as in (1)
###  3.`YOLOv5 USB` camera video test command
> deepstream-app -c source1_usb_dec_infer_yolov5.txt
###  4.`YOLOv5 CSI` camera video test command
> deepstream-app -c source1_csi_dec_infer_yolov5.txt
