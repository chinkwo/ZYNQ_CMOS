//vga模块  1024x768@60Hz  时钟65MHz
module	vga_module(
input	wire		vga_clk		,
input	wire		rst_n		,
output	wire		h_sync		,	
output	wire		v_sync		,
output	wire		pixel_start_flag	,
output	wire		pixel_de		,//有效区域
output	reg[7:0]	r		,
output	reg[7:0]	g		,
output	reg[7:0]	b		
);

reg[11:0]	h_cnt	;	
reg[11:0]	v_cnt	;	

parameter	
		H_ALL	=	2200,	//行总像素点
		H_SYNC	=	44,	//行同步时间	
		H_BP	=	148,	//行后肩时间
		H_LB	=	0,	//行左边框时间
		H_ACT	=	1920,	//行有效区域像素点
		H_RB	=	0,	//行右边框时间	
		H_FP	=	88,	//行前肩时间
		V_ALL	=	1125,	//场总行数点      
		V_SYNC	=	5,	//行同步时间	  	
		V_BP	=	36,	//行后肩时间      
		V_TB	=	0,	//行上边框时间    
		V_ACT	=	1080,	//场有效区域行数
		V_BB	=	0,	//场右边框时间	  
		V_FP	=	4;      //场前肩时间 

//产生行列同步
assign	h_sync	=	(h_cnt<=H_SYNC-1'b1)?1'b1:1'b0;
assign	v_sync	=	(v_cnt<=V_SYNC-1'b1)?1'b1:1'b0;

/********************************行扫描计数器*******************************/		
always@(posedge	vga_clk	or	negedge	rst_n)
	if(rst_n==1'b0)
		h_cnt	<=	10'd0;
	else if(h_cnt==H_ALL-1'b1)
		h_cnt	<=	10'd0;
	else
		h_cnt	<=	h_cnt+1'b1;


/*******列扫描计数器********/		
always@(posedge	vga_clk	or	negedge	rst_n)
	if(rst_n==1'b0)
		v_cnt	<=	10'd0;
	else if(h_cnt==(H_ALL-1'b1)&&v_cnt==(V_ALL-1'b1))
		v_cnt	<=	10'd0;
	else if(h_cnt==(H_ALL-1'b1))
		v_cnt	<=	v_cnt+1'b1;

/*********显示色彩**********/		
always@(posedge	vga_clk	or	negedge	rst_n)
	if(rst_n==1'b0)
		{r,g,b}	<=	24'd0;
	else if(pixel_de==1'b1)
		{r,g,b}	<=	{v_cnt[9:2],v_cnt[9:2],v_cnt[9:2]};
	else
		{r,g,b}	<=	24'd0;

assign	pixel_de = (h_cnt>=(H_SYNC+H_BP+H_LB)&&h_cnt<(H_SYNC+H_BP+H_LB+H_ACT)
		&&v_cnt>=(V_SYNC+V_BP+V_TB-1'b1)&&v_cnt<(V_SYNC+V_BP+V_TB+V_ACT-1'b1))?1'b1:1'b0;

//pixel_start_flag
assign	pixel_start_flag = (h_cnt==(H_SYNC+H_BP+H_LB+H_ACT)&&v_cnt==(V_SYNC+V_BP+V_TB+V_ACT))?1'b1:1'b0;

endmodule