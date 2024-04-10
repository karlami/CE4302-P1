module signExtendImm (
    input reg signed [18:0] in,    // 19-bit immediate value input
    output reg signed [31:0] out   // 32-bit extended output
);

reg signed [31:0] out_aux;

// Sign extension
always @(*) begin
	//out = {{12{in[18]}}, in};  // Repeat the most significant bit of 'in' 12 times and concatenate 'in'
	out_aux[17:0] = in[17:0];
	//out[31:18] = {in[18]};
	for (int i = 18; i < 32; i++) begin
		//Entradas Vector
		out_aux[i] = {in[18]};

	end
end

assign out = out_aux;

endmodule // signExtendImm
