// Modelsim-ASE requires a timescale directive
// vsim work.tb_fetch -Lf altera_mf_ver

`timescale 1 ps / 1 ps

module tb_fetch #(parameter WORD_LEN = 32, MEM_CELL_SIZE = 8) ();

	logic clk; 
	logic brTaker;
	logic getInstruction;
	logic [WORD_LEN-1:0] brOffset;
	logic [MEM_CELL_SIZE-1:0] oldPC;
	logic [MEM_CELL_SIZE-1:0] newPC;
	logic [WORD_LEN-1:0] instruction;
	//logic [WORD_LEN-1:0] instructionExpected;

	FetchStage #(.WORD_LEN(WORD_LEN), .MEM_CELL_SIZE(MEM_CELL_SIZE)) UUT ( clk,  brTaker, getInstruction, brOffset, oldPC, newPC, instruction);
	
	always #1 clk =~ clk;
	//always #3 getInstruction =~ getInstruction;
	

	initial begin 
		// CASO 1:
		// Salida del mux = 0 
		// Salida del adder = 0
		// newPC = 0
		// Instruccion = 1
		clk = 0;
		brTaker = 0;
		getInstruction = 0;
		brOffset = 0;
		oldPC = 0;


		#2
		getInstruction = 1;
		
		#2
		getInstruction = 0;
		
//		brTaker = 0;
//		// CASO 2: 
//		// Salida del mux = 4 
//		// Salida del adder = 4
//		// newPC = 4
//		// Instruccion = 2
//		
//	
	
		#6
		getInstruction = 1;
		brTaker = 1;
		brOffset = 16;
		// CASO 3: 
		// Salida del mux = 16 
		// Salida del adder = 16
		// newPC = 4
		// Instruccion = 2
//		
//		#2
//		brTaker = 0;
		
		
		
		// Salida del mux
//		// Inicializacion de variables
//		rst = 0;
//		brTaken = 0;
//		brOffset = 8'b0;
//		pc = 8'd0;
//		instructionExpected = 8'h01;
//		
//		#10;
//		assert (instruction == instructionExpected) 
//				$display ($sformatf("Exito para pc = %b", pc));
//			else $error($sformatf("Fallo para pc = %b, instruction = %b y instructionExpected = %b", pc, instruction, instructionExpected));
//		
//		// Caso 2: PC = 4
//		$display("PC = 4");
//		// Inicializacion de variables
//		rst = 0;
//		brTaken = 0;
//		brOffset = 8'b0;
//		pc = 8'd4;
//		instructionExpected = 8'h02;
//		
//		#10;
//		assert (instruction == instructionExpected) 
//				$display ($sformatf("Exito para pc = %b", pc));
//			else $error($sformatf("Fallo para pc = %b, instruction = %b y instructionExpected = %b", pc, instruction, instructionExpected));
//			
//		// Caso 3: PC = 8
//		$display("PC = 4");
//		// Inicializacion de variables
//		rst = 0;
//		brTaken = 0;
//		brOffset = 8'b0;
//		pc = 8'd8;
//		instructionExpected = 8'h03;
//		
//		#10;
//		assert (instruction == instructionExpected) 
//				$display ($sformatf("Exito para pc = %b", pc));
//			else $error($sformatf("Fallo para pc = %b, instruction = %b y instructionExpected = %b", pc, instruction, instructionExpected));
//			
//		// Caso 4: PC = 12
//		$display("PC = 4");
//		// Inicializacion de variables
//		rst = 0;
//		brTaken = 0;
//		brOffset = 8'b0;
//		instructionExpected = 8'h04;
//		
//		#10
//		assert (instruction == instructionExpected) 
//				$display ($sformatf("Exito para pc = %b", pc));
//			else $error($sformatf("Fallo para pc = %b, instruction = %b y instructionExpected = %b", pc, instruction, instructionExpected));
//		// Caso 5: rst = 1
//		$display("rst = 1");
//		// Inicializacion de variables
//		rst = 1;
//		brTaken = 0;
//		brOffset = 8'b0;
//		pc = 8'd12;
//		instructionExpected = 8'h00;
//		
//		#10
//		assert (instruction == instructionExpected) 
//				$display ($sformatf("Exito para pc = %b", pc));
//			else $error($sformatf("Fallo para pc = %b, instruction = %b y instructionExpected = %b", pc, instruction, instructionExpected));
//		
	end
	
endmodule
