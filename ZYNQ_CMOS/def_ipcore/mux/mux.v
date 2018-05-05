module  mux(
      input 	wire[2:0]	gpio_in	,
      output	wire 		o1	,
      output	wire		o2	,
      output	wire		o3	
);

assign	{o3,o2,o1}	=	gpio_in;
endmodule 