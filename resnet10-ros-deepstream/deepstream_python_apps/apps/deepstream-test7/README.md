# test7 建立只能播放的实例，并能实时打印出目标检测数据(坐标、置信度和类别)

python3命令后面第一个参数“1”代表视频文件输入模式，“2”代表实时摄像头输入模式

- video_file:
python3 deepstream-test_7_usb_file.py 1 /opt/nvidia/deepstream/deepstream-5.1/samples/streams/sample_720p.h264
（备注）：jetson NX 中，以上输入可能会报错，此时需将183行`source_file.set_property('location', args[2])`中的args[2]直接改为视频文件的绝对路径


- real_video:
python3 deepstream-test_7_usb_file.py 2 /dev/video0

  
