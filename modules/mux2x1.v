module mux5(inA,inB,slc,out);
input [4:0] inA,inB;
input slc;
output [4:0] out;

assign out = slc ? inB:inA;

endmodule

module mux32(inA,inB,slc,out);
input [31:0] inA,inB;
input slc;
output [31:0] out;

assign out = slc ? inB:inA;

endmodule

module mux2_32(inA,inB,slc1,slc2,out);
input [31:0] inA,inB;
input slc1,slc2;
output [31:0] out;

assign out = (slc1 && slc2) ? inB:inA;

endmodule
