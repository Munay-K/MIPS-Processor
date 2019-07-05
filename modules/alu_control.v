module alu_control(funct,ALUop,out);
input [1:0] ALUop;
input [5:0] funct;
output [3:0] out;

reg [3:0] regOut;

/*
assign out = ALUop==2'b00 ? 4'b0010:
						 ALUop==2'b01 ? 4'b0110:
						 ALUop==2'b10 ? funct[3:0]==4'b0000 ? 4'b0010:
													  funct[3:0]==4'b0010 ? 4'b0110:
														funct[3:0]==4'b0100 ? 4'b0000:
														funct[3:0]==4'b0101 ? 4'b0001:
														funct[3:0]==4'b1010 ? 4'b0111;
*/

always @(*)
begin
	casez(ALUop)
		2'b00 : regOut = 4'b0010;
		2'b?1 : regOut = 4'b0110;
		2'b10 :
		casez(funct)
			6'b??0000 : regOut = 4'b0010;
			6'b??0010 : regOut = 4'b0110;
			6'b??0100 : regOut = 4'b0000;
			6'b??0101 : regOut = 4'b0001;
			6'b??1010 : regOut = 4'b0111;
			6'b100111 : regOut = 4'b1110;
		endcase
	endcase
	$monitor("-----------------------REGOUT = %b",regOut);
end

assign out = regOut;

endmodule
													
