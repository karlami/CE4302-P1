// Operaciones no vectoriales empiezan con 0
// Vectoriales empiezan con 1

module Decode (instruction, x, b, _x, _b, y);
  input logic [31:0] instruction; 
  input logic [6:0] x, b;
  output logic [6:0] _x, _b;
  output logic [6:0] y;


  _mux #() mux_x (
    
	 .in1(instruction[n:b]),
    .in2(instruction[n:b]),
    .sel(),
    .out(_x)
  );
  
  _mux #() mux_b (
 
	 .in1(instruction[n:b]),
	 .in2(instruction[n:b]),
	 .sel(),
	 .out(_b)
);

  vector_control_unit vcu(
	 .Opcode(instruction[31:26]),
	 .ALU_Vectorial(), 
	 .VectDst(),
	 .Vector_Read(),
	 .MemWrite_vector(),
	 .Vect_Write(),
	 .Vect_Src1(),
	 .Vect_Src2()
  );
  
  Control_Unit_Decode cud(
	 .Opcode(),
	 .ALUOp(), 
	 .RegDst(),
	 .ALUSrc(),
	 .MemRead(),
	 .MemWrite(),
	 .MemtoReg(),
	 .RegWrite(),
	 .Branch(),
	 .BranchOp(),
	 .RegSrc1(),
	 .RegSrc2(),
	 .ALUDest(),
	 .PF_op(),
	 .ImmSrc(),
	 .Integer_op()
  );
  


	// 19 bits o 27
  signExtendImm signExtend_I(
    .in(instruction[18:0]),
    .out(signExt_Imm)
  );

  // rango de bits de la instruccion para registro dest
  assign dest = instruction[n:b];
endmodule // Decode_Stage