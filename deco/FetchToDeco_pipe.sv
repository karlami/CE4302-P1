 module FetchToDeco_pipe (input logic clk, Reset, input logic [31:0] pc_out, Instr,
					output logic [31:0] pc,
					output logic [4:0] Opcode, //OPCODE, 5 bits
					output logic [6:0] r0, //r0
					output logic [6:0] r1, //r1
					output logic [6:0] r2, //r2
					output logic [18:0] Imm);//Imm

	always_ff@(negedge clk, posedge Reset)
		if(Reset)
			begin
				pc = 0;
				Opcode = 0;
				r0 = 0;
				r1 = 0;
				r2 = 0;
				Imm = 0;
			end
		else 
			begin
				pc_out = pc;
				Opcode = Instr[31:27];
				r0 = Instr[26:20];
				r1 = Instr[19:13];
				r2 = Instr[12:6];
				Imm = Instr[18:0];
			end
endmodule