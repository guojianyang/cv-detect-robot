import sys
from typing import Container
sys.path.append('../')
import gi
import configparser
gi.require_version('Gst', '1.0')
from gi.repository import GObject, Gst
from common.is_aarch_64 import is_aarch64
from common.bus_call import bus_call
import cv2
import numpy as np
import os.path
from os import path
import pyds
import mmap

fps_streams = {}
frame_count = {}
saved_count = {}
Detect_Mode = 0   # 默认值为"0",   "1"为 file文件读取模式， "2"为usb实时视频检测模式
bounding_bboxes =[]
PGIE_CLASS_ID_VEHICLE = 0
PGIE_CLASS_ID_BICYCLE = 1
PGIE_CLASS_ID_PERSON = 2
PGIE_CLASS_ID_ROADSIGN = 3
past_tracking_meta=[0]
pgie_classes_str = ["Vehicle", "TwoWheeler", "Person", "RoadSign"]
MIN_CONFIDENCE = 0.3
MAX_CONFIDENCE = 0.99
def osd_sink_pad_buffer_probe(pad,  info,  u_data):
    frame_number = 0
    obj_counter = {
        PGIE_CLASS_ID_VEHICLE:0,
        PGIE_CLASS_ID_PERSON:0,
        PGIE_CLASS_ID_BICYCLE:0,
        PGIE_CLASS_ID_ROADSIGN:0

    }
    num_rects = 0

    gst_buffer = info.get_buffer() #在缓存区中取数据
    if not gst_buffer:
        print("Unable to get GstBuffer")
        return 

    batch_meta = pyds.gst_buffer_get_nvds_batch_meta(hash(gst_buffer))
    l_frame = batch_meta.frame_meta_list
    while l_frame is not None: #--------对一帧图片进行所有目标的遍历
        try: 
            frame_meta = pyds.NvDsFrameMeta.cast(l_frame.data)
        except StopIteration:
            break

        frame_number = frame_meta.frame_num
        num_rects = frame_meta.num_obj_meta #--------储存每帧目标的总个数
        l_obj = frame_meta.obj_meta_list
        bounding_bboxes =[]
        while l_obj  is not None:  #--------对同个目标类型不同个体进行遍历 
            try:
                obj_meta = pyds.NvDsObjectMeta.cast(l_obj.data)
            except StopIteration:
                break
            obj_counter[obj_meta.class_id]  += 1

            class_id = obj_meta.class_id
            top = obj_meta.tracker_bbox_info.org_bbox_coords.top
            left = obj_meta.tracker_bbox_info.org_bbox_coords.left
            width = obj_meta.tracker_bbox_info.org_bbox_coords.width
            height = obj_meta.tracker_bbox_info.org_bbox_coords.height
            object_id = obj_meta.object_id
            #print(int(class_id), "   ",int(top), "   ",int(left), "   ",int(width), "   ",int(height),"   ", int(object_id))

            bounding_bboxes.append(int(class_id))
            bounding_bboxes.append(int(top))
            bounding_bboxes.append(int(left))
            bounding_bboxes.append(int(width)) 
            bounding_bboxes.append(int(height))
            bounding_bboxes.append(int(object_id)) 
            obj_meta.rect_params.border_color.set(1.0, 0.0, 0.0, 0.0) #--------red ,green, blue, black
            try:
                l_obj = l_obj.next
                
            except StopIteration:
                break
        print("bounding_bboxes:",bounding_bboxes)
        bounding_bboxes_len =  len(str(bounding_bboxes))
        real_len = bounding_bboxes_len
        print("bounding_bboxes_len:", bounding_bboxes_len)

        #--------mmap向internal_memory.txt所指向的内存中写入数据--------#
        with open('internal_memory.txt', 'r+') as f:
            # mmap基本上接收两个参数,(文件描述符,读取长度),size 为0表示读取整个文件
            mm = mmap.mmap(f.fileno(), 0)
            mm.seek(0)  # 定位到文件头
            if len(str(bounding_bboxes_len)) != 5:  # 获取有效信息的长度数字取值
                for ii in range(5 - len(str(bounding_bboxes_len))):  # 循环添加“_”至满5位
                    bounding_bboxes_len = str(bounding_bboxes_len) + str("-")
            print("bounding_bboxes_len_str = ", bounding_bboxes_len)
            mm.write(bytes(str(bounding_bboxes_len), 'utf-8'))
            # 切片读取方式
            # mm.write(bytes(det_str, 'utf-8'))
            mm.seek(6)
            mm.write(bytes(str(bounding_bboxes), 'utf-8'))
            # 标准读取方式
            print(mm[:real_len + 6])  # prints "Hello Python!"
            # 像处理文件一样关闭mmap映射
            mm.close()



        bounding_bboxes =[]
        
        #--------创建左上角长条形数据显示串--------#
        display_meta = pyds.nvds_acquire_display_meta_from_pool(batch_meta)
        display_meta.num_labels = 1
        py_nvosd_text_params = display_meta.text_params[0]

        #左上角显示text串
        py_nvosd_text_params.display_text = "Frame Number = {}  Number of Objects = {}  Vechile_count = {} person_count = {}".format(frame_number, num_rects, obj_counter[PGIE_CLASS_ID_VEHICLE], obj_counter[PGIE_CLASS_ID_PERSON])
        py_nvosd_text_params.x_offset = 10
        py_nvosd_text_params.y_offset = 12
        py_nvosd_text_params.font_params.font_name  = "Serif"
        py_nvosd_text_params.font_params.font_size = 10
        py_nvosd_text_params.font_params.font_color.set(1.0,  1.0,  1.0, 1.0)
        py_nvosd_text_params.set_bg_clr = 1
        py_nvosd_text_params.text_bg_clr.set(0.0,  0.0,  0.0,  1.0)
        print(pyds.get_string(py_nvosd_text_params.display_text))

        pyds.nvds_add_display_meta_to_frame(frame_meta, display_meta)
        try:
            l_frame = l_frame.next
        except StopIteration:
            break
    return Gst.PadProbeReturn.OK


