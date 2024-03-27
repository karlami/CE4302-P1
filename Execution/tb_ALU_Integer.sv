`timescale 1ns / 10ps  // Definición de la escala de tiempo

module tb_ALU_Integer;
	
	// Parametros
	parameter DATA_WIDTH = 8;
	parameter DELAY = 10; // Delay entre entradas en la simulacion
	
	// Inputs
	reg signed [DATA_WIDTH-1:0] A;
	reg signed [DATA_WIDTH-1:0] B;
	logic [1:0] opcode;
	
	// Outputs
	reg signed [DATA_WIDTH-1:0] Out;
	reg signed [DATA_WIDTH-1:0] OutExpected;
	reg N, NExpected, V, VExpected, Z,ZExpected;
	
	ALU_Integer #(.DATA_WIDTH(DATA_WIDTH)) Test(
    .A(A),
    .B(B),
	 .opcode(opcode),
    .Out(Out),
	 .N(N),
	 .V(V),
	 .Z(Z)
   );
	
	
	
	initial 
	begin
	
		//Inicializar las flags
		N = 0;
		V = 0;
		Z = 0;
		
		
		$display ("=============SUMADOR=============");
		opcode = 2'b00;
		
		//Caso suma 2 positivos
		A = 8'b00000001;
		B = 8'b00000001;
		OutExpected=8'b00000010;
		
		ZExpected=0;
		VExpected=0;
		NExpected=0;
		
		#10
		
		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("Exito para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso suma 2 negativos
		A = 8'b11111111;
		B = 8'b11111111;
		OutExpected=8'b11111110;
		
		ZExpected=0;
		VExpected=0;
		NExpected=1;
		
		#10
		
		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("Exito para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
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
		
		
		
		$display ("============Restador=============");
		opcode = 2'b01;
		
		//Caso restar 2 positivos
		A = 8'b00000100;
		B = 8'b00000001;
		OutExpected=8'b00000011;
		
		ZExpected=0;
		VExpected=0;
		NExpected=0;
		
		#10
		
		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("Exito para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso resta 2 negativos
		A = 8'b11111100;
		B = 8'b11111111;
		OutExpected=8'b11111101;
		
		ZExpected=0;
		VExpected=0;
		NExpected=1;
		
		#10
		
		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("Exito para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso overflow positivos
		A = 8'b00001010;
		B = 8'b10000000;
		OutExpected=8'b01111111;
		
		ZExpected=0;
		VExpected=1;
		NExpected=0;
		
		#10
		
		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("Exito para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso overflow negativo
		A = 8'b10000000;
		B = 8'b00001010;
		OutExpected=8'b10000000;
		
		ZExpected=0;
		VExpected=1;
		NExpected=1;
		
		#10
		
		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("Exito para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso resta de negativo con negativo que da 0
		A = 8'b11111111;
		B = 8'b11111111;
		OutExpected=8'b00000000;
		
		ZExpected=1;
		VExpected=0;
		NExpected=0;
		
		#10
		
		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("Exito para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso resta de positivo con positivo que da 0
		A = 8'b00000100;
		B = 8'b00000100;
		OutExpected=8'b00000000;
		
		ZExpected=1;
		VExpected=0;
		NExpected=0;
		
		#10
		
		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("Exito para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		$display ("==========MULTIPLICADOR===========");
		opcode = 2'b10;
		
		//Caso multiplicacion de 2 positivos
		A = 8'b00000101;
		B = 8'b00000010;
		OutExpected=8'b00001010;
		
		ZExpected=0;
		VExpected=0;
		NExpected=0;
		
		#10
		
		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("Exito para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso multiplicacion de 1 negativo y 1 positivo
		A = 8'b11111011;
		B = 8'b00000010;
		OutExpected=8'b11110110;
		
		ZExpected=0;
		VExpected=0;
		NExpected=1;
		
		#10
		
		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("Exito para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso multiplicacion de 2 negativos
		A = 8'b11111011;
		B = 8'b11111110;
		OutExpected=8'b00001010;
		
		ZExpected=0;
		VExpected=0;
		NExpected=0;
		
		#10
		
		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("Exito para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso overflow positivos
		A = 8'b01111111;
		B = 8'b00000100;
		OutExpected=8'b01111111;
		
		ZExpected=0;
		VExpected=1;
		NExpected=0;
		
		#10
		
		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("Exito para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso overflow negativo
		A = 8'b11000000;
		B = 8'b00001010;
		OutExpected=8'b10000000;
		
		ZExpected=0;
		VExpected=1;
		NExpected=1;
		
		#10
		
		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("Exito para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		//Caso multiplicacion que da 0
		A = 8'b01111111;
		B = 8'b00000000;
		OutExpected=8'b00000000;
		
		ZExpected=1;
		VExpected=0;
		NExpected=0;
		
		#10
		
		assert (Out == OutExpected && ZExpected == Z && VExpected == V && NExpected == N) 
			$display ($sformatf("Exito para A = %b, B = %b", A, B));
		else $error($sformatf("Fallo para A = %b, B = %b, Se obtuvo O = %b, y se esperaba O = %b", A, B, Out, OutExpected));
		
		
	end
	
endmodule
