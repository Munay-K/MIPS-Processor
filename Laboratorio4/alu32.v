module alu32(Rdata1,Mdata,ctrl,ovf,out);
input [31:0] Rdata1,Mdata;
input [3:0] ctrl;
output ovf;
output [31:0] out;

assign out = ctrl==0 ? Rdata1 & Mdata:
						 ctrl==1 ? Rdata1 | Mdata:
						 ctrl==2 ? Rdata1 + Mdata:
						 ctrl==6 ? Rdata1 - Mdata:
						 ctrl==7 ? Rdata1 < Mdata:
						 ctrl==12 ? Rdata1 ^ Mdata:0;

assign ovf = ctrl==2 ? Rdata1>out: 0;
endmodule