def main(args):
    if len(args)!=3:
        sys.stderr.write("  \n\n\n对不起，您还未输入视频源！！！\n\n\n")
        sys.exit(1)
    else:
        if args[1]=="1":
            Detect_Mode = 1
            print("您已进入视频文件检测模式！！！")  
        if args[1]=="2":
            Detect_Mode = 2
            print("您已进入实时视频检测模式！！！")
    GObject.threads_init()
    Gst.init(None)
    print("Creating Pileline  \n")
    pipeline = Gst.Pipeline()
    if Detect_Mode ==1:
        source_file = Gst.ElementFactory.make("filesrc", "file-source")
        h264parser = Gst.ElementFactory.make("h264parse", "h264-parper") # h264的编解码
        decoder = Gst.ElementFactory.make("nvv4l2decoder"," nvv4l2-decoder") # h264的编解码
    if Detect_Mode == 2:
        source_usb = Gst.ElementFactory.make("v4l2src", "usb-cam-source")
        caps_v4l2src = Gst.ElementFactory.make("capsfilter", "v4l2src_caps")
        vidconvsrc = Gst.ElementFactory.make("videoconvert", "convertor_src1")
        nvvidconvsrc = Gst.ElementFactory.make("nvvideoconvert", "convertor_src2")
        caps_vidconvsrc = Gst.ElementFactory.make("capsfilter", "nvmm_caps")

    streammux = Gst.ElementFactory.make("nvstreammux", "Stream-muxer") # autobatch 自动批量处理
    pgie = Gst.ElementFactory.make("nvinfer", "primary-inference") #第一级网络（主要的推理引擎engine）


    # -----------------------------为实时储存和实时播放新加的元件--------------------------------------#
    if is_aarch64():
        transform = Gst.ElementFactory.make("nvegltransform", "nvegl-transform")
    sink_real = Gst.ElementFactory.make("nveglglessink", "nvvideo-renderer")
    if not sink_real:
        sys.stderr.write(" Unable to create egl sink \n")


    tracker = Gst.ElementFactory.make("nvtracker", "tracker")
    if not tracker:
        sys.stderr.write(" Unable to create tracker \n")

    sgie1= Gst.ElementFactory.make("nvinfer", "secondary1-inference") #第二级网络
    nvvidconv = Gst.ElementFactory.make("nvvideoconvert", "convertor") #转换工具(因为输出的东西要放到画面上)
    nvosd = Gst.ElementFactory.make("nvdsosd"," onscreendisplay") # 显示display工具
    if Detect_Mode==1:
        source_file.set_property('location', args[2]) #输入本地文件视频源
    if Detect_Mode==2:
        source_usb.set_property('device', args[2]) #输入usb实时视频源
        caps_v4l2src.set_property('caps', Gst.Caps.from_string("video/x-raw, framerate=30/1"))
        caps_vidconvsrc.set_property('caps', Gst.Caps.from_string("video/x-raw(memory:NVMM)"))

    streammux.set_property('width', 1920) #设置输入源的宽
    streammux.set_property('height', 1080) #设置输入源的高
    streammux.set_property('batch-size',  1)
    streammux.set_property("batched-push-timeout", 4000000)
    pgie.set_property('config-file-path',"dstest7_pgie_config.txt")
    sgie1.set_property('config-file-path',"dstest7_sgie1_config.txt")
    #pgie.set_property('config-file-path', "dstest3_pgie_config.txt")
    sink_real.set_property('sync', False) #决定实时视频是否同步显示
    
    config = configparser.ConfigParser()
    config.read('dstest7_tracker_config.txt')
    config.sections()

    for key in config['tracker']:
        if key == 'tracker-width':
            tracker_width = config.getint('tracker', key)
            tracker.set_property('tracker-width', tracker_width)
        if key == 'tracker-height':
            tracker_height = config.getint('tracker', key)
            tracker.set_property('tracker-height', tracker_height)
        if key == 'gpu-id':
            tracker_gpu_id = config.getint('tracker', key)
            tracker.set_property('gpu_id', tracker_gpu_id)
        if key == 'll-lib-file':
            tracker_ll_lib_file = config.get('tracker', key)
            tracker.set_property('ll-lib-file', tracker_ll_lib_file)
        if key == 'll-config-file':
            tracker_ll_config_file = config.get('tracker', key)
            tracker.set_property('ll-config-file', tracker_ll_config_file)
        if key == 'enable-batch-process':
            tracker_enable_batch_process = config.getint('tracker', key)
            tracker.set_property('enable_batch_process', tracker_enable_batch_process)

    print("Adding elements to Pipeline \n")
    if Detect_Mode==1:
        pipeline.add(source_file )
        pipeline.add(h264parser)
        pipeline.add(decoder)
    if Detect_Mode==2:
        pipeline.add(source_usb)
        pipeline.add(caps_v4l2src)
        pipeline.add(vidconvsrc)
        pipeline.add(nvvidconvsrc)
        pipeline.add(caps_vidconvsrc)
    pipeline.add(streammux)
    pipeline.add(pgie)

    pipeline.add(tracker)

    pipeline.add(sgie1)
    pipeline.add(nvvidconv)
    pipeline.add(nvosd) 
    if is_aarch64():
        pipeline.add(transform)
    pipeline.add(sink_real)

    if Detect_Mode==1:
        source_file.link(h264parser)
        h264parser.link(decoder)
        sinkpad_file = streammux.get_request_pad("sink_0")
        srcpad_file = decoder.get_static_pad("src")
        srcpad_file.link(sinkpad_file)
    if Detect_Mode==2:
        source_usb.link(caps_v4l2src)
        caps_v4l2src.link(vidconvsrc)
        vidconvsrc.link(nvvidconvsrc)
        nvvidconvsrc.link(caps_vidconvsrc)
        sinkpad_usb = streammux.get_request_pad("sink_0")
        if not sinkpad_usb:
            sys.stderr.write(" Unable to get the sink pad of streammux \n")
        srcpad_usb = caps_vidconvsrc.get_static_pad("src")
        if not srcpad_usb:
            sys.stderr.write(" Unable to get source pad of caps_vidconvsrc \n")
        srcpad_usb.link(sinkpad_usb)
    streammux.link(pgie)


    pgie.link(tracker)
    tracker.link(sgie1)
    sgie1.link(nvvidconv)
    nvvidconv.link(nvosd)
    if is_aarch64():
        nvosd.link(transform)
        transform.link(sink_real)
    else:
        nvosd.link(sink_real)

    loop = GObject.MainLoop()
    bus = pipeline.get_bus()
    bus.add_signal_watch()
    bus.connect("message", bus_call, loop)

    osdsinkpad = nvosd.get_static_pad("sink")
    if not osdsinkpad:
        sys.stderr.write("Unable to get sink pad of nvosd  \n")
    
    osdsinkpad.add_probe(Gst.PadProbeType.BUFFER,  osd_sink_pad_buffer_probe,  0)

    print("Starting pipeline \n")
    pipeline.set_state(Gst.State.PLAYING)
    try:
        loop.run()
    except:
        pass
    # cleanup
    print("Exiting app\n")
    pipeline.set_state(Gst.State.NULL)

if __name__ == "__main__":
    sys.exit(main(sys.argv))




