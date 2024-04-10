module vector_mux2_1 #(parameter DATA_WIDTH=16,VECTOR_LENGTH=16) (
	input  reg signed [DATA_WIDTH-1:0] d0[VECTOR_LENGTH-1:0],
	input  reg signed  [DATA_WIDTH-1:0] d1[VECTOR_LENGTH-1:0],
	input  reg s,
	output reg signed  [DATA_WIDTH-1:0] out[VECTOR_LENGTH-1:0]
);

generate
	genvar i;
	for (i=0;i<DATA_WIDTH;i++) begin : gen_loop
		assign out[i] = s ? d1[i] : d0[i];
	end
endgenerate

endmodule
