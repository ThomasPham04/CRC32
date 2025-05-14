////////////////////////////////////////////////////////////////////////////////
//
// 
//
// Filename     : proj_crc32_mon.v
// Description  : .
//
// Author       : 
// Created On   : 
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module proj_crc32_mon
    (
	 clk,
	 rst,
	 
	 ivld,
	 idin,
	 ieop,
	 isop, 

	 oerr,
	 omatch
     );
////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter DAT_W = 8;
parameter NUM_W = 36;//byte
parameter DATFCS_W = 4*DAT_W;
parameter INIT_CRC = 32'hFFFF_FFFF;

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input  clk;
input  rst;

input  ivld;
input  [DAT_W-1:0] idin;
input  ieop;
input  isop;


output	 oerr;
output	 omatch;	 
////////////////////////////////////////////////////////////////////////////////                                 
//
wire [DATFCS_W-1:0]  fcs32_result;
reg [DATFCS_W-1:0]   fcsin = INIT_CRC;
wire [DATFCS_W-1:0]  fcsout;
reg  [DAT_W-1:0]     din;
reg                  eop;
always@(posedge clk) fcsin <= isop ? INIT_CRC : fcsout;

always@(posedge clk) din  <= idin;
always@(posedge clk) eop  <= ieop;


//Mon
proj_crc32_in8 crc32_mon
    (
     .datain        (din), 
	 .eopin         (eop),
     .fcsin         (fcsin),     
     .fcsout        (fcsout),
     .fcserr        (err),
     .fcsmatch      (match)
     );


//output
reg	 oerr = 1'b0;
reg	 omatch = 1'b0;
always@(posedge clk)
	begin
	oerr <= err;
	omatch <= match;	
	end



endmodule 
