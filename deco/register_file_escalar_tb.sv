`timescale 1ns / 1ps

module register_file_escalar_tb;
	parameter REGISTERS = 16;
	parameter WIDTH = 16;
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
		wd3 = 16'hABCD; // Dato de escritura
		#10;
		
		
		// Lectura de a1 = 5 y a2 = 10
		we3 = 0;
		a1 = 5;
		a2 = 10;
		#10;
		

		assert (rd1 == 16'hABCD) $display($sformatf("Exito el valor de RD1= %h",rd1));
		else $error("Fallo en el registro escalar");
		
		
		//Otra escritura
		we3 = 1;
		a3 = 1;
		wd3 = 16'h1111; // Dato de escritura
		#10;
		
		//Otra lectura
		we3 = 0;
		a1 = 1;
		a2 = 5;
		#10
		assert (rd1 == 16'h1111 && rd2 ==16'hABCD) $display($sformatf("Exito para RD1 = %h, RD2 = %h",rd1,rd2));
		else $error("Fallo en el registro escalar");
		
		
		$finish;
	end

endmodule
