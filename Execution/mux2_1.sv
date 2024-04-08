module mux2_1 #(parameter DATA_WIDTH = 16) (
	input  reg signed [DATA_WIDTH-1:0] d0,d1,
	input  reg s,
	output reg signed [DATA_WIDTH-1:0] out
);
													
	assign out = s ? d1 : d0;
	
	
endmodule
