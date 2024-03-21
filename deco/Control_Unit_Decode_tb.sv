`timescale 1ns / 1ps

module Control_Unit_Decode_tb;

   reg [4:0] Opcode;
    

    // Outputs
    wire [3:0] ALUOp;
    wire RegDst, ALUSrc, MemRead, MemWrite, MemtoReg, RegWrite, Branch, BranchOp, RegSrc1, RegSrc2, ALUDest, PF_op, ImmSrc, Integer_op;

    // Instantiate the unit under test (UUT)
    Control_Unit_Decode dut (
        .Opcode(Opcode),
        .ALUOp(ALUOp),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .Branch(Branch),
        .BranchOp(BranchOp),
        .RegSrc1(RegSrc1),
        .RegSrc2(RegSrc2),
        .ALUDest(ALUDest),
        .PF_op(PF_op),
        .ImmSrc(ImmSrc),
        .Integer_op(Integer_op)
    );

    // Clock generation
  

    initial begin
        // Test case 1: Opcode = 5'b00000 ADD
        Opcode = 5'b00000;
        #10;
		  //Test Cases 
		  // SUB
		  Opcode = 5'b00001;
        #10;
		  //G3_LDR
		  Opcode = 5'b00100;
        #10;
		  
		  
		  //G3_FADD
		  Opcode = 5'b01000;
        #10;
		  //G3_FLDR
		  Opcode = 5'b01100;
        #10;
		 
		 
		  //G3_B
		  Opcode = 5'b11101;
        #10;
		  //Caso DEFAULT	
		  Opcode = 5'b11111;
        #10;
		

        $finish;
    end
endmodule
