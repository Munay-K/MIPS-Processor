module tb_ALU32();
reg clk;
reg [4:0] rgAddR1, rgAddR2, rgAddW;
reg [31:0] dataW;
wire [31:0] dataR1, dataR2;

regfile32x32 U1 (clk,rgAddR1,rgAddR2,dataR1,dataR2,rgAddW,dataW);

reg [15:0] Idata;
reg slc;
wire [31:0] outM;

multiplaxer2x1 U2 (dataR2,Idata,slc,outM);

reg [3:0] ctrl;
wire ovf;
wire [31:0] outA;

alu32 U3 (dataR1,outM,ctrl,ovf,outA);

initial
begin
	clk=1;
	rgAddR1 = 10; // $t2
	rgAddR2 = 11; // $t3
	rgAddW = 10; // $t2

	slc = 0;
	ctrl = 0;
	
	#1
	clk=0;
	dataW = outA;

	//......................
	
	rgAddR1 = 10; // $t2
	rgAddR2 = 15; // $t7

	ctrl = 1;
	
	#1
	clk=0;
	dataW = outA;

	//.....................
	
	rgAddR1 = 10; // $t2
	Idata = 5;
	
	slc = 1;
	ctrl = 2;

	#1
	clk=0;
	dataW = outA;

	//......................
	
	rgAddR1 = 10; // $t2
	rgAddR2 = 15; // $t7

	slc = 0;
	ctrl = 6;
	
	#1
	clk=0;
	dataW = outA;

	//.....................
	
	rgAddR1 = 10; // $t2
	rgAddR2 = 8; // $t0

	ctrl = 7;
		
	#1
	clk=0;
	dataW = outA;

	//.....................
		
	rgAddR1 = 10; // $t2
	rgAddR2 = 23; // $t8

	ctrl = 12;
	
	#1
	clk=0;
	dataW = outA;

	//.....................
	
	rgAddR1 = 24; // $t8
	rgAddR2 = 25; // $t9

	ctrl = 2;

	#1
	clk=0;
	rgAddW = 24; // $t8
	dataW = outA;

end

initial
	#10 $finish;

always
	#1 clk=!clk;

initial
begin
	$monitor("RegFile: input1 = %d input2 = %d \nMux: slc = %d imData = %d \nALU: ctrl=%d output=%d overflow = %d (clk=%d) \n ------", dataR1,dataR2,slc,Idata,ctrl,outA,ovf,clk);
end

endmodule


