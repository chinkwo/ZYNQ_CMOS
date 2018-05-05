module rst_initial(
input mclk,
input rst,
input [11:0] pixcnt,
output reg rst_int
);
reg [9:0] rstint_cnt;
reg [11:0] pixcnt_reg;
reg [3:0] state_int;
always @ (posedge mclk or posedge rst)
if(rst)
	begin
		pixcnt_reg<=12'd0;
		rstint_cnt<=10'd0;
		rst_int<=1'b0;
		state_int<=4'd0;
	end
else
	begin
		pixcnt_reg<=pixcnt;
		case(state_int)
			4'd0:
				begin
					if(pixcnt_reg!=pixcnt)
						begin
							if(pixcnt!=12'd0) state_int<=4'd1;
							else rst_int<=1'b0;
						end
					else
						begin
						end
				end
			4'd1:
				begin
					if(rstint_cnt!=10'd100)
						begin
							rstint_cnt<=rstint_cnt+1'b1;
							rst_int<=1'b0;
						end
					else
						begin
							rst_int<=1'b1;
							state_int<=4'd0;
						end
				end
		endcase
	end	
endmodule