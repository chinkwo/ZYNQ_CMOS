# ZYNQ_CMOS  
## 基于ZYNQ的CMOS视频采集 
---  
## 开发环境  
Vivado、SDK、Zynq7000-xc7z020-lg400-1  
## 项目概况   
通过CMOS 1080p 500W像素摄像头采集图像，图像输出是裸数据RAW格式，转换为RGB格式，通过FPGA端的DMA通道将RGB图像数据搬移到ARM端的DDR3内存中，HDMI高清数字显示接口连接在FPGA端，并且通过AXI DMA通道将数据版一道FPGA显示端完成整个1080P摄像头采集和显示的闭环   
## 项目描述  
**PL部分：**  
- CMOS摄像头采集RAW格式Bayer图像数据传给PL端；
- PL端通过Bayer格式转换将RAW格式裸数据转为RGB格式；
- AXI_WR模块将转换过后的RGB格式图像数据通过AXI总线传输到DMA，由DMA直接存储到DDR3中；
- AXI_RD模块读取时，向DMA发出数据请求，通过AXI总线将图像数据传输给AXI_RD模块，再传输给HDMI模块，将结果在显示器上显示。   
  
**PS部分：**
- ZYNQ的PS端提供时钟和复位信号、对AXI读写模块进行初始化操作；
- 配置CMOS内部的寄存器，包括分辨率、帧率等；
- PS端通过EMIO输出控制CMOS摄像头的SPI驱动信号，通过PL端输出到管脚来驱动CMOS摄像头进行图像采集。
 
## 结构框图   
![结构图](https://github.com/chinkwo/ZYNQ_CMOS/blob/master/img-folder/%E7%BB%93%E6%9E%84%E5%9B%BE.png)  
## 效果描述 
实时处理1080P@60hz视频流，可以完成拜耳图像转RGB算法，使用AXI总线完成DMA的操作，AXI-DMA实现256突发长度64bit位宽的总线，达到AXI-DMA的最大效率。  
## 应用案例  
大疆战车和大疆无人机的视觉平台中已经应用ZYNQ作为视觉处理平台；在工业相机领域中广泛应用，例如流水线的产品瑕疵检测，包装印刷检测，人脸识别，辅助驾驶等领域。  
