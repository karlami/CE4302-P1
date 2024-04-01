module Execution #(parameter DATA_WIDTH = 16)(
	input signed [DATA_WIDTH-1:0] A_deco_int,
	input signed [DATA_WIDTH-1:0] B_deco_int,
	input signed [DATA_WIDTH-1:0] A_deco_fixed,
	input signed [DATA_WIDTH-1:0] B_deco_fixed,
	input signed [DATA_WIDTH-1:0] A_deco_vector [DATA_WIDTH-1:0],
	input signed [DATA_WIDTH-1:0] B_deco_vector [DATA_WIDTH-1:0],

	input signed [DATA_WIDTH-1:0] A_ua_int,
	input signed [DATA_WIDTH-1:0] B_ua_int,
	input signed [DATA_WIDTH-1:0] A_ua_fixed,
	input signed [DATA_WIDTH-1:0] B_ua_fixed,
	input signed [DATA_WIDTH-1:0] A_ua_vector [DATA_WIDTH-1:0],
	input signed [DATA_WIDTH-1:0] B_ua_vector [DATA_WIDTH-1:0],

	input reg s_mux_A,
	input reg s_mux_B,

	input logic [4:0] opcode,

	output reg signed [DATA_WIDTH-1:0] Out_int,
	output reg signed [DATA_WIDTH-1:0] Out_fixed,
	output reg signed [DATA_WIDTH-1:0] Out_vector [DATA_WIDTH-1:0],

	output reg N_int,
	output reg V_int,
	output reg Z_int,
	
	output reg N_fixed,
	output reg V_fixed,
	output reg Z_fixed,

	output reg [DATA_WIDTH-1:0] N_vector,
	output reg [DATA_WIDTH-1:0] V_vector,
	output reg [DATA_WIDTH-1:0] Z_vector
);

	reg signed [DATA_WIDTH-1:0] A_int;
	reg signed [DATA_WIDTH-1:0] B_int;
	reg signed [DATA_WIDTH-1:0] A_fixed;
	reg signed [DATA_WIDTH-1:0] B_fixed;
	reg signed [DATA_WIDTH-1:0] A_vector [DATA_WIDTH-1:0];
	reg signed [DATA_WIDTH-1:0] B_vector [DATA_WIDTH-1:0];


	logic [1:0] opcode_int;
	logic [1:0] opcode_fixed;
	logic [1:0] opcode_vector;

	mux2_1 #(.DATA_WIDTH(DATA_WIDTH)) mux_A_int(
		.d0(A_deco_int),
		.d1(A_ua_int),
		.s(s_mux_A),
		.out(A_int)
	);

	mux2_1 #(.DATA_WIDTH(DATA_WIDTH)) mux_B_int(
		.d0(B_deco_int),
		.d1(B_ua_int),
		.s(s_mux_B),
		.out(B_int)
	);

	mux2_1 #(.DATA_WIDTH(DATA_WIDTH)) mux_A_fixed(
		.d0(A_deco_fixed),
		.d1(A_ua_fixed),
		.s(s_mux_A),
		.out(A_fixed)
	);

	mux2_1 #(.DATA_WIDTH(DATA_WIDTH)) mux_B_fixed(
		.d0(B_deco_fixed),
		.d1(B_ua_fixed),
		.s(s_mux_B),
		.out(B_fixed)
	);

	vector_mux2_1 #(.DATA_WIDTH(DATA_WIDTH), .VECTOR_LENGTH(DATA_WIDTH)) mux_A_vector(
		.d0(A_deco_vector),
		.d1(A_ua_vector),
		.s(s_mux_A),
		.out(A_vector)
	);

	vector_mux2_1 #(.DATA_WIDTH(DATA_WIDTH), .VECTOR_LENGTH(DATA_WIDTH)) mux_B_vector(
		.d0(B_deco_vector),
		.d1(B_ua_vector),
		.s(s_mux_B),
		.out(B_vector)
	);
	
	/*

	ALU_Integer #(.DATA_WIDTH(DATA_WIDTH)) alu_int(
		.A(A_int),
		.B(B_int),
		.opcode(opcode_int),
		.Out(Out_int),
		.N(N_int),
		.V(V_int),
		.Z(Z_int)
	);

	ALU_FixedPoint #(.DATA_WIDTH(DATA_WIDTH)) alu_fixed(
		.A(A_fixed),
		.B(B_fixed),
		.opcode(opcode_fixed),
		.Out(Out_fixed),
		.N(N_fixed),
		.V(V_fixed),
		.Z(Z_fixed)
	);
	
	ALU_Vector #(.DATA_WIDTH(DATA_WIDTH)) alu_vector(
		.A(A_vector),
		.B(B_vector),
		.opcode(opcode_vector),
		.Out(Out_vector),
		.N(N_vector),
		.V(V_vector),
		.Z(Z_vector)
	);
	*/

	//ALU operations
	always_comb begin
		case (opcode)
			//Integer Cases
			5'b00000: begin // ADD operation\
				opcode_int    = 2'b00;
				opcode_fixed  = 2'b11;
				opcode_vector = 2'b11;
			end
			5'b00001: begin // SUB operation\
				opcode_int    = 2'b01;
				opcode_fixed  = 2'b11;
				opcode_vector = 2'b11;
			end
			5'b00010: begin // MUL operation
				opcode_int    = 2'b10;
				opcode_fixed  = 2'b11;
				opcode_vector = 2'b11;
			end
			
			//Fixed Cases
			5'b01000: begin // ADD operation\
				opcode_fixed  = 2'b00;
				opcode_int    = 2'b11;
				opcode_vector = 2'b11;
			end
			5'b01001: begin // SUB operation
				opcode_fixed  = 2'b00;
				opcode_int    = 2'b11;
				opcode_vector = 2'b11;
			end
			5'b01010: begin // MUL operation
				opcode_fixed  = 2'b00;
				opcode_int    = 2'b11;
				opcode_vector = 2'b11;
			end
			
			//Vectorial Cases
			5'b10000: begin // ADD operation
				opcode_vector = 2'b00;
				opcode_int    = 2'b11;
				opcode_fixed  = 2'b11;
			end
			5'b10001: begin // SUB operation
				opcode_vector = 2'b01;
				opcode_int    = 2'b11;
				opcode_fixed  = 2'b11;
			end
			5'b10010: begin // MUL operation
				opcode_vector = 2'b10;
				opcode_int    = 2'b11;
				opcode_fixed  = 2'b11;
			end
			default: begin // Unsupported operation
				opcode_int    = 2'b11;
				opcode_fixed  = 2'b11;
				opcode_vector = 2'b11;
			end
			//for (int i = 0; i < NUM_LANES; i++)
			
		endcase
	end
endmodule
