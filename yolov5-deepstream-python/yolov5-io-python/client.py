# -*- coding: utf-8 -*-
import numpy
import time
import re
import mmap
global boundingboxes_txt
global boundingboxes_list
if __name__ == "__main__":
    while (1):
        with open('/opt/nvidia/deepstream/deepstream-5.1/sources/yolov5-io-python/nvdsinfer_custom_impl_Yolo/internal_memory.txt', 'r+b') as f:
            # mmap基本上接收两个参数,(文件描述符,读取长度),size 为0表示读取整个文件
            mm = mmap.mmap(f.fileno(), 0)
            mm.seek(0)  # 定位到文件头
            # byte_numline = mm[0]  # mm[]取出来的是byte类型, 要转为int型
            byte_numline = int(mm.read(1))
            str_numline = str(byte_numline)  # 将bytes转化为str类型
            boundingboxes_txt = str(mm[10:int(str_numline)*60 + 10])
            #print("boundingboxes = \n",mm[6:int(str_numline_out)+6])
            mm.close()
        boundingboxes_list = re.findall(r"\d+\.?\d*", boundingboxes_txt)
        #print('boundingboxes_list = ',boundingboxes_list)
        array_boundingbox = numpy.array(boundingboxes_list)
        #print("array_boundingbox = ",boundingboxes_list)
        box_number = len(boundingboxes_list) // 6
        print('box_number = ', box_number)
        re_array_boundingbox = numpy.resize(array_boundingbox, (box_number, 6))
        #print('re_array_boundingbox:\n', re_array_boundingbox)
        print(re_array_boundingbox)
        print("#---------------------------------------------------------------#")


