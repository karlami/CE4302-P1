`timescale 1ns / 10ps  // Definición de la escala de tiempo

module tb_ALU_FixedPoint;
	
	// Parameters
	parameter DATA_WIDTH = 16;
	parameter DELAY = 10; // Delay between inputs in simulation steps

	// Inputs
	reg [DATA_WIDTH-1:0] A;
	reg [DATA_WIDTH-1:0] B;
	reg [1:0] opcode;

	// Outputs
	reg signed [DATA_WIDTH-1:0] Out;
	reg signed [DATA_WIDTH-1:0] OutExpected;
	
	reg signed [DATA_WIDTH/2-1:0] OutIntegerExpected;
	reg signed [DATA_WIDTH/2-1:0] OutFraccionalExpected;
	
	
	reg C, CExpected, N, NExpected, V, VExpected, Z,ZExpected;
	
	ALU_FixedPoint #(.DATA_WIDTH(DATA_WIDTH)) Test(
    .A(A),
    .B(B),
	 .opcode(opcode),
    .Out(Out),
	 .C(C),
	 .N(N),
	 .V(V),
	 .Z(Z)
   );
	
	
	
	initial 
	begin
	
		//Inicializar las flags
		C = 0;
		N = 0;
		V = 0;
		Z = 0;
		
		//Casos suma
		$display ("=============SUMADOR=============");
		opcode = 2'b00;
		
		$display ("Caso 1: suma de positivo + positivo");

		//Caso 1.1: suma sin overflow ni carry
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0011001001000000; //50,25
		B 				= 16'b0001100100100000; //25,125
		OutExpected = 16'b0100101101100000; //75,375
		
		OutIntegerExpected 	 = 8'b01001011;
		OutFraccionalExpected = 8'b01100000;
		
		CExpected=0;
		NExpected=0;
		VExpected=0;
		ZExpected=0;	

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 1.1 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));

		//Caso 1.2: suma con carry que no se propaga
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0000000010100000; //0,625
		B 				= 16'b0000000000100000; //0,125
		OutExpected = 16'b0000000011000000; //0,750
		
		OutIntegerExpected 	 = 8'b00000000;
		OutFraccionalExpected = 8'b11000000;
		
		CExpected=0;
		NExpected=0;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 1.2 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));


		//Caso 1.3: suma con carry que se propaga
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0000101010100000; //10,625
		B 				= 16'b0000001010100000; // 2,625
		OutExpected = 16'b0000110101000000; //13,250
		
		OutIntegerExpected 	 = 8'b00001101;
		OutFraccionalExpected = 8'b01000000;
		
		CExpected=1;
		NExpected=0;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 1.3 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));

		//Caso 1.4: suma con carry que se propaga con overflow
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0011111110100000; //63,625
		B 				= 16'b0011111110100000; //63,625
		OutExpected = 16'b0111111101000000; //127,250
		
		OutIntegerExpected 	 = 8'b01111111;
		OutFraccionalExpected = 8'b01000000;
		
		CExpected=1;
		NExpected=0;
		VExpected=1;
		ZExpected=0;

		#DELAY
		
		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 1.4 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		$display ("Caso 2: suma de positivo + negativo = positivo");
		
		//Caso 2.1: suma sin carry
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0000101011100000; //10,875
		B 				= 16'b1111111101100000; //-1,375
		OutExpected = 16'b0000100110000000; //9,5
		
		OutIntegerExpected 	 = 8'b00001001;
		OutFraccionalExpected = 8'b10000000;
		
		CExpected=0;
		NExpected=0;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 2.1 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));

		//Caso 2.2: suma con carry que no se propaga
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0000101010000000; //10,5
		B 				= 16'b1111111101100000; //-1,375
		OutExpected = 16'b0000100100100000; //9,125
		
		OutIntegerExpected 	 = 8'b00001001;
		OutFraccionalExpected = 8'b00100000;
		
		CExpected=0;
		NExpected=0;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 2.2 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));


		//Caso 2.3: suma con carry que se propaga
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0000101001000000; //10,25
		B 				= 16'b1111111110000000; //-1,5
		OutExpected = 16'b0000100011000000; //8,75
		
		OutIntegerExpected 	 = 8'b00001000;
		OutFraccionalExpected = 8'b11000000;
		
		CExpected=1;
		NExpected=0;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 2.3 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso 2.4: suma con carry que se propaga con A y B en 0
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0000101000010000; //10,0625
		B 				= 16'b1111111100100000; //-1,1250
		OutExpected = 16'b0000100011110000; // 8,9375
		
		OutIntegerExpected 	 = 8'b00001000;
		OutFraccionalExpected = 8'b11110000;
		
		CExpected=1;
		NExpected=0;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 2.4 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso 2.5: suma que da cero
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0000000100010000; // 1,0625
		B 				= 16'b1111111100010000; //-1,0625
		OutExpected = 16'b0000000000000000; // 0,0
		
		OutIntegerExpected 	 = 8'b00000000;
		OutFraccionalExpected = 8'b00000000;
		
		CExpected=0;
		NExpected=0;
		VExpected=0;
		ZExpected=1;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 2.5 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		$display ("Caso 3: suma de positivo + negativo = negativo");
		
		//Caso 3.1: suma sin carry
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0000001010000000; // 2,500
		B 				= 16'b1111110011100000; //-4,875
		OutExpected = 16'b1111111001100000; //-2,375
		
		OutIntegerExpected 	 = 8'b11111110;
		OutFraccionalExpected = 8'b01100000;
		
		CExpected=0;
		NExpected=1;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 3.1 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));

		//Caso 3.2: suma con carry que no se propaga
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0000001001100000; // 2,375
		B 				= 16'b1111110010100000; //-4,625
		OutExpected = 16'b1111111001000000; //-2,250
		
		OutIntegerExpected 	 = 8'b11111110;
		OutFraccionalExpected = 8'b01000000;
		
		CExpected=0;
		NExpected=1;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 3.2 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		
		//Caso 3.3: suma con carry que se propaga
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0000001010000000; // 2,500
		B 				= 16'b1111110001100000; //-4,375
		OutExpected = 16'b1111111111100000; //-1,875
		
		OutIntegerExpected 	 = 8'b11111111;
		OutFraccionalExpected = 8'b11100000;
		
		CExpected=1;
		NExpected=1;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 3.3 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso 3.4: suma con carry que se propaga con A y B en 0
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0000001000100000; // 2,1250
		B 				= 16'b1111110000010000; //-4,0625
		OutExpected = 16'b1111111111110000; //-1,9375
		
		OutIntegerExpected 	 = 8'b11111111;
		OutFraccionalExpected = 8'b11110000;
		
		CExpected=1;
		NExpected=1;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 3.4 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		$display ("Caso 4: suma de negativo + positivo = negativo");
		
		//Caso 4.1: suma sin carry
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1111110001100000; //-4.375
		B 				= 16'b0000001001000000; // 2.250
		OutExpected = 16'b1111111000100000; //-2.125
		
		OutIntegerExpected 	 = 8'b11111110;
		OutFraccionalExpected = 8'b00100000;
		
		CExpected=0;
		NExpected=1;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 4.1 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));

		//Caso 4.2: suma con carry que no se propaga
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1111110010000000; //-4.50
		B 				= 16'b0000001001000000; // 2.25
		OutExpected = 16'b1111111001000000; //-2.25
		
		OutIntegerExpected 	 = 8'b11111110;
		OutFraccionalExpected = 8'b01000000;
		
		CExpected=0;
		NExpected=1;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 4.2 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));


		//Caso 4.3: suma con carry que se propaga
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1111110000100000; //-4.125
		B 				= 16'b0000001010100000; // 2.625
		OutExpected = 16'b1111111110000000; //-1.500
		
		OutIntegerExpected 	 = 8'b11111111;
		OutFraccionalExpected = 8'b10000000;
		
		CExpected=1;
		NExpected=1;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 4.3 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso 4.4: suma con carry que se propaga con A y B en 0
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1111110000010000; //-4,0625
		B 				= 16'b0000001000100000; // 2,1250
		OutExpected = 16'b1111111111110000; //-1,9375
		
		OutIntegerExpected 	 = 8'b11111111;
		OutFraccionalExpected = 8'b11110000;
		
		CExpected=1;
		NExpected=1;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 4.4 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso 4.5: suma que da cero
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1111111100010000; //-1,0625
		B 				= 16'b0000000100010000; // 1,0625
		OutExpected = 16'b0000000000000000; // 0,0
		
		OutIntegerExpected 	 = 8'b00000000;
		OutFraccionalExpected = 8'b00000000;
		
		CExpected=0;
		ZExpected=1;
		VExpected=0;
		NExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 4.5 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		$display ("Caso 5: suma de negativo + positivo = positivo");
		
		//Caso 5.1: suma sin carry
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1111111001000000; //-2.250
		B 				= 16'b0000010001100000; // 4.375
		OutExpected = 16'b0000001000100000; // 2.125
		
		OutIntegerExpected 	 = 8'b00000010;
		OutFraccionalExpected = 8'b00100000;
		
		CExpected=0;
		NExpected=0;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 5.1 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));

		//Caso 5.2: suma con carry que no se propaga
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1111111001000000; //-2.25
		B 				= 16'b0000010010000000; // 4.50
		OutExpected = 16'b0000001001000000; // 2.25
		
		OutIntegerExpected 	 = 8'b00000010;
		OutFraccionalExpected = 8'b01000000;
		
		CExpected=0;
		NExpected=0;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 5.2 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));


		//Caso 5.3: suma con carry que se propaga
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1111111010100000; //-2.625
		B 				= 16'b0000010000100000; // 4.125
		OutExpected = 16'b0000000110000000; // 1.5
		
		OutIntegerExpected 	 = 8'b00000001;
		OutFraccionalExpected = 8'b10000000;
		
		CExpected=1;
		NExpected=0;
		VExpected=0;
		ZExpected=0;

		#DELAY
		
		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 5.3 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso 5.4: suma con carry que se propaga con A y B en 0
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1111111000100000; //-2.1250
		B 				= 16'b0000010000010000; // 4.0625
		OutExpected = 16'b0000000111110000; // 1.9375
		
		OutIntegerExpected 	 = 8'b00000001;
		OutFraccionalExpected = 8'b11110000;
		
		CExpected=1;
		NExpected=0;
		VExpected=0;
		ZExpected=0;

		#DELAY
		
		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 5.4 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		
		
		$display ("Caso 6: suma de negativo + negativo");

		//Caso 6.1: suma sin overflow ni carry
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1111111010000000; //-2,5
		B 				= 16'b1111110001000000; //-4,25
		OutExpected = 16'b1111101011000000; //-6,75
		
		OutIntegerExpected 	 = 8'b11111010;
		OutFraccionalExpected = 8'b11000000;
		
		CExpected=0;
		NExpected=1;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 6.1 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));

		//Caso 6.2: suma con carry que no se propaga
		//                IIIIIIII FFFFFFFF
		A 				= 16'b1111111000100000; //-4,125
		B 				= 16'b1111110010100000; //-2,625
		OutExpected = 16'b1111101011000000; //-6,750
		
		OutIntegerExpected 	 = 8'b11111111;
		OutFraccionalExpected = 8'b10000000;
		
		CExpected=0;
		NExpected=1;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 6.2 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));


		//Caso 6.3: suma con carry que se propaga
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1111110010000000; //-4.50
		B 				= 16'b1111111011000000; //-2.75
		OutExpected = 16'b1111100101000000; //-7.25
		
		OutIntegerExpected 	 = 8'b11111111;
		OutFraccionalExpected = 8'b10000000;
		
		CExpected=1;
		NExpected=1;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 6.3 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso 6.4 suma con carry que se propaga con overflow
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1100000010000000; // -64,50
		B 				= 16'b1100000011000000; // -64,75
		OutExpected = 16'b1000000001000000; //-128,25
		
		OutIntegerExpected 	 = 8'b11111111;
		OutFraccionalExpected = 8'b10000000;
		
		CExpected=1;
		NExpected=1;
		VExpected=1;
		ZExpected=0;

		#DELAY
		
		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 6.4 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Casos Resta
		$display ("==============Restador===============");
		opcode = 2'b01;
		
		$display ("Caso 1: Resta de positivo - positivo == positivo"); //equivale a positivo + negativo == positivo
		//Caso 1.1: suma sin carry
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0000101011100000; //10,875
		B 				= 16'b0000000101100000; // 1,375
		OutExpected = 16'b0000100110000000; // 9,500
		
		OutIntegerExpected 	 = 8'b00001001;
		OutFraccionalExpected = 8'b10000000;
		
		CExpected=0;
		NExpected=0;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 1.1 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));

		//Caso 1.2: suma con carry que no se propaga
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0000101010000000; //10,500
		B 				= 16'b0000000101100000; // 1,375
		OutExpected = 16'b0000100100100000; // 9,125
		
		OutIntegerExpected 	 = 8'b00001001;
		OutFraccionalExpected = 8'b00100000;
		
		CExpected=0;
		NExpected=0;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 1.2 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));


		//Caso 1.3: suma con carry que se propaga
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0000101001000000; //10,25
		B 				= 16'b0000000110000000; // 1,50
		OutExpected = 16'b0000100011000000; // 8,75
		
		OutIntegerExpected 	 = 8'b00001000;
		OutFraccionalExpected = 8'b11000000;
		
		CExpected=1;
		NExpected=0;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 1.3 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso 1.4: suma con carry que se propaga con A y B en 0
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0000101000010000; //10,0625
		B 				= 16'b0000000100100000; // 1,1250
		OutExpected = 16'b0000100011110000; // 8,9375
		
		OutIntegerExpected 	 = 8'b00001000;
		OutFraccionalExpected = 8'b11110000;
		
		CExpected=1;
		NExpected=0;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 1.4 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso 1.5: suma que da cero
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0000000100010000; // 1,0625
		B 				= 16'b0000000100010000; // 1,0625
		OutExpected = 16'b0000000000000000; // 0,0
		
		OutIntegerExpected 	 = 8'b00000000;
		OutFraccionalExpected = 8'b00000000;
		
		CExpected=0;
		NExpected=0;
		VExpected=0;
		ZExpected=1;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 1.5 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		$display ("Caso 2: Resta de positivo - positivo == negativo"); //equivale a positivo + negativo == negativo
		
		//Caso 2.1: suma sin carry
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0000001010000000; // 2,500
		B 				= 16'b0000010011100000; // 4,875
		OutExpected = 16'b1111111001100000; //-2,375
		
		OutIntegerExpected 	 = 8'b11111110;
		OutFraccionalExpected = 8'b01100000;
		
		CExpected=0;
		NExpected=1;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 2.1 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));

		//Caso 2.2: suma con carry que no se propaga
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0000001001100000; // 2,375
		B 				= 16'b0000010010100000; // 4,625
		OutExpected = 16'b1111111001000000; //-2,250
		
		OutIntegerExpected 	 = 8'b11111110;
		OutFraccionalExpected = 8'b01000000;
		
		CExpected=0;
		NExpected=1;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 2.2 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		
		//Caso 2.3: suma con carry que se propaga
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0000001010000000; // 2,500
		B 				= 16'b0000010001100000; // 4,375
		OutExpected = 16'b1111111111100000; //-1,875
		
		OutIntegerExpected 	 = 8'b11111111;
		OutFraccionalExpected = 8'b11100000;
		
		CExpected=1;
		NExpected=1;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 2.3 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso 2.4: suma con carry que se propaga con A y B en 0
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0000001000100000; // 2,1250
		B 				= 16'b0000010000010000; // 4,0625
		OutExpected = 16'b1111111111110000; //-1,9375
		
		OutIntegerExpected 	 = 8'b11111111;
		OutFraccionalExpected = 8'b11110000;
		
		CExpected=1;
		NExpected=1;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 2.4 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		$display ("Caso 3: Resta de positivo - negativo");
		
		//Caso 3.1: suma sin overflow ni carry
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0011001001000000; // 50,25
		B 				= 16'b1110011100100000; //-25,125
		OutExpected = 16'b0100101101100000; // 75,375
		
		OutIntegerExpected 	 = 8'b01001011;
		OutFraccionalExpected = 8'b01100000;
		
		CExpected=0;
		NExpected=0;
		VExpected=0;
		ZExpected=0;	

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 3.1 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));

		//Caso 3.2: suma con carry que no se propaga
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0000000110100000; // 1,625
		B 				= 16'b1111111100100000; //-1,125
		OutExpected = 16'b0000001011000000; // 2,750
		
		OutIntegerExpected 	 = 8'b00000010;
		OutFraccionalExpected = 8'b11000000;
		
		CExpected=0;
		NExpected=0;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 3.2 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));


		//Caso 3.3: suma con carry que se propaga
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0000101010100000; //10,625
		B 				= 16'b1111111010100000; //-2,625
		OutExpected = 16'b0000110101000000; //13,250
		
		OutIntegerExpected 	 = 8'b00001101;
		OutFraccionalExpected = 8'b01000000;
		
		CExpected=1;
		NExpected=0;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 3.3 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));

		//Caso 3.4: suma con carry que se propaga con overflow
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0011111110100000; // 63,625
		B 				= 16'b1000000010100000; //-64,625
		OutExpected = 16'b0111111101000000; //127,250
		
		OutIntegerExpected 	 = 8'b01111111;
		OutFraccionalExpected = 8'b01000000;
		
		CExpected=1;
		NExpected=0;
		VExpected=1;
		ZExpected=0;

		#DELAY
		
		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 3.4 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		
		$display ("Caso 4: Resta de negativo - positivo");
		
		//Caso 4.1: suma sin overflow ni carry
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1111111010000000; //-2,5
		B 				= 16'b0000010001000000; // 4,25
		OutExpected = 16'b1111101011000000; //-6,75
		
		OutIntegerExpected 	 = 8'b11111010;
		OutFraccionalExpected = 8'b11000000;
		
		CExpected=0;
		NExpected=1;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 4.1 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));

		//Caso 4.2: suma con carry que no se propaga
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1111110000100000; //-4,125
		B 				= 16'b0000001010100000; // 2,625
		OutExpected = 16'b1111101011000000; //-6,750
		
		OutIntegerExpected 	 = 8'b11111010;
		OutFraccionalExpected = 8'b11000000;
		
		CExpected=0;
		NExpected=1;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 4.2 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));


		//Caso 4.3: suma con carry que se propaga
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1111110010000000; //-4.50
		B 				= 16'b0000001011000000; // 2.75
		OutExpected = 16'b1111100101000000; //-7.25
		
		OutIntegerExpected 	 = 8'b11111001;
		OutFraccionalExpected = 8'b01000000;
		
		CExpected=1;
		NExpected=1;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 4.3 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso 4.4 suma con carry que se propaga con overflow
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1100000010000000; // -64,50
		B 				= 16'b0100000011000000; //  64,75
		OutExpected = 16'b1000000001000000; //-128,25
		
		OutIntegerExpected 	 = 8'b10000000;
		OutFraccionalExpected = 8'b01000000;
		
		CExpected=1;
		NExpected=1;
		VExpected=1;
		ZExpected=0;

		#DELAY
		
		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 4.4 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		$display ("Caso 5: Resta de negativo - negativo == negativo");
		//Caso 5.1: suma sin carry
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1111110001100000; //-4.375
		B 				= 16'b1111111001000000; //-2.250
		OutExpected = 16'b1111111000100000; //-2.125
		
		OutIntegerExpected 	 = 8'b11111110;
		OutFraccionalExpected = 8'b00100000;
		
		CExpected=0;
		NExpected=1;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 5.1 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));

		//Caso 5.2: suma con carry que no se propaga
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1111110010000000; //-4.50
		B 				= 16'b1111111001000000; //-2.25
		OutExpected = 16'b1111111001000000; //-2.25
		
		OutIntegerExpected 	 = 8'b11111110;
		OutFraccionalExpected = 8'b01000000;
		
		CExpected=0;
		NExpected=1;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 5.2 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));


		//Caso 5.3: suma con carry que se propaga
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1111110000100000; //-4.125
		B 				= 16'b1111111010100000; //-2.625
		OutExpected = 16'b1111111110000000; //-1.500
		
		OutIntegerExpected 	 = 8'b11111111;
		OutFraccionalExpected = 8'b10000000;
		
		CExpected=1;
		NExpected=1;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 5.3 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso 5.4: suma con carry que se propaga con A y B en 0
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1111110000010000; //-4,0625
		B 				= 16'b1111111000100000; //-2,1250
		OutExpected = 16'b1111111111110000; //-1,9375
		
		OutIntegerExpected 	 = 8'b11111111;
		OutFraccionalExpected = 8'b11110000;
		
		CExpected=1;
		NExpected=1;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 5.4 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso 5.5: suma que da cero
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1111111100010000; //-1,0625
		B 				= 16'b1111111100010000; //-1,0625
		OutExpected = 16'b0000000000000000; // 0,0
		
		OutIntegerExpected 	 = 8'b00000000;
		OutFraccionalExpected = 8'b00000000;
		
		CExpected=0;
		ZExpected=1;
		VExpected=0;
		NExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 5.5 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		$display ("Caso 6: Resta de negativo - negativo == positivo");
		
		//Caso 6.1: suma sin carry
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1111111001000000; //-2.250
		B 				= 16'b1111110001100000; //-4.375
		OutExpected = 16'b0000001000100000; // 2.125
		
		OutIntegerExpected 	 = 8'b00000010;
		OutFraccionalExpected = 8'b00100000;
		
		CExpected=0;
		NExpected=0;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 6.1 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));

		//Caso 6.2: suma con carry que no se propaga
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1111111001000000; //-2.25
		B 				= 16'b1111110010000000; //-4.50
		OutExpected = 16'b0000001001000000; // 2.25
		
		OutIntegerExpected 	 = 8'b00000010;
		OutFraccionalExpected = 8'b01000000;
		
		CExpected=0;
		NExpected=0;
		VExpected=0;
		ZExpected=0;

		#DELAY

		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 6.2 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));


		//Caso 6.3: suma con carry que se propaga
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1111111010100000; //-2.625
		B 				= 16'b1111110000100000; //-4.125
		OutExpected = 16'b0000000110000000; // 1.5
		
		OutIntegerExpected 	 = 8'b00000001;
		OutFraccionalExpected = 8'b10000000;
		
		CExpected=1;
		NExpected=0;
		VExpected=0;
		ZExpected=0;

		#DELAY
		
		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 6.3 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso 6.4: suma con carry que se propaga con A y B en 0
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1111111000100000; //-2.1250
		B 				= 16'b1111110000010000; //-4.0625
		OutExpected = 16'b0000000111110000; // 1.9375
		
		OutIntegerExpected 	 = 8'b00000001;
		OutFraccionalExpected = 8'b11110000;
		
		CExpected=1;
		NExpected=0;
		VExpected=0;
		ZExpected=0;

		#DELAY
		
		assert (Out == OutExpected && C == CExpected && N == NExpected && V == VExpected && Z == ZExpected) $display ($sformatf("Exito caso 6.4 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Casos Multiplicacion
		$display ("============MULTIPLICADOR============");
		opcode = 2'b10;	
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
