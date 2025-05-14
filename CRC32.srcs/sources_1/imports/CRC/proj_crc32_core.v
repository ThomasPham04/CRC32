////////////////////////////////////////////////////////////////////////////////
//
// 
//
// Filename     : proj_crc32_core.v
// Description  : .
//
// Author       : 
// Created On   : 
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module proj_crc32_core
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
wire ovld;
wire [DAT_W-1:0] odout;
wire oeop;
wire osop;

proj_crc32_gen crc32_gen
    (
	 .clk 	(clk),
	 .rst	(rst),
	 
	 .ivld	(ivld),
	 .idin	(idin),
	 .ieop	(ieop),
	 .isop	(isop),
	 
	 .ovld	(ovld),
	 .odout	(odout),
	 .oeop	(oeop),
	 .osop	(osop)
     );
	 
proj_crc32_mon crc32_mon
    (
	 .clk	(clk),
	 .rst	(rst),
	 
	 .ivld	(ovld),
	 .idin	(odout),
	 .ieop	(oeop),
	 .isop	(osop),	 

	 .oerr	(oerr),
	 .omatch(omatch)
     );	 
	 

endmodule 
