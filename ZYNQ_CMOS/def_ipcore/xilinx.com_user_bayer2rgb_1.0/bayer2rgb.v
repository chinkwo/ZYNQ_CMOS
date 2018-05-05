module bayer2rgb(
input pixclk,
input config_done,
//input bayer_fv,
//input bayer_lv,
input [7:0] bayer_data,
output reg rgb_fv,
output reg rgb_lv,
output reg [7:0] data_r,data_g,data_b
);
wire [7:0]  bayer_data_o;
wire vsync_o,hsync_o;
sync_em2sp sync_em2sp(
.pclk(pixclk),
.rst(config_done),
.datain(bayer_data),
.pdata(bayer_data_o),
.vsync(vsync_o),
.hsync(hsync_o),
.colcnt(),
.rowcnt()
);

wire [11:0] pixcnt,pixbcnt,linecnt;
mode_det mode_det(
.pixclk		(pixclk		),
.rst		(config_done),
.bayer_lv	(hsync_o	),
.bayer_fv	(vsync_o	),
.pixcnt		(pixcnt		),
.linecnt	(linecnt	),
.pixbcnt	(pixbcnt	)
);
rst_initial rst_initial(
.mclk		(pixclk),
.rst		(config_done),
.pixcnt		(pixcnt),
.rst_int	(rst_int)
);

reg [11:0] addrwr_ram1bon1,addrwr_ram1bon2;
reg [10:0] addrrd_ram1bon;
always @ (posedge pixclk or negedge rst_int)
if(!rst_int)
	begin addrwr_ram1bon1<=12'd0;addrwr_ram1bon1<=12'd0;addrrd_ram1bon<=11'd0;end
