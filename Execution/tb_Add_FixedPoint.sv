`timescale 1ns / 10ps  // Definición de la escala de tiempo

module tb_Add_FixedPoint;

    // Parameters
    parameter DATA_WIDTH = 16;
    parameter DELAY = 10; // Delay between inputs in simulation steps

    // Inputs
    reg signed [DATA_WIDTH-1:0] A;
    reg signed [DATA_WIDTH-1:0] B;

    // Outputs
    reg signed [DATA_WIDTH-1:0] Out;
    reg signed [DATA_WIDTH-1:0] OutExpected;
	 reg N, NExpected, V, VExpected, Z,ZExpected;

    // Instanciar el modulo de suma
    Add_FixedPoint #(DATA_WIDTH)  Add (
        .A(A),
        .B(B),
        .Out(Out),
        .N(N),
        .V(V),
        .Z(Z)
	 );

    // Clock generation
    //logic clk = 0;
    //always #5 clk = ~clk;

    // Test input generation
	 initial 
	 begin
		
		A	 = 0;
		B	 = 0;
		Out = 0;
	
		//Inicializar las flags
		N = 0;
		V = 0;
		Z = 0;
		
		
		//Caso suma 2 positivos
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0011001000011001; //50,25
		B 				= 16'b0001100101111101; //25,125
		OutExpected = 16'b0100101100010111; //75,375
		
		ZExpected=0;
		VExpected=0;
		NExpected=0;
		
		#DELAY
		
		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("Exito para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		/*
		//Caso suma 2 negativos
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1011001000011001; //50,25
		B 				= 16'b1001100101111101; //25,125
		OutExpected = 16'b1100101100010111; //75,375
		
		ZExpected=0;
		VExpected=0;
		NExpected=1;
		
		#DELAY
		
		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("Exito para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		*/
		/*
		//Caso overflow positivos
		A = 8'b01111111;
		B = 8'b00000001;
		OutExpected=8'b01111111;
		
		ZExpected=0;
		VExpected=1;
		NExpected=0;
		
		#10
		
		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("Exito para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso overflow negativo
		A = 8'b11111110;
		B = 8'b10000000;
		OutExpected=8'b10000000;
		
		ZExpected=0;
		VExpected=1;
		NExpected=1;
		
		#10
		
		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("Exito para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso suma de positivo con negativo que da 0
		A = 8'b00000001;
		B = 8'b11111111;
		OutExpected=8'b00000000;
		
		ZExpected=1;
		VExpected=0;
		NExpected=0;
		
		#10
		
		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("Exito para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso suma de positivo con negativo que da positivo
		A = 8'b00000100;
		B = 8'b11111111;
		OutExpected=8'b00000011;
		
		ZExpected=0;
		VExpected=0;
		NExpected=0;
		
		#10
		
		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("Exito para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		*/
      
    end

endmodule
