`timescale 1ns / 10ps  // Definición de la escala de tiempo

module tb_Mult_FixedPoint;
	// Parameters
	parameter DATA_WIDTH = 16;
	parameter DELAY = 10; // Delay between inputs in simulation steps

	// Inputs
	reg signed [DATA_WIDTH-1:0] A;
	reg signed [DATA_WIDTH-1:0] B;

	// Outputs
	reg signed [DATA_WIDTH-1:0] Out;
	reg signed [DATA_WIDTH-1:0] OutExpected;
	
	reg signed [DATA_WIDTH/2-1:0] OutIntegerExpected;
	reg signed [DATA_WIDTH/2-1:0] OutFraccionalExpected;
	
	
	reg C, CExpected, N, NExpected, V, VExpected, Z,ZExpected;

	// Instanciar el modulo de mult_fixed
	Mult_FixedPoint #(.DATA_WIDTH(DATA_WIDTH)) Test(
		.A(A),
		.B(B),
		.Out(Out),
		.C(C),
		.N(N),
		.V(V),
		.Z(Z)
	);


   // Test input generation
	initial 
	begin
	
		//Inicializar las flags
		C = 0;
		N = 0;
		V = 0;
		Z = 0;
		
		OutIntegerExpected = 0;
		OutFraccionalExpected = 0;
		
		//Casos Multiplicacion
		$display ("============MULTIPLICADOR============");	
		//Caso 1: mult de positivo con positivo con numeros pequeños
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0000010101000000; // 5,250
		B 				= 16'b0000001010000000; // 2,500
		OutExpected = 16'b0000110100100000; //13,125
		
		OutIntegerExpected 	 = 8'b00001101;
		OutFraccionalExpected = 8'b00100000;
		
		CExpected=0;
		NExpected=0;
		VExpected=0;
		ZExpected=0;	

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 1 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso 2: mult de positivo con positivo con numeros grandes
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0110010011000000; //100,750
		B 				= 16'b0110010010000000; //100,500
		OutExpected = 16'b0111111101100000; //127,375
		
		OutIntegerExpected 	 = 8'b01111111;
		OutFraccionalExpected = 8'b01100000;
		
		CExpected=0;
		NExpected=0;
		VExpected=1;
		ZExpected=0;	

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 2 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso 3: mult de positivo con negativo con numeros pequeños
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0000010101000000; //  5,250
		B 				= 16'b1111111010000000; // -2,500
		OutExpected = 16'b1111001100100000; //-13,125
		
		
		
		OutIntegerExpected 	 = 8'b11110011;
		OutFraccionalExpected = 8'b00100000;
		
		CExpected=0;
		NExpected=1;
		VExpected=0;
		ZExpected=0;	

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 3 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso 4: mult de negativo con positivo con numeros pequeños
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1111111010000000; // -2,500
		B 				= 16'b0000010101000000; //  5,250
		OutExpected = 16'b1111001100100000; //-13,125
		
		OutIntegerExpected 	 = 8'b11110011;
		OutFraccionalExpected = 8'b00100000;
		
		CExpected=0;
		NExpected=1;
		VExpected=0;
		ZExpected=0;	

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 4 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso 5: mult de negativo con negativo con numeros pequeños
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1111111010000000; //-2,50
		B 				= 16'b1111111010000000; //-2,50
		OutExpected = 16'b0000011001000000; // 6,25
		
		OutIntegerExpected 	 = 8'b00000110;
		OutFraccionalExpected = 8'b01000000;
		
		CExpected=0;
		NExpected=0;
		VExpected=0;
		ZExpected=0;	

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 5 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso 6: mult de negativo con positivo con numeros grandes
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1110000000010000; //- 32,0625000
		B 				= 16'b0000100000100000; //   8,1250000
		OutExpected = 16'b1000000010000010; //-128,5078125
		
		OutIntegerExpected 	 = 8'b10000000;
		OutFraccionalExpected = 8'b10000010;
		
		CExpected=0;
		NExpected=1;
		VExpected=1;
		ZExpected=0;	

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 6 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso 7: mult por cero
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0110010011000000; //100,750
		B 				= 16'b0000000000000000; //  0,000
		OutExpected = 16'b0000000000000000; //  0,000
		
		OutIntegerExpected 	 = 8'b00000000;
		OutFraccionalExpected = 8'b00000000;
		
		CExpected=0;
		NExpected=0;
		VExpected=0;
		ZExpected=1;	

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 7 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
	end

endmodule
