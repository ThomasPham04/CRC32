////////////////////////////////////////////////////////////////////////////////
//
// 
//
// Filename     : proj_crc32_in8.v
// Description  : .
//
// Author       : 
// Created On   : Thu May 04 10:23:52 2023
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module proj_crc32_in8
    (
     datain,   
	 eopin,	 
     fcsin,
     fcsout,
     fcserr,
     fcsmatch
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
localparam      FCS32PATTERN = 32'hc704dd7b;



////////////////////////////////////////////////////////////////////////////////
// Port declarations
input [7:0]    datain;
input          eopin;
input [31:0]   fcsin;
output [31:0]  fcsout;
output         fcserr;
output         fcsmatch;





////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
// P(x)*X^r mode G(x)
/* G(x)=x^32+x^26+x^23+x^22+x^16+x^12+x^11+x^10+x^8+x^7+x^5+x^4+x^2+x^1+x^0
 */

wire [7:0]    idat;
wire [31:0]   ihas;
wire [31:0]   ohas;
assign        idat = {datain[0],datain[1],datain[2],datain[3],datain[4],datain[5],datain[6],datain[7]};
assign        ihas = fcsin;


assign          ohas[31]=idat[5]^ihas[29]^ihas[23];
assign          ohas[30]=idat[7]^idat[4]^ihas[31]^ihas[28]^ihas[22];
assign          ohas[29]=idat[7]^idat[6]^idat[3]^ihas[31]^ihas[30]^ihas[27]^ihas[21];
assign          ohas[28]=idat[6]^idat[5]^idat[2]^ihas[30]^ihas[29]^ihas[26]^ihas[20];
assign          ohas[27]=idat[7]^idat[5]^idat[4]^idat[1]^ihas[31]^ihas[29]^ihas[28]^ihas[25]^ihas[19];
assign          ohas[26]=idat[6]^idat[4]^idat[3]^idat[0]^ihas[30]^ihas[28]^ihas[27]^ihas[24]^ihas[18];
assign          ohas[25]=idat[3]^idat[2]^ihas[27]^ihas[26]^ihas[17];
assign          ohas[24]=idat[7]^idat[2]^idat[1]^ihas[31]^ihas[26]^ihas[25]^ihas[16];
assign          ohas[23]=idat[6]^idat[1]^idat[0]^ihas[30]^ihas[25]^ihas[24]^ihas[15];
assign          ohas[22]=idat[0]^ihas[24]^ihas[14];
assign          ohas[21]=idat[5]^ihas[29]^ihas[13];
assign          ohas[20]=idat[4]^ihas[28]^ihas[12];
assign          ohas[19]=idat[7]^idat[3]^ihas[31]^ihas[27]^ihas[11];
assign          ohas[18]=idat[7]^idat[6]^idat[2]^ihas[31]^ihas[30]^ihas[26]^ihas[10];
assign          ohas[17]=idat[6]^idat[5]^idat[1]^ihas[30]^ihas[29]^ihas[25]^ihas[9];
assign          ohas[16]=idat[5]^idat[4]^idat[0]^ihas[29]^ihas[28]^ihas[24]^ihas[8];
assign          ohas[15]=idat[7]^idat[5]^idat[4]^idat[3]^ihas[31]^ihas[29]^ihas[28]^ihas[27]^ihas[7];
assign          ohas[14]=idat[7]^idat[6]^idat[4]^idat[3]^idat[2]^ihas[31]^ihas[30]^ihas[28]^ihas[27]^ihas[26]^ihas[6];
assign          ohas[13]=idat[7]^idat[6]^idat[5]^idat[3]^idat[2]^idat[1]^ihas[31]^ihas[30]^ihas[29]^ihas[27]^ihas[26]^ihas[25]^ihas[5];
assign          ohas[12]=idat[6]^idat[5]^idat[4]^idat[2]^idat[1]^idat[0]^ihas[30]^ihas[29]^ihas[28]^ihas[26]^ihas[25]^ihas[24]^ihas[4];
assign          ohas[11]=idat[4]^idat[3]^idat[1]^idat[0]^ihas[28]^ihas[27]^ihas[25]^ihas[24]^ihas[3];
assign          ohas[10]=idat[5]^idat[3]^idat[2]^idat[0]^ihas[29]^ihas[27]^ihas[26]^ihas[24]^ihas[2];
assign          ohas[9]=idat[5]^idat[4]^idat[2]^idat[1]^ihas[29]^ihas[28]^ihas[26]^ihas[25]^ihas[1];
assign          ohas[8]=idat[4]^idat[3]^idat[1]^idat[0]^ihas[28]^ihas[27]^ihas[25]^ihas[24]^ihas[0];
assign          ohas[7]=idat[7]^idat[5]^idat[3]^idat[2]^idat[0]^ihas[31]^ihas[29]^ihas[27]^ihas[26]^ihas[24];
assign          ohas[6]=idat[7]^idat[6]^idat[5]^idat[4]^idat[2]^idat[1]^ihas[31]^ihas[30]^ihas[29]^ihas[28]^ihas[26]^ihas[25];
assign          ohas[5]=idat[7]^idat[6]^idat[5]^idat[4]^idat[3]^idat[1]^idat[0]^ihas[31]^ihas[30]^ihas[29]^ihas[28]^ihas[27]^ihas[25]^ihas[24];
assign          ohas[4]=idat[6]^idat[4]^idat[3]^idat[2]^idat[0]^ihas[30]^ihas[28]^ihas[27]^ihas[26]^ihas[24];
assign          ohas[3]=idat[7]^idat[3]^idat[2]^idat[1]^ihas[31]^ihas[27]^ihas[26]^ihas[25];
assign          ohas[2]=idat[7]^idat[6]^idat[2]^idat[1]^idat[0]^ihas[31]^ihas[30]^ihas[26]^ihas[25]^ihas[24];
assign          ohas[1]=idat[7]^idat[6]^idat[1]^idat[0]^ihas[31]^ihas[30]^ihas[25]^ihas[24];
assign          ohas[0]=idat[6]^idat[0]^ihas[30]^ihas[24];



assign          fcsout = ohas;

assign          fcserr   = eopin & (|(fcsout ^ FCS32PATTERN));//only for FCS mon when FCS gen don't care
assign          fcsmatch = eopin & (!(|(fcsout ^ FCS32PATTERN)));

endmodule 
