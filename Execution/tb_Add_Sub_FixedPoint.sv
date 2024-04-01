`timescale 1ns / 10ps  // Definición de la escala de tiempo

module tb_Add_Sub_FixedPoint;
	// Parameters
	parameter DATA_WIDTH = 16;
	parameter DELAY = 10; // Delay between inputs in simulation steps

	// Inputs
	reg [DATA_WIDTH-1:0] A;
	reg [DATA_WIDTH-1:0] B;
	reg op;

	// Outputs
	reg signed [DATA_WIDTH-1:0] Out;
	reg signed [DATA_WIDTH-1:0] OutExpected;
	
	reg signed [DATA_WIDTH/2-1:0] OutIntegerExpected;
	reg signed [DATA_WIDTH/2-1:0] OutFraccionalExpected;
	
	
	reg CExpected, N, NExpected, V, VExpected, Z,ZExpected;

	// Instanciar el modulo de add_sub_fixed
	Add_Sub_FixedPoint #(.DATA_WIDTH(DATA_WIDTH)) Test(
		.A(A),
		.B(B),
		.op(op),
		.Out(Out),
		.N(N),
		.V(V),
		.Z(Z)
	);


   // Test input generation
	initial 
	begin
	
		//Inicializar las flags
		//C = 0;
		N = 0;
		V = 0;
		Z = 0;
		
		OutIntegerExpected = 0;
		OutFraccionalExpected = 0;
		
		//Casos Suma
		$display ("===============SUMADOR===============");
		op = 1'b0;
		
		
		$display ("Caso 1: suma de positivo + positivo");

		//Caso 1.1: suma sin overflow ni carry
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0011001001000000; //50,25
		B 				= 16'b0001100100100000; //25,125
		OutExpected = 16'b0100101101100000; //75,375
		
		OutIntegerExpected 	 = 8'b01001011;
		OutFraccionalExpected = 8'b01100000;
		
		CExpected=0;
		ZExpected=0;
		VExpected=0;
		NExpected=0;

		#DELAY

		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) $display ($sformatf("Exito caso 1.1 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));

		//Caso 1.2: suma con carry que no se propaga
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0000000010100000; //0,625
		B 				= 16'b0000000000100000; //0,125
		OutExpected = 16'b0000000011000000; //0,750
		
		OutIntegerExpected 	 = 8'b00000000;
		OutFraccionalExpected = 8'b11000000;
		
		CExpected=0;
		ZExpected=0;
		VExpected=0;
		NExpected=0;

		#DELAY

		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) $display ($sformatf("Exito caso 1.2 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));


		//Caso 1.3: suma con carry que se propaga
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0000101010100000; //10,625
		B 				= 16'b0000001010100000; // 2,625
		OutExpected = 16'b0000110101000000; //13,250
		
		OutIntegerExpected 	 = 8'b00001101;
		OutFraccionalExpected = 8'b01000000;
		
		CExpected=1;
		ZExpected=0;
		VExpected=0;
		NExpected=0;

		#DELAY

		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) $display ($sformatf("Exito caso 1.3 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));

		//Caso 1.4: suma con carry que se propaga con overflow
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0011111110100000; //63,625
		B 				= 16'b0011111110100000; //63,625
		OutExpected = 16'b0111111101000000; //127,250
		
		OutIntegerExpected 	 = 8'b01111111;
		OutFraccionalExpected = 8'b01000000;
		
		CExpected=1;
		ZExpected=0;
		VExpected=1;
		NExpected=0;

		#DELAY
		
		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) $display ($sformatf("Exito caso 1.4 para A = %b, B = %b", A, B));
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
		ZExpected=0;
		VExpected=0;
		NExpected=0;


		#DELAY

		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) $display ($sformatf("Exito caso 2.1 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));

		//Caso 2.2: suma con carry que no se propaga
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0000101010000000; //10,5
		B 				= 16'b1111111101100000; //-1,375
		OutExpected = 16'b0000100100100000; //9,125
		
		OutIntegerExpected 	 = 8'b00001001;
		OutFraccionalExpected = 8'b00100000;
		
		CExpected=0;
		ZExpected=0;
		VExpected=0;
		NExpected=0;


		#DELAY

		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) $display ($sformatf("Exito caso 2.2 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));


		//Caso 2.3: suma con carry que se propaga
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0000101001000000; //10,25
		B 				= 16'b1111111110000000; //-1,5
		OutExpected = 16'b0000100011000000; //8,75
		
		OutIntegerExpected 	 = 8'b00001000;
		OutFraccionalExpected = 8'b11000000;
		
		CExpected=1;
		ZExpected=0;
		VExpected=0;
		NExpected=0;

		#DELAY

		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) $display ($sformatf("Exito caso 2.3 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso 2.4: suma con carry que se propaga con A y B en 0
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0000101000010000; //10,0625
		B 				= 16'b1111111100100000; //-1,1250
		OutExpected = 16'b0000100011110000; // 8,9375
		
		OutIntegerExpected 	 = 8'b00001000;
		OutFraccionalExpected = 8'b11110000;
		
		CExpected=1;
		ZExpected=0;
		VExpected=0;
		NExpected=0;


		#DELAY

		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) $display ($sformatf("Exito caso 2.4 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso 2.5: suma que da cero
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0000000100010000; // 1,0625
		B 				= 16'b1111111100010000; //-1,0625
		OutExpected = 16'b0000000000000000; // 0,0
		
		OutIntegerExpected 	 = 8'b00000000;
		OutFraccionalExpected = 8'b00000000;
		
		CExpected=0;
		ZExpected=1;
		VExpected=0;
		NExpected=0;


		#DELAY

		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) $display ($sformatf("Exito caso 2.5 para A = %b, B = %b", A, B));
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
		ZExpected=0;
		VExpected=0;
		NExpected=1;


		#DELAY

		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) $display ($sformatf("Exito caso 3.1 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));

		//Caso 3.2: suma con carry que no se propaga
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0000001001100000; // 2,375
		B 				= 16'b1111110010100000; //-4,625
		OutExpected = 16'b1111111001000000; //-2,250
		
		OutIntegerExpected 	 = 8'b11111110;
		OutFraccionalExpected = 8'b01000000;
		
		CExpected=0;
		ZExpected=0;
		VExpected=0;
		NExpected=1;

		#DELAY

		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) $display ($sformatf("Exito caso 3.2 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		
		//Caso 3.3: suma con carry que se propaga
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0000001010000000; // 2,500
		B 				= 16'b1111110001100000; //-4,375
		OutExpected = 16'b1111111111100000; //-1,875
		
		OutIntegerExpected 	 = 8'b11111111;
		OutFraccionalExpected = 8'b11100000;
		
		CExpected=1;
		ZExpected=0;
		VExpected=0;
		NExpected=1;


		#DELAY

		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) $display ($sformatf("Exito caso 3.3 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso 3.4: suma con carry que se propaga con A y B en 0
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b0000001000100000; // 2,1250
		B 				= 16'b1111110000010000; //-4,0625
		OutExpected = 16'b1111111111110000; //-1,9375
		
		OutIntegerExpected 	 = 8'b11111111;
		OutFraccionalExpected = 8'b11110000;
		
		CExpected=1;
		ZExpected=0;
		VExpected=0;
		NExpected=1;


		#DELAY

		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) $display ($sformatf("Exito caso 3.4 para A = %b, B = %b", A, B));
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
		ZExpected=0;
		VExpected=0;
		NExpected=1;


		#DELAY

		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) $display ($sformatf("Exito caso 4.1 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));

		//Caso 4.2: suma con carry que no se propaga
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1111110010000000; //-4.50
		B 				= 16'b0000001001000000; // 2.25
		OutExpected = 16'b1111111001000000; //-2.25
		
		OutIntegerExpected 	 = 8'b11111110;
		OutFraccionalExpected = 8'b01000000;
		
		CExpected=0;
		ZExpected=0;
		VExpected=0;
		NExpected=1;


		#DELAY

		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) $display ($sformatf("Exito caso 4.2 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));


		//Caso 4.3: suma con carry que se propaga
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1111110000100000; //-4.125
		B 				= 16'b0000001010100000; // 2.625
		OutExpected = 16'b1111111110000000; //-1.500
		
		OutIntegerExpected 	 = 8'b11111111;
		OutFraccionalExpected = 8'b10000000;
		
		CExpected=1;
		ZExpected=0;
		VExpected=0;
		NExpected=1;

		#DELAY

		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) $display ($sformatf("Exito caso 4.3 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso 4.4: suma con carry que se propaga con A y B en 0
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1111110000010000; //-4,0625
		B 				= 16'b0000001000100000; // 2,1250
		OutExpected = 16'b1111111111110000; //-1,9375
		
		OutIntegerExpected 	 = 8'b11111111;
		OutFraccionalExpected = 8'b11110000;
		
		CExpected=1;
		ZExpected=0;
		VExpected=0;
		NExpected=1;


		#DELAY

		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) $display ($sformatf("Exito caso 4.4 para A = %b, B = %b", A, B));
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

		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) $display ($sformatf("Exito caso 4.5 para A = %b, B = %b", A, B));
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
		ZExpected=0;
		VExpected=0;
		NExpected=0;

		#DELAY

		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) $display ($sformatf("Exito caso 5.1 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));

		//Caso 5.2: suma con carry que no se propaga
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1111111001000000; //-2.25
		B 				= 16'b0000010010000000; // 4.50
		OutExpected = 16'b0000001001000000; // 2.25
		
		OutIntegerExpected 	 = 8'b00000010;
		OutFraccionalExpected = 8'b01000000;
		
		CExpected=0;
		ZExpected=0;
		VExpected=0;
		NExpected=0;


		#DELAY

		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) $display ($sformatf("Exito caso 5.2 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));


		//Caso 5.3: suma con carry que se propaga
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1111111010100000; //-2.625
		B 				= 16'b0000010000100000; // 4.125
		OutExpected = 16'b0000000110000000; // 1.5
		
		OutIntegerExpected 	 = 8'b00000001;
		OutFraccionalExpected = 8'b10000000;
		
		CExpected=1;
		ZExpected=0;
		VExpected=0;
		NExpected=0;

		#DELAY
		
		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) $display ($sformatf("Exito caso 5.3 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso 5.4: suma con carry que se propaga con A y B en 0
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1111111000100000; //-2.1250
		B 				= 16'b0000010000010000; // 4.0625
		OutExpected = 16'b0000000111110000; // 1.9375
		
		OutIntegerExpected 	 = 8'b00000001;
		OutFraccionalExpected = 8'b11110000;
		
		CExpected=1;
		ZExpected=0;
		VExpected=0;
		NExpected=0;

		#DELAY
		
		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) $display ($sformatf("Exito caso 5.4 para A = %b, B = %b", A, B));
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
		ZExpected=0;
		VExpected=0;
		NExpected=1;

		#DELAY

		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) $display ($sformatf("Exito caso 6.1 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));

		//Caso 6.2: suma con carry que no se propaga
		//                IIIIIIII FFFFFFFF
		A 				= 16'b1111111000100000; //-4,125
		B 				= 16'b1111110010100000; //-2,625
		OutExpected = 16'b1111101011000000; //-6,750
		
		OutIntegerExpected 	 = 8'b11111111;
		OutFraccionalExpected = 8'b10000000;
		
		CExpected=0;
		ZExpected=0;
		VExpected=0;
		NExpected=1;

		#DELAY

		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) $display ($sformatf("Exito caso 6.2 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));


		//Caso 6.3: suma con carry que se propaga
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1111110010000000; //-4.50
		B 				= 16'b1111111011000000; //-2.75
		OutExpected = 16'b1111100101000000; //-7.25
		
		OutIntegerExpected 	 = 8'b11111111;
		OutFraccionalExpected = 8'b10000000;
		
		CExpected=1;
		ZExpected=0;
		VExpected=0;
		NExpected=1;

		#DELAY

		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) $display ($sformatf("Exito caso 6.3 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso 6.4 suma con carry que se propaga con overflow
		//                IIIIIIIIFFFFFFFF
		A 				= 16'b1100000010000000; // -64,50
		B 				= 16'b1100000011000000; // -64,75
		OutExpected = 16'b1000000001000000; //-128,25
		
		OutIntegerExpected 	 = 8'b11111111;
		OutFraccionalExpected = 8'b10000000;
		
		CExpected=1;
		ZExpected=0;
		VExpected=1;
		NExpected=1;

		#DELAY
		
				assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) $display ($sformatf("Exito caso 6.4 para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
	
		
		/*
		//Casos Resta
		$display ("==============Restador===============");
		op = 1'b1;

		A	 = 0;
		B	 = 0;
		Out = 0;

		//Caso suma sin carry
		//               FFFFFFFF
		A 				= 8'b01000000; //0,25
		B 				= 8'b00100000; //0,125
		OutExpected = 8'b01100000; //0,375

		#DELAY

				assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) $display ($sformatf("Exito para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));

		//Caso suma con carry que no se propaga
		//               FFFFFFFF
		A 				= 8'b10100000; //0,625
		B 				= 8'b00100000; //0,125
		OutExpected = 8'b11000000; //0,750

		#DELAY

				assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) $display ($sformatf("Exito para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));


		//Caso suma con carry que se propaga
		//               FFFFFFFF
		A 				= 8'b00100000; //0,125
		B 				= 8'b01100000; //0,375
		OutExpected = 8'b10000000; //0,5

		#DELAY

				assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) $display ($sformatf("Exito para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));

		//Caso suma con carry que se propaga con overflow
		//               FFFFFFFF
		A 				= 8'b10100000; //0,625
		B 				= 8'b01100000; //0,375
		OutExpected = 8'b11111111; //0,99609375

		#DELAY

				assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) $display ($sformatf("Exito para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		*/


end

endmodule