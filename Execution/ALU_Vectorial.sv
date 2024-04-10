//Se define un tamaño de 16 para poder manejar numeros de punto fijo del tipo Q7.8
module ALU_Vectorial #(parameter DATA_WIDTH = 16)( 
	input reg signed [DATA_WIDTH-1:0] A [DATA_WIDTH-1:0],
	input reg signed [DATA_WIDTH-1:0] B [DATA_WIDTH-1:0],
	input reg [1:0] opcode,
	output reg signed [DATA_WIDTH-1:0] Out [DATA_WIDTH-1:0],
	output reg C [DATA_WIDTH-1:0], //Carry de fraccional a entero
	output reg N [DATA_WIDTH-1:0], //Negativo
	output reg V [DATA_WIDTH-1:0], //Overflow
	output reg Z [DATA_WIDTH-1:0]  //Zero
);

	ALU_FixedPoint #(.DATA_WIDTH(DATA_WIDTH)) V15(
	.A(A[DATA_WIDTH-1]),
	.B(B[DATA_WIDTH-1]),
	.opcode(opcode),
	.Out(Out[DATA_WIDTH-1]),
	.C(C[DATA_WIDTH-1]),
	.N(N[DATA_WIDTH-1]),
	.V(V[DATA_WIDTH-1]),
	.Z(Z[DATA_WIDTH-1])
	);
	
	ALU_FixedPoint #(.DATA_WIDTH(DATA_WIDTH)) V14(
	.A(A[DATA_WIDTH-2]),
	.B(B[DATA_WIDTH-2]),
	.opcode(opcode),
	.Out(Out[DATA_WIDTH-2]),
	.C(C[DATA_WIDTH-2]),
	.N(N[DATA_WIDTH-2]),
	.V(V[DATA_WIDTH-2]),
	.Z(Z[DATA_WIDTH-2])
	);
	
	ALU_FixedPoint #(.DATA_WIDTH(DATA_WIDTH)) V13(
	.A(A[DATA_WIDTH-3]),
	.B(B[DATA_WIDTH-3]),
	.opcode(opcode),
	.Out(Out[DATA_WIDTH-3]),
	.C(C[DATA_WIDTH-3]),
	.N(N[DATA_WIDTH-3]),
	.V(V[DATA_WIDTH-3]),
	.Z(Z[DATA_WIDTH-3])
	);
	
	ALU_FixedPoint #(.DATA_WIDTH(DATA_WIDTH)) V12(
	.A(A[DATA_WIDTH-4]),
	.B(B[DATA_WIDTH-4]),
	.opcode(opcode),
	.Out(Out[DATA_WIDTH-4]),
	.C(C[DATA_WIDTH-4]),
	.N(N[DATA_WIDTH-4]),
	.V(V[DATA_WIDTH-4]),
	.Z(Z[DATA_WIDTH-4])
	);
	
	ALU_FixedPoint #(.DATA_WIDTH(DATA_WIDTH)) V11(
	.A(A[DATA_WIDTH-5]),
	.B(B[DATA_WIDTH-5]),
	.opcode(opcode),
	.Out(Out[DATA_WIDTH-5]),
	.C(C[DATA_WIDTH-5]),
	.N(N[DATA_WIDTH-5]),
	.V(V[DATA_WIDTH-5]),
	.Z(Z[DATA_WIDTH-5])
	);
	
	ALU_FixedPoint #(.DATA_WIDTH(DATA_WIDTH)) V10(
	.A(A[DATA_WIDTH-6]),
	.B(B[DATA_WIDTH-6]),
	.opcode(opcode),
	.Out(Out[DATA_WIDTH-6]),
	.C(C[DATA_WIDTH-6]),
	.N(N[DATA_WIDTH-6]),
	.V(V[DATA_WIDTH-6]),
	.Z(Z[DATA_WIDTH-6])
	);
	
	ALU_FixedPoint #(.DATA_WIDTH(DATA_WIDTH)) V09(
	.A(A[DATA_WIDTH-7]),
	.B(B[DATA_WIDTH-7]),
	.opcode(opcode),
	.Out(Out[DATA_WIDTH-7]),
	.C(C[DATA_WIDTH-7]),
	.N(N[DATA_WIDTH-7]),
	.V(V[DATA_WIDTH-7]),
	.Z(Z[DATA_WIDTH-7])
	);
	
	ALU_FixedPoint #(.DATA_WIDTH(DATA_WIDTH)) V08(
	.A(A[DATA_WIDTH-8]),
	.B(B[DATA_WIDTH-8]),
	.opcode(opcode),
	.Out(Out[DATA_WIDTH-8]),
	.C(C[DATA_WIDTH-8]),
	.N(N[DATA_WIDTH-8]),
	.V(V[DATA_WIDTH-8]),
	.Z(Z[DATA_WIDTH-8])
	);
	
	ALU_FixedPoint #(.DATA_WIDTH(DATA_WIDTH)) V07(
	.A(A[DATA_WIDTH-9]),
	.B(B[DATA_WIDTH-9]),
	.opcode(opcode),
	.Out(Out[DATA_WIDTH-9]),
	.C(C[DATA_WIDTH-9]),
	.N(N[DATA_WIDTH-9]),
	.V(V[DATA_WIDTH-9]),
	.Z(Z[DATA_WIDTH-9])
	);
	
	ALU_FixedPoint #(.DATA_WIDTH(DATA_WIDTH)) V06(
	.A(A[DATA_WIDTH-10]),
	.B(B[DATA_WIDTH-10]),
	.opcode(opcode),
	.Out(Out[DATA_WIDTH-10]),
	.C(C[DATA_WIDTH-10]),
	.N(N[DATA_WIDTH-10]),
	.V(V[DATA_WIDTH-10]),
	.Z(Z[DATA_WIDTH-10])
	);
	
	ALU_FixedPoint #(.DATA_WIDTH(DATA_WIDTH)) V05(
	.A(A[DATA_WIDTH-11]),
	.B(B[DATA_WIDTH-11]),
	.opcode(opcode),
	.Out(Out[DATA_WIDTH-11]),
	.C(C[DATA_WIDTH-11]),
	.N(N[DATA_WIDTH-11]),
	.V(V[DATA_WIDTH-11]),
	.Z(Z[DATA_WIDTH-11])
	);
	
	ALU_FixedPoint #(.DATA_WIDTH(DATA_WIDTH)) V04(
	.A(A[DATA_WIDTH-12]),
	.B(B[DATA_WIDTH-12]),
	.opcode(opcode),
	.Out(Out[DATA_WIDTH-12]),
	.C(C[DATA_WIDTH-12]),
	.N(N[DATA_WIDTH-12]),
	.V(V[DATA_WIDTH-12]),
	.Z(Z[DATA_WIDTH-12])
	);
	
	ALU_FixedPoint #(.DATA_WIDTH(DATA_WIDTH)) V03(
	.A(A[DATA_WIDTH-13]),
	.B(B[DATA_WIDTH-13]),
	.opcode(opcode),
	.Out(Out[DATA_WIDTH-13]),
	.C(C[DATA_WIDTH-13]),
	.N(N[DATA_WIDTH-13]),
	.V(V[DATA_WIDTH-13]),
	.Z(Z[DATA_WIDTH-13])
	);
	
	ALU_FixedPoint #(.DATA_WIDTH(DATA_WIDTH)) V02(
	.A(A[DATA_WIDTH-14]),
	.B(B[DATA_WIDTH-14]),
	.opcode(opcode),
	.Out(Out[DATA_WIDTH-14]),
	.C(C[DATA_WIDTH-14]),
	.N(N[DATA_WIDTH-14]),
	.V(V[DATA_WIDTH-14]),
	.Z(Z[DATA_WIDTH-14])
	);
	
	ALU_FixedPoint #(.DATA_WIDTH(DATA_WIDTH)) V01(
	.A(A[DATA_WIDTH-15]),
	.B(B[DATA_WIDTH-15]),
	.opcode(opcode),
	.Out(Out[DATA_WIDTH-15]),
	.C(C[DATA_WIDTH-15]),
	.N(N[DATA_WIDTH-15]),
	.V(V[DATA_WIDTH-15]),
	.Z(Z[DATA_WIDTH-15])
	);
	
	ALU_FixedPoint #(.DATA_WIDTH(DATA_WIDTH)) V00(
	.A(A[DATA_WIDTH-16]),
	.B(B[DATA_WIDTH-16]),
	.opcode(opcode),
	.Out(Out[DATA_WIDTH-16]),
	.C(C[DATA_WIDTH-16]),
	.N(N[DATA_WIDTH-16]),
	.V(V[DATA_WIDTH-16]),
	.Z(Z[DATA_WIDTH-16])
	);

endmodule
