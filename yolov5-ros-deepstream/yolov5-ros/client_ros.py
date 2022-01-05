# -*- coding: utf-8 -*-
import numpy
import time
import re
import mmap
import rospy
from std_msgs.msg import String
from darknet_ros_msgs.msg import BoundingBox_tensor,BoundingBoxes_tensor
global boundingboxes_txt
global boundingboxes_list
if __name__ == "__main__":
    rospy.init_node('BoundingBoxes_tensor')   #初始化程序节点
    rate = rospy.Rate(50)   #相当于等待时间
    boundingboxes_publisher = rospy.Publisher('boundingboxes_tensor',BoundingBoxes_tensor,queue_size=10)
    time.sleep(1)
    BoundingBoxes_ = BoundingBoxes_tensor()
    # bounding_boxes_ = [BoundingBox() for i in range(5)]
    # bounding_boxes_number = [BoundingBox() for i in range(3)]
    while (1):
        with open('/opt/nvidia/deepstream/deepstream-5.1/sources/yolov5-ros/nvdsinfer_custom_impl_Yolo/internal_memory.txt', 'r+b') as f:
            # mmap基本上接收两个参数,(文件描述符,读取长度),size 为0表示读取整个文件
            mm = mmap.mmap(f.fileno(), 0)
            mm.seek(0)  # 定位到文件头
            byte_numline = mm[0]  # mm[]取出来的是byte类型, 要转为int型
            str_numline = str(byte_numline)  # 将bytes转化为str类型
            boundingboxes_txt = str(mm[10:int(str_numline)*60 + 10])
            #print("boundingboxes = \n",mm[6:int(str_numline_out)+6])
            mm.close()
        boundingboxes_list = re.findall(r"\d+\.?\d*", boundingboxes_txt)
        #print('boundingboxes_list = ',boundingboxes_list)
        array_boundingbox = numpy.array(boundingboxes_list)
        #print("array_boundingbox = ",boundingboxes_list)
        box_number = len(boundingboxes_list) // 6
        print("box_number = ", box_number)
        re_array_boundingbox = numpy.resize(array_boundingbox, (box_number, 6))
        bounding_boxes_number = [BoundingBox_tensor() for i in range(box_number)]
        for j in range(box_number):
            top = int(str(re_array_boundingbox[j][1]))
            left = int(str(re_array_boundingbox[j][2]))
            width = int(str(re_array_boundingbox[j][3]))
            height = int(str(re_array_boundingbox[j][4]))
            bounding_boxes_number[j].top = top
            bounding_boxes_number[j].left = left
            bounding_boxes_number[j].width = width
            bounding_boxes_number[j].height = height
            bounding_boxes_number[j].probability = float(str(re_array_boundingbox[j][5]))
            bounding_boxes_number[j].Class = str(re_array_boundingbox[j][0])
            bounding_boxes_number[j].id = j + 1
        # print("输出匹配的数据：\n", re_array_boundingbox)
        # print("输出匹配的数据类型：\n", type(re_array_boundingbox))
        print("BoundingBoxes.bounding_boxes = ", bounding_boxes_number)
        print("#---------------------------------------------------------------#")
        #cmd = 'guojianyang'
        BoundingBoxes_.boundingboxes_tensor = bounding_boxes_number
        boundingboxes_publisher.publish(BoundingBoxes_)
        #string_publisher.publish(cmd)
        rate.sleep()


