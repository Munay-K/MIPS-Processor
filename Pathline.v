//importante: entender porque el output del PC es de 31 si solo hay 256 bytes
//en el IM al igual que el output del ALU con el Address del memory.

//importante: Entender como usar el OPcode del instruction memory, por lo
//pronto he llegado a la conclusion de que se debe repetir en varias ocaciones
//tener el valor '00' es proble que funcione como un contador.

`include "modules/alu32.v"
`include "modules/instructionMemory.v"
`include "modules/regfile.v"
`include "modules/sign_extend.v"
`include "modules/mux2x1.v"
`include "modules/programCounter.v"
`include "modules/shift_left2.v"
`include "modules/mainControl.v"
`include "modules/alu_control.v"
`include "modules/dataMemory.v"
`include "modules/addAlu.v"

module Pathline();
reg clk;
reg [1:0] OPcode;
reg [31:0] in_address;
wire [31:0] PC_output;

programCounter U1 (clk,in_address,OPcode,PC_output);

wire [5:0] op, funct;
wire [4:0] rs,rt,rd,shamt;
wire [15:0] address;
wire [25:0] jump_address;

instructionMemory U2 (PC_output,op,rs,rt,rd,shamt,funct,address,jump_address);

reg [31:0] jump_address_shifted;

shiftLeft2 U3 (jump_address,jump_address_shifted);

wire Branch,MemRead,MemWrite,ALUSrc,RegWrite,RegDst,MemtoReg;
wire [1:0] ALUOp,Jump;

mainControl U4 (op,RegDst,Jump,Branch,MemRead,MemWrite,MemtoReg,ALUOp,ALUSrc,RegWrite);

wire [31:0] muxReg;

multiplaxer2x1 U5 (rt,rd,RegDst,muxReg); // mux betweeen IM and Reg

wire [31:0] dataR1,dataR2,dataW; //dataW come from memory

regfile32x32 U6 (clk,rs,rt,dataR1,dataR2,muxReg,dataW);

wire [31:0] signOut;

sign_extend U7 (address,signOut);

wire [31:0] muxALU;

multiplaxer2x1 U8 (signOut,dataR2,ALUSrc,muxALU); // mux between Reg and ALU

wire [3:0] ALUCtrlOut;

alu_control U9 (funct,ALUOp,ALUCtrlOut);

wire ovf, zero;
wire [31:0] ALUOut;

alu32 U10 (dataR1,muxALU,ALUCtrlOut,ovf,ALUOut,zero);

wire [31:0] DataMemoryOut;

dataMemory U11 (ALUOut,dataR2,MemWrite,MemRead,DataMemoryOut);

multiplaxer2x1 U12 (DataMemoryOut,ALUOut,MemtoReg,dataW);

wire [31:0] shiftOut;

shiftLeft2 U13 (signOut,shiftOut);

wire [31:0] addAlu_output;

addAlu U14 (PC_output,shiftOut,addAlu_output);

initial
begin
	clk = 0;
	OPcode=2'b11;
	#10;
	OPcode=2'b00;
	jump_address_shifted[31:28] = OPcode;

end

always
	#1 clk=!clk;

initial
	#50 $finish;

initial
begin
	$monitor("clk: %b input: %0x output: %0x",clk,PC_output, ALUOut);
end


endmodule

