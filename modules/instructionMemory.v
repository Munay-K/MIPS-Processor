module instructionMemory(pc,op,rs,rt,rd,shamt,funct,address);
input [31:0] pc;
output [5:0] op, funct;
output [4:0] rs,rt,rd,shamt;
output [15:0] address;

wire [31:0] instruction;
reg [7:0] program_instructions [0:255];

initial
	$readmemh("data/program_instructions.txt",program_instructions);
	
assign instruction = {program_instructions[pc],program_instructions[pc+1],program_instructions[pc+2],program_instructions[pc+3]};
assign op = instruction[31:26];
assign rs = instruction[25:21];
assign rt = instruction[20:16];
assign rd = instruction[15:11];
assign shamt = instruction[10:6];
assign funct = instruction[5:0];
assign address = instruction[15:0];

endmodule
