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
		  assert (RegDst == 1 && RegSrc1 == 1'b1 && RegSrc2 == 1'b1 && ALUOp == 4'b0000 && ALUSrc == 0 && MemRead == 0 && MemWrite == 0 && MemtoReg == 0 && RegWrite == 0 && Branch == 0 
		  && BranchOp == 1'b0 && ALUDest== 1'b1 && PF_op == 1'b0 && ImmSrc == 1'b0 && Integer_op == 1'b1) $display("Exito en decodificar caso 1 ");
	     else $error("Fallo la unidad de control");
		  
		  //G3_LDR
		  Opcode = 5'b00100;
        #10;
		  
		  assert(RegDst == 1 && RegSrc1 == 1'b1 && RegSrc2 == 1'b1 && ALUOp == 4'b0100 && ALUSrc == 0 && MemRead == 1 && MemWrite == 0 && MemtoReg == 1			
		  && RegWrite == 1 && Branch == 0 && BranchOp == 1'b0 && ALUDest== 1'b1 && PF_op == 1'b0 && ImmSrc == 1'b0 && Integer_op == 1'b1) $display("Exito en decodificar caso 2 ");
		  else $error("Fallo la unidad de control");
		  
		  //G3_FADD
		  Opcode = 5'b01000;
        #10;
		 
		 assert(RegDst == 1	
				&& RegSrc1 == 1'b1
				&& RegSrc2 == 1'b1
				&& ALUOp == 4'b0000 	
				&& ALUSrc == 0 	 				
				&& MemRead == 0			
				&& MemWrite == 0			
				&& MemtoReg == 0			
				&& RegWrite == 0		
				&& Branch == 0			
				&& BranchOp == 1'b0 	 		
				&& ALUDest== 1'b1			
				&& PF_op == 1'b1
				&& ImmSrc == 1'b0
				&& Integer_op == 1'b0) $display("Exito en decodificar caso 3 ");
		  else $error("Fallo la unidad de control");
		 
		  //G3_B
		  Opcode = 5'b11101;
        #10;
		  
		 assert( RegDst == 1		
				&& RegSrc1 == 1'b1
				&& RegSrc2 == 1'b1
				&& ALUOp == 4'b0100 	
				&& ALUSrc == 0 	 		
				&& MemRead == 0				
				&& MemWrite == 0			
				&& MemtoReg == 0			
				&& RegWrite == 0		
				&& Branch == 0			
				&& BranchOp == 1'b0 	
				&& ALUDest== 1'b1		
				&& PF_op == 1'b0
				&& ImmSrc == 1'b0
				&& Integer_op == 1'b0)$display("Exito en decodificar caso 4 ");
		  else $error("Fallo la unidad de control");
		  

		

        $finish;
    end
endmodule
