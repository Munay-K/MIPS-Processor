module programCounter(clk,in_address,out_address,rst);
input clk, rst;
input [31:0] in_address;
output [31:0] out_address;

reg [31:0] reg_address;

always @(posedge clk)
begin
	if(rst)
		reg_address = 32'h00000000;
	else
		reg_address = in_address;
	
//	$monitor("CLOCK: %b RESET: %b IN_ADDRESS: %h OUT_ADDRESS: %h", clk,rst,in_address,out_address);
end

assign out_address = reg_address;

endmodule
