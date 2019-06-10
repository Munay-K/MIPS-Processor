module dataMemory(Address, WriteData, MemWrite, MemRead, ReadData);
input [31:0] Address, WriteData;
input MemWrite, MemRead;
output reg [31:0] ReadData;

reg [7:0] DataMemory [0:255];

integer i;

initial
begin
	for(i=0; i<256; i=i+1)
		DataMemory[i]=0;
end

always @(posedge MemWrite)
begin
	DataMemory[Address]   = WriteData[31:24];
	DataMemory[Address+1] = WriteData[23:15];
	DataMemory[Address+2] = WriteData[15:7];
	DataMemory[Address+3] = WriteData[7:0];
end

always @(posedge MemRead)
begin
	ReadData = {DataMemory[Address],DataMemory[Address+1],DataMemory[Address+2],DataMemory[Address+3]};
end

endmodule
