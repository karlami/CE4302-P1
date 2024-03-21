`timescale 1ns / 10ps  // Definición de la escala de tiempo

module tb_fractional_add;

    // Parameters
    parameter DATA_WIDTH = 8;
    parameter DELAY = 10; // Delay between inputs in simulation steps

    // Inputs
    reg [DATA_WIDTH-1:0] A;
    reg [DATA_WIDTH-1:0] B;

    // Outputs
    reg [DATA_WIDTH-1:0] Out;
    reg [DATA_WIDTH-1:0] OutExpected;

    // Instanciar el modulo de suma
    fractional_add #(DATA_WIDTH)  test (
        .A(A),
        .B(B),
        .Out(Out)
	 );


    // Test input generation
	 initial 
	 begin
		
		A	 = 0;
		B	 = 0;
		Out = 0;
		
		//Caso suma sin carry
		//               FFFFFFFF
		A 				= 8'b01000000; //0,25
		B 				= 8'b00100000; //0,125
		OutExpected = 8'b01100000; //0,375
		
		#DELAY
		
		assert (Out == OutExpected) 
			$display ($sformatf("Exito para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso suma con carry que no se propaga
		//               FFFFFFFF
		A 				= 8'b10100000; //0,625
		B 				= 8'b00100000; //0,125
		OutExpected = 8'b11000000; //0,750
		
		#DELAY
		
		assert (Out == OutExpected) 
			$display ($sformatf("Exito para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		
		//Caso suma con carry que se propaga
		//               FFFFFFFF
		A 				= 8'b00100000; //0,125
		B 				= 8'b01100000; //0,375
		OutExpected = 8'b10000000; //0,5
		
		#DELAY
		
		assert (Out == OutExpected) 
			$display ($sformatf("Exito para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
      
    end

endmodule
