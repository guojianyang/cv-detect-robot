#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <string.h>
#include <iostream>
#include <typeinfo>
#include <string>
#include <sstream>
#include <stdlib.h>
#include <cmath>
#include <iomanip>
#include<cstring>

//char true_data[500];

int main()
{
 while(1)
 {
   int fd = open("/opt/nvidia/deepstream/deepstream-5.1/sources/yolox-io-cpp/nvdsinfer_custom_impl_yolox/internal_memory.txt",O_RDONLY);
   char *addr = (char *)mmap(NULL, 3008, PROT_READ,MAP_SHARED, fd, 0);
   if (addr == MAP_FAILED)
   {
     perror("mmap err");
     return -1;
   }
   //char* addr = (char*)mmap(NULL, boundingboxes_len, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
   close(fd);
   char data[10] = {0};
   std::string str_data;
   memcpy(data, addr, 1);   // 40*60+10(the largest number of objects is 40)
   int data_len = (int(data[0])-48)*60 + 10;   
   //std::cout << "data_len:" << data_len << std::endl;
   /*------------below two line will show Memory overflow question------------*/
   char true_data[data_len] = {0};
   char true_true_data[data_len-10] = {0};
   memcpy(true_data, addr, data_len-1);
   std::cout << true_data << std::endl;
   munmap(addr,3008);
 }
 return 0;
}
