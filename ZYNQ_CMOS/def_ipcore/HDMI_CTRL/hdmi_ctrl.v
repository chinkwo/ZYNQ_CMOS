module  hdmi_ctrl(
	input    wire     	pixel_clk		 ,
	input    wire       	clkx1    	,
	input    wire       	clkx5    	,//to par2ser
	input    wire     	rst_n      		 , 
	input    wire[23:0] rgb_data      	 ,//from rgb_data_gen to vga_module rgb_data
	                                	    
	output   wire		pixel_start_flag,                                	    
	output	 wire       pixel_de    	 ,//to  rgb_data_gen                              	
	output   wire		r_ser_dat_p 	 ,
	output   wire		r_ser_dat_n 	 ,
	output   wire		g_ser_dat_p 	 ,
    output   wire		g_ser_dat_n 	 ,
    output   wire		b_ser_dat_p 	 ,
    output   wire		b_ser_dat_n 	 ,
                                         
    output   wire		clk_ser_dat_p 	 ,
    output   wire		clk_ser_dat_n 	 ,
    
    output   wire       hdmi_en        
    
);

wire       	h_sync    	;//to b_encode_inst c0
wire       	v_sync    	;//to b_encode_inst c1
wire[7:0]	r			;
wire[7:0]	g			;   
wire[7:0]	b			;
wire[9:0]	r_10bit		;//r_encode_inst -> r_par2ser_inst
wire[9:0]	g_10bit		;//g_encode_inst -> g_par2ser_inst
wire[9:0]	b_10bit		;//b_encode_inst -> b_par2ser_inst

assign		hdmi_en	=	1'b1;


//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
//clk_pixel clk_pixel_inst(
//  // Clock out ports
//  .clkx1(clkx1),     // output clkx1
//  .clkx5(clkx5),     // output clkx5
// // Clock in ports
//  .clk_in1(pixel_clk)
//  );      // input clk_in1
// INST_TAG_END ------ End INSTANTIATION Template ---------

vga_module	vga_module_inst(
.sclk				(pixel_clk			),//input	wire		sclk	,
.rst_n				(rst_n	 			),//input	wire		rst_n	,
.vga_clk			(clkx1	 			),//input	wire		vga_clk	,
.rgb_data			(rgb_data			),//input   wire       rgb_data,
.h_sync				(h_sync	 			),//output	reg			h_sync	,
.v_sync				(v_sync	 			),//output	reg			v_sync	,
.pixel_de			(pixel_de			),//output  wire       pixel_de,
.pixel_start_flag	(pixel_start_flag	),//output  wire		pixel_start_flag,
.r					(r		 			),//output	reg[7:0]	r		,
.g					(g		 			),//output	reg[7:0]	g		,
.b      			(b       			) //output	reg[7:0]	b
);

encode 	r_encode_inst(
.clkin	(clkx1		),// pixel clock input
.rstin	(~rst_n		),// async. reset input (active high)
.din	(r			),// data inputs: expect registered
.c0		(0			),// c0 input
.c1		(0			),// c1 input
.de		(pixel_de	),// de input
.dout   (r_10bit	) // data outputs
);

encode 	g_encode_inst(
.clkin	(clkx1		),// pixel clock input
.rstin	(~rst_n		),// async. reset input (active high)
.din	(g			),// data inputs: expect registered
.c0		(0			),// c0 input
.c1		(0			),// c1 input
.de		(pixel_de	),// de input
.dout   (g_10bit	) // data outputs
);

encode 	b_encode_inst(
.clkin	(clkx1	),// pixel clock input
.rstin	(~rst_n	),// async. reset input (active high)
.din	(b		),// data inputs: expect registered
.c0		(h_sync ),// c0 input
.c1		(v_sync	),// c1 input
.de		(pixel_de),// de input
.dout   (b_10bit) // data outputs
);

par2ser	r_par2ser_inst(
.clkx1    	(clkx1    ),//input    wire      	clkx1      ,
.clkx5    	(clkx5    ),//input    wire      	clkx5      ,
.rst_n    	(rst_n    ),//input    wire      	rst_n      ,
.dat_10bit	(r_10bit  ),//input    wire[9:0]    	dat_10bit  , 
                                
.ser_dat_p	(r_ser_dat_p),//output   wire         	ser_dat_p  , 
.ser_dat_n	(r_ser_dat_n) //output   wire         	ser_dat_n  , 
);

par2ser	g_par2ser_inst(
.clkx1    	(clkx1    ),//input    wire      	clkx1      ,
.clkx5    	(clkx5    ),//input    wire      	clkx5      ,
.rst_n    	(rst_n    ),//input    wire      	rst_n      ,
.dat_10bit	(g_10bit  ),//input    wire[9:0]    	dat_10bit  , 
                                
.ser_dat_p	(g_ser_dat_p),//output   wire         	ser_dat_p  , 
.ser_dat_n	(g_ser_dat_n) //output   wire         	ser_dat_n  , 
);

par2ser	b_par2ser_inst(
.clkx1    	(clkx1    ),//input    wire      	clkx1      ,
.clkx5    	(clkx5    ),//input    wire      	clkx5      ,
.rst_n    	(rst_n    ),//input    wire      	rst_n      ,
.dat_10bit	(b_10bit  ),//input    wire[9:0]    	dat_10bit  , 
                                
.ser_dat_p	(b_ser_dat_p),//output   wire         	ser_dat_p  , 
.ser_dat_n	(b_ser_dat_n) //output   wire         	ser_dat_n  , 
);

par2ser	clk_par2ser_inst(
.clkx1    	(clkx1    		),//input    wire      	clkx1      ,
.clkx5    	(clkx5    		),//input    wire      	clkx5      ,
.rst_n    	(rst_n    		),//input    wire      	rst_n      ,
.dat_10bit	(10'b11111_00000),//input    wire[9:0]    	dat_10bit  , 
                                
.ser_dat_p	(clk_ser_dat_p	),//output   wire         	ser_dat_p  , 
.ser_dat_n	(clk_ser_dat_n	) //output   wire         	ser_dat_n  , 
);
endmodule