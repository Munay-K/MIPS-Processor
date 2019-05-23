module programCounter(addInput,address);
input [31:0] addInput;
output [31:0] address;

assign address = addInput ? addInput:0;

endmodule


