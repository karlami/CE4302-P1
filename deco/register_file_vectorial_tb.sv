`timescale 1ns / 1ps

module register_file_vectorial_tb;

  // Parámetros del módulo
    parameter WIDTH = 32;
    parameter VECTOR_SIZE = 16;
    parameter NUM_VECTORES = 8;

  // Definición de señales
  reg clk;
  reg we3;
  reg [$clog2(NUM_VECTORES)-1:0] v1;
  reg [$clog2(NUM_VECTORES)-1:0] v2;
  reg [$clog2(NUM_VECTORES)-1:0] v3;
  reg [WIDTH-1:0] wd3;
  wire [WIDTH-1:0] vd1[VECTOR_SIZE-1:0];
  wire [WIDTH-1:0] vd2[VECTOR_SIZE-1:0];

  // Instanciación del módulo bajo test
  register_file_vectorial #(
    .WIDTH(WIDTH),
	 .VECTOR_SIZE(VECTOR_SIZE),
    .NUM_VECTORES(NUM_VECTORES)
  ) uut (
    .clk(clk),
    .we3(we3),
    .v1(v1),
    .v2(v2),
    .v3(v3),
    .wd3(wd3),
    .vd1(vd1),
    .vd2(vd2)
  );

  // Generación de clock
  always begin
    #5 clk = ~clk;
  end

  // Test de escritura y lectura
  initial begin
	 clk = 0;
    we3 = 1;
	 v3 =2;
    wd3 = 32'hABCDEFFF; // Dato de escritura
    #10;
	 
	 we3 = 0;
	 v1 = 2;
	 v2 = 1;
	 #10;
	 
	 //Otra escritura
	 we3 = 1;
	 v3 = 4;
	 wd3 = 32'h11111111; // Dato de escritura
	 #10;
	 
	 we3 = 0;
	 v1 = 1;
	 v2 = 4;
	 #10
	 
	 we3 = 0;
	 v1 = 2;
	 v2 = 4;
	 #10
	 
	 //Leer un registro que no esta 
	 we3 = 0;
	 v1 = 7;
	 v2 = 6;
	 #10
	 
    // Fin de la simulación
    $finish;
  end

endmodule
