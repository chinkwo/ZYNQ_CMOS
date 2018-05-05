module sync_em2sp(
input pclk,
input rst,
input [7:0] datain,
output reg [7:0] pdata,
output reg vsync,
output reg hsync,
output reg [11:0] colcnt,
output reg [11:0] rowcnt
);
reg valid_en,invalid_en;
reg [4:0] state1;
always @ (posedge pclk or posedge rst)
if(rst)
  begin
    valid_en<=1'b0;invalid_en<=1'b0;state1<=5'd0;
  end
else
  begin
    case(state1)
      5'd0://determine sav
        begin
          if(datain==8'hff) begin state1<=5'd1;end
          else begin state1<=5'd0;end
        end
      5'd1:
        begin
          if(datain==8'h00) begin state1<=5'd2;end          //for debug change 00 to ef
          else begin state1<=5'd0;end
        end
     5'd2:
        begin
          if(datain==8'h00) begin state1<=5'd3;end
          else begin state1<=5'd0;end
        end
      5'd3:
        begin
          if(datain==8'hab)//invaild line
            begin invalid_en<=1'b1;state1<=5'd4;end
          else if(datain==8'h80)//vaild line
            begin valid_en<=1'b1;state1<=5'd4;end
          else begin state1<=5'd0;end
        end
      5'd4://determine eav
        begin
          if(datain==8'hff) begin state1<=5'd5;end
          else begin state1<=5'd4;end
        end
      5'd5:
        begin
          if(datain==8'h00) begin state1<=5'd6;end      
          else if(datain==8'hff) begin state1<=5'd5;end
          else begin state1<=5'd4;end
        end
      5'd6:
        begin
           if(datain==8'h00) begin state1<=5'd7;end
            else if(datain==8'hff) begin state1<=5'd5;end
            else begin state1<=5'd4;end
        end
      5'd7:
        begin
          if(datain==8'hb6)//invaild line
            begin invalid_en<=1'b0;state1<=5'd0;end
          else if(datain==8'h9d)
            begin valid_en<=1'b0;state1<=5'd0;end
          else begin state1<=5'd4;end
        end
    endcase
  end
reg [4:0] state2;
reg [11:0] hcnt,vcnt;
reg dvalid;
always @ (posedge pclk or posedge rst)
if(rst)
  begin
    vsync<=1'b0;hcnt<=12'd0;vcnt<=12'd0;dvalid<=1'b0;state2<=5'd0;
  end
else
  begin
    case(state2)
      5'd0://determine invaild line
        begin
          if(invalid_en) begin state2<=5'd1;end
          else begin state2<=5'd0;end
        end
      5'd1://determine first vaild line and pull vsync to high
        begin
          if(valid_en) 
            begin state2<=5'd2;vsync<=1'b1;vcnt<=vcnt+1'b1;end
          else 
            begin state2<=5'd1;end
        end
      5'd2:
        begin
          if(!valid_en)
            begin state2<=5'd3;vsync<=1'b0;end
          else
            begin state2<=5'd2;end
        end
      5'd3://determine next 24 vaild line but no pixel
        begin
          if(valid_en) 
            begin vcnt<=vcnt+1'b1;state2<=5'd4;end
          else
            begin state2<=5'd3;end
        end
      5'd4:
        begin
          if(!valid_en)
            begin
              if(vcnt!=12'd25) begin state2<=5'd3;end
              else begin state2<=5'd5;end
            end
          else begin state2<=5'd4;end
        end
      5'd5://determine next 1080 valid line and 1920 pixel
        begin
          if(valid_en) 
            begin 
//              vcnt<=vcnt+1'b1;
              hcnt<=hcnt+1'b1;
              if(hcnt>=12'd47 && hcnt<12'd1967)
                begin dvalid<=1'b1;state2<=5'd5;end
              else if(hcnt==12'd1967)
                begin dvalid<=1'b0;state2<=5'd6; vcnt<=vcnt+1'b1; end   //modelfied
              else
                begin dvalid<=1'b0;state2<=5'd5;end
            end
          else begin state2<=5'd5;end
        end
      5'd6:
        begin
          if(!valid_en)
            begin
              hcnt<=12'd0;
              if(vcnt!=12'd1105) begin state2<=5'd5;end
              else begin vcnt<=12'd0;state2<=5'd0;end
            end
          else begin state2<=5'd6;end
        end
    endcase
  end

always @ (posedge pclk or posedge rst)
if(rst)
  begin
    pdata<=8'd0;hsync<=1'b0;colcnt<=12'd0;
  end
else if(dvalid)
  begin pdata<=datain;hsync<=1'b1;colcnt<=colcnt+1'b1;end
else
  begin pdata<=datain;hsync<=1'b0;colcnt<=12'd0;end

reg dvalid_r;
always @ (posedge pclk or posedge rst)
if(rst)
  begin
    rowcnt<=12'd0;dvalid_r<=1'b0;
  end
else 
  begin
    dvalid_r<=dvalid;
    if(dvalid && !dvalid_r)
      begin rowcnt<=rowcnt+1'b1;end
    if(vsync)
      begin rowcnt<=12'd0;end
  end
endmodule