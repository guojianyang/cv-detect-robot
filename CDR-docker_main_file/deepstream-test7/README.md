
# 读取视频文件
##  video_file:
python3 deepstream-test_7_file.py  file:///opt/nvidia/deepstream/deepstream-6.0/samples/streams/sample_qHD.mp4

# 读取usb实时视频源
## real_video:
python3 deepstream-test_7_cam.py  /dev/video0

# 读取rtsp实时视频流
## rtsp_stream:
python3 deepstream-test_7_rtsp.py rtsp://admin:ak123456@192.168.0.123:554/ch1/main/av_stream
python3 deepstream-test_7_rtsp.py rtsp://192.168.0.104:8554/live.ts


# 如果没有现成rtsp流，可使用usb转rtsp方法(在宿主机运行，此方案视频流延迟较大)：
## usb-stream convert to rtsp-stream
- cvlc -vvv v4l2:///dev/video0 --sout '#transcode{vcodec=h264,vb=800,acodec=mp4a}:rtp{sdp=rtsp://192.168.0.105:8554/live.ts}' -I dummy
- 参考`https://blog.csdn.net/zong596568821xp/article/details/88540455`方法3 vlc
