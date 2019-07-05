module mainControl(op_field, funct, RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, Jump, SignExt,InstrtoReg);
  input [5:0] op_field;
  input [5:0] funct;
	
  output SignExt;
  output [1:0] RegDst;
  output Branch;
  output MemRead;
  output [1:0] MemtoReg;
  output [1:0] ALUOp;
  output MemWrite;
  output ALUSrc;
  output RegWrite;
  output [1:0] Jump;
  output InstrtoReg;
  
  reg reg_InstrtoReg;  
  reg [1:0] reg_RegDst;
  reg reg_Branch;
  reg reg_MemRead;
  reg [1:0] reg_MemtoReg;
  reg [1:0] reg_ALUOp;
  reg reg_MemWrite;
  reg reg_ALUSrc;
  reg reg_RegWrite;
  reg [1:0] reg_Jump;
  reg reg_SignExt;
  always@(op_field or funct)begin
  case (op_field)




    6'b000000 : // R-type
      begin
        if(funct == 6'b001000)begin
          $display("jr called");
          reg_RegDst = 2'b00;
          reg_Branch = 1'b0;
          reg_MemRead = 1'b0;
          reg_MemtoReg = 2'b00;
          reg_ALUOp = 2'b00;
          reg_MemWrite = 1'b0;
          reg_ALUSrc = 1'b0;
          reg_RegWrite = 1'b0;
          reg_Jump = 2'b10;
	
        end
        else begin
          reg_RegDst = 2'b01;
          reg_Branch = 1'b0;
          reg_MemRead = 1'b0;
          reg_MemtoReg = 2'b00;
          reg_ALUOp = 2'b10;
          reg_MemWrite = 1'b0;
          reg_ALUSrc = 1'b0;
          reg_RegWrite = 1'b1;
          reg_Jump = 2'b00;
        end

      end

 6'b001111 : // r-type " lui "
      begin
        $display("lui detected");
        reg_RegDst = 2'b10;
        reg_Branch = 1'b0;
        reg_MemRead = 1'b0;
        reg_MemtoReg = 2'b01;
        reg_ALUOp = 2'b00;
        reg_MemWrite = 1'b0;
        reg_ALUSrc = 1'b1;
        reg_RegWrite = 1'b1;
        reg_Jump = 2'b00;
        reg_InstrtoReg=1'b1;
      end
6'b000000 : begin // R - type
     reg_RegDst = 2'b1;
     reg_ALUSrc = 1'b0;
     reg_MemtoReg= 2'b0;
     reg_RegWrite= 1'b1;
     reg_MemRead = 1'b0;
     reg_MemWrite= 1'b0;
     reg_Branch = 1'b0;
     reg_ALUOp = 2'b10;
     reg_Jump = 2'b0;
  
    end


    6'b001000 : // I-type : addi
      begin
        $display("addi called");
        reg_RegDst = 2'b00;
        reg_Branch = 1'b0;
        reg_MemRead = 1'b0;
        reg_MemtoReg = 2'b00;
        reg_ALUOp = 2'b11;
        reg_MemWrite = 1'b0;
        reg_ALUSrc = 1'b1;
        reg_RegWrite = 1'b1;
        reg_Jump = 2'b00;
	reg_SignExt=1'b1;
      end

    6'b001010 : // I-type : slti
      begin
        $display("slti called");
        reg_RegDst = 2'b00;
        reg_Branch = 1'b0;
        reg_MemRead = 1'b0;
        reg_MemtoReg = 2'b00;
        reg_ALUOp = 2'b10;
        reg_MemWrite = 1'b0;
        reg_ALUSrc = 1'b1;
        reg_RegWrite = 1'b1;
        reg_Jump = 2'b00;
	reg_SignExt=1'b1;
      end
	
    6'b001101: // I-type : ori
      begin
        $display("ori called");
        reg_RegDst = 2'b00;
        reg_Branch = 1'b0;
        reg_MemRead = 1'b0;
        reg_MemtoReg = 2'b00;
        reg_ALUOp = 2'b11;
        reg_MemWrite = 1'b0;
        reg_ALUSrc = 1'b1;
        reg_RegWrite = 1'b1;
        reg_Jump = 2'b00;
	reg_SignExt=1'b1;
      end
    
    6'b001100 : // I-type :  andi
      begin
        $display(" andi called");
        reg_RegDst = 2'b00;
        reg_Branch = 1'b0;
        reg_MemRead = 1'b0;
        reg_MemtoReg = 2'b00;
        reg_ALUOp = 2'b11;
        reg_MemWrite = 1'b0;
        reg_ALUSrc = 1'b1;
        reg_RegWrite = 1'b1;
        reg_Jump = 2'b00;
	reg_SignExt=1'b1;
      end

    6'b110111 : // I-type : subi
      begin
        $display("subi called");
        reg_RegDst = 2'b00;
        reg_Branch = 1'b0;
        reg_MemRead = 1'b0;
        reg_MemtoReg = 2'b00;
        reg_ALUOp = 2'b11;
        reg_MemWrite = 1'b0;
        reg_ALUSrc = 1'b1;
        reg_RegWrite = 1'b1;
        reg_Jump = 2'b00;
	reg_SignExt=1'b1;
      end


    6'b100011 : // I-type : lw
      begin
        $display("lw called");
        reg_RegDst = 2'b00;
        reg_Branch = 1'b0;
        reg_MemRead = 1'b1;
        reg_MemtoReg = 2'b01;
        reg_ALUOp = 2'b00;
        reg_MemWrite = 1'b0;
        reg_ALUSrc = 1'b1;
        reg_RegWrite = 1'b1;
        reg_Jump = 2'b00;
      end
    6'b101011 : // I-type : sw
      begin
        $display("sw called");
        reg_RegDst = 2'b00;
        reg_Branch = 1'b0;
        reg_MemRead = 1'b0;
        reg_MemtoReg = 2'b??;
        reg_ALUOp = 2'b00;
        reg_MemWrite = 1'b1;
        reg_ALUSrc = 1'b1;
        reg_RegWrite = 1'b1;
        reg_Jump = 2'b00;
	reg_SignExt=1'b1;
      end

    6'b000100 : // I-type : beq 
      begin
        $display("beq called");
        reg_RegDst = 2'b00;
        reg_Branch = 1'b1;
        reg_MemRead = 1'b0;
        reg_MemtoReg = 2'b00;
        reg_ALUOp = 2'b01;
        reg_MemWrite = 1'b0;
        reg_ALUSrc = 1'b0;
        reg_RegWrite = 1'b0;
        reg_Jump = 2'b00;
	reg_SignExt=1'b1;
      end

    6'b000100 : // I-type : bne
      begin
        $display("bne called");
        reg_RegDst = 2'b00;
        reg_Branch = 1'b1;
        reg_MemRead = 1'b0;
        reg_MemtoReg = 2'b00;
        reg_ALUOp = 2'b01;
        reg_MemWrite = 1'b0;
        reg_ALUSrc = 1'b0;
        reg_RegWrite = 1'b0;
        reg_Jump = 2'b00;
	reg_SignExt=1'b1;
      end

    6'b000001 : // I-type : bgez
      begin
        $display("bgez called");
        reg_RegDst = 2'b00;
        reg_Branch = 1'b1;
        reg_MemRead = 1'b0;
        reg_MemtoReg = 2'b00;
        reg_ALUOp = 2'b01;
        reg_MemWrite = 1'b0;
        reg_ALUSrc = 1'b0;
        reg_RegWrite = 1'b0;
        reg_Jump = 2'b00;
	reg_SignExt=1'b1;
      end

    6'b000010 : // j-type : j
      begin
        $display("jump called");
        reg_RegDst = 2'b??;
        reg_Branch = 1'b0;
        reg_MemRead = 1'b0;
        reg_MemtoReg = 2'b??;
        reg_ALUOp = 2'b??;
        reg_MemWrite = 1'b0;
        reg_ALUSrc = 1'b?;
        reg_RegWrite = 1'b0;
        reg_Jump = 2'b01;
      end

    6'b000011 : // j-type : jal
      begin
        $display("jal called");
        reg_RegDst = 2'b10;
        reg_Branch = 1'b0;
        reg_MemRead = 1'b0;
        reg_MemtoReg = 2'b10;
        reg_ALUOp = 2'b??;
        reg_MemWrite = 1'b0;
        reg_ALUSrc = 1'b?;
        reg_RegWrite = 1'b1;
        reg_Jump = 2'b01;
      end

    endcase
  end

  assign InstrtoReg=reg_InstrtoReg;
  assign RegDst = reg_RegDst;
  assign Branch = reg_Branch;
  assign MemRead = reg_MemRead;
  assign MemtoReg = reg_MemtoReg;
  assign ALUOp = reg_ALUOp;
  assign MemWrite = reg_MemWrite;
  assign ALUSrc = reg_ALUSrc;
  assign RegWrite = reg_RegWrite;
  assign Jump = reg_Jump;
  assign SignExt= reg_SignExt;
endmodule
