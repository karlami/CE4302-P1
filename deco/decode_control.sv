module decode_control(input logic Instrtype, Src2Type, WriteDest,
	input logic [2:0] Instr,
	output logic FlagW, PCS, RegW, MemW, MemtoReg, ALUSrc,
	output logic [1:0] ImmaSrc,
	output logic [2:0] ALUControl,
	output logic [3:0] Cond
	
);


assign PCS = Instrtype;
assign ALUSrc = Src2Type;

always_comb 
	if (Instrtype==0) begin // Not a branch
		 RegW = (Instr != 3'b110) ? ~WriteDest:0;
		 MemW = (Instr != 3'b110) ? WriteDest:0;
		 MemtoReg = (Instr == 3'b101) ? 1:0;	
		 FlagW = (Instr == 3'b000 || Instr == 3'b001 || Instr == 3'b110) ? 1:0;
		 Cond = 4'b1110; // No condition
		 ImmaSrc = (Instr == 3'b100) ? 2'b01:2'b00;
	end
	else begin // Branch
		RegW = 0;
		MemW = 0;
		FlagW = 0;
		MemtoReg = 0;
		case(Instr)
			3'b001: Cond = 4'b1110; // No cond Branch
			3'b010: Cond = 4'b1011; //Less Than Branch
			default: Cond = 4'b1110;
		endcase
		ImmaSrc = 2'b10;
	end


	
always_comb 
if (Instrtype == 0) begin
	case(Instr)
		3'b000: ALUControl = 3'b000; // Instr ADD ALU ADD
		3'b001: ALUControl = 3'b010; // Intsr MULT ALU MULT
		3'b010: ALUControl = 3'b100; // Instr LSL ALU LSL
		3'b011: ALUControl = 3'b011; // Instr LSR ALU LSR
		3'b100: ALUControl = 3'b000; // Instr STR ALU ADD
		3'b101: ALUControl = 3'b000; // Instr LD ALU ADD
		3'b110: ALUControl = 3'b001; // Instr CMP ALU SUB
		3'b111: ALUControl = (Src2Type == 0) ? 3'b101:3'b110; // Instr MOV ALU PASSA/PASSB
		default: ALUControl = 3'bx; // unimplemented
	endcase
end
else ALUControl = 3'b110; // Instr Branch ALU PASSB


endmodule