//vgaģ��  1024x768@60Hz  ʱ��65MHz
module	vga_module(
input	wire		vga_clk		,
input	wire		rst_n		,
output	wire		h_sync		,	
output	wire		v_sync		,
output	wire		pixel_start_flag	,
output	wire		pixel_de		,//��Ч����
output	reg[7:0]	r		,
output	reg[7:0]	g		,
output	reg[7:0]	b		
);

reg[11:0]	h_cnt	;	
reg[11:0]	v_cnt	;	

parameter	
		H_ALL	=	2200,	//�������ص�
		H_SYNC	=	44,	//��ͬ��ʱ��	
		H_BP	=	148,	//�к��ʱ��
		H_LB	=	0,	//����߿�ʱ��
		H_ACT	=	1920,	//����Ч�������ص�
		H_RB	=	0,	//���ұ߿�ʱ��	
		H_FP	=	88,	//��ǰ��ʱ��
		V_ALL	=	1125,	//����������      
		V_SYNC	=	5,	//��ͬ��ʱ��	  	
		V_BP	=	36,	//�к��ʱ��      
		V_TB	=	0,	//���ϱ߿�ʱ��    
		V_ACT	=	1080,	//����Ч��������
		V_BB	=	0,	//���ұ߿�ʱ��	  
		V_FP	=	4;      //��ǰ��ʱ�� 

//��������ͬ��
assign	h_sync	=	(h_cnt<=H_SYNC-1'b1)?1'b1:1'b0;
assign	v_sync	=	(v_cnt<=V_SYNC-1'b1)?1'b1:1'b0;

/********************************��ɨ�������*******************************/		
always@(posedge	vga_clk	or	negedge	rst_n)
	if(rst_n==1'b0)
		h_cnt	<=	10'd0;
	else if(h_cnt==H_ALL-1'b1)
		h_cnt	<=	10'd0;
	else
		h_cnt	<=	h_cnt+1'b1;


/*******��ɨ�������********/		
always@(posedge	vga_clk	or	negedge	rst_n)
	if(rst_n==1'b0)
		v_cnt	<=	10'd0;
	else if(h_cnt==(H_ALL-1'b1)&&v_cnt==(V_ALL-1'b1))
		v_cnt	<=	10'd0;
	else if(h_cnt==(H_ALL-1'b1))
		v_cnt	<=	v_cnt+1'b1;

/*********��ʾɫ��**********/		
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