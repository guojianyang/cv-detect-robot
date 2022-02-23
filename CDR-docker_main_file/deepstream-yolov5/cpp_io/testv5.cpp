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

int get_num(char* ss)
  {
    int cnt_index = 0, cnt_int = 0;
      //cnt_int 用于存放字符串中的数字.
      //cnt_index 作为字符串b的下标.
     for (int i = 0; ss[i] != '\0'; ++i) //当a数组元素不为结束符时.遍历字符串a.
     {
         if (ss[i] >= '0'&& ss[i] <= '9') //如果是数字.
         {
             cnt_int *= 10;//先乘以10保证先检测到的数字存在高位，后检测的存在低位
             cnt_int += ss[i] - '0'; //数字字符的ascii-字符'0'的ascii码就等于该数字.
         }
    //  cout << cnt_int << endl; //输出数字.(12345)
      }
     return cnt_int;
  }

int main()
{
 while(1)
 {
   int fd = open("/opt/nvidia/deepstream/deepstream-6.0/sources/deepstream_python_apps/apps/deepstream-yolov5/internal_memory.txt",O_RDONLY);
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
   int data_len;
   memcpy(data, addr, 5);   // 40*60+10(the largest number of objects is 40)
//    int data_len = (int(data[0])-48)*60 + 10;   
//    get_num(data)
   std::cout << "data:" << get_num(data) << std::endl;
   /*------------below two line will show Memory overflow question------------*/
//    char true_data[data_len] = {0};
//    char true_true_data[data_len-10] = {0};
//    memcpy(true_data, addr, data_len-1);
   //std::cout << true_data << std::endl;
   munmap(addr,3008);
 }
 return 0;
}
