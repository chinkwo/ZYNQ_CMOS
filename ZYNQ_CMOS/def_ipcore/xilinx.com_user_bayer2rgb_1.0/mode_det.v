module mode_det(
input pixclk,
input rst,
input bayer_lv,
input bayer_fv,
output reg [11:0] pixcnt,
output reg [11:0] linecnt,
output reg [11:0] pixbcnt
);
//mode
reg bayer_lv1;
always @ (posedge pixclk or posedge rst)
if(rst)
	begin bayer_lv1<=1'b0;end
else
	begin bayer_lv1<=bayer_lv;end

reg [11:0] pcnt;
always @ (posedge pixclk or posedge rst)
if(rst)
	begin
		pixcnt<=12'd0;
		pcnt<=12'd0;
	end
else
	begin
		if(bayer_lv)
			begin pcnt<=pcnt+1'b1;end
		else
			begin
				pcnt<=12'd0;
				if(bayer_lv1)
					begin
						pixcnt<=pcnt;
					end
				else begin end
			end
	end
reg [11:0] bcnt;
reg [3:0] stateb;
always @ (posedge pixclk or posedge rst)
if(rst)
	begin
		pixbcnt<=12'd0;
		bcnt<=12'd0;
		stateb<=4'd0;
	end
else
	begin
		if(!bayer_fv)
			begin
				case(stateb)
					4'd0:
						begin
							if(bayer_lv1&& !bayer_lv)
								begin
									bcnt<=bcnt+1'b1;stateb<=4'd1;
								end
							else
								begin end
						end
					4'd1:
						begin
							if(!bayer_lv1 && bayer_lv)
								begin
									pixbcnt<=bcnt;bcnt<=12'd0;stateb<=4'd0;
								end
							else
								begin bcnt<=bcnt+1'b1;stateb<=4'd1;end
						end
				endcase
			end
		else
			begin bcnt<=12'd0;stateb<=4'd0;end
	end
always @ (posedge pixclk or posedge rst)
if(rst)
	begin linecnt<=12'd0;end
else
	begin
		if(!bayer_fv)
			begin
				if(!bayer_lv&&bayer_lv1)
					linecnt<=linecnt+1'b1;
			end
		else
			linecnt<=12'd0;
	end
endmodule