`timescale 1ns / 1ps

module register_file_escalar_tb;
	parameter REGISTERS = 32;
	parameter WIDTH = 32;
	logic clk;
	logic we3;
	logic [$clog2(REGISTERS)-1:0] a1;
	logic [$clog2(REGISTERS)-1:0] a2;
	logic [$clog2(REGISTERS)-1:0] a3;
	logic [WIDTH-1:0] wd3;
	logic [WIDTH-1:0] rd1;
	logic [WIDTH-1:0] rd2;

	register_file_escalar #(
		.REGISTERS(REGISTERS),
		.WIDTH(WIDTH)
	) dut (
		.clk(clk),
		.we3(we3),
		.a1(a1),
		.a2(a2),
		.a3(a3),
		.wd3(wd3),
		.rd1(rd1),
		.rd2(rd2)
	);

	always #5 clk = ~clk;

	initial begin
		clk = 0;
		we3 = 1;
		a3 = 5;
		wd3 = 32'hABCDEFFF; // Dato de escritura
		#10;
		
		// Lectura de a1 = 5 y a2 = 10
		we3 = 0;
		a1 = 5;
		a2 = 10;
		#10;
		
		//Otra escritura
		we3 = 1;
		a3 = 1;
		wd3 = 32'h11111111; // Dato de escritura
		#10;
		
		//Otra lectura
		we3 = 0;
		a1 = 1;
		a2 = 5;
		#10
		
		
		$finish;
	end

endmodule
