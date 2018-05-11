# ZYNQ_CMOS  
---
## 项目描述  
通过CMOS 1080p 500W像素摄像头采集图像，图像输出是裸数据RAW格式，转换为RGB格式，通过FPGA端的DMA通道将RGB图像数据搬移到ARM端的DDR3内存中，HDMI高清数字显示接口连接在FPGA端，并且通过AXI DMA通道将数据版一道FPGA显示端完成整个1080P摄像头采集和显示的闭环  
## 结构框图   
![结构框图](https://github.com/chinkwo/ZYNQ_CMOS/blob/master/img-folder/%E7%BB%93%E6%9E%84%E6%A1%86%E5%9B%BE.png)
## 效果描述  
实时处理1080P@60hz视频流，可以完成拜耳图像转RGB算法，使用AXI总线完成DMA的操作，AXI-DMA实现256突发长度64bit位宽的总线，达到AXI-DMA的最大效率。  
## 应用案例  
大疆战车和大疆无人机的视觉平台中已经应用ZYNQ作为视觉处理平台；在工业相机领域中广泛应用，例如流水线的产品瑕疵检测，包装印刷检测，人脸识别，辅助驾驶等领域。  
