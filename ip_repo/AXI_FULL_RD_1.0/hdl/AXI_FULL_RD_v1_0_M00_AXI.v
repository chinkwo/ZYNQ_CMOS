
`timescale 1 ns / 1 ps

	module AXI_FULL_RD_v1_0_M00_AXI #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line

		// Base address of targeted slave
		parameter  C_M_TARGET_SLAVE_BASE_ADDR	= 32'h01000000,
		// Burst Length. Supports 1, 2, 4, 8, 16, 32, 64, 128, 256 burst lengths
		parameter integer C_M_AXI_BURST_LEN	= 256,
		// Thread ID Width
		parameter integer C_M_AXI_ID_WIDTH	= 1,
		// Width of Address Bus
		parameter integer C_M_AXI_ADDR_WIDTH	= 32,
		// Width of Data Bus
		parameter integer C_M_AXI_DATA_WIDTH	= 64,
		// Width of User Write Address Bus
		parameter integer C_M_AXI_AWUSER_WIDTH	= 0,
		// Width of User Read Address Bus
		parameter integer C_M_AXI_ARUSER_WIDTH	= 0,
		// Width of User Write Data Bus
		parameter integer C_M_AXI_WUSER_WIDTH	= 0,
		// Width of User Read Data Bus
		parameter integer C_M_AXI_RUSER_WIDTH	= 0,
		// Width of User Response Bus
		parameter integer C_M_AXI_BUSER_WIDTH	= 0
	)
	(
		// Users to add ports here
		input	wire	vga_clk,
		input	wire	vga_de,
		input	wire	vga_start,
		output	wire[31:0]	vga_rgb,
		// User ports ends
		// Do not modify the ports beyond this line

		// Initiate AXI transactions
		input wire  INIT_AXI_TXN,
		// Asserts when transaction is complete
		output wire  TXN_DONE,
		// Asserts when ERROR is detected
		output reg  ERROR,
		// Global Clock Signal.
		input wire  M_AXI_ACLK,
		// Global Reset Singal. This Signal is Active Low
		input wire  M_AXI_ARESETN,
		// Master Interface Write Address ID
		output wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_AWID,
		// Master Interface Write Address
		output wire [C_M_AXI_ADDR_WIDTH-1 : 0] M_AXI_AWADDR,
		// Burst length. The burst length gives the exact number of transfers in a burst
		output wire [7 : 0] M_AXI_AWLEN,
		// Burst size. This signal indicates the size of each transfer in the burst
		output wire [2 : 0] M_AXI_AWSIZE,
		// Burst type. The burst type and the size information, 
    // determine how the address for each transfer within the burst is calculated.
		output wire [1 : 0] M_AXI_AWBURST,
		// Lock type. Provides additional information about the
    // atomic characteristics of the transfer.
		output wire  M_AXI_AWLOCK,
		// Memory type. This signal indicates how transactions
    // are required to progress through a system.
		output wire [3 : 0] M_AXI_AWCACHE,
		// Protection type. This signal indicates the privilege
    // and security level of the transaction, and whether
    // the transaction is a data access or an instruction access.
		output wire [2 : 0] M_AXI_AWPROT,
		// Quality of Service, QoS identifier sent for each write transaction.
		output wire [3 : 0] M_AXI_AWQOS,
		// Optional User-defined signal in the write address channel.
		output wire [C_M_AXI_AWUSER_WIDTH-1 : 0] M_AXI_AWUSER,
		// Write address valid. This signal indicates that
    // the channel is signaling valid write address and control information.
		output wire  M_AXI_AWVALID,
		// Write address ready. This signal indicates that
    // the slave is ready to accept an address and associated control signals
		input wire  M_AXI_AWREADY,
		// Master Interface Write Data.
		output wire [C_M_AXI_DATA_WIDTH-1 : 0] M_AXI_WDATA,
		// Write strobes. This signal indicates which byte
    // lanes hold valid data. There is one write strobe
    // bit for each eight bits of the write data bus.
		output wire [C_M_AXI_DATA_WIDTH/8-1 : 0] M_AXI_WSTRB,
		// Write last. This signal indicates the last transfer in a write burst.
		output wire  M_AXI_WLAST,
		// Optional User-defined signal in the write data channel.
		output wire [C_M_AXI_WUSER_WIDTH-1 : 0] M_AXI_WUSER,
		// Write valid. This signal indicates that valid write
    // data and strobes are available
		output wire  M_AXI_WVALID,
		// Write ready. This signal indicates that the slave
    // can accept the write data.
		input wire  M_AXI_WREADY,
		// Master Interface Write Response.
		input wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_BID,
		// Write response. This signal indicates the status of the write transaction.
		input wire [1 : 0] M_AXI_BRESP,
		// Optional User-defined signal in the write response channel
		input wire [C_M_AXI_BUSER_WIDTH-1 : 0] M_AXI_BUSER,
		// Write response valid. This signal indicates that the
    // channel is signaling a valid write response.
		input wire  M_AXI_BVALID,
		// Response ready. This signal indicates that the master
    // can accept a write response.
		output wire  M_AXI_BREADY,
		// Master Interface Read Address.
		output wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_ARID,
		// Read address. This signal indicates the initial
    // address of a read burst transaction.
		output wire [C_M_AXI_ADDR_WIDTH-1 : 0] M_AXI_ARADDR,
		// Burst length. The burst length gives the exact number of transfers in a burst
		output wire [7 : 0] M_AXI_ARLEN,
		// Burst size. This signal indicates the size of each transfer in the burst
		output wire [2 : 0] M_AXI_ARSIZE,
		// Burst type. The burst type and the size information, 
    // determine how the address for each transfer within the burst is calculated.
		output wire [1 : 0] M_AXI_ARBURST,
		// Lock type. Provides additional information about the
    // atomic characteristics of the transfer.
		output wire  M_AXI_ARLOCK,
		// Memory type. This signal indicates how transactions
    // are required to progress through a system.
		output wire [3 : 0] M_AXI_ARCACHE,
		// Protection type. This signal indicates the privilege
    // and security level of the transaction, and whether
    // the transaction is a data access or an instruction access.
		output wire [2 : 0] M_AXI_ARPROT,
		// Quality of Service, QoS identifier sent for each read transaction
		output wire [3 : 0] M_AXI_ARQOS,
		// Optional User-defined signal in the read address channel.
		output wire [C_M_AXI_ARUSER_WIDTH-1 : 0] M_AXI_ARUSER,
		// Write address valid. This signal indicates that
    // the channel is signaling valid read address and control information
		output wire  M_AXI_ARVALID,
		// Read address ready. This signal indicates that
    // the slave is ready to accept an address and associated control signals
		input wire  M_AXI_ARREADY,
		// Read ID tag. This signal is the identification tag
    // for the read data group of signals generated by the slave.
		input wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_RID,
		// Master Read Data
		input wire [C_M_AXI_DATA_WIDTH-1 : 0] M_AXI_RDATA,
		// Read response. This signal indicates the status of the read transfer
		input wire [1 : 0] M_AXI_RRESP,
		// Read last. This signal indicates the last transfer in a read burst
		input wire  M_AXI_RLAST,
		// Optional User-defined signal in the read address channel.
		input wire [C_M_AXI_RUSER_WIDTH-1 : 0] M_AXI_RUSER,
		// Read valid. This signal indicates that the channel
    // is signaling the required read data.
		input wire  M_AXI_RVALID,
		// Read ready. This signal indicates that the master can
    // accept the read data and response information.
		output wire  M_AXI_RREADY
	);


	// function called clogb2 that returns an integer which has the
	//value of the ceiling of the log base 2

	  // function called clogb2 that returns an integer which has the 
	  // value of the ceiling of the log base 2.                      
	  function integer clogb2 (input integer bit_depth);              
	  begin                                                           
	    for(clogb2=0; bit_depth>0; clogb2=clogb2+1)                   
	      bit_depth = bit_depth >> 1;                                 
	    end                                                           
	  endfunction                                                     

	// C_TRANSACTIONS_NUM is the width of the index counter for 
	// number of write or read transaction.
	 localparam integer C_TRANSACTIONS_NUM = clogb2(C_M_AXI_BURST_LEN-1);

	// Burst length for transactions, in C_M_AXI_DATA_WIDTHs.
	// Non-2^n lengths will eventually cause bursts across 4K address boundaries.
	 localparam integer C_MASTER_LENGTH	= 12;
	// total number of burst transfers is master length divided by burst length and burst size
	 localparam integer C_NO_BURSTS_REQ = C_MASTER_LENGTH-clogb2((C_M_AXI_BURST_LEN*C_M_AXI_DATA_WIDTH/8)-1);
	// Example State machine to initialize counter, initialize write transactions, 
	// initialize read transactions and comparison of read data with the 
	// written data words.
	parameter [1:0] IDLE = 2'b00, // This state initiates AXI4Lite transaction 
			// after the state machine changes state to INIT_WRITE 
			// when there is 0 to 1 transition on INIT_AXI_TXN
		INIT_WRITE   = 2'b01, // This state initializes write transaction,
			// once writes are done, the state machine 
			// changes state to INIT_READ 
		INIT_READ = 2'b10, // This state initializes read transaction
			// once reads are done, the state machine 
			// changes state to INIT_COMPARE 
		INIT_COMPARE = 2'b11; // This state issues the status of comparison 
			// of the written data with the read data	

	 reg [1:0] mst_exec_state;

	// AXI4LITE signals
	//AXI4 internal temp signals
	reg [C_M_AXI_ADDR_WIDTH-1 : 0] 	axi_awaddr;
	reg  	axi_awvalid;
	reg [C_M_AXI_DATA_WIDTH-1 : 0] 	axi_wdata;
	reg  	axi_wlast;
	reg  	axi_wvalid;
	reg  	axi_bready;
	reg [C_M_AXI_ADDR_WIDTH-1 : 0] 	axi_araddr;
	reg  	axi_arvalid;
	reg  	axi_rready;
	//write beat count in a burst
	reg [C_TRANSACTIONS_NUM : 0] 	write_index;
	//read beat count in a burst
	reg [C_TRANSACTIONS_NUM : 0] 	read_index;
	//size of C_M_AXI_BURST_LEN length burst in bytes
	wire [C_TRANSACTIONS_NUM+2 : 0] 	burst_size_bytes;
	//The burst counters are used to track the number of burst transfers of C_M_AXI_BURST_LEN burst length needed to transfer 2^C_MASTER_LENGTH bytes of data.
	reg [C_NO_BURSTS_REQ : 0] 	write_burst_counter;
	reg [C_NO_BURSTS_REQ : 0] 	read_burst_counter;
	reg  	start_single_burst_write;
	reg  	start_single_burst_read;
	reg  	writes_done;
	reg  	reads_done;
	reg  	error_reg;
	reg  	compare_done;
	reg  	read_mismatch;
	reg  	burst_write_active;
	reg  	burst_read_active;
	reg [C_M_AXI_DATA_WIDTH-1 : 0] 	expected_rdata;
	//Interface response error flags
	wire  	write_resp_error;
	wire  	read_resp_error;
	wire  	wnext;
	wire  	rnext;
	reg  	init_txn_ff;
	reg  	init_txn_ff2;
	reg  	init_txn_edge;
	wire  	init_txn_pulse;


	// I/O Connections assignments

	//I/O Connections. Write Address (AW)
	assign M_AXI_AWID	= 'b0;
	//The AXI address is a concatenation of the target base address + active offset range
	assign M_AXI_AWADDR	= C_M_TARGET_SLAVE_BASE_ADDR + axi_awaddr;
	//Burst LENgth is number of transaction beats, minus 1
	assign M_AXI_AWLEN	= C_M_AXI_BURST_LEN - 1;
	//Size should be C_M_AXI_DATA_WIDTH, in 2^SIZE bytes, otherwise narrow bursts are used
	assign M_AXI_AWSIZE	= clogb2((C_M_AXI_DATA_WIDTH/8)-1);
	//INCR burst type is usually used, except for keyhole bursts
	assign M_AXI_AWBURST	= 2'b01;
	assign M_AXI_AWLOCK	= 1'b0;
	//Update value to 4'b0011 if coherent accesses to be used via the Zynq ACP port. Not Allocated, Modifiable, not Bufferable. Not Bufferable since this example is meant to test memory, not intermediate cache. 
	assign M_AXI_AWCACHE	= 4'b0010;
	assign M_AXI_AWPROT	= 3'h0;
	assign M_AXI_AWQOS	= 4'h0;
	assign M_AXI_AWUSER	= 'b1;
	assign M_AXI_AWVALID	= axi_awvalid;
	//Write Data(W)
	assign M_AXI_WDATA	= axi_wdata;
	//All bursts are complete and aligned in this example
	assign M_AXI_WSTRB	= {(C_M_AXI_DATA_WIDTH/8){1'b1}};
	assign M_AXI_WLAST	= axi_wlast;
	assign M_AXI_WUSER	= 'b0;
	assign M_AXI_WVALID	= axi_wvalid;
	//Write Response (B)
	assign M_AXI_BREADY	= axi_bready;
	//Read Address (AR)
	assign M_AXI_ARID	= 'b0;
	assign M_AXI_ARADDR	= C_M_TARGET_SLAVE_BASE_ADDR + axi_araddr;
	//Burst LENgth is number of transaction beats, minus 1
	assign M_AXI_ARLEN	= C_M_AXI_BURST_LEN - 1;
	//Size should be C_M_AXI_DATA_WIDTH, in 2^n bytes, otherwise narrow bursts are used
	assign M_AXI_ARSIZE	= clogb2((C_M_AXI_DATA_WIDTH/8)-1);
	//INCR burst type is usually used, except for keyhole bursts
	assign M_AXI_ARBURST	= 2'b01;
	assign M_AXI_ARLOCK	= 1'b0;
	//Update value to 4'b0011 if coherent accesses to be used via the Zynq ACP port. Not Allocated, Modifiable, not Bufferable. Not Bufferable since this example is meant to test memory, not intermediate cache. 
	assign M_AXI_ARCACHE	= 4'b0010;
	assign M_AXI_ARPROT	= 3'h0;
	assign M_AXI_ARQOS	= 4'h0;
	assign M_AXI_ARUSER	= 'b1;
	assign M_AXI_ARVALID	= axi_arvalid;
	//Read and Read Response (R)
	assign M_AXI_RREADY	= axi_rready;
	//Example design I/O
	assign TXN_DONE	= compare_done;
	//Burst size in bytes
	assign burst_size_bytes	= C_M_AXI_BURST_LEN * C_M_AXI_DATA_WIDTH/8;
	assign init_txn_pulse	= (!init_txn_ff2) && init_txn_ff;


	//Generate a pulse to initiate AXI transaction.
	always @(posedge M_AXI_ACLK)										      
	  begin                                                                        
	    // Initiates AXI transaction delay    
	    if (M_AXI_ARESETN == 0 )                                                   
	      begin                                                                    
	        init_txn_ff <= 1'b0;                                                   
	        init_txn_ff2 <= 1'b0;                                                   
	      end                                                                               
	    else                                                                       
	      begin  
	        init_txn_ff <= INIT_AXI_TXN;
	        init_txn_ff2 <= init_txn_ff;                                                                 
	      end                                                                      
	  end     


	//--------------------
	//Write Address Channel
	//--------------------

	// The purpose of the write address channel is to request the address and 
	// command information for the entire transaction.  It is a single beat
	// of information.

	// The AXI4 Write address channel in this example will continue to initiate
	// write commands as fast as it is allowed by the slave/interconnect.
	// The address will be incremented on each accepted address transaction,
	// by burst_size_byte to point to the next address. 

	  always @(posedge M_AXI_ACLK)                                   
	                                                                
	    if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1 )                                           
	      begin                                                            
	        axi_awvalid <= 1'b0;                                           
	      end                                                              
	                                        
                                                                      
	// Next address after AWREADY indicates previous address acceptance    
	  always @(posedge M_AXI_ACLK)                                         
                                                               
	    if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1)                                            
	      begin                                                            
	        axi_awaddr <= 'b0;                                             
	      end                                                              
	   
	//--------------------
	//Write Data Channel
	//--------------------

	//The write data will continually try to push write data across the interface.

	//The amount of data accepted will depend on the AXI slave and the AXI
	//Interconnect settings, such as if there are FIFOs enabled in interconnect.

	//Note that there is no explicit timing relationship to the write address channel.
	//The write channel has its own throttling flag, separate from the AW channel.

	//Synchronization between the channels must be determined by the user.

	//The simpliest but lowest performance would be to only issue one address write
	//and write data burst at a time.

	//In this example they are kept in sync by using the same address increment
	//and burst sizes. Then the AW and W channels have their transactions measured
	//with threshold counters as part of the user logic, to make sure neither 
	//channel gets too far ahead of each other.

	//Forward movement occurs when the write channel is valid and ready

	  assign wnext = M_AXI_WREADY & axi_wvalid;                                   
	                                                                                    
	// WVALID logic, similar to the axi_awvalid always block above                      
	  always @(posedge M_AXI_ACLK)                                                      
                                                                             
	    if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1 )                                                        
	      begin                                                                         
	        axi_wvalid <= 1'b0;                                                         
	      end                                                                           
	                                                                        
	                                                                                    
	//WLAST generation on the MSB of a counter underflow                                
	// WVALID logic, similar to the axi_awvalid always block above                      
	  always @(posedge M_AXI_ACLK)                                                      
                                                                            
	    if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1 )                                                        
	      begin                                                                         
	        axi_wlast <= 1'b0;                                                          
	      end                                                                           
	                                                                             
	/* Burst length counter. Uses extra counter register bit to indicate terminal       
	 count to reduce decode logic */                                                    
	  always @(posedge M_AXI_ACLK)                                                      
                                                                             
	    if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1 || start_single_burst_write == 1'b1)    
	      begin                                                                         
	        write_index <= 0;                                                           
	      end                                                                           
	                                                                            
	                                                                                    
	/* Write Data Generator                                                             
	 Data pattern is only a simple incrementing count from 0 for each burst  */         
	  always @(posedge M_AXI_ACLK)                                                      
                                                                            
	    if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1)                                                         
	      axi_wdata <= 'b1;                                                             
	    //else if (wnext && axi_wlast)                                                  
	    //  axi_wdata <= 'b0;                                                           
	   
	//----------------------------
	//Write Response (B) Channel
	//----------------------------

	//The write response channel provides feedback that the write has committed
	//to memory. BREADY will occur when all of the data and the write address
	//has arrived and been accepted by the slave.

	//The write issuance (number of outstanding write addresses) is started by 
	//the Address Write transfer, and is completed by a BREADY/BRESP.

	//While negating BREADY will eventually throttle the AWREADY signal, 
	//it is best not to throttle the whole data channel this way.

	//The BRESP bit [1] is used indicate any errors from the interconnect or
	//slave for the entire write burst. This example will capture the error 
	//into the ERROR output. 

	  always @(posedge M_AXI_ACLK)                                     
                                                                 
	    if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1 )                                            
	      begin                                                             
	        axi_bready <= 1'b0;                                             
	      end                                                               
	    // accept/acknowledge bresp with axi_bready by the master           
	    // when M_AXI_BVALID is asserted by slave                           
	                                                                   
	                                                                        
	//Flag any write response errors                                        
	  assign write_resp_error = axi_bready & M_AXI_BVALID & M_AXI_BRESP[1]; 


	//----------------------------
	//Read Address Channel
	//----------------------------
	parameter		VALUE	=	1500	;
	parameter		IDLE1	=	3'b001	;
	parameter		JUDGE	=	3'b010	;
	parameter		RD		=	3'b100	;

	wire          	full              	;
	wire          	empty             	;
	wire [11 : 0] 	rd_data_count     	;
	wire [10 : 0] 	fifo_count        	;
	wire		  	fifo_rd_en			;
	
	reg  [2:0]		state			;
	reg				rd_flag			;
	reg				rd_start		;	
	reg [7:0]       data_cnt        ;
	reg 			rd_end          ;
	reg	[64:0]		rd_data_64bit	;
	reg				rd_data_valid	;
	
	
	//compare_done
	always@(posedge M_AXI_ACLK )
	    if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1 )
	      compare_done <=  1'b0;
		else
			compare_done<=1'b1;
	
	
	/* //rd_data_valid
  always@(posedge M_AXI_ACLK )
	    if (M_AXI_ARESETN == 0 )
	      rd_data_valid <=  1'b0;
	     else 
	      rd_data_valid <=  M_AXI_RVALID; */
	
	/* //rd_data_64bit
 always@(posedge M_AXI_ACLK )
	    if (M_AXI_ARESETN == 0 )
	      rd_data_64bit <=  'd0;
	    else if(M_AXI_RVALID==1'b1)
	      rd_data_64bit <=  M_AXI_RDATA; */
	      
	//axi_arvalid
	always@(posedge M_AXI_ACLK )
	    if (M_AXI_ARESETN == 0  )
			axi_arvalid <=  1'b0;	    
	    else if(fifo_count<VALUE&&state==JUDGE)
				axi_arvalid <=  1'b1;
		else if(M_AXI_ARREADY==1&&state==RD)
				axi_arvalid <=  1'b0;
				
				
	//axi_araddr
	always@(posedge M_AXI_ACLK )
		if (M_AXI_ARESETN == 0  )
			axi_araddr	<=	'd0	;
		else if(axi_araddr==8294400)
				axi_araddr  <=  'd0;		
		else if(M_AXI_ARREADY==1 && axi_arvalid==1)
				axi_araddr  <=  axi_araddr  + 2048;
		
	   
	//axi_rready
	always@(posedge M_AXI_ACLK )
		if (M_AXI_ARESETN == 0  )
			axi_rready  <=  1'b0;
		else 	if(state==RD)	
					axi_rready  <=  1'b1;
		else		axi_rready<=1'b0;
	
	/* //data_cnt
	always@(posedge M_AXI_ACLK )
		if (M_AXI_ARESETN == 0  )
			data_cnt  <=  'd0;
		else if(data_cnt==255&&M_AXI_RVALID==1'b1)
				data_cnt  <=  'd0;
		else if(M_AXI_RVALID==1'b1)
				data_cnt  <=  data_cnt  + 1'b1; */
	
	/* //rd_end
	always@(posedge M_AXI_ACLK )
		if (M_AXI_ARESETN == 0  )
			rd_end  <=  1'b0;
		else if(data_cnt==255&&M_AXI_RVALID==1'b1)
				rd_end  <=  1'b1;
		else 
				rd_end  <=  1'b0; */
	                                                                                  
	//state
	always@(posedge M_AXI_ACLK )
		if (M_AXI_ARESETN == 0  )
			state	<=	IDLE1	;
		else case (state)
			IDLE1	:	if(init_txn_pulse == 1'b1)
							state	<=	JUDGE	;
			JUDGE	:	if(fifo_count<VALUE)
							state	<=	RD	;
						else
							state	<=	JUDGE	;
			RD 		:	if(M_AXI_RLAST==1'b1)
							state	<=	JUDGE	;
						else
							state	<=	RD ;
			default:  state	<=	IDLE1	;
		endcase

	/* //rd_start
	always@(posedge M_AXI_ACLK )
		if (M_AXI_ARESETN == 0  )
			rd_start	<=	1'b0	;
		else if(fifo_count<VALUE&&state==JUDGE)
			rd_start	<=	1'b1	;
		else 
			rd_start	<=	1'b0	;	 */
			
	//rd_flag
	always@(posedge vga_clk )
		if (M_AXI_ARESETN == 0  )
			rd_flag	<=	1'b0	;
		else if(fifo_count>=VALUE&&vga_start==1'b1)
				rd_flag	<=	1'b1	;
		else	rd_flag	<=	rd_flag	;
				
	//fifo_rd_en
	assign	fifo_rd_en = vga_de && rd_flag;

	//fifo_generator_0
	fifo_generator_0 fifo_generator_0_inst (
		//.rst(state[0]),
		.wr_clk(M_AXI_ACLK),                // input wire wr_clk
		.rd_clk(vga_clk),                // input wire rd_clk
		.din(M_AXI_RDATA),                      // input wire [63 : 0] din
		.wr_en(M_AXI_RVALID),                  // input wire wr_en
		.rd_en(fifo_rd_en),                  // input wire rd_en
		
		.dout(vga_rgb),                    // output wire [31 : 0] dout
		.full(full),                    // output wire full
		.empty(empty),                  // output wire empty
		.rd_data_count(rd_data_count),  // output wire [11 : 0] rd_data_count
		.wr_data_count(fifo_count)  // output wire [10 : 0] wr_data_count
	);

	/* ila_0 ila_0_inst (
		.clk(M_AXI_ACLK), // input wire clk
	
	
		.probe0({	fifo_count,
					M_AXI_RDATA,
					M_AXI_RVALID,
					M_AXI_RLAST,
					M_AXI_ARREADY,
					init_txn_pulse,
					data_cnt,
					axi_arvalid,
					axi_araddr,
					axi_rready,
					rd_end,
					rd_start,
					fifo_rd_en,
					vga_rgb,
					vga_de}) // input wire [99:0] probe0
	); */

	/* ila_axi_full_rd ila_axi_full_rd_inst1 (
		.clk(vga_clk), // input wire clk
	
	
		.probe0({vga_rgb,fifo_rd_en,rd_flag,vga_start,vga_de}) // input wire [99:0] probe0
	); */
	
	endmodule