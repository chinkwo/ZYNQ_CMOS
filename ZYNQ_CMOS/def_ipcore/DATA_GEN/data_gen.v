`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/19 16:17:50
// Design Name: 
// Module Name: rgb_data_gen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module data_gen(
	input    wire      pixel_clk    ,
	input    wire      rst_n      	,
	input    wire      pixel_de     ,
	
	output   reg[23:0] rgb_data    
    );   
           
//rgb_data
always@(posedge  pixel_clk  or  negedge  rst_n)
    if(rst_n==0)
       rgb_data	<=	24'h0;
   else  if(rgb_data==24'hffffff)
       rgb_data	<=	24'h0;
   else  if(pixel_de==1)
       rgb_data	<=	rgb_data+24'h010101; 
   else
   	   rgb_data	<=	24'h0;
    
    
    
endmodule
