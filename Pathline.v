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
reg clk,PC_reset;
wire [31:0] PC_input;
wire [31:0] PC_output;

programCounter PC (clk,PC_input,PC_output,PC_reset);

wire [2:0] add_input4;
wire [31:0] ADD4_output;

addAlu ADD_4 (PC_output,add_input4,ADD4_output);

wire [5:0] op, funct;
wire [4:0] rs,rt,rd,shamt;
wire [15:0] address;
wire [25:0] jump_address;
wire [31:0] instruction;

instructionMemory IM (PC_output,op,rs,rt,rd,shamt,funct,address,jump_address,instruction);

wire [28:0] jump_address_shifted;

shift26_28 SHIFT1 (jump_address,jump_address_shifted);

wire [31:0] jump_address_merged; //jump_address_shifted merged with ADD4_output[31:28]
wire Branch,MemRead,MemWrite,ALUSrc,RegWrite,RegDst,MemtoReg;
wire [1:0] ALUOp,Jump;

mainControl CONTROL (op,RegDst,Jump,Branch,MemRead,MemWrite,MemtoReg,ALUOp,ALUSrc,RegWrite);

wire [31:0] muxReg;

mux5 MUX1 (rt,rd,RegDst,muxReg); // mux betweeen IM and Reg

wire [31:0] dataR1,dataR2,dataW; //dataW come from memory

regfile32x32 REG (clk,rs,rt,dataR1,dataR2,muxReg,dataW);

wire [31:0] sign_output;

sign_extend SIGN_EXTEND (address,sign_output);

wire [31:0] sign_shifted;

shift32_32 SHIFT2 (sign_output, sign_shifted);

wire [31:0] muxALU;

mux32 MUX2 (dataR2,sign_output,ALUSrc,muxALU); // mux between Reg and ALU

wire [3:0] ALUCtrlOut;

alu_control ALU_CONTROL (funct,ALUOp,ALUCtrlOut);

wire [31:0] ADDalu_output;

addAlu ADD_ALU (ADD4_output,sign_shifted,ADDalu_output);

wire ovf, zero;
wire [31:0] ALUOut;

alu32 ALU (dataR1,muxALU,ALUCtrlOut,ovf,ALUOut,zero);

wire [31:0] muxMux_output;

wire BranchAndZero;
assign BranchAndZero = Branch && zero;

mux32 MUX3 (ADD4_output,ADDalu_output,BranchAndZero,muxMux_output);

wire [31:0] DataMemory_output;

dataMemory MEMORY (ALUOut,dataR2,MemWrite,MemRead,DataMemory_output);

wire [31:0] muxPC_output;

mux32 MUX4 (jump_address_merged,muxMux_output,Jump,PC_input);

mux32 MUX5 (DataMemory_output,ALUOut,MemtoReg,dataW);

initial
begin
	clk = 0;
	PC_reset = 1;
	#2
	PC_reset = 0;
end

always
	#1 clk=!clk;

always @(*)
begin
	$display("P_COUNTER -> CLOCK: %b RESET: %b INPUT: %h OUTPUT: %h",clk,
		PC_reset,PC_input,PC_output);
	$display("I_MEMORY -> INPUT: %h OUTPUT: %b", PC_output,instruction);
	$display("REGISTER -> CLK: %b RS: %h RT: %h MUX: %h WRITE: %h READ1: %h READ2: %h",clk,rs,rt,muxReg,dataW,dataR1,dataR2);
	$display("SIGN_EXTEND -> INPUT: %h OUTPUT: %h", address,sign_output);
	$display("ALU_CONTROL -> INPUT: %h CONTROL: %b OUTPUT: %h",funct,ALUCtrlOut);
	$display("ALU --> INPUT_1: %h INPUT_2: %h ZERO: %b OUTPUT: %h \n",dataR1,muxALU,zero,ALUOut);

end

initial
	#10 $finish;

endmodule

