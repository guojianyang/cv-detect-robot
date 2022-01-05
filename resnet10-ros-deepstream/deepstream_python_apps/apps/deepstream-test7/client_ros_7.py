# -*- coding: utf-8 -*-
import numpy
import time
import re
import mmap
import rospy
from std_msgs.msg import String
from darknet_ros_msgs.msg import BoundingBox,BoundingBoxes
global boundingboxes_txt
global boundingboxes_list

if __name__ == "__main__":
    rospy.init_node('BoundingBoxes')   #初始化程序节点
    rate = rospy.Rate(50)   #相当于等待时间
    boundingboxes_publisher = rospy.Publisher('boundingboxes',BoundingBoxes,queue_size=10)
    time.sleep(1)
    BoundingBoxes_ = BoundingBoxes()
    # bounding_boxes_ = [BoundingBox() for i in range(5)]
    # bounding_boxes_number = [BoundingBox() for i in range(3)]
    while (1):
        with open('/opt/nvidia/deepstream/deepstream-5.1/sources/deepstream_python_apps/apps/deepstream-test7/internal_memory.txt', 'r+b') as f:
            # mmap基本上接收两个参数,(文件描述符,读取长度),size 为0表示读取整个文件
            mm = mmap.mmap(f.fileno(), 0)
            mm.seek(0)  # 定位到文件头
            byte_numline = mm[0:5]  # mm[]取出来的是byet类型, 要转为int型
            str_numline = str(byte_numline)  # 将bytes转化为str类型

            m = re.findall("\d+", str_numline)
            int_numline = int(m[0])
            boundingboxes_txt = str(mm[6:int_numline+6])
            #print("boundingboxes = \n",mm[6:int(str_numline_out)+6])
            mm.close()
        boundingboxes_list = re.findall(r"\d+\.?\d*", boundingboxes_txt)
        #print('boundingboxes_list = ',boundingboxes_list)
        array_boundingbox = numpy.array(boundingboxes_list)
        #print("array_boundingbox = ",boundingboxes_list)
        box_number = len(boundingboxes_list) // 6
        print("box_number = ", box_number)
        re_array_boundingbox = numpy.resize(array_boundingbox, (box_number, 6))
        bounding_boxes_number = [BoundingBox() for i in range(box_number)]
        for j in range(box_number):
            class_id = int(str(re_array_boundingbox[j][0]))
            top = int(str(re_array_boundingbox[j][1]))
            left = int(str(re_array_boundingbox[j][2]))
            width = int(str(re_array_boundingbox[j][3]))
            height = int(str(re_array_boundingbox[j][4]))
            object_id = int(str(re_array_boundingbox[j][5]))
            
            bounding_boxes_number[j].class_id =  class_id
            bounding_boxes_number[j].top = top
            bounding_boxes_number[j].left = left
            bounding_boxes_number[j].width = width
            bounding_boxes_number[j].height = height
            bounding_boxes_number[j].object_id = object_id
        # print("输出匹配的数据：\n", re_array_boundingbox)
        # print("输出匹配的数据类型：\n", type(re_array_boundingbox))
        #print("BoundingBoxes.bounding_boxes = ", bounding_boxes_number)
        print("#---------------------------------------------------------------#")
        #cmd = 'guojianyang'
        BoundingBoxes_.bounding_boxes = bounding_boxes_number
        boundingboxes_publisher.publish(BoundingBoxes_)
        #string_publisher.publish(cmd)
        rate.sleep()




