//importante: entender porque el output del PC es de 31 si solo hay 256 bytes
//en el IM al igual que el output del ALU con el Address del memory.

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

instructionMemory U2 (PC_output,op,rs,rt,rd,shamt,funct,address);

wire Branch,MemRead,MemWrite,ALUSrc,RegWrite,RegDst,MemtoReg;
wire [1:0] ALUOp,Jump;

mainControl U3 (op,RegDst,Jump,Branch,MemRead,MemWrite,MemtoReg,ALUOp,ALUSrc,RegWrite);

wire [31:0] muxReg;

multiplaxer2x1 U4 (rt,rd,RegDst,muxReg); // mux betweeen IM and Reg

wire [31:0] dataR1,dataR2,dataW; //dataW come from memory

regfile32x32 U5 (clk,rs,rt,dataR1,dataR2,muxReg,dataW);

wire [31:0] signOut;

sign_extend U6 (address,signOut);

wire [31:0] muxALU;

multiplaxer2x1 U7 (signOut,dataR2,ALUSrc,muxALU); // mux between Reg and ALU

wire [3:0] ALUCtrlOut;

alu_control U8 (funct,ALUOp,ALUCtrlOut);

wire ovf, zero;
wire [31:0] ALUOut;

alu32 U9 (dataR1,muxALU,ALUCtrlOut,ovf,ALUOut,zero);

wire [31:0] DataMemoryOut;

dataMemory U10 (ALUOut,dataR2,MemWrite,MemRead,DataMemoryOut);

multiplaxer2x1 U11 (DataMemoryOut,ALUOut,MemtoReg,dataW);

wire [31:0] shiftOut;

shiftLeft2 U12 (signOut,shiftOut);

wire [31:0] addAlu_output;

addAlu U13 (PC_output,shiftOut,addAlu_output);

initial
begin
in_address = 0;
end

always
	#1 clk=!clk;

initial
begin
	$monitor("input: %h output: % h", PC_output, ALUOut);
end
endmodule
