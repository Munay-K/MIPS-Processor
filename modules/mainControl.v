module mainControl(opcode,Jump,Branch,RegDst,RegWrite,ALUSrc,PCSrc,MemRead,MemWrite,MemtoReg,ALUOp);
input [5:0] opcode;
output Branch,MemRead,MemWrite,ALUSrc,RegWrite;
output [1:0] RegDst,MemtoReg,ALUOp,Jump;
