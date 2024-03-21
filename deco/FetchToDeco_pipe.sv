 module FetchToDeco_pipe (input logic clk, Reset, input logic [31:0] pc_out, Instr,
					output logic [31:0] pc,
					output logic [31:0] intr_out);//32 bit instruction

	always_ff@(negedge clk, posedge Reset)
		if(Reset)
			begin
				pc = 0;
				Instr = 0;
			end
		else 
			begin
				pc_out = pc;
				intr_out = Instr;

			end
endmodule