////////////////////////////////////////////////////////////////////////////////
//
// 
//
// Filename     : proj_crc32_tb.v
// Description  : .
//
// Author       : 
// Created On   : 
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module proj_crc32_tb
    (

     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter DAT_W = 8;
parameter NUM_W = 36;//byte
parameter DATFCS_W = 4*DAT_W;

parameter INIT = 2'd0;
parameter VLD  = 2'd1;
parameter WAIT = 2'd2;
////////////////////////////////////////////////////////////////////////////////
//Create clock.
reg clk;
reg rst;

initial
    begin 
    clk = 1;
    rst = 1;
    #20;    
    rst = 0;    
    end 
    
always #5  clk = !clk; 

////////////////////////////////////////////////////////////////////////////////                                 
//Ethernat frame database
wire [DAT_W*NUM_W-1:0]   db_eth;
assign                   db_eth = {
                                   32'hFF_03_00_31, 32'hA2_EF_CA_FE,//F,Z,pad,mac...
                                   64'hCA_EF_CA_FE_C0_CA_C0_CA, //DA-SA                                     
                                   32'hC0_CA_AA_AA,/*src MAC + len*/ 32'hFF_FF_FF_FF,//llc                                                                  
                                   64'h00_11_22_33_44_55_66_77, //llc                                                                                            
                                   32'hFE_FE_FE_FE       //frm fcs
                                   };//total 32 byte						   
								   

wire        oerr_tb;
wire        omatch_tb;


reg 		ivld_tb;
reg 		isop_tb;
reg 	 	ieop_tb;
reg [7:0]	cnt_tb;
reg [1:0] 	fsm_tb;
wire        cnt_max;
assign      cnt_max = (cnt_tb >= NUM_W-1);
always@(posedge clk)
	begin
	if (rst)
		begin
		ivld_tb <= 1'b0;
		isop_tb <= 1'b0;
		ieop_tb <= 1'b0;
		cnt_tb  <= 1'b0;		
		fsm_tb  <= INIT;
		end
	else
		begin
		case (fsm_tb)
			INIT: 
				begin
				ivld_tb <= 1'b1;
				isop_tb <= 1'b1;
				ieop_tb <= (NUM_W == 1);
				cnt_tb  <= 1'b0;
				fsm_tb  <= VLD;
				end
			VLD:
				begin
				ivld_tb <= !cnt_max;
				isop_tb <= 1'b0;
				ieop_tb <= cnt_max ? 1'b0 : (cnt_tb >= NUM_W-2);
				cnt_tb  <= cnt_max ? cnt_tb : (cnt_tb + 1'b1);
				fsm_tb  <= cnt_max ? WAIT : VLD;
				end
			WAIT:
				begin
				ivld_tb <= 1'b0;
				isop_tb <= 1'b0;
				ieop_tb <= 1'b0;
				cnt_tb  <= 1'b0;
				fsm_tb  <= (oerr_tb | omatch_tb) ? INIT : WAIT;
				end
			default:;
		endcase
			
		end
	end
	
	
//data
integer                 idx; //port index
reg [DAT_W-1:0]         idin_tb;
always@(*)
    begin 
	for (idx = 0; idx < NUM_W; idx = idx + 1)
		begin
		if (idx == cnt_tb)
			begin
			idin_tb[7] = db_eth[idx*DAT_W + 7];
			idin_tb[6] = db_eth[idx*DAT_W + 6];
			idin_tb[5] = db_eth[idx*DAT_W + 5];
			idin_tb[4] = db_eth[idx*DAT_W + 4];
			idin_tb[3] = db_eth[idx*DAT_W + 3];
			idin_tb[2] = db_eth[idx*DAT_W + 2];
			idin_tb[1] = db_eth[idx*DAT_W + 1];
			idin_tb[0] = db_eth[idx*DAT_W + 0];
			end 
			
		end    
    end	

//DUT
proj_crc32_core DUT
    (
	 .clk	(clk),
	 .rst	(rst),
	 
	 .ivld	(ivld_tb),
	 .idin	(idin_tb),
	 .ieop	(ieop_tb),
	 .isop	(isop_tb), 

	 .oerr	(oerr_tb),
	 .omatch(omatch_tb)
     );



endmodule 
