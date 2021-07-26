#  cv-detect-ros(CVR)项目介绍
**cv-detect-ros项目的立项宗旨**：为基于ROS机器人操作系统开发机器人、无人机、无人车等相关人工智能产品，且有视觉检测需求的开发者提供前沿高性能视觉检测及其相关算法的ros接口。
- （ **备注**）:已接入本项目的视觉检测算法都已经做好了ROS系统的适配，待相关软硬件环境搭建好后即可直接调用已定义好的ros话题消息获取目标检测实数据。
***
#  cv-detect-ros子项目(一)（yolov5-ros-deepstream）
##  硬件环境
- 英伟达TX2板载计算机
- 鼠标键盘（推荐使用有线连接方式）
##  软件环境
- Jetpack  4.5 （ubuntu 18.04）
- TensorRT  7.1
- cuDNN  8.0
- OpenCV  4.1.1
##  安装ROS操作系统
请参考ROS官方安装连接： [官方安装教程](http://wiki.ros.org/ROS/Installation).
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
