module regfile32x32(clk,rgAddR1,rgAddR2,dataR1,dataR2,rgAddW,dataW);
input clk;
input [4:0] rgAddR1, rgAddR2, rgAddW;
input [31:0] dataW;
reg signed [31:0] regf [0:31];
output reg [31:0] dataR1,dataR2;

integer i;

initial
	$readmemb("registers.txt",regf);

always @(posedge clk)
begin
	dataR1 = regf[rgAddR1];
	dataR2 = regf[rgAddR2];
end

always @(negedge clk)
begin
	regf[rgAddW] = dataW;
end

endmodule

