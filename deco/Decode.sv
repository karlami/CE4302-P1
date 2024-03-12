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

	// 19 bits o 27
  signExtendImm signExtend_I(
    .in(instruction[18:0]),
    .out(signExt_Imm)
  );

  // rango de bits de la instruccion para registro dest
  assign dest = instruction[n:b];
endmodule // Decode_Stage