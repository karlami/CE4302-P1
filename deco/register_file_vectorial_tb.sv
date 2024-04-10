`timescale 1ns / 1ps

module register_file_vectorial_tb;

  // Parámetros del módulo
    parameter WIDTH = 16;
    parameter VECTOR_SIZE = 16;
    parameter NUM_VECTORES = 8;

  // Definición de señales
  reg clk;
  reg we3;
  reg [$clog2(NUM_VECTORES)-1:0] v1;
  reg [$clog2(NUM_VECTORES)-1:0] v2;
  reg [$clog2(NUM_VECTORES)-1:0] v3;
  reg [WIDTH-1:0] wd3[VECTOR_SIZE-1:0];
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
    wd3[0] = 16'hABCD;
	 wd3[1] = 16'hABCD;
	 wd3[2] = 16'hABCD;
	 wd3[3] = 16'hABCD;
	 wd3[4] = 16'hABCD;
	 wd3[5] = 16'hABCD;
	 wd3[6] = 16'hABCD;
	 wd3[7] = 16'hABCD;
	 wd3[8] = 16'hABCD;
	 wd3[9] = 16'hABCD;
	 wd3[10] = 16'hABCD;
	 wd3[11] = 16'hABCD;
	 wd3[12] = 16'hABCD;
	 wd3[13] = 16'hABCD;
	 wd3[14] = 16'hABCD;
	 wd3[15] = 16'hABCD;
    #10;
	 
	 we3 = 0;
	 v1 = 2;
	 v2 = 1;
	 #10;
	 
	 assert (vd1[0] == 16'hABCD && vd1[10] == 16'hABCD && vd1[15] == 16'hABCD ) $display($sformatf("Exito el valor de VD1= %p",vd1));
	 else $error("Fallo en el registro vectorial");
	 
	 //Otra escritura
	 we3 = 1;
	 v3 = 4;
	 wd3[0] = 16'h1111;
	 wd3[1] = 16'h1111;
	 wd3[2] = 16'h1111;
	 wd3[3] = 16'h1111;
	 wd3[4] = 16'h1111;
	 wd3[5] = 16'h1111;
	 wd3[6] = 16'h1111;
	 wd3[7] = 16'h1111;
	 wd3[8] = 16'h1111;
	 wd3[9] = 16'h1111;
	 wd3[10] = 16'h1111;
	 wd3[11] = 16'h1111;
	 wd3[12] = 16'h1111;
	 wd3[13] = 16'h1111;
	 wd3[14] = 16'h1111;
	 wd3[15] = 16'h1111;// Dato de escritura
	 #10;
	 
	 
	 we3 = 0;
	 v1 = 2;
	 v2 = 4;
	 #10
	 
	 assert (vd1[0] == 16'hABCD && vd1[10] == 16'hABCD && vd1[15] == 16'hABCD && vd2[0] == 16'h1111 && vd2[10] == 16'h1111 && vd2[15] == 16'h1111) $display($sformatf("Exito el valor de VD1= %p, VD2 = %p ",vd1,vd2));
	 else $error("Fallo en el registro vectorial");
	 
	 //Leer un registro que no esta 
	 we3 = 0;
	 v1 = 7;
	 v2 = 6;
	 #10
	 
    // Fin de la simulación
    $finish;
  end

endmodule
