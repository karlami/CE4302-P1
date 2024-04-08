`timescale 1ns / 10ps  // Definición de la escala de tiempo

module tb_Execution;
	
	// Parameters
	parameter DATA_WIDTH = 16;
	parameter DELAY = 10; // Delay between inputs in simulation steps

	// Inputs
	reg signed [DATA_WIDTH-1:0] A_deco_int;
	reg signed [DATA_WIDTH-1:0] B_deco_int;
	reg signed [DATA_WIDTH-1:0] A_deco_fixed;
	reg signed [DATA_WIDTH-1:0] B_deco_fixed;
	reg signed [DATA_WIDTH-1:0] A_deco_vector [DATA_WIDTH-1:0];
	reg signed [DATA_WIDTH-1:0] B_deco_vector [DATA_WIDTH-1:0];

	reg signed [DATA_WIDTH-1:0] A_ua_int;
	reg signed [DATA_WIDTH-1:0] B_ua_int;
	reg signed [DATA_WIDTH-1:0] A_ua_fixed;
	reg signed [DATA_WIDTH-1:0] B_ua_fixed;
	reg signed [DATA_WIDTH-1:0] A_ua_vector [DATA_WIDTH-1:0];
	reg signed [DATA_WIDTH-1:0] B_ua_vector [DATA_WIDTH-1:0];

	reg s_mux_A;
	reg s_mux_B;

	reg [4:0] opcode;

	// Outputs
	reg signed [DATA_WIDTH-1:0] Out_int;	
	reg C_int;
	reg N_int;
	reg V_int;
	reg Z_int;
	
	reg signed [DATA_WIDTH-1:0] Out_fixed;
	reg C_fixed;
	reg N_fixed;
	reg V_fixed;
	reg Z_fixed;
	
	reg signed [DATA_WIDTH-1:0] Out_vector[DATA_WIDTH-1:0];
	reg C_vector [DATA_WIDTH-1:0];
	reg N_vector [DATA_WIDTH-1:0];
	reg V_vector [DATA_WIDTH-1:0];
	reg Z_vector [DATA_WIDTH-1:0];
	
	reg signed [DATA_WIDTH-1:0] Out_intE;	
	reg C_intE;
	reg N_intE;
	reg V_intE;
	reg Z_intE;
	
	reg signed [DATA_WIDTH-1:0] Out_fixedE;
	reg C_fixedE;
	reg N_fixedE;
	reg V_fixedE;
	reg Z_fixedE;
	
	reg signed [DATA_WIDTH-1:0] Out_vectorE [DATA_WIDTH-1:0];
	reg C_vectorE [DATA_WIDTH-1:0];
	reg N_vectorE [DATA_WIDTH-1:0];
	reg V_vectorE [DATA_WIDTH-1:0];
	reg Z_vectorE [DATA_WIDTH-1:0];
	
	Execution #(.DATA_WIDTH(DATA_WIDTH)) test(
		.A_deco_int(A_deco_int),
		.B_deco_int(B_deco_int),
		.A_deco_fixed(A_deco_fixed),
		.B_deco_fixed(B_deco_fixed),
		.A_deco_vector(A_deco_vector),
		.B_deco_vector(B_deco_vector),
		.A_ua_int(A_ua_int),
		.B_ua_int(B_ua_int),
		.A_ua_fixed(A_ua_fixed),
		.B_ua_fixed(B_ua_fixed),
		.A_ua_vector(A_ua_vector),
		.B_ua_vector(B_ua_vector),
		.s_mux_A(s_mux_A),
		.s_mux_B(s_mux_B),
		.opcode(opcode),
		.Out_int(Out_int),
		.Out_fixed(Out_fixed),
		.Out_vector(Out_vector),
		.C_int(C_int),
		.N_int(N_int),
		.V_int(V_int),
		.Z_int(Z_int),
		.C_fixed(C_fixed),
		.N_fixed(N_fixed),
		.V_fixed(V_fixed),
		.Z_fixed(Z_fixed),
		.C_vector(C_vector),
		.N_vector(N_vector),
		.V_vector(V_vector),
		.Z_vector(Z_vector)
   );
	
	
	
	initial 
	begin
		//Inicializacion de las entradas de control
		s_mux_A = 0;
		s_mux_B = 0;
		opcode  = 0;
		
		//Inicializacion de las entradas y salidas de tipo integer y fixed
		//Entradas Integer 
		A_deco_int = 0;
		B_deco_int = 0;
		A_ua_int = 0;
		B_ua_int = 0;
		//Salidas Integer 
		Out_intE = 0;
		C_intE = 0;
		N_intE = 0;
		V_intE = 0;
		Z_intE = 0;
		
		//Entradas Fixed 
		A_deco_fixed = 0;
		B_deco_fixed = 0;
		A_ua_fixed = 0;
		B_ua_fixed = 0;
		
		//Salidas Fixed 
		Out_fixedE = 0;
		C_fixedE = 0;
		N_fixedE = 0;
		V_fixedE = 0;
		Z_fixedE = 0;


		//Inicializacion de las entradas y salidas vectoriales
		for (int i = 0; i < DATA_WIDTH; i++) begin
			//Entradas Vector
			A_deco_vector[i] = 0;
			B_deco_vector[i] = 0;
			A_ua_vector[i] = 0;
			B_ua_vector[i] = 0;
			//Salidas Vector
			Out_vectorE[i] = 0;
			C_vectorE[i] = 0;
			N_vectorE[i] = 0;
			V_vectorE[i] = 0;
			Z_vectorE[i] = 0;
		end
		
		//Integer Cases
		$display ("=============INTEGER=============");
			// ADD operation
			$display ("=============SUMADOR=============");
			opcode = 5'b00000;
			
			//Caso 1: suma 2 positivos
			A_deco_int  = 16'b0000000000000001;
			B_deco_int  = 16'b0000000000000001;
			
			A_ua_int    = 16'b0000000000001010;
			B_ua_int    = 16'b0000000000001010;
			
			Out_intE    = 16'b0000000000000010;
			
			s_mux_A = 0;
			s_mux_B = 0;
			
			C_intE = 0;
			N_intE = 0;
			V_intE = 0;
			Z_intE = 0;
			
			#10
			
			assert (Out_int == Out_intE && C_int == C_intE && N_int == N_intE && V_int == V_intE && Z_int == Z_intE) $display ($sformatf("Exito caso: %b caso 1 para A = %b, B = %b", opcode, A_deco_int, B_deco_int));
			else $error($sformatf("Fallo caso: %b para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_int, B_deco_int, Out_int, Out_intE));
			
			//Caso 1: suma 2 positivos con UA
			A_deco_int  = 16'b0000000000000001;
			B_deco_int  = 16'b0000000000000000;
			
			A_ua_int    = 16'b0000000000001010;
			B_ua_int    = 16'b0000000000001010;
			
			Out_intE    = 16'b0000000000001011;
			
			s_mux_A = 0;
			s_mux_B = 1;
			
			C_intE = 0;
			N_intE = 0;
			V_intE = 0;
			Z_intE = 0;
			
			#10
			
			assert (Out_int == Out_intE && C_int == C_intE && N_int == N_intE && V_int == V_intE && Z_int == Z_intE) $display ($sformatf("Exito caso: %b caso 1 para A = %b, B = %b con Unidad de Adelantamiento", opcode, A_deco_int, B_ua_int));
			else $error($sformatf("Fallo caso: %b para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_int, B_ua_int, Out_int, Out_intE));
			
			// SUB operation
			$display ("============RESTADOR=============");
			opcode = 5'b00001;
			
			//Caso 4: overflow negativo
			A_deco_int  = 16'b1000000000000000;
			B_deco_int  = 16'b0000000000001010;
			
			A_ua_int    = 16'b1000000000001010;
			B_ua_int    = 16'b1000000000001010;
			
			Out_intE    = 16'b1000000000000000;

			s_mux_A = 0;
			s_mux_B = 0;
			
			C_intE = 0;
			N_intE = 1;
			V_intE = 1;
			Z_intE = 0;
			
			#10
			
			assert (Out_int == Out_intE && C_int == C_intE && N_int == N_intE && V_int == V_intE && Z_int == Z_intE) $display ($sformatf("Exito caso: %b caso 4 para A = %b, B = %b", opcode, A_deco_int, B_deco_int));
			else $error($sformatf("Fallo caso: %b para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_int, B_deco_int, Out_int, Out_intE));

			//Caso 4: overflow negativo con UA
			A_deco_int  = 16'b1000000000000000;
			B_deco_int  = 16'b0000000000001010;
			
			A_ua_int    = 16'b1000000000001010;
			B_ua_int    = 16'b1000000000001010;
			
			Out_intE    = 16'b1000000000000000;

			s_mux_A = 1;
			s_mux_B = 0;
			
			C_intE = 0;
			N_intE = 1;
			V_intE = 1;
			Z_intE = 0;
			
			#10
			
			assert (Out_int == Out_intE && C_int == C_intE && N_int == N_intE && V_int == V_intE && Z_int == Z_intE) $display ($sformatf("Exito caso: %b caso 4 para A = %b, B = %b con Unidad de Adelantamiento", opcode, A_ua_int, B_deco_int));
			else $error($sformatf("Fallo caso: %b para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_ua_int, B_deco_int, Out_int, Out_intE));
			
		
			// MUL operation
			$display ("==========MULTIPLICADOR==========");
			opcode = 5'b00010;
			
			//Caso 2: multiplicacion de 1 negativo y 1 positivo
			A_deco_int  = 16'b1111111111111011;
			B_deco_int  = 16'b0000000000000010;
			
			A_ua_int    = 16'b1111111111110110;
			B_ua_int    = 16'b0000000000001010;
		
			Out_intE    = 16'b1111111111110110;

			s_mux_A = 0;
			s_mux_B = 0;

			C_intE = 0;
			N_intE = 1;
			V_intE = 0;
			Z_intE = 0;
			
			#10
			
			assert (Out_int == Out_intE && C_int == C_intE && N_int == N_intE && V_int == V_intE && Z_int == Z_intE) $display ($sformatf("Exito caso: %b caso 2 para A = %b, B = %b", opcode, A_deco_int, B_deco_int));
			else $error($sformatf("Fallo caso: %b para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_int, B_deco_int, Out_int, Out_intE));

			//Caso 2: multiplicacion de 1 negativo y 1 positivo con UA
			A_deco_int  = 16'b1111111111111011;
			B_deco_int  = 16'b0000000000000010;
			
			A_ua_int    = 16'b1111111111110110;
			B_ua_int    = 16'b0000000000001010;
		
			Out_intE    = 16'b1111111110011100;

			s_mux_A = 1;
			s_mux_B = 1;
			
			C_intE = 0;
			N_intE = 1;
			V_intE = 0;
			Z_intE = 0;
			
			#10
			
			assert (Out_int == Out_intE && C_int == C_intE && N_int == N_intE && V_int == V_intE && Z_int == Z_intE) $display ($sformatf("Exito caso: %b caso 2 para A = %b, B = %b con Unidad de Adelantamiento", opcode, A_ua_int, B_ua_int));
			else $error($sformatf("Fallo caso: %b para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_ua_int, B_ua_int, Out_int, Out_intE));
			
		//Fixed Cases
		$display ("===========FIXEDPOINT============");
			// ADD operation
			$display ("=============SUMADOR=============");
			opcode = 5'b01000;

			//Caso 1.1: suma sin overflow ni carry
			//                 IIIIIIIIFFFFFFFF
			A_deco_fixed = 16'b0011001001000000; //50,250
			B_deco_fixed = 16'b0001100100100000; //25,125
			A_ua_fixed   = 16'b0000000110000000; // 1,500
			B_ua_fixed   = 16'b0000000110000000; // 1,500
			Out_fixedE   = 16'b0100101101100000; //75,375
			
			A_ua_int     = 16'b0000000000000000;
			B_ua_int     = 16'b0000000000000000;
			
			s_mux_A = 0;
			s_mux_B = 0;
		
			
			C_fixedE = 0;
			N_fixedE = 0;
			V_fixedE = 0;
			Z_fixedE = 0;

			#DELAY

			assert (Out_fixed == Out_fixedE && C_fixed == C_fixedE && N_fixed == N_fixedE && V_fixed == V_fixedE && Z_fixed == Z_fixedE) $display ($sformatf("Exito caso: %b caso 1.1 para A = %b, B = %b", opcode, A_deco_fixed, B_deco_fixed));
			else $error($sformatf("Fallo caso: %b para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_fixed, B_deco_fixed, Out_fixed, Out_fixedE));
			
			//Caso 1.1: suma sin overflow ni carry con UA
			//                 IIIIIIIIFFFFFFFF
			A_deco_fixed = 16'b0011001001000000; //50,250
			B_deco_fixed = 16'b0001100100100000; //25,125
			A_ua_fixed   = 16'b0000000110000000; // 1,500
			B_ua_fixed   = 16'b0000000110000000; // 1,500
			Out_fixedE   = 16'b0011001111000000; //51,750
			
			s_mux_A = 0;
			s_mux_B = 1;
		
			
			C_fixedE = 0;
			N_fixedE = 0;
			V_fixedE = 0;
			Z_fixedE = 0;

			#DELAY

			assert (Out_fixed == Out_fixedE && C_fixed == C_fixedE && N_fixed == N_fixedE && V_fixed == V_fixedE && Z_fixed == Z_fixedE) $display ($sformatf("Exito caso: %b caso 1.1 para A = %b, B = %b con Unidad de Adelantamiento", opcode, A_deco_fixed, B_ua_int));
			else $error($sformatf("Fallo caso: %b para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_fixed, B_ua_int, Out_fixed, Out_fixedE));
			
			// SUB operation
			$display ("============RESTADOR=============");
			opcode = 5'b01001;
			
			//Caso 2.3: suma con carry que se propaga
			//                   IIIIIIIIFFFFFFFF
			A_deco_fixed   = 16'b0000001010000000; // 2,500
			B_deco_fixed   = 16'b0000010001100000; // 4,375
			A_ua_fixed     = 16'b0000000110000000; // 1,500
			B_ua_fixed     = 16'b0000000110000000; // 1,500
			Out_fixedE     = 16'b1111111111100000; //-1,875
			
			s_mux_A = 0;
			s_mux_B = 0;
			
			C_fixedE = 1;
			N_fixedE = 1;
			V_fixedE = 0;
			Z_fixedE = 0;

			#DELAY

			assert (Out_fixed == Out_fixedE && C_fixed == C_fixedE && N_fixed == N_fixedE && V_fixed == V_fixedE && Z_fixed == Z_fixedE) $display ($sformatf("Exito caso: %b caso 2.3 para A = %b, B = %b", opcode, A_deco_fixed, B_deco_fixed));
			else $error($sformatf("Fallo caso: %b para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_fixed, B_deco_fixed, Out_fixed, Out_fixedE));
			
			//Caso 2.3: suma con carry que se propaga con UA
			//                   IIIIIIIIFFFFFFFF
			A_deco_fixed   = 16'b0000001010000000; // 2,500
			B_deco_fixed   = 16'b0000010001100000; // 4,375
			A_ua_fixed     = 16'b0000000110000000; // 1,500
			B_ua_fixed     = 16'b0000000110000000; // 1,500
			Out_fixedE     = 16'b1111111011100000; //-2,875
			
			s_mux_A = 1;
			s_mux_B = 0;
			
			C_fixedE = 1;
			N_fixedE = 1;
			V_fixedE = 0;
			Z_fixedE = 0;

			#DELAY

			assert (Out_fixed == Out_fixedE && C_fixed == C_fixedE && N_fixed == N_fixedE && V_fixed == V_fixedE && Z_fixed == Z_fixedE) $display ($sformatf("Exito caso: %b caso 2.3 para A = %b, B = %b con Unidad de Adelantamiento", opcode, A_ua_fixed, B_deco_fixed));
			else $error($sformatf("Fallo caso: %b para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_ua_fixed, B_deco_fixed, Out_fixed, Out_fixedE));
				
			// MUL operation
			$display ("==========MULTIPLICADOR==========");
			opcode = 5'b01010;
			
			//Caso 5: mult de negativo con negativo con numeros pequeños
			//                   IIIIIIIIFFFFFFFF
			A_deco_fixed 	= 16'b1111111010000000; //-2,50
			B_deco_fixed 	= 16'b1111111010000000; //-2,50
			A_ua_fixed     = 16'b1111111110000000; //-1,500
			B_ua_fixed     = 16'b1111111110000000; //-1,500
			Out_fixedE     = 16'b0000011001000000; // 2,25
			
			s_mux_A = 0;
			s_mux_B = 0;
			
			C_fixedE = 0;
			N_fixedE = 0;
			V_fixedE = 0;
			Z_fixedE = 0;	

			#DELAY

			assert (Out_fixed == Out_fixedE && C_fixed == C_fixedE && N_fixed == N_fixedE && V_fixed == V_fixedE && Z_fixed == Z_fixedE) $display ($sformatf("Exito caso: %b caso 5 para A = %b, B = %b", opcode, A_deco_fixed, B_deco_fixed));
			else $error($sformatf("Fallo caso: %b para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_fixed, B_deco_fixed, Out_fixed, Out_fixedE));
			
			
			//Caso 5: mult de negativo con negativo con numeros pequeños con UA
			//                   IIIIIIIIFFFFFFFF
			A_deco_fixed 	= 16'b1111111010000000; //-2,50
			B_deco_fixed 	= 16'b1111111010000000; //-2,50
			A_ua_fixed     = 16'b1111111110000000; //-1,500
			B_ua_fixed     = 16'b1111111110000000; //-1,500
			Out_fixedE     = 16'b0000001001000000; // 2,25
			
			s_mux_A = 1;
			s_mux_B = 1;
			
			C_fixedE = 0;
			N_fixedE = 0;
			V_fixedE = 0;
			Z_fixedE = 0;	

			#DELAY

			assert (Out_fixed == Out_fixedE && C_fixed == C_fixedE && N_fixed == N_fixedE && V_fixed == V_fixedE && Z_fixed == Z_fixedE) $display ($sformatf("Exito caso: %b caso 5 para A = %b, B = %b con Unidad de Adelantamiento", opcode, A_deco_fixed, B_deco_fixed));
			else $error($sformatf("Fallo caso: %b para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_fixed, B_deco_fixed, Out_fixed, Out_fixedE));
			

		//Vectorial Cases
		$display ("============VECTORIAL============");
			// ADD operation
			$display ("=============SUMADOR=============");
			opcode = 5'b10000;
			s_mux_A = 0;
			s_mux_B = 0;
			
			//Caso en [15] caso 1.1: suma sin overflow ni carry
			//                					  IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-1]  = 16'b0011001001000000; //50,25
			B_deco_vector[DATA_WIDTH-1]  = 16'b0001100100100000; //25,125
			Out_vectorE[DATA_WIDTH-1]    = 16'b0100101101100000; //75,375
			
			C_vectorE[DATA_WIDTH-1]=0;
			N_vectorE[DATA_WIDTH-1]=0;
			V_vectorE[DATA_WIDTH-1]=0;
			Z_vectorE[DATA_WIDTH-1]=0;	

			//Caso en [14] caso 1.3: suma con carry que se propaga
			//                					  IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-2]  = 16'b0000101010100000; //10,625
			B_deco_vector[DATA_WIDTH-2]  = 16'b0000001010100000; // 2,625
			Out_vectorE[DATA_WIDTH-2]    = 16'b0000110101000000; //13,250
			
			C_vectorE[DATA_WIDTH-2]=1;
			N_vectorE[DATA_WIDTH-2]=0;
			V_vectorE[DATA_WIDTH-2]=0;
			Z_vectorE[DATA_WIDTH-2]=0;

			//Caso en [13] caso 1.4: suma con carry que se propaga con overflow
			//                					  IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-3]  = 16'b0011111110100000; //63,625
			B_deco_vector[DATA_WIDTH-3]  = 16'b0011111110100000; //63,625
			Out_vectorE[DATA_WIDTH-3]    = 16'b0111111101000000; //127,250
			
			C_vectorE[DATA_WIDTH-3]=1;
			N_vectorE[DATA_WIDTH-3]=0;
			V_vectorE[DATA_WIDTH-3]=1;
			Z_vectorE[DATA_WIDTH-3]=0;

			//Caso en [12] caso 2.1: suma sin carry
			//                					  IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-4]  = 16'b0000101011100000; //10,875
			B_deco_vector[DATA_WIDTH-4]  = 16'b1111111101100000; //-1,375
			Out_vectorE[DATA_WIDTH-4]    = 16'b0000100110000000; //9,5
			
			C_vectorE[DATA_WIDTH-4]=0;
			N_vectorE[DATA_WIDTH-4]=0;
			V_vectorE[DATA_WIDTH-4]=0;
			Z_vectorE[DATA_WIDTH-4]=0;
			
			//Caso en [11] caso 2.3: suma con carry que se propaga
			//                					  IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-5]  = 16'b0000101001000000; //10,25
			B_deco_vector[DATA_WIDTH-5]  = 16'b1111111110000000; //-1,5
			Out_vectorE[DATA_WIDTH-5]    = 16'b0000100011000000; //8,75
			
			C_vectorE[DATA_WIDTH-5]=1;
			N_vectorE[DATA_WIDTH-5]=0;
			V_vectorE[DATA_WIDTH-5]=0;
			Z_vectorE[DATA_WIDTH-5]=0;
			
			//Caso en [10] caso 2.5: suma que da cero
			//                					  IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-6]  = 16'b0000000100010000; // 1,0625
			B_deco_vector[DATA_WIDTH-6]  = 16'b1111111100010000; //-1,0625
			Out_vectorE[DATA_WIDTH-6]    = 16'b0000000000000000; // 0,0
			
			C_vectorE[DATA_WIDTH-6]=0;
			N_vectorE[DATA_WIDTH-6]=0;
			V_vectorE[DATA_WIDTH-6]=0;
			Z_vectorE[DATA_WIDTH-6]=1;
			
			//Caso en [09] caso 3.1: suma sin carry
			//                					  IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-7]  = 16'b0000001010000000; // 2,500
			B_deco_vector[DATA_WIDTH-7]  = 16'b1111110011100000; //-4,875
			Out_vectorE[DATA_WIDTH-7]    = 16'b1111111001100000; //-2,375
			
			C_vectorE[DATA_WIDTH-7]=0;
			N_vectorE[DATA_WIDTH-7]=1;
			V_vectorE[DATA_WIDTH-7]=0;
			Z_vectorE[DATA_WIDTH-7]=0;
			
			//Caso en [08] caso 3.3: suma con carry que se propaga
			//                					  IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-8]  = 16'b0000001010000000; // 2,500
			B_deco_vector[DATA_WIDTH-8]  = 16'b1111110001100000; //-4,375
			Out_vectorE[DATA_WIDTH-8]    = 16'b1111111111100000; //-1,875
			
			C_vectorE[DATA_WIDTH-8]=1;
			N_vectorE[DATA_WIDTH-8]=1;
			V_vectorE[DATA_WIDTH-8]=0;
			Z_vectorE[DATA_WIDTH-8]=0;
			
			//Caso en [07] caso 4.1: suma sin carry
			//                					  IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-9]  = 16'b1111110001100000; //-4.375
			B_deco_vector[DATA_WIDTH-9]  = 16'b0000001001000000; // 2.250
			Out_vectorE[DATA_WIDTH-9]    = 16'b1111111000100000; //-2.125
			
			C_vectorE[DATA_WIDTH-9]=0;
			N_vectorE[DATA_WIDTH-9]=1;
			V_vectorE[DATA_WIDTH-9]=0;
			Z_vectorE[DATA_WIDTH-9]=0;
			
			//Caso en [06] caso 4.3: suma con carry que se propaga
			//                					  IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-10] = 16'b1111110000100000; //-4.125
			B_deco_vector[DATA_WIDTH-10] = 16'b0000001010100000; // 2.625
			Out_vectorE[DATA_WIDTH-10]   = 16'b1111111110000000; //-1.500
			
			C_vectorE[DATA_WIDTH-10]=1;
			N_vectorE[DATA_WIDTH-10]=1;
			V_vectorE[DATA_WIDTH-10]=0;
			Z_vectorE[DATA_WIDTH-10]=0;
			
			//Caso en [05] caso 4.5: suma que da cero
			//                					  IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-11] = 16'b1111111100010000; //-1,0625
			B_deco_vector[DATA_WIDTH-11] = 16'b0000000100010000; // 1,0625
			Out_vectorE[DATA_WIDTH-11]   = 16'b0000000000000000; // 0,0
			
			C_vectorE[DATA_WIDTH-11]=0;
			Z_vectorE[DATA_WIDTH-11]=1;
			V_vectorE[DATA_WIDTH-11]=0;
			N_vectorE[DATA_WIDTH-11]=0;

			//Caso en [04] caso 5.1: suma sin carry
			//                					  IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-12] = 16'b1111111001000000; //-2.250
			B_deco_vector[DATA_WIDTH-12] = 16'b0000010001100000; // 4.375
			Out_vectorE[DATA_WIDTH-12]   = 16'b0000001000100000; // 2.125
			
			C_vectorE[DATA_WIDTH-12]=0;
			N_vectorE[DATA_WIDTH-12]=0;
			V_vectorE[DATA_WIDTH-12]=0;
			Z_vectorE[DATA_WIDTH-12]=0;

			//Caso en [03] caso 5.3: suma con carry que se propaga
			//                					  IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-13] = 16'b1111111010100000; //-2.625
			B_deco_vector[DATA_WIDTH-13] = 16'b0000010000100000; // 4.125
			Out_vectorE[DATA_WIDTH-13]   = 16'b0000000110000000; // 1.5
			
			C_vectorE[DATA_WIDTH-13]=1;
			N_vectorE[DATA_WIDTH-13]=0;
			V_vectorE[DATA_WIDTH-13]=0;
			Z_vectorE[DATA_WIDTH-13]=0;
			
			//Caso en [02] caso 6.1: suma sin overflow ni carry
			//                					  IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-14] = 16'b1111111010000000; //-2,5
			B_deco_vector[DATA_WIDTH-14] = 16'b1111110001000000; //-4,25
			Out_vectorE[DATA_WIDTH-14]   = 16'b1111101011000000; //-6,75
			
			C_vectorE[DATA_WIDTH-14]=0;
			N_vectorE[DATA_WIDTH-14]=1;
			V_vectorE[DATA_WIDTH-14]=0;
			Z_vectorE[DATA_WIDTH-14]=0;
			
			//Caso en [01] caso 6.3: suma con carry que se propaga
			//                					  IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-15] = 16'b1111110010000000; //-4.50
			B_deco_vector[DATA_WIDTH-15] = 16'b1111111011000000; //-2.75
			Out_vectorE[DATA_WIDTH-15]   = 16'b1111100101000000; //-7.25
			
			C_vectorE[DATA_WIDTH-15]=1;
			N_vectorE[DATA_WIDTH-15]=1;
			V_vectorE[DATA_WIDTH-15]=0;
			Z_vectorE[DATA_WIDTH-15]=0;

			//Caso en [00] caso 6.4 suma con carry que se propaga con overflow
			//                					  IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-16] = 16'b1100000010000000; // -64,50
			B_deco_vector[DATA_WIDTH-16] = 16'b1100000011000000; // -64,75
			Out_vectorE[DATA_WIDTH-16]   = 16'b1000000001000000; //-128,25
			
			C_vectorE[DATA_WIDTH-16]=1;
			N_vectorE[DATA_WIDTH-16]=1;
			V_vectorE[DATA_WIDTH-16]=1;
			Z_vectorE[DATA_WIDTH-16]=0;

			#DELAY
			
			//Verificacion de los casos
			//Caso en [15] caso 1.1: suma sin overflow ni carry
			assert (Out_vector[DATA_WIDTH-1] == Out_vectorE[DATA_WIDTH-1] && C_vector[DATA_WIDTH-1] == C_vectorE[DATA_WIDTH-1] && N_vector[DATA_WIDTH-1] == N_vectorE[DATA_WIDTH-1] && V_vectorE[DATA_WIDTH-1] == V_vectorE[DATA_WIDTH-1] && Z_vectorE[DATA_WIDTH-1] == Z_vectorE[DATA_WIDTH-1]) $display ($sformatf("Exito caso: %b en [15] caso 1.1 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-1], B_deco_vector[DATA_WIDTH-1]));
			else $error($sformatf("Fallo caso: %b en [15]  para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-1], B_deco_vector[DATA_WIDTH-1], Out_vector[DATA_WIDTH-1], Out_vectorE[DATA_WIDTH-1]));
			
			//Caso en [14] caso 1.3: suma con carry que se propaga
			assert (Out_vector[DATA_WIDTH-2] == Out_vectorE[DATA_WIDTH-2] && C_vector[DATA_WIDTH-2] == C_vectorE[DATA_WIDTH-2] && N_vectorE[DATA_WIDTH-2] == N_vectorE[DATA_WIDTH-2] && V_vectorE[DATA_WIDTH-2] == V_vectorE[DATA_WIDTH-2] && Z_vectorE[DATA_WIDTH-2] == Z_vectorE[DATA_WIDTH-2]) $display ($sformatf("Exito caso: %b en [14] caso 1.3 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-2], B_deco_vector[DATA_WIDTH-2]));
			else $error($sformatf("Fallo caso: %b en [14]  para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-2], B_deco_vector[DATA_WIDTH-2], Out_vector[DATA_WIDTH-2], Out_vectorE[DATA_WIDTH-2]));
			
			
			//Caso en [13] caso 1.4: suma con carry que se propaga con overflow
			assert (Out_vector[DATA_WIDTH-3] == Out_vectorE[DATA_WIDTH-3] && C_vector[DATA_WIDTH-3] == C_vectorE[DATA_WIDTH-3] && N_vectorE[DATA_WIDTH-3] == N_vectorE[DATA_WIDTH-3] && V_vectorE[DATA_WIDTH-3] == V_vectorE[DATA_WIDTH-3] && Z_vectorE[DATA_WIDTH-3] == Z_vectorE[DATA_WIDTH-3]) $display ($sformatf("Exito caso: %b en [13] caso 1.4 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-3], B_deco_vector[DATA_WIDTH-3]));
			else $error($sformatf("Fallo caso: %b en [13]  para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-3], B_deco_vector[DATA_WIDTH-3], Out_vector[DATA_WIDTH-3], Out_vectorE[DATA_WIDTH-3]));
			
			
			//Caso en [12] caso 2.1: suma sin carry
			assert (Out_vector[DATA_WIDTH-4] == Out_vectorE[DATA_WIDTH-4] && C_vector[DATA_WIDTH-4] == C_vectorE[DATA_WIDTH-4] && N_vectorE[DATA_WIDTH-4] == N_vectorE[DATA_WIDTH-4] && V_vectorE[DATA_WIDTH-4] == V_vectorE[DATA_WIDTH-4] && Z_vectorE[DATA_WIDTH-4] == Z_vectorE[DATA_WIDTH-4]) $display ($sformatf("Exito caso: %b en [12] caso 2.1 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-4], B_deco_vector[DATA_WIDTH-4]));
			else $error($sformatf("Fallo caso: %b en [12]  para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-4], B_deco_vector[DATA_WIDTH-4], Out_vector[DATA_WIDTH-4], Out_vectorE[DATA_WIDTH-4]));
			
			
			//Caso en [11] caso 2.3: suma con carry que se propaga
			assert (Out_vector[DATA_WIDTH-5] == Out_vectorE[DATA_WIDTH-5] && C_vector[DATA_WIDTH-5] == C_vectorE[DATA_WIDTH-5] && N_vectorE[DATA_WIDTH-5] == N_vectorE[DATA_WIDTH-5] && V_vectorE[DATA_WIDTH-5] == V_vectorE[DATA_WIDTH-5] && Z_vectorE[DATA_WIDTH-5] == Z_vectorE[DATA_WIDTH-5]) $display ($sformatf("Exito caso: %b en [11] caso 2.3 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-5], B_deco_vector[DATA_WIDTH-5]));
			else $error($sformatf("Fallo caso: %b en [11]  para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-5], B_deco_vector[DATA_WIDTH-5], Out_vector[DATA_WIDTH-5], Out_vectorE[DATA_WIDTH-5]));
			
			
			//Caso en [10] caso 2.5: suma que da cero
			assert (Out_vector[DATA_WIDTH-6] == Out_vectorE[DATA_WIDTH-6] && C_vector[DATA_WIDTH-6] == C_vectorE[DATA_WIDTH-6] && N_vectorE[DATA_WIDTH-6] == N_vectorE[DATA_WIDTH-6] && V_vectorE[DATA_WIDTH-6] == V_vectorE[DATA_WIDTH-6] && Z_vectorE[DATA_WIDTH-6] == Z_vectorE[DATA_WIDTH-6]) $display ($sformatf("Exito caso: %b en [10] caso 2.5 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-6], B_deco_vector[DATA_WIDTH-6]));
			else $error($sformatf("Fallo caso: %b en [10]  para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-6], B_deco_vector[DATA_WIDTH-6], Out_vector[DATA_WIDTH-6], Out_vectorE[DATA_WIDTH-6]));
			
			
			//Caso en [09] caso 3.1: suma sin carry
			assert (Out_vector[DATA_WIDTH-7] == Out_vectorE[DATA_WIDTH-7] && C_vector[DATA_WIDTH-7] == C_vectorE[DATA_WIDTH-7] && N_vectorE[DATA_WIDTH-7] == N_vectorE[DATA_WIDTH-7] && V_vectorE[DATA_WIDTH-7] == V_vectorE[DATA_WIDTH-7] && Z_vectorE[DATA_WIDTH-7] == Z_vectorE[DATA_WIDTH-7]) $display ($sformatf("Exito caso: %b en [09] caso 3.1 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-7], B_deco_vector[DATA_WIDTH-7]));
			else $error($sformatf("Fallo caso: %b en [09]  para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-7], B_deco_vector[DATA_WIDTH-7], Out_vector[DATA_WIDTH-7], Out_vectorE[DATA_WIDTH-7]));
			
			//Caso en [08] 3.3: suma con carry que se propaga
			assert (Out_vector[DATA_WIDTH-8] == Out_vectorE[DATA_WIDTH-8] && C_vector[DATA_WIDTH-8] == C_vectorE[DATA_WIDTH-8] && N_vectorE[DATA_WIDTH-8] == N_vectorE[DATA_WIDTH-8] && V_vectorE[DATA_WIDTH-8] == V_vectorE[DATA_WIDTH-8] && Z_vectorE[DATA_WIDTH-8] == Z_vectorE[DATA_WIDTH-8]) $display ($sformatf("Exito caso: %b en [08] caso 3.3 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-8], B_deco_vector[DATA_WIDTH-8]));
			else $error($sformatf("Fallo caso: %b en [08]  para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-8], B_deco_vector[DATA_WIDTH-8], Out_vector[DATA_WIDTH-8], Out_vectorE[DATA_WIDTH-8]));
			
			//Caso en [07] 4.1: suma sin carry
			assert (Out_vector[DATA_WIDTH-9] == Out_vectorE[DATA_WIDTH-9] && C_vector[DATA_WIDTH-9] == C_vectorE[DATA_WIDTH-9] && N_vectorE[DATA_WIDTH-9] == N_vectorE[DATA_WIDTH-9] && V_vectorE[DATA_WIDTH-9] == V_vectorE[DATA_WIDTH-9] && Z_vectorE[DATA_WIDTH-9] == Z_vectorE[DATA_WIDTH-9]) $display ($sformatf("Exito caso: %b en [07] caso 4.1 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-9], B_deco_vector[DATA_WIDTH-9]));
			else $error($sformatf("Fallo caso: %b en [07]  para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-9], B_deco_vector[DATA_WIDTH-9], Out_vector[DATA_WIDTH-9], Out_vectorE[DATA_WIDTH-9]));
			
			//Caso en [06] 4.3: suma con carry que se propaga
			assert (Out_vector[DATA_WIDTH-10] == Out_vectorE[DATA_WIDTH-10] && C_vector[DATA_WIDTH-10] == C_vectorE[DATA_WIDTH-10] && N_vectorE[DATA_WIDTH-10] == N_vectorE[DATA_WIDTH-10] && V_vectorE[DATA_WIDTH-10] == V_vectorE[DATA_WIDTH-10] && Z_vectorE[DATA_WIDTH-10] == Z_vectorE[DATA_WIDTH-10]) $display ($sformatf("Exito caso: %b en [06] caso 4.3 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-10], B_deco_vector[DATA_WIDTH-10]));
			else $error($sformatf("Fallo caso: %b en [06]  para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-10], B_deco_vector[DATA_WIDTH-10], Out_vector[DATA_WIDTH-10], Out_vectorE[DATA_WIDTH-10]));
			
			//Caso en [05] 4.5: suma que da cero
			assert (Out_vector[DATA_WIDTH-11] == Out_vectorE[DATA_WIDTH-11] && C_vector[DATA_WIDTH-11] == C_vectorE[DATA_WIDTH-11] && N_vectorE[DATA_WIDTH-11] == N_vectorE[DATA_WIDTH-11] && V_vectorE[DATA_WIDTH-11] == V_vectorE[DATA_WIDTH-11] && Z_vectorE[DATA_WIDTH-11] == Z_vectorE[DATA_WIDTH-11]) $display ($sformatf("Exito caso: %b en [05] caso 4.5 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-11], B_deco_vector[DATA_WIDTH-11]));
			else $error($sformatf("Fallo caso: %b en [05]  para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-11], B_deco_vector[DATA_WIDTH-11], Out_vector[DATA_WIDTH-11], Out_vectorE[DATA_WIDTH-11]));
			
			//Caso en [04] 5.1: suma sin carry
			assert (Out_vector[DATA_WIDTH-12] == Out_vectorE[DATA_WIDTH-12] && C_vector[DATA_WIDTH-12] == C_vectorE[DATA_WIDTH-12] && N_vectorE[DATA_WIDTH-12] == N_vectorE[DATA_WIDTH-12] && V_vectorE[DATA_WIDTH-12] == V_vectorE[DATA_WIDTH-12] && Z_vectorE[DATA_WIDTH-12] == Z_vectorE[DATA_WIDTH-12]) $display ($sformatf("Exito caso: %b en [04] caso 5.1 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-12], B_deco_vector[DATA_WIDTH-12]));
			else $error($sformatf("Fallo caso: %b en [04]  para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-12], B_deco_vector[DATA_WIDTH-12], Out_vector[DATA_WIDTH-12], Out_vectorE[DATA_WIDTH-12]));
			
			//Caso en [03] 5.3: suma con carry que se propaga
			assert (Out_vector[DATA_WIDTH-13] == Out_vectorE[DATA_WIDTH-13] && C_vector[DATA_WIDTH-13] == C_vectorE[DATA_WIDTH-13] && N_vectorE[DATA_WIDTH-13] == N_vectorE[DATA_WIDTH-13] && V_vectorE[DATA_WIDTH-13] == V_vectorE[DATA_WIDTH-13] && Z_vectorE[DATA_WIDTH-13] == Z_vectorE[DATA_WIDTH-13]) $display ($sformatf("Exito caso: %b en [03] caso 5.3 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-13], B_deco_vector[DATA_WIDTH-13]));
			else $error($sformatf("Fallo caso: %b en [03]  para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-13], B_deco_vector[DATA_WIDTH-13], Out_vector[DATA_WIDTH-13], Out_vectorE[DATA_WIDTH-13]));
			
			//Caso en [02] 6.1: suma sin overflow ni carry
			assert (Out_vector[DATA_WIDTH-14] == Out_vectorE[DATA_WIDTH-14] && C_vector[DATA_WIDTH-14] == C_vectorE[DATA_WIDTH-14] && N_vectorE[DATA_WIDTH-14] == N_vectorE[DATA_WIDTH-14] && V_vectorE[DATA_WIDTH-14] == V_vectorE[DATA_WIDTH-14] && Z_vectorE[DATA_WIDTH-14] == Z_vectorE[DATA_WIDTH-14]) $display ($sformatf("Exito caso: %b en [02] caso 6.1 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-14], B_deco_vector[DATA_WIDTH-14]));
			else $error($sformatf("Fallo caso: %b en [02]  para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-14], B_deco_vector[DATA_WIDTH-14], Out_vector[DATA_WIDTH-14], Out_vectorE[DATA_WIDTH-14]));
			
			//Caso en [01] 6.3: suma con carry que se propaga
			assert (Out_vector[DATA_WIDTH-15] == Out_vectorE[DATA_WIDTH-15] && C_vector[DATA_WIDTH-15] == C_vectorE[DATA_WIDTH-15] && N_vectorE[DATA_WIDTH-15] == N_vectorE[DATA_WIDTH-15] && V_vectorE[DATA_WIDTH-15] == V_vectorE[DATA_WIDTH-15] && Z_vectorE[DATA_WIDTH-15] == Z_vectorE[DATA_WIDTH-15]) $display ($sformatf("Exito caso: %b en [01] caso 6.3 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-15], B_deco_vector[DATA_WIDTH-15]));
			else $error($sformatf("Fallo caso: %b en [01]  para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-15], B_deco_vector[DATA_WIDTH-15], Out_vector[DATA_WIDTH-15], Out_vectorE[DATA_WIDTH-15]));
			
			//Caso en [00] 6.4 suma con carry que se propaga con overflow	
			assert (Out_vector[DATA_WIDTH-16] == Out_vectorE[DATA_WIDTH-16] && C_vector[DATA_WIDTH-16] == C_vectorE[DATA_WIDTH-16] && N_vectorE[DATA_WIDTH-16] == N_vectorE[DATA_WIDTH-16] && V_vectorE[DATA_WIDTH-16] == V_vectorE[DATA_WIDTH-16] && Z_vectorE[DATA_WIDTH-16] == Z_vectorE[DATA_WIDTH-16]) $display ($sformatf("Exito caso: %b en [00] caso 6.4 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-16], B_deco_vector[DATA_WIDTH-16]));
			else $error($sformatf("Fallo caso: %b en [00]  para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-16], B_deco_vector[DATA_WIDTH-16], Out_vector[DATA_WIDTH-16], Out_vectorE[DATA_WIDTH-16]));
			
			
			
			// SUB operation
			$display ("============RESTADOR=============");
			opcode = 5'b10001;
			s_mux_A = 0;
			s_mux_B = 0;

			//Caso en [15] caso 1.2: resta con carry que no se propaga
			//                                 IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-1]  = 16'b0000101010000000; //10,500
			B_deco_vector[DATA_WIDTH-1]  = 16'b0000000101100000; // 1,375
			Out_vectorE[DATA_WIDTH-1]    = 16'b0000100100100000; // 9,125
			
			C_vectorE[DATA_WIDTH-1]=0;
			N_vectorE[DATA_WIDTH-1]=0;
			V_vectorE[DATA_WIDTH-1]=0;
			Z_vectorE[DATA_WIDTH-1]=0;

			//Caso en [14] caso 1.4: resta con carry que se propaga con A y B en 0
			//                                 IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-2]  = 16'b0000101000010000; //10,0625
			B_deco_vector[DATA_WIDTH-2]  = 16'b0000000100100000; // 1,1250
			Out_vectorE[DATA_WIDTH-2]    = 16'b0000100011110000; // 8,9375
			
			C_vectorE[DATA_WIDTH-2]=1;
			N_vectorE[DATA_WIDTH-2]=0;
			V_vectorE[DATA_WIDTH-2]=0;
			Z_vectorE[DATA_WIDTH-2]=0;

			//Caso en [13] caso 1.5: resta que da cero
			//                                 IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-3]  = 16'b0000000100010000; // 1,0625
			B_deco_vector[DATA_WIDTH-3]  = 16'b0000000100010000; // 1,0625
			Out_vectorE[DATA_WIDTH-3]    = 16'b0000000000000000; // 0,0
			
			C_vectorE[DATA_WIDTH-3]=0;
			N_vectorE[DATA_WIDTH-3]=0;
			V_vectorE[DATA_WIDTH-3]=0;
			Z_vectorE[DATA_WIDTH-3]=1;

			//Caso en [12] caso 2.2: resta con carry que no se propaga
			//                                 IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-4]  = 16'b0000001001100000; // 2,375
			B_deco_vector[DATA_WIDTH-4]  = 16'b0000010010100000; // 4,625
			Out_vectorE[DATA_WIDTH-4]    = 16'b1111111001000000; //-2,250
			
			C_vectorE[DATA_WIDTH-4]=0;
			N_vectorE[DATA_WIDTH-4]=1;
			V_vectorE[DATA_WIDTH-4]=0;
			Z_vectorE[DATA_WIDTH-4]=0;

			//Caso en [11] caso 2.4: resta con carry que se propaga con A y B en 0
			//                                 IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-5]  = 16'b0000001000100000; // 2,1250
			B_deco_vector[DATA_WIDTH-5]  = 16'b0000010000010000; // 4,0625
			Out_vectorE[DATA_WIDTH-5]    = 16'b1111111111110000; //-1,9375
			
			C_vectorE[DATA_WIDTH-5]=1;
			N_vectorE[DATA_WIDTH-5]=1;
			V_vectorE[DATA_WIDTH-5]=0;
			Z_vectorE[DATA_WIDTH-5]=0;

			//Caso en [10] caso 3.2: resta con carry que no se propaga
			//                                 IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-6]  = 16'b0000000110100000; // 1,625
			B_deco_vector[DATA_WIDTH-6]  = 16'b1111111100100000; //-1,125
			Out_vectorE[DATA_WIDTH-6]    = 16'b0000001011000000; // 2,750

			C_vectorE[DATA_WIDTH-6]=0;
			N_vectorE[DATA_WIDTH-6]=0;
			V_vectorE[DATA_WIDTH-6]=0;
			Z_vectorE[DATA_WIDTH-6]=0;
			
			//Caso en [09] caso 3.3: resta con carry que se propaga
			//                                 IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-7]  = 16'b0000101010100000; //10,625
			B_deco_vector[DATA_WIDTH-7]  = 16'b1111111010100000; //-2,625
			Out_vectorE[DATA_WIDTH-7]    = 16'b0000110101000000; //13,250
			
			C_vectorE[DATA_WIDTH-7]=1;
			N_vectorE[DATA_WIDTH-7]=0;
			V_vectorE[DATA_WIDTH-7]=0;
			Z_vectorE[DATA_WIDTH-7]=0;

			//Caso en [08] caso 3.4: resta con carry que se propaga con overflow
			//                                 IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-8]  = 16'b0011111110100000; // 63,625
			B_deco_vector[DATA_WIDTH-8]  = 16'b1000000010100000; //-64,625
			Out_vectorE[DATA_WIDTH-8]    = 16'b0111111101000000; //127,250
			
			C_vectorE[DATA_WIDTH-8]=1;
			N_vectorE[DATA_WIDTH-8]=0;
			V_vectorE[DATA_WIDTH-8]=1;
			Z_vectorE[DATA_WIDTH-8]=0;
			
			//Caso en [07] caso 4.2: resta con carry que no se propaga
			//                                 IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-9]  = 16'b1111110000100000; //-4,125
			B_deco_vector[DATA_WIDTH-9]  = 16'b0000001010100000; // 2,625
			Out_vectorE[DATA_WIDTH-9]    = 16'b1111101011000000; //-6,750
			
			C_vectorE[DATA_WIDTH-9]=0;
			N_vectorE[DATA_WIDTH-9]=1;
			V_vectorE[DATA_WIDTH-9]=0;
			Z_vectorE[DATA_WIDTH-9]=0;

			//Caso en [06] caso 4.3: resta con carry que se propaga
			//                                 IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-10] = 16'b1111110010000000; //-4.50
			B_deco_vector[DATA_WIDTH-10] = 16'b0000001011000000; // 2.75
			Out_vectorE[DATA_WIDTH-10]   = 16'b1111100101000000; //-7.25
			
			C_vectorE[DATA_WIDTH-10]=1;
			N_vectorE[DATA_WIDTH-10]=1;
			V_vectorE[DATA_WIDTH-10]=0;
			Z_vectorE[DATA_WIDTH-10]=0;

			//Caso en [05] caso 4.4 resta con carry que se propaga con overflow
			//                                 IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-11] = 16'b1100000010000000; // -64,50
			B_deco_vector[DATA_WIDTH-11] = 16'b0100000011000000; //  64,75
			Out_vectorE[DATA_WIDTH-11]   = 16'b1000000001000000; //-128,25
			
			C_vectorE[DATA_WIDTH-11]=1;
			N_vectorE[DATA_WIDTH-11]=1;
			V_vectorE[DATA_WIDTH-11]=1;
			Z_vectorE[DATA_WIDTH-11]=0;
			
			//Caso en [04] caso 5.2: resta con carry que no se propaga
			//                                 IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-12] = 16'b1111110010000000; //-4.50
			B_deco_vector[DATA_WIDTH-12] = 16'b1111111001000000; //-2.25
			Out_vectorE[DATA_WIDTH-12]   = 16'b1111111001000000; //-2.25
			
			C_vectorE[DATA_WIDTH-12]=0;
			N_vectorE[DATA_WIDTH-12]=1;
			V_vectorE[DATA_WIDTH-12]=0;
			Z_vectorE[DATA_WIDTH-12]=0;

			//Caso en [03] caso 5.4: resta con carry que se propaga con A y B en 0
			//                                 IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-13] = 16'b1111110000010000; //-4,0625
			B_deco_vector[DATA_WIDTH-13] = 16'b1111111000100000; //-2,1250
			Out_vectorE[DATA_WIDTH-13]   = 16'b1111111111110000; //-1,9375
			
			C_vectorE[DATA_WIDTH-13]=1;
			N_vectorE[DATA_WIDTH-13]=1;
			V_vectorE[DATA_WIDTH-13]=0;
			Z_vectorE[DATA_WIDTH-13]=0;

			//Caso en [02] caso 5.5: resta que da cero
			//                                 IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-14] = 16'b1111111100010000; //-1,0625
			B_deco_vector[DATA_WIDTH-14] = 16'b1111111100010000; //-1,0625
			Out_vectorE[DATA_WIDTH-14]   = 16'b0000000000000000; // 0,0
			
			C_vectorE[DATA_WIDTH-14]=0;
			Z_vectorE[DATA_WIDTH-14]=1;
			V_vectorE[DATA_WIDTH-14]=0;
			N_vectorE[DATA_WIDTH-14]=0;

			//Caso en [01] caso 6.2: resta con carry que no se propaga
			//                                 IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-15] = 16'b1111111001000000; //-2.25
			B_deco_vector[DATA_WIDTH-15] = 16'b1111110010000000; //-4.50
			Out_vectorE[DATA_WIDTH-15]   = 16'b0000001001000000; // 2.25
			
			C_vectorE[DATA_WIDTH-15]=0;
			N_vectorE[DATA_WIDTH-15]=0;
			V_vectorE[DATA_WIDTH-15]=0;
			Z_vectorE[DATA_WIDTH-15]=0;

			//Caso en [00] caso 6.4: resta con carry que se propaga con A y B en 0
			//                                 IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-16] = 16'b1111111000100000; //-2.1250
			B_deco_vector[DATA_WIDTH-16] = 16'b1111110000010000; //-4.0625
			Out_vectorE[DATA_WIDTH-16]   = 16'b0000000111110000; // 1.9375
			
			C_vectorE[DATA_WIDTH-16]=1;
			N_vectorE[DATA_WIDTH-16]=0;
			V_vectorE[DATA_WIDTH-16]=0;
			Z_vectorE[DATA_WIDTH-16]=0;

			#DELAY
			
			//Verificacion de los casos
			//Caso en [15] caso 1.2: resta con carry que no se propaga
			assert (Out_vector[DATA_WIDTH-1] == Out_vectorE[DATA_WIDTH-1] && C_vectorE[DATA_WIDTH-1] == C_vectorE[DATA_WIDTH-1] && N_vector[DATA_WIDTH-1] == N_vectorE[DATA_WIDTH-1] && V_vector[DATA_WIDTH-1] == V_vectorE[DATA_WIDTH-1] && Z_vector[DATA_WIDTH-1] == Z_vectorE[DATA_WIDTH-1]) $display ($sformatf("Exito caso: %b en [15] caso 1.2 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-1], B_deco_vector[DATA_WIDTH-1]));
			else $error($sformatf("Fallo caso: %b en [15]  para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-1], B_deco_vector[DATA_WIDTH-1], Out_vector[DATA_WIDTH-1], Out_vectorE[DATA_WIDTH-1]));
			
			//Caso en [14] caso 1.4: resta con carry que se propaga con A y B en 0
			assert (Out_vector[DATA_WIDTH-2] == Out_vectorE[DATA_WIDTH-2] && C_vectorE[DATA_WIDTH-2] == C_vectorE[DATA_WIDTH-2] && N_vector[DATA_WIDTH-2] == N_vectorE[DATA_WIDTH-2] && V_vector[DATA_WIDTH-2] == V_vectorE[DATA_WIDTH-2] && Z_vector[DATA_WIDTH-2] == Z_vectorE[DATA_WIDTH-2]) $display ($sformatf("Exito caso: %b en [14] caso 1.4 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-2], B_deco_vector[DATA_WIDTH-2]));
			else $error($sformatf("Fallo caso: %b en [14]  para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-2], B_deco_vector[DATA_WIDTH-2], Out_vector[DATA_WIDTH-2], Out_vectorE[DATA_WIDTH-2]));
			
			//Caso en [13] caso 1.5: resta que da cero
			assert (Out_vector[DATA_WIDTH-3] == Out_vectorE[DATA_WIDTH-3] && C_vectorE[DATA_WIDTH-3] == C_vectorE[DATA_WIDTH-3] && N_vector[DATA_WIDTH-3] == N_vectorE[DATA_WIDTH-3] && V_vector[DATA_WIDTH-3] == V_vectorE[DATA_WIDTH-3] && Z_vector[DATA_WIDTH-3] == Z_vectorE[DATA_WIDTH-3]) $display ($sformatf("Exito caso: %b en [13] caso 1.5 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-3], B_deco_vector[DATA_WIDTH-3]));
			else $error($sformatf("Fallo caso: %b en [13]  para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-3], B_deco_vector[DATA_WIDTH-3], Out_vector[DATA_WIDTH-3], Out_vectorE[DATA_WIDTH-3]));
			
			//Caso en [12] caso 2.2: resta con carry que no se propaga
			assert (Out_vector[DATA_WIDTH-4] == Out_vectorE[DATA_WIDTH-4] && C_vectorE[DATA_WIDTH-4] == C_vectorE[DATA_WIDTH-4] && N_vector[DATA_WIDTH-4] == N_vectorE[DATA_WIDTH-4] && V_vector[DATA_WIDTH-4] == V_vectorE[DATA_WIDTH-4] && Z_vector[DATA_WIDTH-4] == Z_vectorE[DATA_WIDTH-4]) $display ($sformatf("Exito caso: %b en [12] caso 2.2 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-4], B_deco_vector[DATA_WIDTH-4]));
			else $error($sformatf("Fallo caso: %b en [12]  para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-4], B_deco_vector[DATA_WIDTH-4], Out_vector[DATA_WIDTH-4], Out_vectorE[DATA_WIDTH-4]));
			
			//Caso en [11] caso 2.4: resta con carry que se propaga con A y B en 0
			assert (Out_vector[DATA_WIDTH-5] == Out_vectorE[DATA_WIDTH-5] && C_vectorE[DATA_WIDTH-5] == C_vectorE[DATA_WIDTH-5] && N_vector[DATA_WIDTH-5] == N_vectorE[DATA_WIDTH-5] && V_vector[DATA_WIDTH-5] == V_vectorE[DATA_WIDTH-5] && Z_vector[DATA_WIDTH-5] == Z_vectorE[DATA_WIDTH-5]) $display ($sformatf("Exito caso: %b en [11] caso 2.4 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-5], B_deco_vector[DATA_WIDTH-5]));
			else $error($sformatf("Fallo caso: %b en [11]  para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-5], B_deco_vector[DATA_WIDTH-5], Out_vector[DATA_WIDTH-5], Out_vectorE[DATA_WIDTH-5]));
			
			//Caso en [10] caso 3.2: resta con carry que no se propaga
			assert (Out_vector[DATA_WIDTH-6] == Out_vectorE[DATA_WIDTH-6] && C_vectorE[DATA_WIDTH-6] == C_vectorE[DATA_WIDTH-6] && N_vector[DATA_WIDTH-6] == N_vectorE[DATA_WIDTH-6] && V_vector[DATA_WIDTH-6] == V_vectorE[DATA_WIDTH-6] && Z_vector[DATA_WIDTH-6] == Z_vectorE[DATA_WIDTH-6]) $display ($sformatf("Exito caso: %b en [10] caso 3.2 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-6], B_deco_vector[DATA_WIDTH-6]));
			else $error($sformatf("Fallo caso: %b en [10]  para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-6], B_deco_vector[DATA_WIDTH-6], Out_vector[DATA_WIDTH-6], Out_vectorE[DATA_WIDTH-6]));
			
			//Caso en [09] caso 3.3: resta con carry que se propaga
			assert (Out_vector[DATA_WIDTH-7] == Out_vectorE[DATA_WIDTH-7] && C_vectorE[DATA_WIDTH-7] == C_vectorE[DATA_WIDTH-7] && N_vector[DATA_WIDTH-7] == N_vectorE[DATA_WIDTH-7] && V_vector[DATA_WIDTH-7] == V_vectorE[DATA_WIDTH-7] && Z_vector[DATA_WIDTH-7] == Z_vectorE[DATA_WIDTH-7]) $display ($sformatf("Exito caso: %b en [09] caso 3.3 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-7], B_deco_vector[DATA_WIDTH-7]));
			else $error($sformatf("Fallo caso: %b en [09]  para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-7], B_deco_vector[DATA_WIDTH-7], Out_vector[DATA_WIDTH-7], Out_vectorE[DATA_WIDTH-7]));
			
			//Caso en [08] caso 3.4: resta con carry que se propaga con overflow
			assert (Out_vector[DATA_WIDTH-8] == Out_vectorE[DATA_WIDTH-8] && C_vectorE[DATA_WIDTH-8] == C_vectorE[DATA_WIDTH-8] && N_vector[DATA_WIDTH-8] == N_vectorE[DATA_WIDTH-8] && V_vector[DATA_WIDTH-8] == V_vectorE[DATA_WIDTH-8] && Z_vector[DATA_WIDTH-8] == Z_vectorE[DATA_WIDTH-8]) $display ($sformatf("Exito caso: %b en [08] caso 3.4 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-8], B_deco_vector[DATA_WIDTH-8]));
			else $error($sformatf("Fallo caso: %b en [08]  para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-8], B_deco_vector[DATA_WIDTH-8], Out_vector[DATA_WIDTH-8], Out_vectorE[DATA_WIDTH-8]));
			
			//Caso en [07] caso 4.2: resta con carry que no se propaga
			assert (Out_vector[DATA_WIDTH-9] == Out_vectorE[DATA_WIDTH-9] && C_vectorE[DATA_WIDTH-9] == C_vectorE[DATA_WIDTH-9] && N_vector[DATA_WIDTH-9] == N_vectorE[DATA_WIDTH-9] && V_vector[DATA_WIDTH-9] == V_vectorE[DATA_WIDTH-9] && Z_vector[DATA_WIDTH-9] == Z_vectorE[DATA_WIDTH-9]) $display ($sformatf("Exito caso: %b en [07] caso 4.2 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-9], B_deco_vector[DATA_WIDTH-9]));
			else $error($sformatf("Fallo caso: %b en [07]  para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-9], B_deco_vector[DATA_WIDTH-9], Out_vector[DATA_WIDTH-9], Out_vectorE[DATA_WIDTH-9]));
			
			//Caso en [06] caso 4.3: resta con carry que se propaga
			assert (Out_vector[DATA_WIDTH-10] == Out_vectorE[DATA_WIDTH-10] && C_vectorE[DATA_WIDTH-10] == C_vectorE[DATA_WIDTH-10] && N_vector[DATA_WIDTH-10] == N_vectorE[DATA_WIDTH-10] && V_vector[DATA_WIDTH-10] == V_vectorE[DATA_WIDTH-10] && Z_vector[DATA_WIDTH-10] == Z_vectorE[DATA_WIDTH-10]) $display ($sformatf("Exito caso: %b en [06] caso 4.3 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-10], B_deco_vector[DATA_WIDTH-10]));
			else $error($sformatf("Fallo caso: %b en [06]  para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-10], B_deco_vector[DATA_WIDTH-10], Out_vector[DATA_WIDTH-10], Out_vectorE[DATA_WIDTH-10]));
			
			//Caso en [05] caso 4.4 resta con carry que se propaga con overflow
			assert (Out_vector[DATA_WIDTH-11] == Out_vectorE[DATA_WIDTH-11] && C_vectorE[DATA_WIDTH-11] == C_vectorE[DATA_WIDTH-11] && N_vector[DATA_WIDTH-11] == N_vectorE[DATA_WIDTH-11] && V_vector[DATA_WIDTH-11] == V_vectorE[DATA_WIDTH-11] && Z_vector[DATA_WIDTH-11] == Z_vectorE[DATA_WIDTH-11]) $display ($sformatf("Exito caso: %b en [05] caso 4.4 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-11], B_deco_vector[DATA_WIDTH-11]));
			else $error($sformatf("Fallo caso: %b en [05]  para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-11], B_deco_vector[DATA_WIDTH-11], Out_vector[DATA_WIDTH-11], Out_vectorE[DATA_WIDTH-11]));
			
			//Caso en [04] caso 5.2: resta con carry que no se propaga
			assert (Out_vector[DATA_WIDTH-12] == Out_vectorE[DATA_WIDTH-12] && C_vectorE[DATA_WIDTH-12] == C_vectorE[DATA_WIDTH-12] && N_vector[DATA_WIDTH-12] == N_vectorE[DATA_WIDTH-12] && V_vector[DATA_WIDTH-12] == V_vectorE[DATA_WIDTH-12] && Z_vector[DATA_WIDTH-12] == Z_vectorE[DATA_WIDTH-12]) $display ($sformatf("Exito caso: %b en [04] caso 5.2 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-12], B_deco_vector[DATA_WIDTH-12]));
			else $error($sformatf("Fallo caso: %b en [04]  para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-12], B_deco_vector[DATA_WIDTH-12], Out_vector[DATA_WIDTH-12], Out_vectorE[DATA_WIDTH-12]));
			
			//Caso en [03] caso 5.4: resta con carry que se propaga con A y B en 0
			assert (Out_vector[DATA_WIDTH-13] == Out_vectorE[DATA_WIDTH-13] && C_vectorE[DATA_WIDTH-13] == C_vectorE[DATA_WIDTH-13] && N_vector[DATA_WIDTH-13] == N_vectorE[DATA_WIDTH-13] && V_vector[DATA_WIDTH-13] == V_vectorE[DATA_WIDTH-13] && Z_vector[DATA_WIDTH-13] == Z_vectorE[DATA_WIDTH-13]) $display ($sformatf("Exito caso: %b en [03] caso 5.4 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-13], B_deco_vector[DATA_WIDTH-13]));
			else $error($sformatf("Fallo caso: %b en [03]  para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-13], B_deco_vector[DATA_WIDTH-13], Out_vector[DATA_WIDTH-13], Out_vectorE[DATA_WIDTH-13]));
			
			//Caso en [02] caso 5.5: resta que da cero
			assert (Out_vector[DATA_WIDTH-14] == Out_vectorE[DATA_WIDTH-14] && C_vectorE[DATA_WIDTH-14] == C_vectorE[DATA_WIDTH-14] && N_vector[DATA_WIDTH-14] == N_vectorE[DATA_WIDTH-14] && V_vector[DATA_WIDTH-14] == V_vectorE[DATA_WIDTH-14] && Z_vector[DATA_WIDTH-14] == Z_vectorE[DATA_WIDTH-14]) $display ($sformatf("Exito caso: %b en [02] caso 5.5 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-14], B_deco_vector[DATA_WIDTH-14]));
			else $error($sformatf("Fallo caso: %b en [02]  para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-14], B_deco_vector[DATA_WIDTH-14], Out_vector[DATA_WIDTH-14], Out_vectorE[DATA_WIDTH-14]));
			
			//Caso en [01] caso 6.2: resta con carry que no se propaga
			assert (Out_vector[DATA_WIDTH-15] == Out_vectorE[DATA_WIDTH-15] && C_vectorE[DATA_WIDTH-15] == C_vectorE[DATA_WIDTH-15] && N_vector[DATA_WIDTH-15] == N_vectorE[DATA_WIDTH-15] && V_vector[DATA_WIDTH-15] == V_vectorE[DATA_WIDTH-15] && Z_vector[DATA_WIDTH-15] == Z_vectorE[DATA_WIDTH-15]) $display ($sformatf("Exito caso: %b en [01] caso 6.2 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-15], B_deco_vector[DATA_WIDTH-15]));
			else $error($sformatf("Fallo caso: %b en [01]  para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-15], B_deco_vector[DATA_WIDTH-15], Out_vector[DATA_WIDTH-15], Out_vectorE[DATA_WIDTH-15]));
			
			//Caso en [00] caso 6.4: resta con carry que se propaga con A y B en 0	
			assert (Out_vector[DATA_WIDTH-16] == Out_vectorE[DATA_WIDTH-16] && C_vectorE[DATA_WIDTH-16] == C_vectorE[DATA_WIDTH-16] && N_vector[DATA_WIDTH-16] == N_vectorE[DATA_WIDTH-16] && V_vector[DATA_WIDTH-16] == V_vectorE[DATA_WIDTH-16] && Z_vector[DATA_WIDTH-16] == Z_vectorE[DATA_WIDTH-16]) $display ($sformatf("Exito caso: %b en [00] caso 6.4 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-16], B_deco_vector[DATA_WIDTH-16]));
			else $error($sformatf("Fallo caso: %b en [00]  para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-16], B_deco_vector[DATA_WIDTH-16], Out_vector[DATA_WIDTH-16], Out_vectorE[DATA_WIDTH-16]));
			
			
			// MUL operation
			$display ("==========MULTIPLICADOR==========");
			opcode = 5'b10010;
			s_mux_A = 0;
			s_mux_B = 0;
			
			//Caso en [15] Caso 1: mult de positivo con positivo con numeros pequeños
			//                               IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-1]  				= 16'b0000010101000000; // 5,250
			B_deco_vector[DATA_WIDTH-1] 				= 16'b0000001010000000; // 2,500
			Out_vectorE[DATA_WIDTH-1]  = 16'b0000110100100000; //13,125
			
			C_vectorE[DATA_WIDTH-1]=0;
			N_vectorE[DATA_WIDTH-1]=0;
			V_vectorE[DATA_WIDTH-1]=0;
			Z_vectorE[DATA_WIDTH-1]=0;	
			
			//Caso en [14] Caso 2: mult de positivo con positivo con numeros grandes
			//                               IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-2] 				= 16'b0110010011000000; //100,750
			B_deco_vector[DATA_WIDTH-2] 				= 16'b0110010010000000; //100,500
			Out_vector [DATA_WIDTH-2]  = 16'b0111111101100000; //127,375
			
			C_vectorE[DATA_WIDTH-2]=0;
			N_vectorE[DATA_WIDTH-2]=0;
			V_vectorE[DATA_WIDTH-2]=1;
			Z_vectorE[DATA_WIDTH-2]=0;	
			
			//Caso en [13] Caso 3: mult de positivo con negativo con numeros pequeños
			//                               IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-3] 				= 16'b0000010101000000; //  5,250
			B_deco_vector[DATA_WIDTH-3] 				= 16'b1111111010000000; // -2,500
			Out_vector [DATA_WIDTH-3]  = 16'b1111001100100000; //-13,125
			
			C_vectorE[DATA_WIDTH-3]=0;
			N_vectorE[DATA_WIDTH-3]=1;
			V_vectorE[DATA_WIDTH-3]=0;
			Z_vectorE[DATA_WIDTH-3]=0;	
			
			//Caso en [12] Caso 4: mult de negativo con positivo con numeros pequeños
			//                               IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-4] 				= 16'b1111111010000000; // -2,500
			B_deco_vector[DATA_WIDTH-4] 				= 16'b0000010101000000; //  5,250
			Out_vector [DATA_WIDTH-4]  = 16'b1111001100100000; //-13,125
			
			C_vectorE[DATA_WIDTH-4]=0;
			N_vectorE[DATA_WIDTH-4]=1;
			V_vectorE[DATA_WIDTH-4]=0;
			Z_vectorE[DATA_WIDTH-4]=0;	
			
			//Caso en [11] Caso 5: mult de negativo con negativo con numeros pequeños
			//                               IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-5] 				= 16'b1111111010000000; //-2,50
			B_deco_vector[DATA_WIDTH-5] 				= 16'b1111111010000000; //-2,50
			Out_vector [DATA_WIDTH-5]  = 16'b0000011001000000; // 6,25
			
			C_vectorE[DATA_WIDTH-5]=0;
			N_vectorE[DATA_WIDTH-5]=0;
			V_vectorE[DATA_WIDTH-5]=0;
			Z_vectorE[DATA_WIDTH-5]=0;	
			
			//Caso en [10] Caso 6: mult de negativo con positivo con numeros grandes
			//                               IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-6] 				= 16'b1110000000010000; //- 32,0625000
			B_deco_vector[DATA_WIDTH-6] 				= 16'b0000100000100000; //   8,1250000
			Out_vector [DATA_WIDTH-6]  = 16'b1000000010000010; //-128,5078125
			
			C_vectorE[DATA_WIDTH-6]=0;
			N_vectorE[DATA_WIDTH-6]=1;
			V_vectorE[DATA_WIDTH-6]=1;
			Z_vectorE[DATA_WIDTH-6]=0;	
			
			//Caso en [09] Caso 7: mult por cero
			//                               IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-7] 				= 16'b0110010011000000; //100,750
			B_deco_vector[DATA_WIDTH-7] 				= 16'b0000000000000000; //  0,000
			Out_vector [DATA_WIDTH-7]  = 16'b0000000000000000; //  0,000
			
			C_vectorE[DATA_WIDTH-7]=0;
			N_vectorE[DATA_WIDTH-7]=0;
			V_vectorE[DATA_WIDTH-7]=0;
			Z_vectorE[DATA_WIDTH-7]=1;	
			
			//Caso en [08] Caso 1: mult de positivo con positivo con numeros pequeños
			//                               IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-8]  				= 16'b0000010101000000; // 5,250
			B_deco_vector[DATA_WIDTH-8] 				= 16'b0000001010000000; // 2,500
			Out_vector [DATA_WIDTH-8]  = 16'b0000110100100000; //13,125
			
			C_vectorE[DATA_WIDTH-8]=0;
			N_vectorE[DATA_WIDTH-8]=0;
			V_vectorE[DATA_WIDTH-8]=0;
			Z_vectorE[DATA_WIDTH-8]=0;	
			
			//Caso en [07] Caso 2: mult de positivo con positivo con numeros grandes
			//                               IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-9] 				= 16'b0110010011000000; //100,750
			B_deco_vector[DATA_WIDTH-9] 				= 16'b0110010010000000; //100,500
			Out_vector [DATA_WIDTH-9]  = 16'b0111111101100000; //127,375
			
			C_vectorE[DATA_WIDTH-9]=0;
			N_vectorE[DATA_WIDTH-9]=0;
			V_vectorE[DATA_WIDTH-9]=1;
			Z_vectorE[DATA_WIDTH-9]=0;	
			
			//Caso en [06] Caso 3: mult de positivo con negativo con numeros pequeños
			//                               IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-10] 				= 16'b0000010101000000; //  5,250
			B_deco_vector[DATA_WIDTH-10] 		   	= 16'b1111111010000000; // -2,500
			Out_vector [DATA_WIDTH-10] = 16'b1111001100100000; //-13,125
			
			C_vectorE[DATA_WIDTH-10]=0;
			N_vectorE[DATA_WIDTH-10]=1;
			V_vectorE[DATA_WIDTH-10]=0;
			Z_vectorE[DATA_WIDTH-10]=0;	
			
			//Caso en [05] Caso 4: mult de negativo con positivo con numeros pequeños
			//                               IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-11] 				= 16'b1111111010000000; // -2,500
			B_deco_vector[DATA_WIDTH-11] 				= 16'b0000010101000000; //  5,250
			Out_vector [DATA_WIDTH-11] = 16'b1111001100100000; //-13,125
			
			C_vectorE[DATA_WIDTH-11]=0;
			N_vectorE[DATA_WIDTH-11]=1;
			V_vectorE[DATA_WIDTH-11]=0;
			Z_vectorE[DATA_WIDTH-11]=0;	
			
			//Caso en [04] Caso 5: mult de negativo con negativo con numeros pequeños
			//                               IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-12] 				= 16'b1111111010000000; //-2,50
			B_deco_vector[DATA_WIDTH-12] 				= 16'b1111111010000000; //-2,50
			Out_vector [DATA_WIDTH-12] = 16'b0000011001000000; // 6,25
			
			C_vectorE[DATA_WIDTH-12]=0;
			N_vectorE[DATA_WIDTH-12]=0;
			V_vectorE[DATA_WIDTH-12]=0;
			Z_vectorE[DATA_WIDTH-12]=0;	
			
			//Caso en [03] Caso 6: mult de negativo con positivo con numeros grandes
			//                               IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-13] 				= 16'b1110000000010000; //- 32,0625000
			B_deco_vector[DATA_WIDTH-13] 				= 16'b0000100000100000; //   8,1250000
			Out_vector [DATA_WIDTH-13] = 16'b1000000010000010; //-128,5078125
			
			C_vectorE[DATA_WIDTH-13]=0;
			N_vectorE[DATA_WIDTH-13]=1;
			V_vectorE[DATA_WIDTH-13]=1;
			Z_vectorE[DATA_WIDTH-13]=0;	
			
			//Caso en [02] Caso 7: mult por cero
			//                               IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-14] 				= 16'b0110010011000000; //100,750
			B_deco_vector[DATA_WIDTH-14] 				= 16'b0000000000000000; //  0,000
			Out_vector [DATA_WIDTH-14] = 16'b0000000000000000; //  0,000
			
			C_vectorE[DATA_WIDTH-14]=0;
			N_vectorE[DATA_WIDTH-14]=0;
			V_vectorE[DATA_WIDTH-14]=0;
			Z_vectorE[DATA_WIDTH-14]=1;
			
			//Caso en [01] Caso 1: mult de positivo con positivo con numeros pequeños
			//                               IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-15]  			= 16'b0000010101000000; // 5,250
			B_deco_vector[DATA_WIDTH-15] 				= 16'b0000001010000000; // 2,500
			Out_vector [DATA_WIDTH-15] = 16'b0000110100100000; //13,125
			
			C_vectorE[DATA_WIDTH-15]=0;
			N_vectorE[DATA_WIDTH-15]=0;
			V_vectorE[DATA_WIDTH-15]=0;
			Z_vectorE[DATA_WIDTH-15]=0;
			
			//Caso en [00] Caso 1: mult de positivo con positivo con numeros pequeños
			//                               IIIIIIIIFFFFFFFF
			A_deco_vector[DATA_WIDTH-16]  			= 16'b0000010101000000; // 5,250
			B_deco_vector[DATA_WIDTH-16] 				= 16'b0000001010000000; // 2,500
			Out_vector [DATA_WIDTH-16] = 16'b0000110100100000; //13,125
			
			C_vectorE[DATA_WIDTH-16]=0;
			N_vectorE[DATA_WIDTH-16]=0;
			V_vectorE[DATA_WIDTH-16]=0;
			Z_vectorE[DATA_WIDTH-16]=0;	
			
			#DELAY
			//Verificacion de los casos
			//Caso en [15] Caso 1: mult de positivo con positivo con numeros pequeños
			assert (Out_vector[DATA_WIDTH-1] == Out_vectorE[DATA_WIDTH-1] && C_vector[DATA_WIDTH-1] == C_vectorE[DATA_WIDTH-1] && N_vector[DATA_WIDTH-1] == N_vectorE[DATA_WIDTH-1] && V_vector[DATA_WIDTH-1] == V_vectorE[DATA_WIDTH-1] && Z_vector[DATA_WIDTH-1] == Z_vectorE[DATA_WIDTH-1]) $display ($sformatf("Exito caso: %b en [15] caso 1 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-1], B_deco_vector[DATA_WIDTH-1]));
			else $error($sformatf("Fallo caso: %b en [15] para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-1], B_deco_vector[DATA_WIDTH-1], Out_vector[DATA_WIDTH-1], Out_vectorE[DATA_WIDTH-1]));
					
			//Caso en [14] Caso 2: mult de positivo con positivo con numeros grandes
			assert (Out_vector[DATA_WIDTH-2] == Out_vector [DATA_WIDTH-2] && C_vector[DATA_WIDTH-2] == C_vectorE[DATA_WIDTH-2] && N_vector[DATA_WIDTH-2] == N_vectorE[DATA_WIDTH-2] && V_vector[DATA_WIDTH-2] == V_vectorE[DATA_WIDTH-2] && Z_vector[DATA_WIDTH-2] == Z_vectorE[DATA_WIDTH-2]) $display ($sformatf("Exito caso: %b en [14] caso 2 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-2], B_deco_vector[DATA_WIDTH-2]));
			else $error($sformatf("Fallo caso: %b en [14] para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-2], B_deco_vector[DATA_WIDTH-2], Out_vector[DATA_WIDTH-2], Out_vector [DATA_WIDTH-2]));
			
			//Caso en [13] Caso 3: mult de positivo con negativo con numeros pequeños
			assert (Out_vector[DATA_WIDTH-3] == Out_vector [DATA_WIDTH-3] && C_vector[DATA_WIDTH-3] == C_vectorE[DATA_WIDTH-3] && N_vector[DATA_WIDTH-3] == N_vectorE[DATA_WIDTH-3] && V_vector[DATA_WIDTH-3] == V_vectorE[DATA_WIDTH-3] && Z_vector[DATA_WIDTH-3] == Z_vectorE[DATA_WIDTH-3]) $display ($sformatf("Exito caso: %b en [13] caso 3 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-3], B_deco_vector[DATA_WIDTH-3]));
			else $error($sformatf("Fallo caso: %b en [13] para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-3], B_deco_vector[DATA_WIDTH-3], Out_vector[DATA_WIDTH-3], Out_vector [DATA_WIDTH-3]));

			//Caso en [12] Caso 4: mult de negativo con positivo con numeros pequeños
			assert (Out_vector[DATA_WIDTH-4] == Out_vector [DATA_WIDTH-4] && C_vector[DATA_WIDTH-4] == C_vectorE[DATA_WIDTH-4] && N_vector[DATA_WIDTH-4] == N_vectorE[DATA_WIDTH-4] && V_vector[DATA_WIDTH-4] == V_vectorE[DATA_WIDTH-4] && Z_vector[DATA_WIDTH-4] == Z_vectorE[DATA_WIDTH-4]) $display ($sformatf("Exito caso: %b en [12] caso 4 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-4], B_deco_vector[DATA_WIDTH-4]));
			else $error($sformatf("Fallo caso: %b en [12] para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-4], B_deco_vector[DATA_WIDTH-4], Out_vector[DATA_WIDTH-4], Out_vector [DATA_WIDTH-4]));
			
			//Caso en [11] Caso 5: mult de negativo con negativo con numeros pequeños
			assert (Out_vector[DATA_WIDTH-5] == Out_vector [DATA_WIDTH-5] && C_vector[DATA_WIDTH-5] == C_vectorE[DATA_WIDTH-5] && N_vector[DATA_WIDTH-5] == N_vectorE[DATA_WIDTH-5] && V_vector[DATA_WIDTH-5] == V_vectorE[DATA_WIDTH-5] && Z_vector[DATA_WIDTH-5] == Z_vectorE[DATA_WIDTH-5]) $display ($sformatf("Exito caso: %b en [11] caso 5 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-5], B_deco_vector[DATA_WIDTH-5]));
			else $error($sformatf("Fallo caso: %b en [11] para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-5], B_deco_vector[DATA_WIDTH-5], Out_vector[DATA_WIDTH-5], Out_vector [DATA_WIDTH-5]));
			
			//Caso en [10] Caso 6: mult de negativo con positivo con numeros grandes
			assert (Out_vector[DATA_WIDTH-6] == Out_vector [DATA_WIDTH-6] && C_vector[DATA_WIDTH-6] == C_vectorE[DATA_WIDTH-6] && N_vector[DATA_WIDTH-6] == N_vectorE[DATA_WIDTH-6] && V_vector[DATA_WIDTH-6] == V_vectorE[DATA_WIDTH-6] && Z_vector[DATA_WIDTH-6] == Z_vectorE[DATA_WIDTH-6]) $display ($sformatf("Exito caso: %b en [10] caso 6 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-6], B_deco_vector[DATA_WIDTH-6]));
			else $error($sformatf("Fallo caso: %b en [10] para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-6], B_deco_vector[DATA_WIDTH-6], Out_vector[DATA_WIDTH-6], Out_vector [DATA_WIDTH-6]));

			//Caso en [09] Caso 7: mult por cero
			assert (Out_vector[DATA_WIDTH-7] == Out_vector [DATA_WIDTH-7] && C_vector[DATA_WIDTH-7] == C_vectorE[DATA_WIDTH-7] && N_vector[DATA_WIDTH-7] == N_vectorE[DATA_WIDTH-7] && V_vector[DATA_WIDTH-7] == V_vectorE[DATA_WIDTH-7] && Z_vector[DATA_WIDTH-7] == Z_vectorE[DATA_WIDTH-7]) $display ($sformatf("Exito caso: %b en [09] caso 7 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-7], B_deco_vector[DATA_WIDTH-7]));
			else $error($sformatf("Fallo caso: %b en [09] para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-7], B_deco_vector[DATA_WIDTH-7], Out_vector[DATA_WIDTH-7], Out_vector [DATA_WIDTH-7]));

			//Caso en [08] Caso 1: mult de positivo con positivo con numeros pequeños
			assert (Out_vector[DATA_WIDTH-8] == Out_vector [DATA_WIDTH-8] && C_vector[DATA_WIDTH-8] == C_vectorE[DATA_WIDTH-8] && N_vector[DATA_WIDTH-8] == N_vectorE[DATA_WIDTH-8] && V_vector[DATA_WIDTH-8] == V_vectorE[DATA_WIDTH-8] && Z_vector[DATA_WIDTH-8] == Z_vectorE[DATA_WIDTH-8]) $display ($sformatf("Exito caso: %b en [08] caso 1 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-8], B_deco_vector[DATA_WIDTH-8]));
			else $error($sformatf("Fallo caso: %b en [08] para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-8], B_deco_vector[DATA_WIDTH-8], Out_vector[DATA_WIDTH-8], Out_vector [DATA_WIDTH-8]));
			
			//Caso en [07] Caso 2: mult de positivo con positivo con numeros grandes
			assert (Out_vector[DATA_WIDTH-9] == Out_vector [DATA_WIDTH-9] && C_vector[DATA_WIDTH-9] == C_vectorE[DATA_WIDTH-9] && N_vector[DATA_WIDTH-9] == N_vectorE[DATA_WIDTH-9] && V_vector[DATA_WIDTH-9] == V_vectorE[DATA_WIDTH-9] && Z_vector[DATA_WIDTH-9] == Z_vectorE[DATA_WIDTH-9]) $display ($sformatf("Exito caso: %b en [07] caso 2 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-9], B_deco_vector[DATA_WIDTH-9]));
			else $error($sformatf("Fallo caso: %b en [07] para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-9], B_deco_vector[DATA_WIDTH-9], Out_vector[DATA_WIDTH-9], Out_vector [DATA_WIDTH-9]));

			//Caso en [06] Caso 3: mult de positivo con negativo con numeros pequeños
			assert (Out_vector[DATA_WIDTH-10] == Out_vector [DATA_WIDTH-10] && C_vector[DATA_WIDTH-10] == C_vectorE[DATA_WIDTH-10] && N_vector[DATA_WIDTH-10] == N_vectorE[DATA_WIDTH-10] && V_vector[DATA_WIDTH-10] == V_vectorE[DATA_WIDTH-10] && Z_vector[DATA_WIDTH-10] == Z_vectorE[DATA_WIDTH-10]) $display ($sformatf("Exito caso: %b en [06] caso 3 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-10], B_deco_vector[DATA_WIDTH-10]));
			else $error($sformatf("Fallo caso: %b en [06] para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-10], B_deco_vector[DATA_WIDTH-10], Out_vector[DATA_WIDTH-10], Out_vector [DATA_WIDTH-10]));
			
			//Caso en [05] Caso 4: mult de negativo con positivo con numeros pequeños
			assert (Out_vector[DATA_WIDTH-11] == Out_vector [DATA_WIDTH-11] && C_vector[DATA_WIDTH-11] == C_vectorE[DATA_WIDTH-11] && N_vector[DATA_WIDTH-11] == N_vectorE[DATA_WIDTH-11] && V_vector[DATA_WIDTH-11] == V_vectorE[DATA_WIDTH-11] && Z_vector[DATA_WIDTH-11] == Z_vectorE[DATA_WIDTH-11]) $display ($sformatf("Exito caso: %b en [05] caso 4 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-11], B_deco_vector[DATA_WIDTH-11]));
			else $error($sformatf("Fallo caso: %b en [05] para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-11], B_deco_vector[DATA_WIDTH-11], Out_vector[DATA_WIDTH-11], Out_vector [DATA_WIDTH-11]));

			//Caso en [04] Caso 5: mult de negativo con negativo con numeros pequeños
			assert (Out_vector[DATA_WIDTH-12] == Out_vector [DATA_WIDTH-12] && C_vector[DATA_WIDTH-12] == C_vectorE[DATA_WIDTH-12] && N_vector[DATA_WIDTH-12] == N_vectorE[DATA_WIDTH-12] && V_vector[DATA_WIDTH-12] == V_vectorE[DATA_WIDTH-12] && Z_vector[DATA_WIDTH-12] == Z_vectorE[DATA_WIDTH-12]) $display ($sformatf("Exito caso: %b en [04] caso 5 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-12], B_deco_vector[DATA_WIDTH-12]));
			else $error($sformatf("Fallo caso: %b en [04] para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-12], B_deco_vector[DATA_WIDTH-12], Out_vector[DATA_WIDTH-12], Out_vector [DATA_WIDTH-12]));
			
			//Caso en [03] Caso 6: mult de negativo con positivo con numeros grandes
			assert (Out_vector[DATA_WIDTH-13] == Out_vector [DATA_WIDTH-13] && C_vector[DATA_WIDTH-13] == C_vectorE[DATA_WIDTH-13] && N_vector[DATA_WIDTH-13] == N_vectorE[DATA_WIDTH-13] && V_vector[DATA_WIDTH-13] == V_vectorE[DATA_WIDTH-13] && Z_vector[DATA_WIDTH-13] == Z_vectorE[DATA_WIDTH-13]) $display ($sformatf("Exito caso: %b en [03] caso 6 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-13], B_deco_vector[DATA_WIDTH-13]));
			else $error($sformatf("Fallo caso: %b en [03] para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-13], B_deco_vector[DATA_WIDTH-13], Out_vector[DATA_WIDTH-13], Out_vector [DATA_WIDTH-13]));
			
			//Caso en [02] Caso 7: mult por cero
			assert (Out_vector[DATA_WIDTH-14] == Out_vector [DATA_WIDTH-14] && C_vector[DATA_WIDTH-14] == C_vectorE[DATA_WIDTH-14] && N_vector[DATA_WIDTH-14] == N_vectorE[DATA_WIDTH-14] && V_vector[DATA_WIDTH-14] == V_vectorE[DATA_WIDTH-14] && Z_vector[DATA_WIDTH-14] == Z_vectorE[DATA_WIDTH-14]) $display ($sformatf("Exito caso: %b en [02] caso 7 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-14], B_deco_vector[DATA_WIDTH-14]));
			else $error($sformatf("Fallo caso: %b en [02] para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-14], B_deco_vector[DATA_WIDTH-14], Out_vector[DATA_WIDTH-14], Out_vector [DATA_WIDTH-14]));
			
			//Caso en [01] Caso 1: mult de positivo con positivo con numeros pequeños
			assert (Out_vector[DATA_WIDTH-15] == Out_vector [DATA_WIDTH-15] && C_vector[DATA_WIDTH-15] == C_vectorE[DATA_WIDTH-15] && N_vector[DATA_WIDTH-15] == N_vectorE[DATA_WIDTH-15] && V_vector[DATA_WIDTH-15] == V_vectorE[DATA_WIDTH-15] && Z_vector[DATA_WIDTH-15] == Z_vectorE[DATA_WIDTH-15]) $display ($sformatf("Exito caso: %b en [01] caso 1 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-15], B_deco_vector[DATA_WIDTH-15]));
			else $error($sformatf("Fallo caso: %b en [01] para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-15], B_deco_vector[DATA_WIDTH-15], Out_vector[DATA_WIDTH-15], Out_vector [DATA_WIDTH-15]));
			
			//Caso en [00] Caso 1: mult de positivo con positivo con numeros pequeños
			assert (Out_vector[DATA_WIDTH-16] == Out_vector [DATA_WIDTH-16] && C_vector[DATA_WIDTH-16] == C_vectorE[DATA_WIDTH-16] && N_vector[DATA_WIDTH-16] == N_vectorE[DATA_WIDTH-16] && V_vector[DATA_WIDTH-16] == V_vectorE[DATA_WIDTH-16] && Z_vector[DATA_WIDTH-16] == Z_vectorE[DATA_WIDTH-16]) $display ($sformatf("Exito caso: %b en [00] caso 1 para A = %b, B = %b", opcode, A_deco_vector[DATA_WIDTH-16], B_deco_vector[DATA_WIDTH-16]));
			else $error($sformatf("Fallo caso: %b en [00] para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", opcode, A_deco_vector[DATA_WIDTH-16], B_deco_vector[DATA_WIDTH-16], Out_vector[DATA_WIDTH-16], Out_vector [DATA_WIDTH-16]));
			

	end
	
endmodule
