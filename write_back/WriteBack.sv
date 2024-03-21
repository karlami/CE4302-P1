module WriteBack #(WIDTH=16,VECTOR_LENGTH=16) (
	input logic [WIDTH-1:0] mem_out_vector[VECTOR_LENGTH-1:0],
	input logic [WIDTH-1:0] alu_out_vector[VECTOR_LENGTH-1:0],
	input logic [WIDTH-1:0] mem_out_scalar,
	input logic [WIDTH-1:0] alu_out_scalar,
	input logic [3:0]register_Write,
	input logic vecop,aluop,
	
	output logic [WIDTH-1:0] out_vector[VECTOR_LENGTH-1:0],
	output logic [WIDTH-1:0] out_scalar,
	output logic outvecop);
	
	vector_mux2_1 #(.WIDTH(WIDTH), .VECTOR_LENGTH(VECTOR_LENGTH)) mux_vec(mem_out_vector,alu_out_vector,aluop,out_vector);

	mux2_1 #(.WIDTH(WIDTH)) mux_esc(mem_out_scalar,alu_out_scalar,aluop,out_scalar);
	
	assign outvecop=vecop;

endmodule
