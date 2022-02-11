![enter image description here](https://img-blog.csdnimg.cn/7007a6ec9d584018bdf289bd8987c45d.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBA6YOt5bu65rSL,size_20,color_FFFFFF,t_70,g_se,x_16)
#   [中文] | [[English]](https://github.com/guojianyang/cv-detect-robot/blob/main/README_EN.md)
#  CDR(cv-detect-robot)项目介绍🔥🔥🔥（工业级视觉算法Jetson侧端优化部署）
**CDR项目立项宗旨**：高性能视觉检测及其相关算法赋能机器人行业，搭建起技术落地的桥梁。
> （ **备注1**）:本项目已针对ubuntu-x_86平台和nvidia-jetson平台配置了全套docker镜像，无需配置繁杂软件环境，一键导入，省时又省力，镜像下载请联系CDR项目交流群群主(微信`17370042325`)。

>   （ **备注2**）:本项目后续将通过腾讯优图的ncnn加速库对华为海思3559、瑞芯微3399pro、勘智K210等国产AI芯片进行视觉算法的侧端优化及部署，敬请期待！！！。

>   （ **备注3**）:随着本人及团队的学习成长，该项目会不定期进行维护和更新，由于能力有限，项目中存在错误和不足之处望各位批评指正或在`issue`中留言。

>   （ **备注4**）:为方便大家学习交流，已建立**CDR(cv-detect-robot)项目**交流微信群，请添加群负责人`小郭`微信号`17370042325`,以方便拉您进群。
***
***
# CDR~全系标配docker镜像之-v4.0版本更新内容如下🔥🔥🔥🔥🔥：
- CDR中deepstream框架升级到6.0版本(tensorRT 8.0.1)
- 所有子项目都适配了deepsort跟踪器(IOU,DCF和deepsort三种跟踪器随意切换)，且所有子项目的目标跟踪ID都可通过rostopic,python脚本和cpp程序获得。
- 全系标配docker镜像，项目作者为	CDR项目分别配置了基于x_86平台和nvidia-jetson平台的全套镜像环境，并附带项目镜像操作及各子项目测试教程。
    - [CDR x86 docker镜像使用及测试教程](https://github.com/guojianyang/cv-detect-robot/wiki/CDR-x86-docker%E9%95%9C%E5%83%8F%E4%BD%BF%E7%94%A8%E5%8F%8A%E6%B5%8B%E8%AF%95%E6%95%99%E7%A8%8B)
    - [CDR jetson docker镜像使用及测试教程](https://github.com/guojianyang/cv-detect-robot/wiki/CDR-jetson-docker%E9%95%9C%E5%83%8F%E4%BD%BF%E7%94%A8%E5%8F%8A%E6%B5%8B%E8%AF%95%E6%95%99%E7%A8%8B)
- CDR镜像内具备pt->wts->trt功能(yolov5)和onnx-trt功能(yolox)。
- CDR镜像内每个子项目都能具备多流检测，具体操作参考如下链接。
   - [docker镜像CDR项目中多视频流检测方法
](https://github.com/guojianyang/cv-detect-robot/wiki/docker%E9%95%9C%E5%83%8FCDR%E9%A1%B9%E7%9B%AE%E4%B8%AD%E5%A4%9A%E8%A7%86%E9%A2%91%E6%B5%81%E6%A3%80%E6%B5%8B%E6%96%B9%E6%B3%95)
-  CDR镜像内各子项目同时具备视频文件检测、usb摄像头检测及rtsp实时流检测功能。
- CDR镜像内已配置yolov5项目源码全套运行环境、yolox项目源码全套运行环境、deepstream全套运行环境及ros-melodic全套运行环境，具体环境配置请查阅如下链接：
   - [docker镜像CDR项目中已有环境及相应版本介绍](https://github.com/guojianyang/cv-detect-robot/wiki/docker%E9%95%9C%E5%83%8FCDR%E9%A1%B9%E7%9B%AE%E4%B8%AD%E5%B7%B2%E6%9C%89%E7%8E%AF%E5%A2%83%E5%8F%8A%E7%9B%B8%E5%BA%94%E7%89%88%E6%9C%AC%E4%BB%8B%E7%BB%8D)
***
***
- **因`CDR x86 docker`镜像和`CDR jetson docker`镜像环境配置和算法调试及其复杂，耗时巨大，对上述两镜像采取收费机制**：
    -  **[CDR x86 docker镜像](https://github.com/guojianyang/cv-detect-robot/wiki/CDR-x86-docker%E9%95%9C%E5%83%8F%E4%BD%BF%E7%94%A8%E5%8F%8A%E6%B5%8B%E8%AF%95%E6%95%99%E7%A8%8B)--------------------------------------------收费28RMB**
    -  **[CDR jetson docker镜像](https://github.com/guojianyang/cv-detect-robot/wiki/CDR-jetson-docker%E9%95%9C%E5%83%8F%E4%BD%BF%E7%94%A8%E5%8F%8A%E6%B5%8B%E8%AF%95%E6%95%99%E7%A8%8B)-----------------------------------------收费36RMB**
    - 购买请联系下方项目作者微信(17370042325):
		- ![在这里插入图片描述](https://img-blog.csdnimg.cn/98e5578034fe47cab5ef59a10219810c.png)


***
#  ！！！若使用docker镜像，本行以下内容只作了解即可,若想从零开始配置环境则可参照以下内容！！！
***
#  CDR子项目(一)（yolov5-ros-deepstream）
-  yolov5-ros-deepstream 子项目简介
> 该项目是将yolov5视觉检测算法与神经网络加速引擎tensorRT结合，并在英伟达的deepstream框架下运行，结合ros通信机制，将检测数据实时通过ros topic 发布出去。以供基于ROS机器人操作系统的开发人员及相关科研人员使用。

>详细教程请进入[yolov5-ros-deepstream](https://github.com/guojianyang/cv-detect-robot/blob/main/yolov5-ros-deepstream)

>最终视频检测效果请进入[yolov5-ros-deepstream检测](https://www.bilibili.com/video/BV1Lo4y1Q79C/)
>
>加入目标跟踪器视频检测效果请进入[Jetson NX yolov5-ros-deepstream+目标跟踪](https://www.bilibili.com/video/BV1u34y1673W?spm_id_from=333.999.0.0)
>
>加入目标跟踪器视频检测效果请进入[Jetson Nano yolov5-ros-deepstream+目标跟踪](https://www.bilibili.com/video/BV1pS4y1Z7cX?spm_id_from=333.999.0.0)

#  CDR子项目(二)（yolov5-deepstream-python）
-  yolov5-deepstream-python 子项目简介
> 该项目是将视觉检测算法yolov5与神经网络加速引擎tensorRT结合,利用共享内存技术将检测所得到的数据实时储存到事先定义好的物理内存中（物理地址是唯一的），在同一硬件平台上的任意软件目录中，建立一个读取物理内存的`client.py`脚本文件（里面只包含一个读取内存的代码段），将指定好的物理内存中的数据读取出来，在读取成功的前提下，可将该代码段插入到任意需要目标检测数据的python项目中，从而使该python项目能顺利获取目标检测数据。

> 详细教程请进入[yolov5-deepstream-python](https://github.com/guojianyang/cv-detect-robot/tree/main/yolov5-deepstream-python)

> 最终视频检测效果请进入[yolov5-deepstream-python检测](https://www.bilibili.com/video/BV1Uv411E755/)
> 
>加入目标跟踪器视频检测效果请进入[Jetson NX yolov5-python-deepstream+目标跟踪器](https://www.bilibili.com/video/BV1u34y1673W?spm_id_from=333.999.0.0)
>
>加入目标跟踪器视频检测效果请进入[Jetson Nano yolov5-python-deepstream+目标跟踪器](https://www.bilibili.com/video/BV1pS4y1Z7cX?spm_id_from=333.999.0.0)

#  CDR子项目(三)（yolov5-deepstream-cpp）
- yolov5-deepstream-cpp 子项目简介
> 该项目是将视觉检测算法yolov5与神经网络加速引擎tensorRT结合,利用共享内存技术将检测所得到的数据实时储存到事先定义好的物理内存中（物理地址是唯一的），在同一硬件平台上的任意软件目录中，建立一个读取物理内存的`yolov5_tensor.cpp`文件（里面只包含一个读取内存的代码段），编译后可将指定好的物理内存中的数据读取出来，在读取成功的前提下，可将该代码段插入到任意需要目标检测数据的C++项目中，从而使该C++项目能顺利获取目标检测数据。

> 详细教程请进入[yolov5-deepstream-cpp](https://github.com/guojianyang/cv-detect-robot/tree/main/yolov5-deepstream-cpp)

> 最终视频检测效果请进入[yolov5-deepstream-cpp检测](https://www.bilibili.com/video/BV1yV411p7Dx/)
> 
> 加入目标跟踪器视频检测效果请进入[Jetson NX yolov5-cpp-deepstream+目标跟踪器](https://www.bilibili.com/video/BV1u34y1673W?spm_id_from=333.999.0.0)
> 
> 加入目标跟踪器视频检测效果请进入[Jetson Nano yolov5-cpp-deepstream+目标跟踪器](https://www.bilibili.com/video/BV1pS4y1Z7cX?spm_id_from=333.999.0.0)

#  CDR子项目(四)（yolox-ros-deepstream）
- yolox-ros-deepstream 子项目简介
> 该项目是将yolox视觉检测算法与神经网络加速引擎tensorRT结合，本子项目采另一种引擎文件生成方法，通过onnx转到engine，此方法更具灵活性，也越来越稳定，符合行业主流发展趋势，在英伟达的deepstream框架下运行，结合ros通信机制，将检测数据实时通过ros topic 发布出去。以供基于ROS机器人操作系统的开发人员及相关科研人员使用。

> 详细教程请进入[yolox-ros-deepstream](https://github.com/guojianyang/cv-detect-robot/tree/main/yolox-ros-deepstream)

> 最终视频检测效果请进入[yolox-ros-deepstream检测](https://www.bilibili.com/video/BV1k34y1o7Ck/)
> 
> 加入目标跟踪器视频检测效果请进入[Jetson NX yolox-ros-deepstream+目标跟踪器](https://www.bilibili.com/video/BV1W34y1B7YB?spm_id_from=333.999.0.0)
> 
> 加入目标跟踪器视频检测效果请进入[Jetson Nano yolox-ros-deepstream+目标跟踪器](https://www.bilibili.com/video/BV1Tq4y1A7km?spm_id_from=333.999.0.0)

#  CDR子项目(五)（resnet10+ros+deepstream `for python` ）----(Jetson Nano `and` X_86) 
> 该项目利用`deepstream`的python接口，基于英伟达针对性优化的`resnet10.caffemodel`模型,可利用英伟达新推出的`(TAO) Toolkit `工具包进行自定义数据集训练及模型优化，并继承CDR项目祖传的ros接口。不仅能在Jetson系列平台使用，通过docker容器技术，也可在Linux-x_86平台(Ubuntu)实现快速部署。经测试，该模型在Jetson Nano上可实现在检测算法和多目标跟踪算法同时加持情况下高达30fps的帧率(检测四种目标)，准确率可达90%以上(接近yolov5)。

> 详细教程请进入[resnet10-ros-deepstream](https://github.com/guojianyang/cv-detect-robot/blob/main/resnet10-ros-deepstream/README.md)

> 最终视频检测效果请进入[resnet10-ros-deepstream检测](https://www.bilibili.com/video/BV1Xg411w78P/)
> 
> 加入目标跟踪器视频检测效果请进入[Jetson NX resnet10-ros-deepstream+目标跟踪器](https://www.bilibili.com/video/BV1Fr4y1v7AM?spm_id_from=333.999.0.0)
> 
> 加入目标跟踪器视频检测效果请进入[Jetson Nano resnet10-ros-deepstream+目标跟踪器](https://www.bilibili.com/video/BV1p34y1B7Vx?spm_id_from=333.999.0.0)

#  CDR子项目(六)（yolox-deepstream-python）
- yolox-deepstream-python 子项目简介
> 该项目是将yolox视觉检测算法与神经网络加速引擎tensorRT结合，本子项目采另一种引擎文件生成方法，通过onnx转到engine，此方法更具灵活性，也越来越稳定，符合行业主流发展趋势，在英伟达的deepstream框架下运行，在同一硬件平台上的任意软件目录中，建立一个读取物理内存的`client.py`脚本文件（里面只包含一个读取内存的代码段），将指定好的物理内存中的数据读取出来，在读取成功的前提下，可将该代码段插入到任意需要目标检测数据的python项目中，从而使该python项目能顺利获取目标检测数据。

> 详细教程请进入[yolox-deepstream-python](https://github.com/guojianyang/cv-detect-robot/tree/main/yolox-deepstream-python)

> 最终视频检测效果请进入[yolox-deepstream-python检测](https://www.bilibili.com/video/BV1k34y1o7Ck/)
> 
> 加入目标跟踪器视频检测效果请进入[Jetson NX yolox-ros-deepstream+目标跟踪器](https://www.bilibili.com/video/BV1W34y1B7YB?spm_id_from=333.999.0.0)
> 
> 加入目标跟踪器视频检测效果请进入[Jetson Nano yolox-ros-deepstream+目标跟踪器](https://www.bilibili.com/video/BV1Tq4y1A7km?spm_id_from=333.999.0.0)

#  CDR子项目(七)（yolox-deepstream-cpp）
- yolox-deepstream-cpp 子项目简介
> 该项目是将yolox视觉检测算法与神经网络加速引擎tensorRT结合，本子项目采另一种引擎文件生成方法，通过onnx转到engine，此方法更具灵活性，也越来越稳定，符合行业主流发展趋势，在英伟达的deepstream框架下运行，在同一硬件平台上的任意软件目录中，建立一个读取物理内存的`yolox_tensor.cpp`文件（里面只包含一个读取内存的代码段），编译后可将指定好的物理内存中的数据读取出来，在读取成功的前提下，可将该代码段插入到任意需要目标检测数据的C++项目中，从而使该C++项目能顺利获取目标检测数据。

> 详细教程请进入[yolox-deepstream-cpp](https://github.com/guojianyang/cv-detect-robot/tree/main/yolox-deepstream-cpp)

> 最终视频检测效果请进入[yolox-deepstream-cpp检测](https://www.bilibili.com/video/BV1k34y1o7Ck/)
> 
> 加入目标跟踪器视频检测效果请进入[Jetson NX yolox-ros-deepstream+目标跟踪器](https://www.bilibili.com/video/BV1W34y1B7YB?spm_id_from=333.999.0.0)
> 
> 加入目标跟踪器视频检测效果请进入[Jetson Nano yolox-ros-deepstream+目标跟踪器](https://www.bilibili.com/video/BV1Tq4y1A7km?spm_id_from=333.999.0.0)

#  [CDR项目常见问题及其解决方案(Common problems and solutions)](https://github.com/guojianyang/cv-detect-robot/wiki/CDR%E9%A1%B9%E7%9B%AE%E5%B8%B8%E8%A7%81%E9%97%AE%E9%A2%98%E5%8F%8A%E5%85%B6%E8%A7%A3%E5%86%B3%E6%96%B9%E6%A1%88(Common-problems-and-solutions))
#  [Jetson Nano和 NX在运行CDR项目时注意事项](https://github.com/guojianyang/cv-detect-robot/wiki/Jetson-Nano%E5%92%8C-NX%E5%9C%A8%E8%BF%90%E8%A1%8CCDR%E9%A1%B9%E7%9B%AE%E6%97%B6%E6%B3%A8%E6%84%8F%E4%BA%8B%E9%A1%B9)
#  [wts文件生成engine文件的方法](https://github.com/guojianyang/cv-detect-robot/wiki/wts%E6%96%87%E4%BB%B6%E7%94%9F%E6%88%90engine%E6%96%87%E4%BB%B6%E7%9A%84%E6%96%B9%E6%B3%95)
#  [对多类目标中指定目标类别进行识别与跟踪](https://github.com/guojianyang/cv-detect-robot/wiki/%E5%AF%B9%E5%A4%9A%E7%B1%BB%E7%9B%AE%E6%A0%87%E4%B8%AD%E6%8C%87%E5%AE%9A%E7%9B%AE%E6%A0%87%E7%B1%BB%E5%88%AB%E8%BF%9B%E8%A1%8C%E8%AF%86%E5%88%AB%E4%B8%8E%E8%B7%9F%E8%B8%AA)

