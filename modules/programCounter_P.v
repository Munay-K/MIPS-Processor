module programCounter(clk,in_address,OPcode,address);
input clk;
input [1:0] OPcode;
input [31:0] in_address;
output [31:0] address;

reg [31:0] reg_address;

always @(posedge clk)
begin
	case(OPcode)
		2'b00 : reg_address = reg_address + 4;
		2'b01 : reg_address = in_address;
		2'b10 : reg_address = address;
		2'b11 : reg_address = 0;
	endcase
end

assign address = reg_address;

endmodule

//This Pogram Counter has 3 inputs in this case, the clock as clk for
//syncronization, the OPcode which indicates the operation we need to
//make and the input address as 'in_address'.
//
//All this operations were made in order to implement a pipeline in
//future updates.
//
//PC+8 para cuando se hace un jal (jump and link)
