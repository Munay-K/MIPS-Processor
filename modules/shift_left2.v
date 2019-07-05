module shift26_28(in,out);
input [25:0] in;
output [27:0] out;

assign out = in << 2;

endmodule

module shift32_32(in,out);
input [31:0] in;
output [31:0] out;

assign out = in << 2;

endmodule