else
	begin
		addrwr_ram1bon1<={pixcnt[10:0],1'b0}-2'd2;
		addrwr_ram1bon2<={pixcnt[10:0],1'b0}-2'd1;
		addrrd_ram1bon<=pixcnt[10:0]-1'b1;
	end
//write 2 line to ram1,line2 insert to line1,
//max coms line size is 2048
reg [12:0] addrwr_ram1;
reg [3:0] statec;
reg [1:0] ram1_state;
wire clkwr_ram1=pixclk;
wire [7:0] datawr_ram1=(hsync_o)?bayer_data_o:8'd0;
wire wren_ram1=hsync_o;
always @ (posedge pixclk or negedge rst_int)
if(!rst_int)
	begin
		addrwr_ram1<=13'd0;statec<=4'd0;ram1_state<=2'b00;
	end
else
	begin
		case(statec)
			4'b0000:
				begin
					if(vsync_o)begin statec<=4'b0001;end
					else begin statec<=4'b0000;end
				end
			4'b0001:
				begin
					if(!vsync_o)
						begin statec<=4'b0011;end
					else
						begin statec<=4'b0001;end
				end
			4'b0011:
				begin
					if(hsync_o)
						begin
							if(addrwr_ram1[11:0]==addrwr_ram1bon1)
								begin
									addrwr_ram1[11:0]<=12'd1;
								end
							else if(addrwr_ram1[11:0]==addrwr_ram1bon2)
								begin
									addrwr_ram1[11:0]<=12'd0;
									addrwr_ram1[12]<=~addrwr_ram1[12];
									if(ram1_state==2'b00) ram1_state<=2'b01;
									else begin ram1_state<=~ram1_state;end
								end
							else
								begin
									addrwr_ram1[11:0]<=addrwr_ram1[11:0]+2'd2;
								end
						end
					else
						begin
						end
				end
		endcase
	end
//read ram1 datard_ram1=GBRG
reg [11:0] addrrd_ram1;
reg rden_ram1;
wire clkrd_ram1=pixclk;
reg flag2;
reg [3:0] staterd;
reg [1:0] ram1_state_new;
reg [11:0] blank_cnt;
always @ (posedge pixclk or negedge rst_int)
if(!rst_int)
	begin
		addrrd_ram1<=12'd0;rden_ram1<=1'b0;flag2<=1'b0;staterd<=4'd0;ram1_state_new<=2'b01;blank_cnt<=12'd0;
	end
else
	begin
		case(staterd)
			4'd0:
				begin ram1_state_new<=2'b01;staterd<=4'd1;end
			4'd1:
				begin
					if(ram1_state_new==ram1_state)
						begin
							staterd<=4'd2;
							addrrd_ram1[10:0]<=11'd0;
							rden_ram1<=1'b1;
						end
					else
						begin end
				end
			4'd2:
				begin
					if(addrrd_ram1[10:0]!=addrrd_ram1bon)
						begin
							staterd<=4'd2;
							rden_ram1<=1'b1;
							addrrd_ram1[10:0]<=addrrd_ram1[10:0]+1'b1;
						end
					else
						begin
							staterd<=4'd1;
							addrrd_ram1[10:0]<=11'd0;
							rden_ram1<=1'b0;
							if(flag2)
								begin 
									addrrd_ram1[11]<=~addrrd_ram1[11];
									staterd<=4'd1;
									flag2<=1'b0;
									ram1_state_new<=~ram1_state_new;
								end
							else
								begin
									addrrd_ram1[11]<= addrrd_ram1[11];
									staterd<=4'd3;
									flag2<=1'b1;
								end
						end
				end
			4'd3:
				begin
					if(blank_cnt!=pixbcnt)
						begin
							blank_cnt<=blank_cnt+1'b1;staterd<=4'd3;
						end
					else
						begin
							blank_cnt<=12'd0;staterd<=4'd1;
						end
				end
		endcase
	end
wire [31:0] datard_ram1;
reg rden_ram1_reg;
always @ (posedge pixclk or negedge rst_int)
if(!rst_int)
	begin
		data_r<=8'd0;data_g<=8'd0;data_b<=8'd0;rden_ram1_reg<=1'b0;
	end
else
	begin
		rden_ram1_reg<=rden_ram1;
		if(rden_ram1_reg)
			begin
				data_b<=datard_ram1[31:24];
				data_g<=datard_ram1[15:8];
				data_r<=datard_ram1[7:0];
			end
		else
			begin
				data_r<=8'd0;data_g<=8'd0;data_b<=8'd0;
			end
	end
always @ (posedge pixclk or negedge rst_int)
if(!rst_int)
	begin
		rgb_lv<=1'b0;
	end
else
	begin
		rgb_lv<=rden_ram1_reg;
	end
reg [11:0] fvdly_cnt;
reg [3:0] statefv;
reg vsync_o_r;
always @ (posedge pixclk or negedge rst_int)
if(!rst_int)
	begin
		fvdly_cnt<=12'd0;statefv<=4'd0;vsync_o_r<=1'b0;rgb_fv<=1'b0;
	end
else
	begin
		vsync_o_r<=vsync_o;
		case(statefv)
			4'd0:
				begin
					rgb_fv<=1'b0;
					if(vsync_o && !vsync_o_r)
						begin statefv<=4'd1;end
					else
						begin end
				end
			4'd1:
				begin
					rgb_fv<=1'b0;
					if(fvdly_cnt!=pixcnt) 
						begin fvdly_cnt<=fvdly_cnt+1'b1;statefv<=4'd1;end
					else
						begin fvdly_cnt<=12'd0;statefv<=4'd2;end
				end
			4'd2:
				begin
					rgb_fv<=1'b0;
					if(fvdly_cnt!=pixbcnt) 
						begin fvdly_cnt<=fvdly_cnt+1'b1;statefv<=4'd2;end
					else
						begin fvdly_cnt<=12'd0;statefv<=4'd3;end
				end
			4'd3:
				begin
					rgb_fv<=1'b0;
					if(fvdly_cnt!=pixcnt) 
						begin fvdly_cnt<=fvdly_cnt+1'b1;statefv<=4'd3;end
					else
						begin fvdly_cnt<=12'd0;statefv<=4'd4;end
				end
			4'd4:
				begin
					rgb_fv<=1'b0;
					if(fvdly_cnt!=pixbcnt) 
						begin fvdly_cnt<=fvdly_cnt+1'b1;statefv<=4'd4;end
					else
						begin fvdly_cnt<=12'd0;statefv<=4'd5;end
				end
			4'd5:
				begin
					if(fvdly_cnt!=pixbcnt)
						begin fvdly_cnt<=fvdly_cnt+1'b1;statefv<=4'd5;rgb_fv<=1'b1;end
					else
						begin fvdly_cnt<=12'd0;statefv<=4'd0;rgb_fv<=1'b0;end
				end
		endcase
	end
ram_2x4096x8_2x1024x32 ram1 (
										.clka		(clkwr_ram1	),
										.wea		(wren_ram1	),
										.addra	(addrwr_ram1),
										.dina		(datawr_ram1),
										.clkb		(clkrd_ram1	),
										.enb		(rden_ram1	),
										.addrb	(addrrd_ram1[11:1]),
										.doutb	(datard_ram1)
										);

endmodule