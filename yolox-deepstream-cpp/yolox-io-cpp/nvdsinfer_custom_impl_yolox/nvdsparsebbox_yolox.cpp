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
#include <vector>
#include <omp.h>
#include <opencv2/opencv.hpp>
#include "nvdsinfer_custom_impl.h"


//----the below head file by myself----//
#include<stdio.h>
#include<unistd.h>
#include<fcntl.h>
#include<sys/mman.h>
#include<string.h>
#include<iostream>
#include<typeinfo>
#include<string>
#include<sstream>
#include<cmath>
#include<iomanip>



#define DEVICE 0  // GPU id
#define NMS_THRESH 0.65
#define BBOX_CONF_THRESH 0.3


static const int INPUT_W = 416; //640
static const int INPUT_H = 416; //640
const char* INPUT_BLOB_NAME = "images";
const char* OUTPUT_BLOB_NAME = "output";



struct Object
{
    cv::Rect_<float> rect;
    int label;
    float prob;
};

struct GridAndStride
{
    int grid0;
    int grid1;
    int stride;
};

static void generate_grids_and_stride(const int target_size, std::vector<int>& strides, std::vector<GridAndStride>& grid_strides)
{
    for (auto stride : strides)
    {
        int num_grid = target_size / stride;
        for (int g1 = 0; g1 < num_grid; g1++)
        {
            for (int g0 = 0; g0 < num_grid; g0++)
            {
                grid_strides.push_back((GridAndStride){g0, g1, stride});
            }
        }
    }
}

static inline float intersection_area(const Object& a, const Object& b)
{
    cv::Rect_<float> inter = a.rect & b.rect;
    return inter.area();
}

/*
 * 对目标检测模型输出层做非极大值抑制（NMS）等后处理，输出检测。
 * NMS具体来说分为两个步骤，第一个步骤是按照置信度对检测到的bounding box排序，
 * 采用的是快速排序法，代码如下： *
 */
static void qsort_descent_inplace(std::vector<Object>& faceobjects, int left, int right)
{
    int i = left;
    int j = right;
    float p = faceobjects[(left + right) / 2].prob;

    while (i <= j)
    {
        while (faceobjects[i].prob > p)
            i++;

        while (faceobjects[j].prob < p)
            j--;

        if (i <= j)
        {
            // swap
            std::swap(faceobjects[i], faceobjects[j]);

            i++;
            j--;
        }
    }

    #pragma omp parallel sections
    {
        #pragma omp section
        {
            if (left < j) qsort_descent_inplace(faceobjects, left, j);
        }
        #pragma omp section
        {
            if (i < right) qsort_descent_inplace(faceobjects, i, right);
        }
    }
}

static void qsort_descent_inplace(std::vector<Object>& objects)
{
    if (objects.empty())
        return;

    qsort_descent_inplace(objects, 0, objects.size() - 1);
}

/*
 * 排序完成后，根据框与框之间的交并比（IOU）对检测结果进行过滤：
 *
 */
static void nms_sorted_bboxes(const std::vector<Object>& faceobjects, std::vector<int>& picked, float nms_threshold)
{
    picked.clear();

    const int n = faceobjects.size();

    std::vector<float> areas(n);
    for (int i = 0; i < n; i++)
    {
        areas[i] = faceobjects[i].rect.area();
    }

    for (int i = 0; i < n; i++)
    {
        const Object& a = faceobjects[i];

        int keep = 1;
        for (int j = 0; j < (int)picked.size(); j++)
        {
            const Object& b = faceobjects[picked[j]];

            // intersection over union
            float inter_area = intersection_area(a, b);
            float union_area = areas[i] + areas[picked[j]] - inter_area;
            // float IoU = inter_area / union_area
            if (inter_area / union_area > nms_threshold)
                keep = 0;
        }

        if (keep)
            picked.push_back(i);
    }
}


static void generate_yolox_proposals(std::vector<GridAndStride> grid_strides, float* feat_blob, float prob_threshold, std::vector<Object>& objects)
{
    const int num_class = 80;

    const int num_anchors = grid_strides.size();

    for (int anchor_idx = 0; anchor_idx < num_anchors; anchor_idx++)
    {
        const int grid0 = grid_strides[anchor_idx].grid0;
        const int grid1 = grid_strides[anchor_idx].grid1;
        const int stride = grid_strides[anchor_idx].stride;

        const int basic_pos = anchor_idx * (num_class + 5);

        // yolox/models/yolo_head.py decode logic
        float x_center = (feat_blob[basic_pos+0] + grid0) * stride;
        float y_center = (feat_blob[basic_pos+1] + grid1) * stride;
        float w = exp(feat_blob[basic_pos+2]) * stride;
        float h = exp(feat_blob[basic_pos+3]) * stride;
        float x0 = x_center - w * 0.5f;
        float y0 = y_center - h * 0.5f;

        float box_objectness = feat_blob[basic_pos+4];
        for (int class_idx = 0; class_idx < num_class; class_idx++)
        {
            float box_cls_score = feat_blob[basic_pos + 5 + class_idx];
            float box_prob = box_objectness * box_cls_score;
            if (box_prob > prob_threshold)
            {
                Object obj;
                obj.rect.x = x0;
                obj.rect.y = y0;
                obj.rect.width = w;
                obj.rect.height = h;
                obj.label = class_idx;
                obj.prob = box_prob;

                objects.push_back(obj);
            }

        } // class loop

    } // point anchor loop
}



