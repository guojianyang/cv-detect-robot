![enter image description here](https://img-blog.csdnimg.cn/7007a6ec9d584018bdf289bd8987c45d.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBA6YOt5bu65rSL,size_20,color_FFFFFF,t_70,g_se,x_16)
#  [English] | [[中文]](https://github.com/guojianyang/cv-detect-robot/wiki/README.md-%28%E4%B8%AD%E6%96%87%E7%89%88%29)
#  CDR(cv-detect-robot)   Project Introduction
**CDR Project purpose**：High-performance visual inspection and related algorithms empower the robotics industry and build a bridge for technology landing.
> **Remark(1)**: Connected to this subproject of `yolov5-ros-deepstream` that has been adapted for ROS system,after the relevant software and hardware environment is set up, you can directly call the defined ros topic messages to obtain real-time target detection data

>    **Remark(2)**:In the future, the **ppyolo algorithms** from Baidu's paddle ,**YOLOX** from MEGVII and A series of pixel-level target detection and tracking algorithms  will adapted for the CDR project.

>   **Remark(３)**: As I and my team learn and grow, the project will be maintained and updated from time to time. Due to limited capabilities, there are errors and deficiencies in the project. I hope you can criticize and correct or leave a message in the `issue`.

>   **Remark(4)**:In order to facilitate everyone to learn and communicate, the **CDR (cv-detect-robot) project** communication WeChat group has been established, please add the person in charge of the group `Xiao Guo`, WeChat ID:**17370042325** to facilitate your participation in the group(WeChat is the most common communication software in China).
***
***
#  CDR subitem(1)（yolov5-ros-deepstream）
-  `yolov5-ros-deepstream` subproject profile
> The project is to combine the yolov5 vision detection algorithm with the neural network acceleration engine tensorRT, and run under the deepstream framework of NVIDIA, combined with the ros communication mechanism, to publish the detection data through the ros topic in real time. It is used by developers and related scientific researchers based on ROS robot operating system.

>For detailed tutorial, please enter--------->[yolov5-ros-deepstream](https://github.com/guojianyang/cv-detect-robot/wiki/yolov5-ros-deepstream(English))

>Please enter the final video detection effect--------->[yolov5-ros-deepstream--[detect video]](https://www.bilibili.com/video/BV1Lo4y1Q79C/)

#  CDR subitem(2)（yolov5-deepstream-python）
-  `yolov5-deepstream-python` subproject profile
>The project is to combine the visual detection algorithm yolov5 with the neural network acceleration engine tensorRT, and use shared memory technology to store the detected data in real time in a pre-defined physical memory (physical address is unique).On the same hardware platform In any software directory, create a `client.py` script file that reads the physical memory (it only contains a code segment for reading the memory),and read the data in the specified physical memory . On the premise that the reading is successful, the code segment can be inserted into any python project that needs target detection data, so that the python project can obtain the target detection data smoothly.

> For detailed tutorial, please enter------>[yolov5-deepstream-python](https://github.com/guojianyang/cv-detect-robot/wiki/yolov5-deepstream-python(English))

> Please enter the final video detection effect------>[yolov5-deepstream-python--[detect video]](https://www.bilibili.com/video/BV1Uv411E755/)
#  CDR子 subitem(3)（yolov5-deepstream-cpp）
- `yolov5-deepstream-python` subproject profile
> The project is to combine the visual detection algorithm yolov5 with the neural network acceleration engine tensorRT, and use shared memory technology to store the detected data in real time in a pre-defined physical memory (physical address is unique).On the same hardware platform In any software directory, create a file `yolov5_tensor.cpp` that reads the physical memory (it only contains a code segment that reads the memory). After compilation, the data in the specified physical memory can be read out. On the premise of successful reading, the code segment can be inserted into any C++ project that requires target detection data, so that the C++ project can obtain target detection data smoothly.

> For detailed tutorial, please enter-------->[yolov5-deepstream-cpp](https://github.com/guojianyang/cv-detect-robot/wiki/yolov5-deepstream-cpp(English))

> Please enter the final video detection effect-------->[yolov5-deepstream-cpp--[detect video]](https://www.bilibili.com/video/BV1yV411p7Dx/)
