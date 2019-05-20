module multiplaxer2x1(Rdata2,Idata,slc,out);
input [31:0] Rdata2;
input [15:0] Idata;
input slc;
output [31:0] out;

assign out = slc ? Idata:Rdata2;

endmodule