static void decode_outputs(float* prob, std::vector<Object>& objects, float scale, const int img_w, const int img_h) {
        std::vector<Object> proposals;
        std::vector<int> strides = {8, 16, 32};
        std::vector<GridAndStride> grid_strides;
        generate_grids_and_stride(INPUT_W, strides, grid_strides);
        generate_yolox_proposals(grid_strides, prob,  BBOX_CONF_THRESH, proposals);
        // std::cout << "num of boxes before nms: " << proposals.size() << std::endl;

        qsort_descent_inplace(proposals);

        std::vector<int> picked;
        nms_sorted_bboxes(proposals, picked, NMS_THRESH);


        int count = picked.size();

        // std::cout << "num of boxes: " << count << std::endl;

        objects.resize(count);
        for (int i = 0; i < count; i++)
        {
            objects[i] = proposals[picked[i]];

            // adjust offset to original unpadded
            // float x0 = (objects[i].rect.x) / scale;
            // float y0 = (objects[i].rect.y) / scale;
            // float x1 = (objects[i].rect.x + objects[i].rect.width) / scale;
            // float y1 = (objects[i].rect.y + objects[i].rect.height) / scale;
            float x0 = (objects[i].rect.x);
            float y0 = (objects[i].rect.y);
            float x1 = (objects[i].rect.x + objects[i].rect.width);
            float y1 = (objects[i].rect.y + objects[i].rect.height);

            // clip
            x0 = std::max(std::min(x0, (float)(img_w - 1)), 0.f);
            y0 = std::max(std::min(y0, (float)(img_h - 1)), 0.f);
            x1 = std::max(std::min(x1, (float)(img_w - 1)), 0.f);
            y1 = std::max(std::min(y1, (float)(img_h - 1)), 0.f);

            objects[i].rect.x = x0;
            objects[i].rect.y = y0;
            objects[i].rect.width = x1 - x0;
            objects[i].rect.height = y1 - y0;
			
			//fprintf(stderr, "bbox: %d, classId=%d conf=%.2f x=%.f, y=%.f, w=%.f, h=%.f\n", i, objects[i].label, objects[i].prob, objects[i].rect.x, objects[i].rect.y, objects[i].rect.width, objects[i].rect.height);
        }
}


/* This is a sample bounding box parsing function for the sample YOLOX detector model */
static bool NvDsInferParseYolox(
    std::vector<NvDsInferLayerInfo> const& outputLayersInfo,
    NvDsInferNetworkInfo const& networkInfo,
    NvDsInferParseDetectionParams const& detectionParams,
    std::vector<NvDsInferParseObjectInfo>& objectList)
{
    float* prob = (float*)outputLayersInfo[0].buffer;
    std::vector<Object> objects;
    int img_w = 1920;
    int img_h = 1080;
    float scale = std::min(INPUT_W / (img_w*1.0), INPUT_H / (img_h*1.0));
    decode_outputs(prob, objects, scale, img_w, img_h);
    for(auto& r : objects) {
	    NvDsInferParseObjectInfo oinfo;
        
	    oinfo.classId = r.label;
        oinfo.left    = static_cast<unsigned int>(r.rect.x);
	    oinfo.top     = static_cast<unsigned int>(r.rect.y);
	    oinfo.width   = static_cast<unsigned int>(r.rect.width);
	    oinfo.height  = static_cast<unsigned int>(r.rect.height);
	    oinfo.detectionConfidence = r.prob;
	    objectList.push_back(oinfo);
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
    int fd = open("/opt/nvidia/deepstream/deepstream-5.1/sources/yolox-io-cpp/nvdsinfer_custom_impl_yolox/internal_memory.txt",O_RDWR|O_CREAT, 0777);
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

extern "C" bool NvDsInferParseCustomYolox(
    std::vector<NvDsInferLayerInfo> const &outputLayersInfo,
    NvDsInferNetworkInfo const &networkInfo,
    NvDsInferParseDetectionParams const &detectionParams,
    std::vector<NvDsInferParseObjectInfo> &objectList)
{
    return NvDsInferParseYolox(
        outputLayersInfo, networkInfo, detectionParams, objectList);
}

/* Check that the custom function has been defined correctly */
CHECK_CUSTOM_PARSE_FUNC_PROTOTYPE(NvDsInferParseCustomYolox);
