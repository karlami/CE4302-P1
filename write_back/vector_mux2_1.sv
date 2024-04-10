module vector_mux2_1 #(parameter WIDTH=16,VECTOR_LENGTH=16) (
	input logic [WIDTH-1:0] d0[VECTOR_LENGTH-1:0],
	input logic [WIDTH-1:0] d1[VECTOR_LENGTH-1:0],
	input logic s,
	output logic [WIDTH-1:0] out[VECTOR_LENGTH-1:0]
);

generate
	genvar i;
	for (i=0;i<WIDTH;i++) begin : gen_loop
		assign out[i] = s ? d1[i] : d0[i];
	end
endgenerate

endmodule