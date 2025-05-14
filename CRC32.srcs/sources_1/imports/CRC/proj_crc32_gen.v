////////////////////////////////////////////////////////////////////////////////
//
// 
//
// Filename     : proj_crc32_gen.v
// Description  : .
//
// Author       : 
// Created On   : 
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module proj_crc32_gen
    (
	 clk,
	 rst,
	 
	 ivld,
	 idin,
	 ieop,
	 isop,
	 
	 ovld,
	 odout,
	 oeop,
	 osop
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
	 
output ovld;
output [DAT_W-1:0] odout;
output oeop;
output osop;
////////////////////////////////////////////////////////////////////////////////                                 
//
wire [DATFCS_W-1:0]  fcs32_result;
wire [DATFCS_W-1:0]  fcsout_l;
reg  [DATFCS_W-1:0]  fcsout_lp;
reg [DATFCS_W-1:0]   fcsin = INIT_CRC;
wire [DATFCS_W-1:0]  fcsout;
reg  [DAT_W-1:0]     din;
always@(posedge clk) fcsin <= isop ? INIT_CRC : fcsout;


always@(posedge clk) din  <= idin;


always@(posedge clk) fcsout_lp  <= fcsout_l;     					


	

//Gen
proj_crc32_in8 crc32_gen
    (
     .datain        (din), 
	 .eopin         (1'b0),
     .fcsin         (fcsin),     
     .fcsout        (fcsout),
     .fcserr        (),
     .fcsmatch      ()
     );

//Ins FCS
reg eop_p,eop_pp,eop_ppp,eop_pppp;
always@(posedge clk)
	begin
	eop_p    <= ieop;
	eop_pp   <= eop_p;
	eop_ppp  <= eop_pp;
	eop_pppp <= eop_ppp;
	end
	

//output
reg ovld = 1'b0;
reg [DAT_W-1:0] odout = 1'b0;
reg oeop = 1'b0;
reg osop = 1'b0;
always@(posedge clk)
	begin
	ovld <= ivld | eop_p | eop_pp | eop_ppp | eop_pppp;
	oeop <= eop_pppp;
	osop <= isop;
	
	if      (ivld) 	   odout <= idin;
	else if (eop_p)    odout <= fcs32_result[31:24];
	else if (eop_pp)   odout <= fcs32_result[23:16];
	else if (eop_ppp)  odout <= fcs32_result[15:08];
	else               odout <= fcs32_result[07:00];
	
	end
	
assign 	            fcsout_l = eop_p ? fcsout : fcsout_lp;

assign              fcs32_result = INIT_CRC ^ {fcsout_l[24],fcsout_l[25],fcsout_l[26],fcsout_l[27],fcsout_l[28],fcsout_l[29],fcsout_l[30],fcsout_l[31],
											   fcsout_l[16],fcsout_l[17],fcsout_l[18],fcsout_l[19],fcsout_l[20],fcsout_l[21],fcsout_l[22],fcsout_l[23],
											   fcsout_l[08],fcsout_l[09],fcsout_l[10],fcsout_l[11],fcsout_l[12],fcsout_l[13],fcsout_l[14],fcsout_l[15],
											   fcsout_l[00],fcsout_l[01],fcsout_l[02],fcsout_l[03],fcsout_l[04],fcsout_l[05],fcsout_l[06],fcsout_l[07]											   
											  };



endmodule 
