module getInstruction(
    input clk,
    input getInstruccion,
    input [7:0] address,
    output logic [31:0] data
);

	logic [31:0] temp_data = 0;
	
   instruction_memory ROM (
		.address(address),
      .clock(clk),
      .q(temp_data)
   );
	 

    always @* begin
        if (getInstruccion == 1) begin
            data = temp_data;
        end
    end

endmodule
