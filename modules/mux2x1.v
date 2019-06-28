module multiplaxer2x1(inA,inB,slc,out);
input [31:0] inA;
input [31:0] inB;
input slc;
output [31:0] out;

assign out = slc ? inB:inA;

endmodule
