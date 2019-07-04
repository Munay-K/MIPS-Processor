module addAlu(inA,inB,out);
input [31:0] inA, inB;
output [31:0] out;

assign out = inA + inB;

always @(*)
	$monitor("ADDRESS_+4: %0x", out);

endmodule
