/*
 * Copyright (c) 2020, NVIDIA CORPORATION. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <algorithm>
#include <cassert>
#include <cmath>
#include <cstring>
#include <fstream>
#include <iostream>
#include <unordered_map>
#include "nvdsinfer_custom_impl.h"
#include <typeinfo>
#include <map>

//----the below head file by myself-----
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <string.h>
#include <iostream>
#include <typeinfo>
#include <string>
#include <sstream>
#include <cmath>
#include <iomanip>

//----the above head file by myself-----

#define kNMS_THRESH 0.45

static constexpr int LOCATIONS = 4;
//alignas(float) 设置地址对其性
struct alignas(float) Detection{
        //center_x center_y w h
        float bbox[LOCATIONS];
        float conf;  // bbox_conf * cls_conf
        float class_id;
    };

//以下iou为交并比
float iou(float lbox[4], float rbox[4]) {
    float interBox[] = {
        std::max(lbox[0] - lbox[2]/2.f , rbox[0] - rbox[2]/2.f), //left
        std::min(lbox[0] + lbox[2]/2.f , rbox[0] + rbox[2]/2.f), //right
        std::max(lbox[1] - lbox[3]/2.f , rbox[1] - rbox[3]/2.f), //top
        std::min(lbox[1] + lbox[3]/2.f , rbox[1] + rbox[3]/2.f), //bottom
    };

    if(interBox[2] > interBox[3] || interBox[0] > interBox[1])
        return 0.0f;

    float interBoxS =(interBox[1]-interBox[0])*(interBox[3]-interBox[2]);
    return interBoxS/(lbox[2]*lbox[3] + rbox[2]*rbox[3] -interBoxS);
}

bool cmp(Detection& a, Detection& b) {
    return a.conf > b.conf;
}


void nms(std::vector<Detection>& res, float *output, float conf_thresh, float nms_thresh) {
    int det_size = sizeof(Detection) / sizeof(float);
    std::map<float, std::vector<Detection>> m;
    for (int i = 0; i < output[0] && i < 1000; i++) {
        if (output[1 + det_size * i + 4] <= conf_thresh) continue;
        Detection det;
        memcpy(&det, &output[1 + det_size * i], det_size * sizeof(float));
        if (m.count(det.class_id) == 0) m.emplace(det.class_id, std::vector<Detection>());
        m[det.class_id].push_back(det);
    }
    for (auto it = m.begin(); it != m.end(); it++) {
        auto& dets = it->second;
        std::sort(dets.begin(), dets.end(), cmp);
        for (size_t m = 0; m < dets.size(); ++m) {
            auto& item = dets[m];
            res.push_back(item);
            for (size_t n = m + 1; n < dets.size(); ++n) {
                if (iou(item.bbox, dets[n].bbox) > nms_thresh) {
                    dets.erase(dets.begin()+n);
                    --n;
                }
            }
        }
    }
}

/* This is a sample bounding box parsing function for the sample YoloV5 detector model */
static bool NvDsInferParseYoloV5(
    std::vector<NvDsInferLayerInfo> const& outputLayersInfo,
    NvDsInferNetworkInfo const& networkInfo,
    NvDsInferParseDetectionParams const& detectionParams,
    std::vector<NvDsInferParseObjectInfo>& objectList)
{
    const float kCONF_THRESH = detectionParams.perClassThreshold[0];

    std::vector<Detection> res;

    nms(res, (float*)(outputLayersInfo[0].buffer), kCONF_THRESH, kNMS_THRESH);

    //循环体中修改r，res中对应的内容也会做出改变，相当于‘r’储存了‘res’的地址
    for(auto& r : res) {
	    NvDsInferParseObjectInfo oinfo;        
	    oinfo.classId = r.class_id;
	    oinfo.left    = static_cast<unsigned int>(r.bbox[0]-r.bbox[2]*0.5f);
	    oinfo.top     = static_cast<unsigned int>(r.bbox[1]-r.bbox[3]*0.5f);
	    oinfo.width   = static_cast<unsigned int>(r.bbox[2]);
	    oinfo.height  = static_cast<unsigned int>(r.bbox[3]);
	    oinfo.detectionConfidence = r.conf;
	    objectList.push_back(oinfo);
            //printf("the_oinfo:",typeid(oinfo).name());          
    }
    std::stringstream boundingboxes; //create a stringstream to store object-data per frame
    unsigned long int objectlist_len = objectList.size();
    boundingboxes << objectlist_len;
    for(int j =0; j < 9; j++)
    {
     boundingboxes << " ";
    }
    for (auto i : objectList)
    {
    	//std::cout << i.classId << "  "<<i.left <<"  "<< i.top <<"  "<<i.width <<"  "<< i.height <<"  "<< i.detectionConfidence <<std::endl;
        /*-----------------------below these code is puiting data into boundingboxes orderly----------------------------*/
        std::string conf = std::to_string(i.detectionConfidence);
        boundingboxes << i.classId;
        for(int j = 0; j< 9;j++){
         boundingboxes << " ";
        }
        if (i.left < 10)
        {
         boundingboxes << i.left;
         for(int j = 0; j< 9 ; j++)
         {
          boundingboxes << " ";
         } 
        }
        else
        {
         boundingboxes << i.left;
         for(int j = 0; j< (10-log10(i.left)-1);j++)
         {
          boundingboxes << " ";
         }
        }
        if (i.top < 10)
        {
         boundingboxes << i.top;
         for(int j = 0; j< 9 ; j++)
         {
          boundingboxes << " ";
         }
        }
        else{
         boundingboxes << i.top;
         for(int j = 0; j< (10-log10(i.top)-1);j++)
         {
          boundingboxes << " ";
         }
        }
        boundingboxes << i.width;
        for(int j = 0; j< (10-log10(i.width)-1);j++){
         boundingboxes << " ";
        } 
        boundingboxes << i.height;
        for(int j = 0; j< (10-log10(i.height)-1);j++){
         boundingboxes << " ";
        }
        boundingboxes << conf.substr(0,5);   // get the top five bits of the string 'conf'
        for(int j = 0; j< 5 ;j++){
         boundingboxes << " ";
        }
        /*--------------------------------------------------------------------------------------------------------------*/
    }
     
    /*-----------------below these code is taking the boundingboxes into memory of 'internal_memory.txt'----------------*/
    unsigned long int boundingboxes_len = objectlist_len*60 + 10;
    int fd = open("/opt/nvidia/deepstream/deepstream-5.1/sources/yolov5-io-python/nvdsinfer_custom_impl_Yolo/internal_memory.txt",O_RDWR|O_CREAT, 00777);
    char* guo =(char*)(mmap(NULL, boundingboxes_len, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0));

    //determine whether the memory is read successfully by the return-value 'MAP_FAILED'
    if (guo == MAP_FAILED)
    {
        perror("mmap err");
        return -1;
    }
    close(fd);      // close the txt-file

    std::string s = boundingboxes.str();   // stringstream transform into string
    //unsigned long int len_s = s.size();
    //std::cout << "the boundingboxes: \n" << s << std::endl; 
    const char *file_txt=(char*)s.c_str();       // string transform into char[]
    //std::cout << "the length of s is:" << s << std::endl;
    memcpy(guo, file_txt,boundingboxes_len);           // put the char[] into txt-file
    munmap(guo,boundingboxes_len);         // free the memory, the '1500' is the size of free memory

    /*------------------------------------------------------------------------------------------------------------------*/

    // printf("the_oinfo:%s\n",&objectList.back());
    //std::cout << "the length of objectList is :"<<objectList.size() << std::endl;
    //printf("--------------------------------------------\n");
    return true;
}

extern "C" bool NvDsInferParseCustomYoloV5(
    std::vector<NvDsInferLayerInfo> const &outputLayersInfo,
    NvDsInferNetworkInfo const &networkInfo,
    NvDsInferParseDetectionParams const &detectionParams,
    std::vector<NvDsInferParseObjectInfo> &objectList)
{
    return NvDsInferParseYoloV5(
        outputLayersInfo, networkInfo, detectionParams, objectList);
}

/* Check that the custom function has been defined correctly */
CHECK_CUSTOM_PARSE_FUNC_PROTOTYPE(NvDsInferParseCustomYoloV5);
