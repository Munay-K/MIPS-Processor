module alu32(Rdata1,Mdata,ctrl,ovf,out);
input [31:0] Rdata1,Mdata;
input [3:0] ctrl;
output ovf;
output [31:0] out;

assign out = ctrl==4'b0000 ? Rdata1 & Mdata:
						 ctrl==4'b0001 ? Rdata1 | Mdata:
						 ctrl==4'b0010 ? Rdata1 + Mdata:
						 ctrl==4'b0110 ? Rdata1 - Mdata:
						 ctrl==4'b0111 ? Rdata1 < Mdata:
						 ctrl==4'b1100 ? Rdata1 ^ Mdata:0;

assign ovf = ctrl==2 ? Rdata1>out: 0;

endmodule
