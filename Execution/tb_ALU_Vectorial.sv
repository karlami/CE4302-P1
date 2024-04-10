`timescale 1ns / 10ps  // Definición de la escala de tiempo

module tb_ALU_Vectorial;
	
	// Parameters
	parameter DATA_WIDTH = 16;
	parameter DELAY = 10; // Delay between inputs in simulation steps
	
	// Inputs
	reg signed [DATA_WIDTH-1:0] A [DATA_WIDTH-1:0];
	reg signed [DATA_WIDTH-1:0] B [DATA_WIDTH-1:0];
	reg [1:0] opcode;

	// Outputs
	reg signed [DATA_WIDTH-1:0] Out [DATA_WIDTH-1:0];
	reg signed [DATA_WIDTH-1:0] OutExpected [DATA_WIDTH-1:0];
	
	reg signed [DATA_WIDTH/2-1:0] OutIntegerExpected [DATA_WIDTH-1:0];
	reg signed [DATA_WIDTH/2-1:0] OutFraccionalExpected [DATA_WIDTH-1:0];
	
	
	reg C [DATA_WIDTH-1:0];
	reg CExpected [DATA_WIDTH-1:0];
	reg N [DATA_WIDTH-1:0];
	reg NExpected [DATA_WIDTH-1:0];
	reg V [DATA_WIDTH-1:0];
	reg VExpected [DATA_WIDTH-1:0];
	reg Z [DATA_WIDTH-1:0];
	reg ZExpected [DATA_WIDTH-1:0];
	
	
	ALU_Vectorial #(.DATA_WIDTH(DATA_WIDTH)) Test(
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
		//Casos suma
		$display ("=============SUMADOR=============");
		opcode = 2'b00;
		
		//Caso en [15] caso 1.1: suma sin overflow ni carry
		//                					 IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-1] 				= 16'b0011001001000000; //50,25
		B[DATA_WIDTH-1] 				= 16'b0001100100100000; //25,125
		OutExpected[DATA_WIDTH-1]  = 16'b0100101101100000; //75,375
		
		OutIntegerExpected[DATA_WIDTH-1] 	= 8'b01001011;
		OutFraccionalExpected[DATA_WIDTH-1] = 8'b01100000;
		
		CExpected[DATA_WIDTH-1]=0;
		NExpected[DATA_WIDTH-1]=0;
		VExpected[DATA_WIDTH-1]=0;
		ZExpected[DATA_WIDTH-1]=0;	

		//Caso en [14] caso 1.3: suma con carry que se propaga
		//                					 IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-2] 				= 16'b0000101010100000; //10,625
		B[DATA_WIDTH-2] 				= 16'b0000001010100000; // 2,625
		OutExpected[DATA_WIDTH-2]  = 16'b0000110101000000; //13,250
		
		OutIntegerExpected[DATA_WIDTH-2] 	= 8'b00001101;
		OutFraccionalExpected[DATA_WIDTH-2] = 8'b01000000;
		
		CExpected[DATA_WIDTH-2]=1;
		NExpected[DATA_WIDTH-2]=0;
		VExpected[DATA_WIDTH-2]=0;
		ZExpected[DATA_WIDTH-2]=0;

		//Caso en [13] caso 1.4: suma con carry que se propaga con overflow
		//                					 IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-3] 				= 16'b0011111110100000; //63,625
		B[DATA_WIDTH-3] 				= 16'b0011111110100000; //63,625
		OutExpected[DATA_WIDTH-3]  = 16'b0111111101000000; //127,250
		
		OutIntegerExpected[DATA_WIDTH-3]    = 8'b01111111;
		OutFraccionalExpected[DATA_WIDTH-3] = 8'b01000000;
		
		CExpected[DATA_WIDTH-3]=1;
		NExpected[DATA_WIDTH-3]=0;
		VExpected[DATA_WIDTH-3]=1;
		ZExpected[DATA_WIDTH-3]=0;

		//Caso en [12] caso 2.1: suma sin carry
		//                					 IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-4] 				= 16'b0000101011100000; //10,875
		B[DATA_WIDTH-4] 				= 16'b1111111101100000; //-1,375
		OutExpected[DATA_WIDTH-4]  = 16'b0000100110000000; //9,5
		
		OutIntegerExpected[DATA_WIDTH-4]    = 8'b00001001;
		OutFraccionalExpected[DATA_WIDTH-4] = 8'b10000000;
		
		CExpected[DATA_WIDTH-4]=0;
		NExpected[DATA_WIDTH-4]=0;
		VExpected[DATA_WIDTH-4]=0;
		ZExpected[DATA_WIDTH-4]=0;
		
		//Caso en [11] caso 2.3: suma con carry que se propaga
		//                					 IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-5] 				= 16'b0000101001000000; //10,25
		B[DATA_WIDTH-5] 				= 16'b1111111110000000; //-1,5
		OutExpected[DATA_WIDTH-5]  = 16'b0000100011000000; //8,75
		
		OutIntegerExpected[DATA_WIDTH-5] 	= 8'b00001000;
		OutFraccionalExpected[DATA_WIDTH-5] = 8'b11000000;
		
		CExpected[DATA_WIDTH-5]=1;
		NExpected[DATA_WIDTH-5]=0;
		VExpected[DATA_WIDTH-5]=0;
		ZExpected[DATA_WIDTH-5]=0;
		
		//Caso en [10] caso 2.5: suma que da cero
		//                					 IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-6] 				= 16'b0000000100010000; // 1,0625
		B[DATA_WIDTH-6] 				= 16'b1111111100010000; //-1,0625
		OutExpected[DATA_WIDTH-6]  = 16'b0000000000000000; // 0,0
		
		OutIntegerExpected[DATA_WIDTH-6] 	= 8'b00000000;
		OutFraccionalExpected[DATA_WIDTH-6] = 8'b00000000;
		
		CExpected[DATA_WIDTH-6]=0;
		NExpected[DATA_WIDTH-6]=0;
		VExpected[DATA_WIDTH-6]=0;
		ZExpected[DATA_WIDTH-6]=1;
		
		//Caso en [09] caso 3.1: suma sin carry
		//                					IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-7] 				= 16'b0000001010000000; // 2,500
		B[DATA_WIDTH-7] 				= 16'b1111110011100000; //-4,875
		OutExpected[DATA_WIDTH-7]  = 16'b1111111001100000; //-2,375
		
		OutIntegerExpected[DATA_WIDTH-7] 	= 8'b11111110;
		OutFraccionalExpected[DATA_WIDTH-7] = 8'b01100000;
		
		CExpected[DATA_WIDTH-7]=0;
		NExpected[DATA_WIDTH-7]=1;
		VExpected[DATA_WIDTH-7]=0;
		ZExpected[DATA_WIDTH-7]=0;
		
		//Caso en [08] caso 3.3: suma con carry que se propaga
		//                					IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-8] 				= 16'b0000001010000000; // 2,500
		B[DATA_WIDTH-8] 				= 16'b1111110001100000; //-4,375
		OutExpected[DATA_WIDTH-8]  = 16'b1111111111100000; //-1,875
		
		OutIntegerExpected[DATA_WIDTH-8] 	= 8'b11111111;
		OutFraccionalExpected[DATA_WIDTH-8] = 8'b11100000;
		
		CExpected[DATA_WIDTH-8]=1;
		NExpected[DATA_WIDTH-8]=1;
		VExpected[DATA_WIDTH-8]=0;
		ZExpected[DATA_WIDTH-8]=0;
		
		//Caso en [07] caso 4.1: suma sin carry
		//                					IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-9] 				= 16'b1111110001100000; //-4.375
		B[DATA_WIDTH-9] 				= 16'b0000001001000000; // 2.250
		OutExpected[DATA_WIDTH-9]  = 16'b1111111000100000; //-2.125
		
		OutIntegerExpected[DATA_WIDTH-9] 	= 8'b11111110;
		OutFraccionalExpected[DATA_WIDTH-9] = 8'b00100000;
		
		CExpected[DATA_WIDTH-9]=0;
		NExpected[DATA_WIDTH-9]=1;
		VExpected[DATA_WIDTH-9]=0;
		ZExpected[DATA_WIDTH-9]=0;
		
		//Caso en [06] caso 4.3: suma con carry que se propaga
		//                					IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-10] 				= 16'b1111110000100000; //-4.125
		B[DATA_WIDTH-10] 				= 16'b0000001010100000; // 2.625
		OutExpected[DATA_WIDTH-10] = 16'b1111111110000000; //-1.500
		
		OutIntegerExpected[DATA_WIDTH-10] 	= 8'b11111111;
		OutFraccionalExpected[DATA_WIDTH-10]= 8'b10000000;
		
		CExpected[DATA_WIDTH-10]=1;
		NExpected[DATA_WIDTH-10]=1;
		VExpected[DATA_WIDTH-10]=0;
		ZExpected[DATA_WIDTH-10]=0;
		
		//Caso en [05] caso 4.5: suma que da cero
		//                					IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-11] 				= 16'b1111111100010000; //-1,0625
		B[DATA_WIDTH-11] 				= 16'b0000000100010000; // 1,0625
		OutExpected[DATA_WIDTH-11] = 16'b0000000000000000; // 0,0
		
		OutIntegerExpected[DATA_WIDTH-11] 	= 8'b00000000;
		OutFraccionalExpected[DATA_WIDTH-11]= 8'b00000000;
		
		CExpected[DATA_WIDTH-11]=0;
		ZExpected[DATA_WIDTH-11]=1;
		VExpected[DATA_WIDTH-11]=0;
		NExpected[DATA_WIDTH-11]=0;

		//Caso en [04] caso 5.1: suma sin carry
		//                					IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-12] 				= 16'b1111111001000000; //-2.250
		B[DATA_WIDTH-12] 				= 16'b0000010001100000; // 4.375
		OutExpected[DATA_WIDTH-12] = 16'b0000001000100000; // 2.125
		
		OutIntegerExpected[DATA_WIDTH-12] 	= 8'b00000010;
		OutFraccionalExpected[DATA_WIDTH-12]= 8'b00100000;
		
		CExpected[DATA_WIDTH-12]=0;
		NExpected[DATA_WIDTH-12]=0;
		VExpected[DATA_WIDTH-12]=0;
		ZExpected[DATA_WIDTH-12]=0;

		//Caso en [03] caso 5.3: suma con carry que se propaga
		//                					IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-13] 				= 16'b1111111010100000; //-2.625
		B[DATA_WIDTH-13] 				= 16'b0000010000100000; // 4.125
		OutExpected[DATA_WIDTH-13] = 16'b0000000110000000; // 1.5
		
		OutIntegerExpected[DATA_WIDTH-13] 	= 8'b00000001;
		OutFraccionalExpected[DATA_WIDTH-13]= 8'b10000000;
		
		CExpected[DATA_WIDTH-13]=1;
		NExpected[DATA_WIDTH-13]=0;
		VExpected[DATA_WIDTH-13]=0;
		ZExpected[DATA_WIDTH-13]=0;
		
		//Caso en [02] caso 6.1: suma sin overflow ni carry
		//                					IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-14] 				= 16'b1111111010000000; //-2,5
		B[DATA_WIDTH-14] 				= 16'b1111110001000000; //-4,25
		OutExpected[DATA_WIDTH-14] = 16'b1111101011000000; //-6,75
		
		OutIntegerExpected[DATA_WIDTH-14] 	= 8'b11111010;
		OutFraccionalExpected[DATA_WIDTH-14]= 8'b11000000;
		
		CExpected[DATA_WIDTH-14]=0;
		NExpected[DATA_WIDTH-14]=1;
		VExpected[DATA_WIDTH-14]=0;
		ZExpected[DATA_WIDTH-14]=0;
		
		//Caso en [01] caso 6.3: suma con carry que se propaga
		//                					IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-15] 				= 16'b1111110010000000; //-4.50
		B[DATA_WIDTH-15] 				= 16'b1111111011000000; //-2.75
		OutExpected[DATA_WIDTH-15] = 16'b1111100101000000; //-7.25
		
		OutIntegerExpected[DATA_WIDTH-15] 	= 8'b11111111;
		OutFraccionalExpected[DATA_WIDTH-15]= 8'b10000000;
		
		CExpected[DATA_WIDTH-15]=1;
		NExpected[DATA_WIDTH-15]=1;
		VExpected[DATA_WIDTH-15]=0;
		ZExpected[DATA_WIDTH-15]=0;

		//Caso en [00] caso 6.4 suma con carry que se propaga con overflow
		//                					IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-16] 				= 16'b1100000010000000; // -64,50
		B[DATA_WIDTH-16] 				= 16'b1100000011000000; // -64,75
		OutExpected[DATA_WIDTH-16] = 16'b1000000001000000; //-128,25
		
		OutIntegerExpected[DATA_WIDTH-16] 	= 8'b11111111;
		OutFraccionalExpected[DATA_WIDTH-16]= 8'b10000000;
		
		CExpected[DATA_WIDTH-16]=1;
		NExpected[DATA_WIDTH-16]=1;
		VExpected[DATA_WIDTH-16]=1;
		ZExpected[DATA_WIDTH-16]=0;

		#DELAY
		
		//Verificacion de los casos
		//Caso en [15] caso 1.1: suma sin overflow ni carry
		assert (Out[DATA_WIDTH-1] == OutExpected[DATA_WIDTH-1] && C[DATA_WIDTH-1] == CExpected[DATA_WIDTH-1] && N[DATA_WIDTH-1] == NExpected[DATA_WIDTH-1] && V[DATA_WIDTH-1] == VExpected[DATA_WIDTH-1] && Z[DATA_WIDTH-1] == ZExpected[DATA_WIDTH-1]) $display ($sformatf("Exito en [15] caso 1.1 para A = %b, B = %b", A[DATA_WIDTH-1], B[DATA_WIDTH-1]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-1], B[DATA_WIDTH-1], Out[DATA_WIDTH-1], OutExpected[DATA_WIDTH-1]));
		
		//Caso en [14] caso 1.3: suma con carry que se propaga
		assert (Out[DATA_WIDTH-2] == OutExpected[DATA_WIDTH-2] && C[DATA_WIDTH-2] == CExpected[DATA_WIDTH-2] && N[DATA_WIDTH-2] == NExpected[DATA_WIDTH-2] && V[DATA_WIDTH-2] == VExpected[DATA_WIDTH-2] && Z[DATA_WIDTH-2] == ZExpected[DATA_WIDTH-2]) $display ($sformatf("Exito en [14] caso 1.3 para A = %b, B = %b", A[DATA_WIDTH-2], B[DATA_WIDTH-2]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-2], B[DATA_WIDTH-2], Out[DATA_WIDTH-2], OutExpected[DATA_WIDTH-2]));
		
		
		//Caso en [13] caso 1.4: suma con carry que se propaga con overflow
		assert (Out[DATA_WIDTH-3] == OutExpected[DATA_WIDTH-3] && C[DATA_WIDTH-3] == CExpected[DATA_WIDTH-3] && N[DATA_WIDTH-3] == NExpected[DATA_WIDTH-3] && V[DATA_WIDTH-3] == VExpected[DATA_WIDTH-3] && Z[DATA_WIDTH-3] == ZExpected[DATA_WIDTH-3]) $display ($sformatf("Exito en [13] caso 1.4 para A = %b, B = %b", A[DATA_WIDTH-3], B[DATA_WIDTH-3]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-3], B[DATA_WIDTH-3], Out[DATA_WIDTH-3], OutExpected[DATA_WIDTH-3]));
		
		
		//Caso en [12] caso 2.1: suma sin carry
		assert (Out[DATA_WIDTH-4] == OutExpected[DATA_WIDTH-4] && C[DATA_WIDTH-4] == CExpected[DATA_WIDTH-4] && N[DATA_WIDTH-4] == NExpected[DATA_WIDTH-4] && V[DATA_WIDTH-4] == VExpected[DATA_WIDTH-4] && Z[DATA_WIDTH-4] == ZExpected[DATA_WIDTH-4]) $display ($sformatf("Exito en [12] caso 2.1 para A = %b, B = %b", A[DATA_WIDTH-4], B[DATA_WIDTH-4]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-4], B[DATA_WIDTH-4], Out[DATA_WIDTH-4], OutExpected[DATA_WIDTH-4]));
		
		
		//Caso en [11] caso 2.3: suma con carry que se propaga
		assert (Out[DATA_WIDTH-5] == OutExpected[DATA_WIDTH-5] && C[DATA_WIDTH-5] == CExpected[DATA_WIDTH-5] && N[DATA_WIDTH-5] == NExpected[DATA_WIDTH-5] && V[DATA_WIDTH-5] == VExpected[DATA_WIDTH-5] && Z[DATA_WIDTH-5] == ZExpected[DATA_WIDTH-5]) $display ($sformatf("Exito en [11] caso 2.3 para A = %b, B = %b", A[DATA_WIDTH-5], B[DATA_WIDTH-5]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-5], B[DATA_WIDTH-5], Out[DATA_WIDTH-5], OutExpected[DATA_WIDTH-5]));
		
		
		//Caso en [10] caso 2.5: suma que da cero
		assert (Out[DATA_WIDTH-6] == OutExpected[DATA_WIDTH-6] && C[DATA_WIDTH-6] == CExpected[DATA_WIDTH-6] && N[DATA_WIDTH-6] == NExpected[DATA_WIDTH-6] && V[DATA_WIDTH-6] == VExpected[DATA_WIDTH-6] && Z[DATA_WIDTH-6] == ZExpected[DATA_WIDTH-6]) $display ($sformatf("Exito en [10] caso 2.5 para A = %b, B = %b", A[DATA_WIDTH-6], B[DATA_WIDTH-6]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-6], B[DATA_WIDTH-6], Out[DATA_WIDTH-6], OutExpected[DATA_WIDTH-6]));
		
		
		//Caso en [09] caso 3.1: suma sin carry
		assert (Out[DATA_WIDTH-7] == OutExpected[DATA_WIDTH-7] && C[DATA_WIDTH-7] == CExpected[DATA_WIDTH-7] && N[DATA_WIDTH-7] == NExpected[DATA_WIDTH-7] && V[DATA_WIDTH-7] == VExpected[DATA_WIDTH-7] && Z[DATA_WIDTH-7] == ZExpected[DATA_WIDTH-7]) $display ($sformatf("Exito en [09] caso 3.1 para A = %b, B = %b", A[DATA_WIDTH-7], B[DATA_WIDTH-7]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-7], B[DATA_WIDTH-7], Out[DATA_WIDTH-7], OutExpected[DATA_WIDTH-7]));
		
		//Caso en [08] 3.3: suma con carry que se propaga
		assert (Out[DATA_WIDTH-8] == OutExpected[DATA_WIDTH-8] && C[DATA_WIDTH-8] == CExpected[DATA_WIDTH-8] && N[DATA_WIDTH-8] == NExpected[DATA_WIDTH-8] && V[DATA_WIDTH-8] == VExpected[DATA_WIDTH-8] && Z[DATA_WIDTH-8] == ZExpected[DATA_WIDTH-8]) $display ($sformatf("Exito en [08] caso 3.3 para A = %b, B = %b", A[DATA_WIDTH-8], B[DATA_WIDTH-8]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-8], B[DATA_WIDTH-8], Out[DATA_WIDTH-8], OutExpected[DATA_WIDTH-8]));
		
		//Caso en [07] 4.1: suma sin carry
		assert (Out[DATA_WIDTH-9] == OutExpected[DATA_WIDTH-9] && C[DATA_WIDTH-9] == CExpected[DATA_WIDTH-9] && N[DATA_WIDTH-9] == NExpected[DATA_WIDTH-9] && V[DATA_WIDTH-9] == VExpected[DATA_WIDTH-9] && Z[DATA_WIDTH-9] == ZExpected[DATA_WIDTH-9]) $display ($sformatf("Exito en [07] caso 4.1 para A = %b, B = %b", A[DATA_WIDTH-9], B[DATA_WIDTH-9]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-9], B[DATA_WIDTH-9], Out[DATA_WIDTH-9], OutExpected[DATA_WIDTH-9]));
		
		//Caso en [06] 4.3: suma con carry que se propaga
		assert (Out[DATA_WIDTH-10] == OutExpected[DATA_WIDTH-10] && C[DATA_WIDTH-10] == CExpected[DATA_WIDTH-10] && N[DATA_WIDTH-10] == NExpected[DATA_WIDTH-10] && V[DATA_WIDTH-10] == VExpected[DATA_WIDTH-10] && Z[DATA_WIDTH-10] == ZExpected[DATA_WIDTH-10]) $display ($sformatf("Exito en [06] caso 4.3 para A = %b, B = %b", A[DATA_WIDTH-10], B[DATA_WIDTH-10]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-10], B[DATA_WIDTH-10], Out[DATA_WIDTH-10], OutExpected[DATA_WIDTH-10]));
		
		//Caso en [05] 4.5: suma que da cero
		assert (Out[DATA_WIDTH-11] == OutExpected[DATA_WIDTH-11] && C[DATA_WIDTH-11] == CExpected[DATA_WIDTH-11] && N[DATA_WIDTH-11] == NExpected[DATA_WIDTH-11] && V[DATA_WIDTH-11] == VExpected[DATA_WIDTH-11] && Z[DATA_WIDTH-11] == ZExpected[DATA_WIDTH-11]) $display ($sformatf("Exito en [05] caso 4.5 para A = %b, B = %b", A[DATA_WIDTH-11], B[DATA_WIDTH-11]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-11], B[DATA_WIDTH-11], Out[DATA_WIDTH-11], OutExpected[DATA_WIDTH-11]));
		
		//Caso en [04] 5.1: suma sin carry
		assert (Out[DATA_WIDTH-12] == OutExpected[DATA_WIDTH-12] && C[DATA_WIDTH-12] == CExpected[DATA_WIDTH-12] && N[DATA_WIDTH-12] == NExpected[DATA_WIDTH-12] && V[DATA_WIDTH-12] == VExpected[DATA_WIDTH-12] && Z[DATA_WIDTH-12] == ZExpected[DATA_WIDTH-12]) $display ($sformatf("Exito en [04] caso 5.1 para A = %b, B = %b", A[DATA_WIDTH-12], B[DATA_WIDTH-12]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-12], B[DATA_WIDTH-12], Out[DATA_WIDTH-12], OutExpected[DATA_WIDTH-12]));
		
		//Caso en [03] 5.3: suma con carry que se propaga
		assert (Out[DATA_WIDTH-13] == OutExpected[DATA_WIDTH-13] && C[DATA_WIDTH-13] == CExpected[DATA_WIDTH-13] && N[DATA_WIDTH-13] == NExpected[DATA_WIDTH-13] && V[DATA_WIDTH-13] == VExpected[DATA_WIDTH-13] && Z[DATA_WIDTH-13] == ZExpected[DATA_WIDTH-13]) $display ($sformatf("Exito en [03] caso 5.3 para A = %b, B = %b", A[DATA_WIDTH-13], B[DATA_WIDTH-13]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-13], B[DATA_WIDTH-13], Out[DATA_WIDTH-13], OutExpected[DATA_WIDTH-13]));
		
		//Caso en [02] 6.1: suma sin overflow ni carry
		assert (Out[DATA_WIDTH-14] == OutExpected[DATA_WIDTH-14] && C[DATA_WIDTH-14] == CExpected[DATA_WIDTH-14] && N[DATA_WIDTH-14] == NExpected[DATA_WIDTH-14] && V[DATA_WIDTH-14] == VExpected[DATA_WIDTH-14] && Z[DATA_WIDTH-14] == ZExpected[DATA_WIDTH-14]) $display ($sformatf("Exito en [02] caso 6.1 para A = %b, B = %b", A[DATA_WIDTH-14], B[DATA_WIDTH-14]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-14], B[DATA_WIDTH-14], Out[DATA_WIDTH-14], OutExpected[DATA_WIDTH-14]));
		
		//Caso en [01] 6.3: suma con carry que se propaga
		assert (Out[DATA_WIDTH-15] == OutExpected[DATA_WIDTH-15] && C[DATA_WIDTH-15] == CExpected[DATA_WIDTH-15] && N[DATA_WIDTH-15] == NExpected[DATA_WIDTH-15] && V[DATA_WIDTH-15] == VExpected[DATA_WIDTH-15] && Z[DATA_WIDTH-15] == ZExpected[DATA_WIDTH-15]) $display ($sformatf("Exito en [01] caso 6.3 para A = %b, B = %b", A[DATA_WIDTH-15], B[DATA_WIDTH-15]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-15], B[DATA_WIDTH-15], Out[DATA_WIDTH-15], OutExpected[DATA_WIDTH-15]));
		
		//Caso en [00] 6.4 suma con carry que se propaga con overflow	
		assert (Out[DATA_WIDTH-16] == OutExpected[DATA_WIDTH-16] && C[DATA_WIDTH-16] == CExpected[DATA_WIDTH-16] && N[DATA_WIDTH-16] == NExpected[DATA_WIDTH-16] && V[DATA_WIDTH-16] == VExpected[DATA_WIDTH-16] && Z[DATA_WIDTH-16] == ZExpected[DATA_WIDTH-16]) $display ($sformatf("Exito en [00] caso 6.4 para A = %b, B = %b", A[DATA_WIDTH-16], B[DATA_WIDTH-16]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-16], B[DATA_WIDTH-16], Out[DATA_WIDTH-16], OutExpected[DATA_WIDTH-16]));
		
		//Casos Resta
		$display ("==============RESTADOR===============");
		opcode = 2'b01;

		//Caso en [15] caso 1.2: suma con carry que no se propaga
		//                               IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-1] 				= 16'b0000101010000000; //10,500
		B[DATA_WIDTH-1] 				= 16'b0000000101100000; // 1,375
		OutExpected[DATA_WIDTH-1]  = 16'b0000100100100000; // 9,125
		
		OutIntegerExpected[DATA_WIDTH-1] 	= 8'b00001001;
		OutFraccionalExpected[DATA_WIDTH-1] = 8'b00100000;
		
		CExpected[DATA_WIDTH-1]=0;
		NExpected[DATA_WIDTH-1]=0;
		VExpected[DATA_WIDTH-1]=0;
		ZExpected[DATA_WIDTH-1]=0;

		//Caso en [14] caso 1.4: suma con carry que se propaga con A y B en 0
		//                               IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-2] 				= 16'b0000101000010000; //10,0625
		B[DATA_WIDTH-2] 				= 16'b0000000100100000; // 1,1250
		OutExpected[DATA_WIDTH-2]  = 16'b0000100011110000; // 8,9375
		
		OutIntegerExpected[DATA_WIDTH-2] 	= 8'b00001000;
		OutFraccionalExpected[DATA_WIDTH-2] = 8'b11110000;
		
		CExpected[DATA_WIDTH-2]=1;
		NExpected[DATA_WIDTH-2]=0;
		VExpected[DATA_WIDTH-2]=0;
		ZExpected[DATA_WIDTH-2]=0;

		//Caso en [13] caso 1.5: suma que da cero
		//                               IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-3] 				= 16'b0000000100010000; // 1,0625
		B[DATA_WIDTH-3] 				= 16'b0000000100010000; // 1,0625
		OutExpected[DATA_WIDTH-3]  = 16'b0000000000000000; // 0,0
		
		OutIntegerExpected[DATA_WIDTH-3] 	= 8'b00000000;
		OutFraccionalExpected[DATA_WIDTH-3] = 8'b00000000;
		
		CExpected[DATA_WIDTH-3]=0;
		NExpected[DATA_WIDTH-3]=0;
		VExpected[DATA_WIDTH-3]=0;
		ZExpected[DATA_WIDTH-3]=1;

		//Caso en [12] caso 2.2: suma con carry que no se propaga
		//                               IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-4] 				= 16'b0000001001100000; // 2,375
		B[DATA_WIDTH-4] 				= 16'b0000010010100000; // 4,625
		OutExpected[DATA_WIDTH-4]  = 16'b1111111001000000; //-2,250
		
		OutIntegerExpected[DATA_WIDTH-4] 	= 8'b11111110;
		OutFraccionalExpected[DATA_WIDTH-4] = 8'b01000000;
		
		CExpected[DATA_WIDTH-4]=0;
		NExpected[DATA_WIDTH-4]=1;
		VExpected[DATA_WIDTH-4]=0;
		ZExpected[DATA_WIDTH-4]=0;

		//Caso en [11] caso 2.4: suma con carry que se propaga con A y B en 0
		//                               IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-5] 				= 16'b0000001000100000; // 2,1250
		B[DATA_WIDTH-5] 				= 16'b0000010000010000; // 4,0625
		OutExpected[DATA_WIDTH-5]  = 16'b1111111111110000; //-1,9375
		
		OutIntegerExpected[DATA_WIDTH-5] 	= 8'b11111111;
		OutFraccionalExpected[DATA_WIDTH-5] = 8'b11110000;
		
		CExpected[DATA_WIDTH-5]=1;
		NExpected[DATA_WIDTH-5]=1;
		VExpected[DATA_WIDTH-5]=0;
		ZExpected[DATA_WIDTH-5]=0;

		//Caso en [10] caso 3.2: suma con carry que no se propaga
		//                               IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-6] 				= 16'b0000000110100000; // 1,625
		B[DATA_WIDTH-6] 				= 16'b1111111100100000; //-1,125
		OutExpected[DATA_WIDTH-6]  = 16'b0000001011000000; // 2,750
		
		OutIntegerExpected[DATA_WIDTH-6] 	= 8'b00000010;
		OutFraccionalExpected[DATA_WIDTH-6] = 8'b11000000;
		
		CExpected[DATA_WIDTH-6]=0;
		NExpected[DATA_WIDTH-6]=0;
		VExpected[DATA_WIDTH-6]=0;
		ZExpected[DATA_WIDTH-6]=0;
		
		//Caso en [09] caso 3.3: suma con carry que se propaga
		//                               IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-7] 				= 16'b0000101010100000; //10,625
		B[DATA_WIDTH-7] 				= 16'b1111111010100000; //-2,625
		OutExpected[DATA_WIDTH-7]  = 16'b0000110101000000; //13,250
		
		OutIntegerExpected[DATA_WIDTH-7] 	= 8'b00001101;
		OutFraccionalExpected[DATA_WIDTH-7] = 8'b01000000;
		
		CExpected[DATA_WIDTH-7]=1;
		NExpected[DATA_WIDTH-7]=0;
		VExpected[DATA_WIDTH-7]=0;
		ZExpected[DATA_WIDTH-7]=0;

		//Caso en [08] caso 3.4: suma con carry que se propaga con overflow
		//                               IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-8] 				= 16'b0011111110100000; // 63,625
		B[DATA_WIDTH-8] 				= 16'b1000000010100000; //-64,625
		OutExpected[DATA_WIDTH-8]  = 16'b0111111101000000; //127,250
		
		OutIntegerExpected[DATA_WIDTH-8] 	= 8'b01111111;
		OutFraccionalExpected[DATA_WIDTH-8] = 8'b01000000;
		
		CExpected[DATA_WIDTH-8]=1;
		NExpected[DATA_WIDTH-8]=0;
		VExpected[DATA_WIDTH-8]=1;
		ZExpected[DATA_WIDTH-8]=0;
		
		//Caso en [07] caso 4.2: suma con carry que no se propaga
		//                               IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-9] 				= 16'b1111110000100000; //-4,125
		B[DATA_WIDTH-9] 				= 16'b0000001010100000; // 2,625
		OutExpected[DATA_WIDTH-9]  = 16'b1111101011000000; //-6,750
		
		OutIntegerExpected[DATA_WIDTH-9] 	= 8'b11111010;
		OutFraccionalExpected[DATA_WIDTH-9] = 8'b11000000;
		
		CExpected[DATA_WIDTH-9]=0;
		NExpected[DATA_WIDTH-9]=1;
		VExpected[DATA_WIDTH-9]=0;
		ZExpected[DATA_WIDTH-9]=0;

		//Caso en [06] caso 4.3: suma con carry que se propaga
		//                               IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-10] 				= 16'b1111110010000000; //-4.50
		B[DATA_WIDTH-10] 				= 16'b0000001011000000; // 2.75
		OutExpected[DATA_WIDTH-10] = 16'b1111100101000000; //-7.25
		
		OutIntegerExpected[DATA_WIDTH-10] 	= 8'b11111001;
		OutFraccionalExpected[DATA_WIDTH-10]= 8'b01000000;
		
		CExpected[DATA_WIDTH-10]=1;
		NExpected[DATA_WIDTH-10]=1;
		VExpected[DATA_WIDTH-10]=0;
		ZExpected[DATA_WIDTH-10]=0;

		//Caso en [05] caso 4.4 suma con carry que se propaga con overflow
		//                               IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-11] 				= 16'b1100000010000000; // -64,50
		B[DATA_WIDTH-11] 				= 16'b0100000011000000; //  64,75
		OutExpected[DATA_WIDTH-11] = 16'b1000000001000000; //-128,25
		
		OutIntegerExpected[DATA_WIDTH-11]	= 8'b10000000;
		OutFraccionalExpected[DATA_WIDTH-11]= 8'b01000000;
		
		CExpected[DATA_WIDTH-11]=1;
		NExpected[DATA_WIDTH-11]=1;
		VExpected[DATA_WIDTH-11]=1;
		ZExpected[DATA_WIDTH-11]=0;
		
		//Caso en [04] caso 5.2: suma con carry que no se propaga
		//                               IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-12] 				= 16'b1111110010000000; //-4.50
		B[DATA_WIDTH-12] 				= 16'b1111111001000000; //-2.25
		OutExpected[DATA_WIDTH-12] = 16'b1111111001000000; //-2.25
		
		OutIntegerExpected[DATA_WIDTH-12] 	= 8'b11111110;
		OutFraccionalExpected[DATA_WIDTH-12]= 8'b01000000;
		
		CExpected[DATA_WIDTH-12]=0;
		NExpected[DATA_WIDTH-12]=1;
		VExpected[DATA_WIDTH-12]=0;
		ZExpected[DATA_WIDTH-12]=0;

		//Caso en [03] caso 5.4: suma con carry que se propaga con A y B en 0
		//                               IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-13] 				= 16'b1111110000010000; //-4,0625
		B[DATA_WIDTH-13] 				= 16'b1111111000100000; //-2,1250
		OutExpected[DATA_WIDTH-13] = 16'b1111111111110000; //-1,9375
		
		OutIntegerExpected[DATA_WIDTH-13] 	= 8'b11111111;
		OutFraccionalExpected[DATA_WIDTH-13]= 8'b11110000;
		
		CExpected[DATA_WIDTH-13]=1;
		NExpected[DATA_WIDTH-13]=1;
		VExpected[DATA_WIDTH-13]=0;
		ZExpected[DATA_WIDTH-13]=0;

		//Caso en [02] caso 5.5: suma que da cero
		//                               IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-14] 				= 16'b1111111100010000; //-1,0625
		B[DATA_WIDTH-14] 				= 16'b1111111100010000; //-1,0625
		OutExpected[DATA_WIDTH-14] = 16'b0000000000000000; // 0,0
		
		OutIntegerExpected[DATA_WIDTH-14] 	= 8'b00000000;
		OutFraccionalExpected[DATA_WIDTH-14]= 8'b00000000;
		
		CExpected[DATA_WIDTH-14]=0;
		ZExpected[DATA_WIDTH-14]=1;
		VExpected[DATA_WIDTH-14]=0;
		NExpected[DATA_WIDTH-14]=0;

		//Caso en [01] caso 6.2: suma con carry que no se propaga
		//                               IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-15] 				= 16'b1111111001000000; //-2.25
		B[DATA_WIDTH-15] 				= 16'b1111110010000000; //-4.50
		OutExpected[DATA_WIDTH-15] = 16'b0000001001000000; // 2.25
		
		OutIntegerExpected[DATA_WIDTH-15]   = 8'b00000010;
		OutFraccionalExpected[DATA_WIDTH-15]= 8'b01000000;
		
		CExpected[DATA_WIDTH-15]=0;
		NExpected[DATA_WIDTH-15]=0;
		VExpected[DATA_WIDTH-15]=0;
		ZExpected[DATA_WIDTH-15]=0;

		//Caso en [00] caso 6.4: suma con carry que se propaga con A y B en 0
		//                               IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-16] 				= 16'b1111111000100000; //-2.1250
		B[DATA_WIDTH-16] 				= 16'b1111110000010000; //-4.0625
		OutExpected[DATA_WIDTH-16] = 16'b0000000111110000; // 1.9375
		
		OutIntegerExpected[DATA_WIDTH-16] 	= 8'b00000001;
		OutFraccionalExpected[DATA_WIDTH-16]= 8'b11110000;
		
		CExpected[DATA_WIDTH-16]=1;
		NExpected[DATA_WIDTH-16]=0;
		VExpected[DATA_WIDTH-16]=0;
		ZExpected[DATA_WIDTH-16]=0;

		#DELAY
		
		//Verificacion de los casos
		//Caso en [15] caso 1.2: suma con carry que no se propaga
		assert (Out[DATA_WIDTH-1] == OutExpected[DATA_WIDTH-1] && C[DATA_WIDTH-1] == CExpected[DATA_WIDTH-1] && N[DATA_WIDTH-1] == NExpected[DATA_WIDTH-1] && V[DATA_WIDTH-1] == VExpected[DATA_WIDTH-1] && Z[DATA_WIDTH-1] == ZExpected[DATA_WIDTH-1]) $display ($sformatf("Exito en [15] caso 1.2 para A = %b, B = %b", A[DATA_WIDTH-1], B[DATA_WIDTH-1]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-1], B[DATA_WIDTH-1], Out[DATA_WIDTH-1], OutExpected[DATA_WIDTH-1]));
				
		//Caso en [14] caso 1.4: suma con carry que se propaga con A y B en 0
		assert (Out[DATA_WIDTH-2] == OutExpected[DATA_WIDTH-2] && C[DATA_WIDTH-2] == CExpected[DATA_WIDTH-2] && N[DATA_WIDTH-2] == NExpected[DATA_WIDTH-2] && V[DATA_WIDTH-2] == VExpected[DATA_WIDTH-2] && Z[DATA_WIDTH-2] == ZExpected[DATA_WIDTH-2]) $display ($sformatf("Exito en [14] caso 1.4 para A = %b, B = %b", A[DATA_WIDTH-2], B[DATA_WIDTH-2]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-2], B[DATA_WIDTH-2], Out[DATA_WIDTH-2], OutExpected[DATA_WIDTH-2]));
		
		//Caso en [13] caso 1.5: suma que da cero
		assert (Out[DATA_WIDTH-3] == OutExpected[DATA_WIDTH-3] && C[DATA_WIDTH-3] == CExpected[DATA_WIDTH-3] && N[DATA_WIDTH-3] == NExpected[DATA_WIDTH-3] && V[DATA_WIDTH-3] == VExpected[DATA_WIDTH-3] && Z[DATA_WIDTH-3] == ZExpected[DATA_WIDTH-3]) $display ($sformatf("Exito en [13] caso 1.5 para A = %b, B = %b", A[DATA_WIDTH-3], B[DATA_WIDTH-3]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-3], B[DATA_WIDTH-3], Out[DATA_WIDTH-3], OutExpected[DATA_WIDTH-3]));

		//Caso en [12] caso 2.2: suma con carry que no se propaga
		assert (Out[DATA_WIDTH-4] == OutExpected[DATA_WIDTH-4] && C[DATA_WIDTH-4] == CExpected[DATA_WIDTH-4] && N[DATA_WIDTH-4] == NExpected[DATA_WIDTH-4] && V[DATA_WIDTH-4] == VExpected[DATA_WIDTH-4] && Z[DATA_WIDTH-4] == ZExpected[DATA_WIDTH-4]) $display ($sformatf("Exito en [12] caso 2.2 para A = %b, B = %b", A[DATA_WIDTH-4], B[DATA_WIDTH-4]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-4], B[DATA_WIDTH-4], Out[DATA_WIDTH-4], OutExpected[DATA_WIDTH-4]));
		
		//Caso en [11] caso 2.4: suma con carry que se propaga con A y B en 0
		assert (Out[DATA_WIDTH-5] == OutExpected[DATA_WIDTH-5] && C[DATA_WIDTH-5] == CExpected[DATA_WIDTH-5] && N[DATA_WIDTH-5] == NExpected[DATA_WIDTH-5] && V[DATA_WIDTH-5] == VExpected[DATA_WIDTH-5] && Z[DATA_WIDTH-5] == ZExpected[DATA_WIDTH-5]) $display ($sformatf("Exito en [11] caso 2.4 para A = %b, B = %b", A[DATA_WIDTH-5], B[DATA_WIDTH-5]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-5], B[DATA_WIDTH-5], Out[DATA_WIDTH-5], OutExpected[DATA_WIDTH-5]));
		
		//Caso en [10] caso 3.2: suma con carry que no se propaga
		assert (Out[DATA_WIDTH-6] == OutExpected[DATA_WIDTH-6] && C[DATA_WIDTH-6] == CExpected[DATA_WIDTH-6] && N[DATA_WIDTH-6] == NExpected[DATA_WIDTH-6] && V[DATA_WIDTH-6] == VExpected[DATA_WIDTH-6] && Z[DATA_WIDTH-6] == ZExpected[DATA_WIDTH-6]) $display ($sformatf("Exito en [10] caso 3.2 para A = %b, B = %b", A[DATA_WIDTH-6], B[DATA_WIDTH-6]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-6], B[DATA_WIDTH-6], Out[DATA_WIDTH-6], OutExpected[DATA_WIDTH-6]));

		//Caso en [09] caso 3.3: suma con carry que se propaga
		assert (Out[DATA_WIDTH-7] == OutExpected[DATA_WIDTH-7] && C[DATA_WIDTH-7] == CExpected[DATA_WIDTH-7] && N[DATA_WIDTH-7] == NExpected[DATA_WIDTH-7] && V[DATA_WIDTH-7] == VExpected[DATA_WIDTH-7] && Z[DATA_WIDTH-7] == ZExpected[DATA_WIDTH-7]) $display ($sformatf("Exito en [09] caso 3.3 para A = %b, B = %b", A[DATA_WIDTH-7], B[DATA_WIDTH-7]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-7], B[DATA_WIDTH-7], Out[DATA_WIDTH-7], OutExpected[DATA_WIDTH-7]));

		//Caso en [08] caso 3.4: suma con carry que se propaga con overflow
		assert (Out[DATA_WIDTH-8] == OutExpected[DATA_WIDTH-8] && C[DATA_WIDTH-8] == CExpected[DATA_WIDTH-8] && N[DATA_WIDTH-8] == NExpected[DATA_WIDTH-8] && V[DATA_WIDTH-8] == VExpected[DATA_WIDTH-8] && Z[DATA_WIDTH-8] == ZExpected[DATA_WIDTH-8]) $display ($sformatf("Exito en [08] caso 3.4 para A = %b, B = %b", A[DATA_WIDTH-8], B[DATA_WIDTH-8]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-8], B[DATA_WIDTH-8], Out[DATA_WIDTH-8], OutExpected[DATA_WIDTH-8]));
		
		//Caso en [07] caso 4.2: suma con carry que no se propaga
		assert (Out[DATA_WIDTH-9] == OutExpected[DATA_WIDTH-9] && C[DATA_WIDTH-9] == CExpected[DATA_WIDTH-9] && N[DATA_WIDTH-9] == NExpected[DATA_WIDTH-9] && V[DATA_WIDTH-9] == VExpected[DATA_WIDTH-9] && Z[DATA_WIDTH-9] == ZExpected[DATA_WIDTH-9]) $display ($sformatf("Exito en [07] caso 4.2 para A = %b, B = %b", A[DATA_WIDTH-9], B[DATA_WIDTH-9]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-9], B[DATA_WIDTH-9], Out[DATA_WIDTH-9], OutExpected[DATA_WIDTH-9]));

		//Caso en [06] caso 4.3: suma con carry que se propaga
		assert (Out[DATA_WIDTH-10] == OutExpected[DATA_WIDTH-10] && C[DATA_WIDTH-10] == CExpected[DATA_WIDTH-10] && N[DATA_WIDTH-10] == NExpected[DATA_WIDTH-10] && V[DATA_WIDTH-10] == VExpected[DATA_WIDTH-10] && Z[DATA_WIDTH-10] == ZExpected[DATA_WIDTH-10]) $display ($sformatf("Exito en [06] caso 4.3 para A = %b, B = %b", A[DATA_WIDTH-10], B[DATA_WIDTH-10]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-10], B[DATA_WIDTH-10], Out[DATA_WIDTH-10], OutExpected[DATA_WIDTH-10]));
		
		//Caso en [05] caso 4.4 suma con carry que se propaga con overflow
		assert (Out[DATA_WIDTH-11] == OutExpected[DATA_WIDTH-11] && C[DATA_WIDTH-11] == CExpected[DATA_WIDTH-11] && N[DATA_WIDTH-11] == NExpected[DATA_WIDTH-11] && V[DATA_WIDTH-11] == VExpected[DATA_WIDTH-11] && Z[DATA_WIDTH-11] == ZExpected[DATA_WIDTH-11]) $display ($sformatf("Exito en [05] caso 4.4 para A = %b, B = %b", A[DATA_WIDTH-11], B[DATA_WIDTH-11]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-11], B[DATA_WIDTH-11], Out[DATA_WIDTH-11], OutExpected[DATA_WIDTH-11]));

		//Caso en [04] caso 5.2: suma con carry que no se propaga
		assert (Out[DATA_WIDTH-12] == OutExpected[DATA_WIDTH-12] && C[DATA_WIDTH-12] == CExpected[DATA_WIDTH-12] && N[DATA_WIDTH-12] == NExpected[DATA_WIDTH-12] && V[DATA_WIDTH-12] == VExpected[DATA_WIDTH-12] && Z[DATA_WIDTH-12] == ZExpected[DATA_WIDTH-12]) $display ($sformatf("Exito en [04] caso 5.2 para A = %b, B = %b", A[DATA_WIDTH-12], B[DATA_WIDTH-12]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-12], B[DATA_WIDTH-12], Out[DATA_WIDTH-12], OutExpected[DATA_WIDTH-12]));
		
		//Caso en [03] caso 5.4: suma con carry que se propaga con A y B en 0
		assert (Out[DATA_WIDTH-13] == OutExpected[DATA_WIDTH-13] && C[DATA_WIDTH-13] == CExpected[DATA_WIDTH-13] && N[DATA_WIDTH-13] == NExpected[DATA_WIDTH-13] && V[DATA_WIDTH-13] == VExpected[DATA_WIDTH-13] && Z[DATA_WIDTH-13] == ZExpected[DATA_WIDTH-13]) $display ($sformatf("Exito en [03] caso 5.4 para A = %b, B = %b", A[DATA_WIDTH-13], B[DATA_WIDTH-13]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-13], B[DATA_WIDTH-13], Out[DATA_WIDTH-13], OutExpected[DATA_WIDTH-13]));
		
		//Caso en [02] caso 5.5: suma que da cero
		assert (Out[DATA_WIDTH-14] == OutExpected[DATA_WIDTH-14] && C[DATA_WIDTH-14] == CExpected[DATA_WIDTH-14] && N[DATA_WIDTH-14] == NExpected[DATA_WIDTH-14] && V[DATA_WIDTH-14] == VExpected[DATA_WIDTH-14] && Z[DATA_WIDTH-14] == ZExpected[DATA_WIDTH-14]) $display ($sformatf("Exito en [02] caso 5.5 para A = %b, B = %b", A[DATA_WIDTH-14], B[DATA_WIDTH-14]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-14], B[DATA_WIDTH-14], Out[DATA_WIDTH-14], OutExpected[DATA_WIDTH-14]));
		
		//Caso en [01] caso 6.2: suma con carry que no se propaga
		assert (Out[DATA_WIDTH-15] == OutExpected[DATA_WIDTH-15] && C[DATA_WIDTH-15] == CExpected[DATA_WIDTH-15] && N[DATA_WIDTH-15] == NExpected[DATA_WIDTH-15] && V[DATA_WIDTH-15] == VExpected[DATA_WIDTH-15] && Z[DATA_WIDTH-15] == ZExpected[DATA_WIDTH-15]) $display ($sformatf("Exito en [01] caso 6.2 para A = %b, B = %b", A[DATA_WIDTH-15], B[DATA_WIDTH-15]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-15], B[DATA_WIDTH-15], Out[DATA_WIDTH-15], OutExpected[DATA_WIDTH-15]));
		
		//Caso en [00] caso 6.4: suma con carry que se propaga con A y B en 0
		assert (Out[DATA_WIDTH-16] == OutExpected[DATA_WIDTH-16] && C[DATA_WIDTH-16] == CExpected[DATA_WIDTH-16] && N[DATA_WIDTH-16] == NExpected[DATA_WIDTH-16] && V[DATA_WIDTH-16] == VExpected[DATA_WIDTH-16] && Z[DATA_WIDTH-16] == ZExpected[DATA_WIDTH-16]) $display ($sformatf("Exito en [00] caso 6.4 para A = %b, B = %b", A[DATA_WIDTH-16], B[DATA_WIDTH-16]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-16], B[DATA_WIDTH-16], Out[DATA_WIDTH-16], OutExpected[DATA_WIDTH-16]));
		
		//Casos Multiplicacion
		$display ("============MULTIPLICADOR============");
		opcode = 2'b10;
	
		//Caso en [15] Caso 1: mult de positivo con positivo con numeros pequeños
		//                               IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-1]  				= 16'b0000010101000000; // 5,250
		B[DATA_WIDTH-1] 				= 16'b0000001010000000; // 2,500
		OutExpected[DATA_WIDTH-1]  = 16'b0000110100100000; //13,125
		
		OutIntegerExpected[DATA_WIDTH-1] 	= 8'b00001101;
		OutFraccionalExpected[DATA_WIDTH-1] = 8'b00100000;
		
		CExpected[DATA_WIDTH-1]=0;
		NExpected[DATA_WIDTH-1]=0;
		VExpected[DATA_WIDTH-1]=0;
		ZExpected[DATA_WIDTH-1]=0;	
		
		//Caso en [14] Caso 2: mult de positivo con positivo con numeros grandes
		//                               IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-2] 				= 16'b0110010011000000; //100,750
		B[DATA_WIDTH-2] 				= 16'b0110010010000000; //100,500
		OutExpected[DATA_WIDTH-2]  = 16'b0111111101100000; //127,375
		
		OutIntegerExpected[DATA_WIDTH-2] 	= 8'b01111111;
		OutFraccionalExpected[DATA_WIDTH-2] = 8'b01100000;
		
		CExpected[DATA_WIDTH-2]=0;
		NExpected[DATA_WIDTH-2]=0;
		VExpected[DATA_WIDTH-2]=1;
		ZExpected[DATA_WIDTH-2]=0;	
		
		//Caso en [13] Caso 3: mult de positivo con negativo con numeros pequeños
		//                               IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-3] 				= 16'b0000010101000000; //  5,250
		B[DATA_WIDTH-3] 				= 16'b1111111010000000; // -2,500
		OutExpected[DATA_WIDTH-3]  = 16'b1111001100100000; //-13,125
		
		OutIntegerExpected[DATA_WIDTH-3] 	 = 8'b11110011;
		OutFraccionalExpected[DATA_WIDTH-3]  = 8'b00100000;
		
		CExpected[DATA_WIDTH-3]=0;
		NExpected[DATA_WIDTH-3]=1;
		VExpected[DATA_WIDTH-3]=0;
		ZExpected[DATA_WIDTH-3]=0;	
		
		//Caso en [12] Caso 4: mult de negativo con positivo con numeros pequeños
		//                               IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-4] 				= 16'b1111111010000000; // -2,500
		B[DATA_WIDTH-4] 				= 16'b0000010101000000; //  5,250
		OutExpected[DATA_WIDTH-4]  = 16'b1111001100100000; //-13,125
		
		OutIntegerExpected[DATA_WIDTH-4] 	= 8'b11110011;
		OutFraccionalExpected[DATA_WIDTH-4] = 8'b00100000;
		
		CExpected[DATA_WIDTH-4]=0;
		NExpected[DATA_WIDTH-4]=1;
		VExpected[DATA_WIDTH-4]=0;
		ZExpected[DATA_WIDTH-4]=0;	
		
		//Caso en [11] Caso 5: mult de negativo con negativo con numeros pequeños
		//                               IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-5] 				= 16'b1111111010000000; //-2,50
		B[DATA_WIDTH-5] 				= 16'b1111111010000000; //-2,50
		OutExpected[DATA_WIDTH-5]  = 16'b0000011001000000; // 6,25
		
		OutIntegerExpected[DATA_WIDTH-5] 	= 8'b00000110;
		OutFraccionalExpected[DATA_WIDTH-5] = 8'b01000000;
		
		CExpected[DATA_WIDTH-5]=0;
		NExpected[DATA_WIDTH-5]=0;
		VExpected[DATA_WIDTH-5]=0;
		ZExpected[DATA_WIDTH-5]=0;	
		
		//Caso en [10] Caso 6: mult de negativo con positivo con numeros grandes
		//                               IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-6] 				= 16'b1110000000010000; //- 32,0625000
		B[DATA_WIDTH-6] 				= 16'b0000100000100000; //   8,1250000
		OutExpected[DATA_WIDTH-6]  = 16'b1000000010000010; //-128,5078125
		
		OutIntegerExpected[DATA_WIDTH-6]	   = 8'b10000000;
		OutFraccionalExpected[DATA_WIDTH-6] = 8'b10000010;
		
		CExpected[DATA_WIDTH-6]=0;
		NExpected[DATA_WIDTH-6]=1;
		VExpected[DATA_WIDTH-6]=1;
		ZExpected[DATA_WIDTH-6]=0;	
		
		//Caso en [09] Caso 7: mult por cero
		//                               IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-7] 				= 16'b0110010011000000; //100,750
		B[DATA_WIDTH-7] 				= 16'b0000000000000000; //  0,000
		OutExpected[DATA_WIDTH-7]  = 16'b0000000000000000; //  0,000
		
		OutIntegerExpected[DATA_WIDTH-7] 	= 8'b00000000;
		OutFraccionalExpected[DATA_WIDTH-7] = 8'b00000000;
		
		CExpected[DATA_WIDTH-7]=0;
		NExpected[DATA_WIDTH-7]=0;
		VExpected[DATA_WIDTH-7]=0;
		ZExpected[DATA_WIDTH-7]=1;	
		
		//Caso en [08] Caso 1: mult de positivo con positivo con numeros pequeños
		//                               IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-8]  				= 16'b0000010101000000; // 5,250
		B[DATA_WIDTH-8] 				= 16'b0000001010000000; // 2,500
		OutExpected[DATA_WIDTH-8]  = 16'b0000110100100000; //13,125
		
		OutIntegerExpected[DATA_WIDTH-8] 	= 8'b00001101;
		OutFraccionalExpected[DATA_WIDTH-8] = 8'b00100000;
		
		CExpected[DATA_WIDTH-8]=0;
		NExpected[DATA_WIDTH-8]=0;
		VExpected[DATA_WIDTH-8]=0;
		ZExpected[DATA_WIDTH-8]=0;	
		
		//Caso en [07] Caso 2: mult de positivo con positivo con numeros grandes
		//                               IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-9] 				= 16'b0110010011000000; //100,750
		B[DATA_WIDTH-9] 				= 16'b0110010010000000; //100,500
		OutExpected[DATA_WIDTH-9]  = 16'b0111111101100000; //127,375
		
		OutIntegerExpected[DATA_WIDTH-9] 	= 8'b01111111;
		OutFraccionalExpected[DATA_WIDTH-9] = 8'b01100000;
		
		CExpected[DATA_WIDTH-9]=0;
		NExpected[DATA_WIDTH-9]=0;
		VExpected[DATA_WIDTH-9]=1;
		ZExpected[DATA_WIDTH-9]=0;	
		
		//Caso en [06] Caso 3: mult de positivo con negativo con numeros pequeños
		//                               IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-10] 				= 16'b0000010101000000; //  5,250
		B[DATA_WIDTH-10] 		   	= 16'b1111111010000000; // -2,500
		OutExpected[DATA_WIDTH-10] = 16'b1111001100100000; //-13,125
		
		OutIntegerExpected[DATA_WIDTH-10] 	= 8'b11110011;
		OutFraccionalExpected[DATA_WIDTH-10]= 8'b00100000;
		
		CExpected[DATA_WIDTH-10]=0;
		NExpected[DATA_WIDTH-10]=1;
		VExpected[DATA_WIDTH-10]=0;
		ZExpected[DATA_WIDTH-10]=0;	
		
		//Caso en [05] Caso 4: mult de negativo con positivo con numeros pequeños
		//                               IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-11] 				= 16'b1111111010000000; // -2,500
		B[DATA_WIDTH-11] 				= 16'b0000010101000000; //  5,250
		OutExpected[DATA_WIDTH-11] = 16'b1111001100100000; //-13,125
		
		OutIntegerExpected[DATA_WIDTH-11] 	= 8'b11110011;
		OutFraccionalExpected[DATA_WIDTH-11]= 8'b00100000;
		
		CExpected[DATA_WIDTH-11]=0;
		NExpected[DATA_WIDTH-11]=1;
		VExpected[DATA_WIDTH-11]=0;
		ZExpected[DATA_WIDTH-11]=0;	
		
		//Caso en [04] Caso 5: mult de negativo con negativo con numeros pequeños
		//                               IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-12] 				= 16'b1111111010000000; //-2,50
		B[DATA_WIDTH-12] 				= 16'b1111111010000000; //-2,50
		OutExpected[DATA_WIDTH-12] = 16'b0000011001000000; // 6,25
		
		OutIntegerExpected[DATA_WIDTH-12] 	= 8'b00000110;
		OutFraccionalExpected[DATA_WIDTH-12]= 8'b01000000;
		
		CExpected[DATA_WIDTH-12]=0;
		NExpected[DATA_WIDTH-12]=0;
		VExpected[DATA_WIDTH-12]=0;
		ZExpected[DATA_WIDTH-12]=0;	
		
		//Caso en [03] Caso 6: mult de negativo con positivo con numeros grandes
		//                               IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-13] 				= 16'b1110000000010000; //- 32,0625000
		B[DATA_WIDTH-13] 				= 16'b0000100000100000; //   8,1250000
		OutExpected[DATA_WIDTH-13] = 16'b1000000010000010; //-128,5078125
		
		OutIntegerExpected[DATA_WIDTH-13]	= 8'b10000000;
		OutFraccionalExpected[DATA_WIDTH-13]= 8'b10000010;
		
		CExpected[DATA_WIDTH-13]=0;
		NExpected[DATA_WIDTH-13]=1;
		VExpected[DATA_WIDTH-13]=1;
		ZExpected[DATA_WIDTH-13]=0;	
		
		//Caso en [02] Caso 7: mult por cero
		//                               IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-14] 				= 16'b0110010011000000; //100,750
		B[DATA_WIDTH-14] 				= 16'b0000000000000000; //  0,000
		OutExpected[DATA_WIDTH-14] = 16'b0000000000000000; //  0,000
		
		OutIntegerExpected[DATA_WIDTH-14] 	= 8'b00000000;
		OutFraccionalExpected[DATA_WIDTH-14]= 8'b00000000;
		
		CExpected[DATA_WIDTH-14]=0;
		NExpected[DATA_WIDTH-14]=0;
		VExpected[DATA_WIDTH-14]=0;
		ZExpected[DATA_WIDTH-14]=1;
		
		//Caso en [01] Caso 1: mult de positivo con positivo con numeros pequeños
		//                               IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-15]  			= 16'b0000010101000000; // 5,250
		B[DATA_WIDTH-15] 				= 16'b0000001010000000; // 2,500
		OutExpected[DATA_WIDTH-15] = 16'b0000110100100000; //13,125
		
		OutIntegerExpected[DATA_WIDTH-15] 	= 8'b00001101;
		OutFraccionalExpected[DATA_WIDTH-15]= 8'b00100000;
		
		CExpected[DATA_WIDTH-15]=0;
		NExpected[DATA_WIDTH-15]=0;
		VExpected[DATA_WIDTH-15]=0;
		ZExpected[DATA_WIDTH-15]=0;
		
		//Caso en [00] Caso 1: mult de positivo con positivo con numeros pequeños
		//                               IIIIIIIIFFFFFFFF
		A[DATA_WIDTH-16]  			= 16'b0000010101000000; // 5,250
		B[DATA_WIDTH-16] 				= 16'b0000001010000000; // 2,500
		OutExpected[DATA_WIDTH-16] = 16'b0000110100100000; //13,125
		
		OutIntegerExpected[DATA_WIDTH-16] 	= 8'b00001101;
		OutFraccionalExpected[DATA_WIDTH-16]= 8'b00100000;
		
		CExpected[DATA_WIDTH-16]=0;
		NExpected[DATA_WIDTH-16]=0;
		VExpected[DATA_WIDTH-16]=0;
		ZExpected[DATA_WIDTH-16]=0;	
		
		#DELAY
		//Verificacion de los casos
		//Caso en [15] Caso 1: mult de positivo con positivo con numeros pequeños
		assert (Out[DATA_WIDTH-1] == OutExpected[DATA_WIDTH-1] && C[DATA_WIDTH-1] == CExpected[DATA_WIDTH-1] && N[DATA_WIDTH-1] == NExpected[DATA_WIDTH-1] && V[DATA_WIDTH-1] == VExpected[DATA_WIDTH-1] && Z[DATA_WIDTH-1] == ZExpected[DATA_WIDTH-1]) $display ($sformatf("Exito en [15] caso 1 para A = %b, B = %b", A[DATA_WIDTH-1], B[DATA_WIDTH-1]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-1], B[DATA_WIDTH-1], Out[DATA_WIDTH-1], OutExpected[DATA_WIDTH-1]));
				
		//Caso en [14] Caso 2: mult de positivo con positivo con numeros grandes
		assert (Out[DATA_WIDTH-2] == OutExpected[DATA_WIDTH-2] && C[DATA_WIDTH-2] == CExpected[DATA_WIDTH-2] && N[DATA_WIDTH-2] == NExpected[DATA_WIDTH-2] && V[DATA_WIDTH-2] == VExpected[DATA_WIDTH-2] && Z[DATA_WIDTH-2] == ZExpected[DATA_WIDTH-2]) $display ($sformatf("Exito en [14] caso 2 para A = %b, B = %b", A[DATA_WIDTH-2], B[DATA_WIDTH-2]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-2], B[DATA_WIDTH-2], Out[DATA_WIDTH-2], OutExpected[DATA_WIDTH-2]));
		
		//Caso en [13] Caso 3: mult de positivo con negativo con numeros pequeños
		assert (Out[DATA_WIDTH-3] == OutExpected[DATA_WIDTH-3] && C[DATA_WIDTH-3] == CExpected[DATA_WIDTH-3] && N[DATA_WIDTH-3] == NExpected[DATA_WIDTH-3] && V[DATA_WIDTH-3] == VExpected[DATA_WIDTH-3] && Z[DATA_WIDTH-3] == ZExpected[DATA_WIDTH-3]) $display ($sformatf("Exito en [13] caso 3 para A = %b, B = %b", A[DATA_WIDTH-3], B[DATA_WIDTH-3]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-3], B[DATA_WIDTH-3], Out[DATA_WIDTH-3], OutExpected[DATA_WIDTH-3]));

		//Caso en [12] Caso 4: mult de negativo con positivo con numeros pequeños
		assert (Out[DATA_WIDTH-4] == OutExpected[DATA_WIDTH-4] && C[DATA_WIDTH-4] == CExpected[DATA_WIDTH-4] && N[DATA_WIDTH-4] == NExpected[DATA_WIDTH-4] && V[DATA_WIDTH-4] == VExpected[DATA_WIDTH-4] && Z[DATA_WIDTH-4] == ZExpected[DATA_WIDTH-4]) $display ($sformatf("Exito en [12] caso 4 para A = %b, B = %b", A[DATA_WIDTH-4], B[DATA_WIDTH-4]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-4], B[DATA_WIDTH-4], Out[DATA_WIDTH-4], OutExpected[DATA_WIDTH-4]));
		
		//Caso en [11] Caso 5: mult de negativo con negativo con numeros pequeños
		assert (Out[DATA_WIDTH-5] == OutExpected[DATA_WIDTH-5] && C[DATA_WIDTH-5] == CExpected[DATA_WIDTH-5] && N[DATA_WIDTH-5] == NExpected[DATA_WIDTH-5] && V[DATA_WIDTH-5] == VExpected[DATA_WIDTH-5] && Z[DATA_WIDTH-5] == ZExpected[DATA_WIDTH-5]) $display ($sformatf("Exito en [11] caso 5 para A = %b, B = %b", A[DATA_WIDTH-5], B[DATA_WIDTH-5]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-5], B[DATA_WIDTH-5], Out[DATA_WIDTH-5], OutExpected[DATA_WIDTH-5]));
		
		//Caso en [10] Caso 6: mult de negativo con positivo con numeros grandes
		assert (Out[DATA_WIDTH-6] == OutExpected[DATA_WIDTH-6] && C[DATA_WIDTH-6] == CExpected[DATA_WIDTH-6] && N[DATA_WIDTH-6] == NExpected[DATA_WIDTH-6] && V[DATA_WIDTH-6] == VExpected[DATA_WIDTH-6] && Z[DATA_WIDTH-6] == ZExpected[DATA_WIDTH-6]) $display ($sformatf("Exito en [10] caso 6 para A = %b, B = %b", A[DATA_WIDTH-6], B[DATA_WIDTH-6]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-6], B[DATA_WIDTH-6], Out[DATA_WIDTH-6], OutExpected[DATA_WIDTH-6]));

		//Caso en [09] Caso 7: mult por cero
		assert (Out[DATA_WIDTH-7] == OutExpected[DATA_WIDTH-7] && C[DATA_WIDTH-7] == CExpected[DATA_WIDTH-7] && N[DATA_WIDTH-7] == NExpected[DATA_WIDTH-7] && V[DATA_WIDTH-7] == VExpected[DATA_WIDTH-7] && Z[DATA_WIDTH-7] == ZExpected[DATA_WIDTH-7]) $display ($sformatf("Exito en [09] caso 7 para A = %b, B = %b", A[DATA_WIDTH-7], B[DATA_WIDTH-7]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-7], B[DATA_WIDTH-7], Out[DATA_WIDTH-7], OutExpected[DATA_WIDTH-7]));

		//Caso en [08] Caso 1: mult de positivo con positivo con numeros pequeños
		assert (Out[DATA_WIDTH-8] == OutExpected[DATA_WIDTH-8] && C[DATA_WIDTH-8] == CExpected[DATA_WIDTH-8] && N[DATA_WIDTH-8] == NExpected[DATA_WIDTH-8] && V[DATA_WIDTH-8] == VExpected[DATA_WIDTH-8] && Z[DATA_WIDTH-8] == ZExpected[DATA_WIDTH-8]) $display ($sformatf("Exito en [08] caso 1 para A = %b, B = %b", A[DATA_WIDTH-8], B[DATA_WIDTH-8]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-8], B[DATA_WIDTH-8], Out[DATA_WIDTH-8], OutExpected[DATA_WIDTH-8]));
		
		//Caso en [07] Caso 2: mult de positivo con positivo con numeros grandes
		assert (Out[DATA_WIDTH-9] == OutExpected[DATA_WIDTH-9] && C[DATA_WIDTH-9] == CExpected[DATA_WIDTH-9] && N[DATA_WIDTH-9] == NExpected[DATA_WIDTH-9] && V[DATA_WIDTH-9] == VExpected[DATA_WIDTH-9] && Z[DATA_WIDTH-9] == ZExpected[DATA_WIDTH-9]) $display ($sformatf("Exito en [07] caso 2 para A = %b, B = %b", A[DATA_WIDTH-9], B[DATA_WIDTH-9]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-9], B[DATA_WIDTH-9], Out[DATA_WIDTH-9], OutExpected[DATA_WIDTH-9]));

		//Caso en [06] Caso 3: mult de positivo con negativo con numeros pequeños
		assert (Out[DATA_WIDTH-10] == OutExpected[DATA_WIDTH-10] && C[DATA_WIDTH-10] == CExpected[DATA_WIDTH-10] && N[DATA_WIDTH-10] == NExpected[DATA_WIDTH-10] && V[DATA_WIDTH-10] == VExpected[DATA_WIDTH-10] && Z[DATA_WIDTH-10] == ZExpected[DATA_WIDTH-10]) $display ($sformatf("Exito en [06] caso 3 para A = %b, B = %b", A[DATA_WIDTH-10], B[DATA_WIDTH-10]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-10], B[DATA_WIDTH-10], Out[DATA_WIDTH-10], OutExpected[DATA_WIDTH-10]));
		
		//Caso en [05] Caso 4: mult de negativo con positivo con numeros pequeños
		assert (Out[DATA_WIDTH-11] == OutExpected[DATA_WIDTH-11] && C[DATA_WIDTH-11] == CExpected[DATA_WIDTH-11] && N[DATA_WIDTH-11] == NExpected[DATA_WIDTH-11] && V[DATA_WIDTH-11] == VExpected[DATA_WIDTH-11] && Z[DATA_WIDTH-11] == ZExpected[DATA_WIDTH-11]) $display ($sformatf("Exito en [05] caso 4 para A = %b, B = %b", A[DATA_WIDTH-11], B[DATA_WIDTH-11]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-11], B[DATA_WIDTH-11], Out[DATA_WIDTH-11], OutExpected[DATA_WIDTH-11]));

		//Caso en [04] Caso 5: mult de negativo con negativo con numeros pequeños
		assert (Out[DATA_WIDTH-12] == OutExpected[DATA_WIDTH-12] && C[DATA_WIDTH-12] == CExpected[DATA_WIDTH-12] && N[DATA_WIDTH-12] == NExpected[DATA_WIDTH-12] && V[DATA_WIDTH-12] == VExpected[DATA_WIDTH-12] && Z[DATA_WIDTH-12] == ZExpected[DATA_WIDTH-12]) $display ($sformatf("Exito en [04] caso 5 para A = %b, B = %b", A[DATA_WIDTH-12], B[DATA_WIDTH-12]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-12], B[DATA_WIDTH-12], Out[DATA_WIDTH-12], OutExpected[DATA_WIDTH-12]));
		
		//Caso en [03] Caso 6: mult de negativo con positivo con numeros grandes
		assert (Out[DATA_WIDTH-13] == OutExpected[DATA_WIDTH-13] && C[DATA_WIDTH-13] == CExpected[DATA_WIDTH-13] && N[DATA_WIDTH-13] == NExpected[DATA_WIDTH-13] && V[DATA_WIDTH-13] == VExpected[DATA_WIDTH-13] && Z[DATA_WIDTH-13] == ZExpected[DATA_WIDTH-13]) $display ($sformatf("Exito en [03] caso 6 para A = %b, B = %b", A[DATA_WIDTH-13], B[DATA_WIDTH-13]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-13], B[DATA_WIDTH-13], Out[DATA_WIDTH-13], OutExpected[DATA_WIDTH-13]));
		
		//Caso en [02] Caso 7: mult por cero
		assert (Out[DATA_WIDTH-14] == OutExpected[DATA_WIDTH-14] && C[DATA_WIDTH-14] == CExpected[DATA_WIDTH-14] && N[DATA_WIDTH-14] == NExpected[DATA_WIDTH-14] && V[DATA_WIDTH-14] == VExpected[DATA_WIDTH-14] && Z[DATA_WIDTH-14] == ZExpected[DATA_WIDTH-14]) $display ($sformatf("Exito en [02] caso 7 para A = %b, B = %b", A[DATA_WIDTH-14], B[DATA_WIDTH-14]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-14], B[DATA_WIDTH-14], Out[DATA_WIDTH-14], OutExpected[DATA_WIDTH-14]));
		
		//Caso en [01] Caso 1: mult de positivo con positivo con numeros pequeños
		assert (Out[DATA_WIDTH-15] == OutExpected[DATA_WIDTH-15] && C[DATA_WIDTH-15] == CExpected[DATA_WIDTH-15] && N[DATA_WIDTH-15] == NExpected[DATA_WIDTH-15] && V[DATA_WIDTH-15] == VExpected[DATA_WIDTH-15] && Z[DATA_WIDTH-15] == ZExpected[DATA_WIDTH-15]) $display ($sformatf("Exito en [01] caso 1 para A = %b, B = %b", A[DATA_WIDTH-15], B[DATA_WIDTH-15]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-15], B[DATA_WIDTH-15], Out[DATA_WIDTH-15], OutExpected[DATA_WIDTH-15]));
		
		//Caso en [00] Caso 1: mult de positivo con positivo con numeros pequeños
		assert (Out[DATA_WIDTH-16] == OutExpected[DATA_WIDTH-16] && C[DATA_WIDTH-16] == CExpected[DATA_WIDTH-16] && N[DATA_WIDTH-16] == NExpected[DATA_WIDTH-16] && V[DATA_WIDTH-16] == VExpected[DATA_WIDTH-16] && Z[DATA_WIDTH-16] == ZExpected[DATA_WIDTH-16]) $display ($sformatf("Exito en [00] caso 1 para A = %b, B = %b", A[DATA_WIDTH-16], B[DATA_WIDTH-16]));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A[DATA_WIDTH-16], B[DATA_WIDTH-16], Out[DATA_WIDTH-16], OutExpected[DATA_WIDTH-16]));
		

	end
	
endmodule
