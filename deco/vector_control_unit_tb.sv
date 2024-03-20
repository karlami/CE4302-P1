`timescale 1ns / 1ps
module vector_control_unit_tb;

    // Inputs
    reg [4:0] Opcode;
    

    // Outputs
    wire [1:0] ALU_Vectorial;
    wire VectDst,Vector_Read,MemWrite_vector,Vect_Write,Vect_Src1,Vect_Src2;

    // Instantiate the unit under test (UUT)
    vector_control_unit dut(
		.Opcode(Opcode),
		.ALU_Vectorial(ALU_Vectorial),
		.VectDst(VectDst),
		.Vector_Read(Vector_Read),
		.MemWrite_vector(MemWrite_vector),
		.Vect_Write(Vect_Write),
		.Vect_Src1(Vect_Src1),
		.Vect_Src2(Vect_Src2)
    );
	 
	  initial begin
        //G2_VADD
        Opcode = 5'b10000;
        #5;
		  //G2_VSUB
		  Opcode = 5'b10001;
        #5;
		  //G2_VMUL
		  Opcode = 5'b10010;
        #5;
		  //G2_VLDR
		  Opcode = 5'b10100;
        #5;
		  //G2_VSTR
		  Opcode = 5'b10101;
        #5;
		  //default
		  Opcode = 5'b11111;
        #5;
		  
		  $finish;

	end			 
		  
endmodule