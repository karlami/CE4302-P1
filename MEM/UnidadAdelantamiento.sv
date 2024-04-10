module UnidadAdelantamiento(
	input logic [3:0] registerload,registerALU_A,registerALU_B,
	input logic load,
	output logic AdelantamientoA,AdelantamientoB
	);
	assign AdelantamientoA = (load&&(registerALU_A == registerload)) ? 1 : 0;
	assign AdelantamientoB = (load&&(registerALU_B == registerload)) ? 1 : 0;
	
endmodule
