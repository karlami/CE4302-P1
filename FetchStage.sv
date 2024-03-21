
module FetchStage #(parameter WORD_LEN = 32, MEM_CELL_SIZE = 8)
(
	input logic clk,
	input logic brTaker,
	input logic getInstruction,
	input logic [WORD_LEN-1:0] brOffset,
	input logic [MEM_CELL_SIZE-1:0] oldPC,
	output logic [MEM_CELL_SIZE-1:0] newPC,
	output logic [WORD_LEN-1:0] instruction
);


	logic [WORD_LEN-1:0] four = 4;
	logic [WORD_LEN-1:0] adderIn1;
	


//	fetch_mux #(.N(MEM_CELL_SIZE)) adderInput ( 
//		 .op1(four),
//		 .op2(brOffset),
//		 .sel(brTaker),
//		 .out(adderIn1)
//	  );
//	 
	  
	 fetch_adder #(.N(MEM_CELL_SIZE)) adder (
		.op1(oldPC),
		.op2(brOffset),
		.sel(brTaker),
		.out(newPC)
	 );
	  

	 getInstruction instruction_mem (
		.clk(clk),
		.getInstruccion(getInstruction),
		.address(newPC),
		.data(instruction)
	 );
	  
	 

endmodule

// Cambios rst, oldPC y newPC