// Modelsim-ASE requires a timescale directive
// vsim  -L altera_mf_ver work.tb_getInstruction

`timescale 1 ps / 1 ps

module tb_getInstruction();

logic[7:0] a;
logic[31:0] d;
logic clk, getInstruction;

getInstruction UUT(clk,getInstruction, a,d);

always #1 clk =~ clk;
always #2 getInstruction =~ getInstruction;

initial begin 
	$display("Instruction memory TB...");
	clk =0;
	getInstruction = 0;
	a = 0;
	
	#4
	a = 4;
	
	#4
	a = 8;


end
endmodule


