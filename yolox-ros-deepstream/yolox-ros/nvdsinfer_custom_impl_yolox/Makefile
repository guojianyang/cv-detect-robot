#
# Copyright (c) 2020, NVIDIA CORPORATION. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#CUDA_VER?=
CUDA_VER=10.2
ifeq ($(CUDA_VER),)
  $(error "CUDA_VER is not set")
endif
CC:= g++
NVCC:=/usr/local/cuda-$(CUDA_VER)/bin/nvcc

CFLAGS:= -Wall -std=c++11 -shared -fPIC -Wno-error=deprecated-declarations
CFLAGS+= -I../../includes -I/usr/local/cuda-$(CUDA_VER)/include -I/usr/include/opencv4/ -I/usr/lib/gcc/x86_64-linux-gnu/7/include/ 
CFLAGS+= -I/opt/nvidia/deepstream/deepstream-5.1/sources/includes
CXXFLAGS:= -fopenmp

LIBS:= -lnvinfer_plugin -lnvinfer -lnvparsers -L/usr/local/cuda-$(CUDA_VER)/lib64 -lcudart -lcublas -lstdc++fs -L/usr/lib/aarch64-linux-gpu -lopencv_core
LFLAGS:= -shared -Wl,--start-group $(LIBS) -Wl,--end-group -fopenmp

INCS:= $(wildcard *.h)
SRCFILES:= nvdsparsebbox_yolox.cpp 

TARGET_LIB:= libnvdsinfer_custom_impl_yolox.so

TARGET_OBJS:= $(SRCFILES:.cpp=.o)
TARGET_OBJS:= $(TARGET_OBJS:.cu=.o)

all: $(TARGET_LIB)

%.o: %.cpp $(INCS) Makefile
	$(CC) -c -o $@ $(CFLAGS) $(CXXFLAGS) $<

%.o: %.cu $(INCS) Makefile
	$(NVCC) -c -o $@ --compiler-options '-fPIC' $<

$(TARGET_LIB) : $(TARGET_OBJS)
	$(CC) -o $@  $(TARGET_OBJS) $(LFLAGS)

clean:
	rm -rf $(TARGET_LIB)
	rm -rf $(TARGET_OBJS)
