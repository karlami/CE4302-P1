module Decode_pipe( input logic clk, reset,
	input logic [31:0] RD1In, RD2In, ImmaExtIn, 
	input logic [3:0] WA3In,
	
	input logic PCSrcIn,RegWriteIn,MemtoRegIn,MemWriteIn,ALUSrcIn,FlagWriteIn,
	
	input logic [3:0] Flags_prima,ALUControlIn, CondIn,

	output logic [31:0] PCSrcD,RegWriteD,MemtoRegD,MemWriteD,ALUSrcD,FlagWriteD,
	
	output logic [3:0] Flags_primaOut,
	output logic [2:0] ALUControlD,
	output logic [3:0] CondE,
	
	output logic [31:0] RD1Out,RD2Out, ImmaExtOut, 
	output logic [3:0] WA3Out
);

always_ff@(posedge clk, posedge reset)
	if(reset) begin
		RD1Out = 32'b0;
		RD2Out = 32'b0;
		WA3Out = 4'b0;
		ImmaExtOut = 32'b0;
		
		
		PCSrcD= 0;
		RegWriteD = 0;
		MemtoRegD = 0;
		MemWriteD= 0;
		ALUControlD= 4'b0000;
		ALUSrcD= 0;
		FlagWriteD= 0;
	end
	else begin
		RD1Out = RD1In;
		RD2Out = RD2In;
		WA3Out = WA3In;
		ImmaExtOut = ImmaExtIn;
		
		CondE=CondIn;
		PCSrcD=PCSrcIn;
		RegWriteD=RegWriteIn;
		MemtoRegD=MemtoRegIn;
		MemWriteD=MemWriteIn;
		ALUControlD=ALUControlIn;
		ALUSrcD=ALUSrcIn;
		FlagWriteD=FlagWriteIn;
		Flags_primaOut = Flags_prima;
	end
endmodule