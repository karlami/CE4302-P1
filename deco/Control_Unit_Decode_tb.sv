`timescale 1ns / 1ps

module Control_Unit_Decode_tb;

    parameter CLK_PERIOD = 10;

    logic clk = 0;
    logic rst = 1;
    logic [4:0] Opcode;
    logic [3:0] ALUOp; 
    logic RegDst; 
    logic ALUSrc; 
    logic MemRead; 
    logic MemWrite; 
    logic MemtoReg; 
    logic RegWrite; 
    logic Branch; 
    logic BranchOp; 
    logic RegSrc1; 
    logic RegSrc2; 
    logic ALUDest; 
    logic Vector_Op; 
    logic PF_op; 
    logic ImmSrc; 
    logic Integer_op;

    // Instanciacion
    Control_Unit_Decode dut (
        .Opcode(Opcode),
        .clk(clk),
        .rst(rst),
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
        .Vector_Op(Vector_Op),
        .PF_op(PF_op),
        .ImmSrc(ImmSrc),
        .Integer_op(Integer_op)
    );

    // Clock generation, square signal
    always #((CLK_PERIOD)/2) clk = ~clk;

    // Test case 1: Opcode 00000 (ADD)
    initial begin
        $display("Test Case 1: Opcode 00000 (ADD)");
        Opcode <= 5'b00000;
        #10;
        assert (ALUOp === 4'b0000) else $fatal("Test Case 1 failed: Unexpected ALUOp value");
        assert (RegDst === 1'b1) else $fatal("Test Case 1 failed: Unexpected RegDst value");
        assert ()
        $display("Test Case 1 passed");
        $finish;
    end

    // Test case 2: Opcode 00000 (ADD)
    initial begin
        $display("Test Case 2:  Opcode 00000 (ADD)");
        Opcode <= 5'b;
        #10;
		  assert ()
        $display("Test Case 2 passed");
        $finish;
    end

endmodule