module mainControl(opcode,RegDst,Jump,Branch,MemRead,MemWrite,MemtoReg,ALUOp,ALUSrc,RegWrite);
input [5:0] opcode;
output reg Branch,MemRead,MemWrite,ALUSrc,RegWrite;
output reg [1:0] RegDst,MemtoReg,ALUOp,Jump;

always @(*)
begin
	case (opcode)
		6'b0: // R-type - 0
		begin
		 RegDst = 1;
		 ALUSrc = 0;
		 MemtoReg = 0;
		 RegWrite = 1;
		 MemRead = 0;
		 MemWrite = 0;
		 Branch = 0;
		 ALUOp = 2'b10;
		end
		
		6'b100011: // Load word - 35
		begin
			RegDst = 0;
			ALUSrc = 1;
			MemtoReg = 1;
			RegWrite = 1;
			MemRead = 1;
			MemWrite = 0;
			Branch = 0;
			ALUOp = 2'b00;
		end
		
		
	endcase
end

endmodule
