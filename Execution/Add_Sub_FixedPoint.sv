//Se define un tamaño de 16 para poder manejar numeros de punto fijo del tipo Q7.8
module Add_Sub_FixedPoint #(parameter DATA_WIDTH = 16)( 
    input  reg signed [DATA_WIDTH-1:0] A,
	 input  reg signed [DATA_WIDTH-1:0] B,
	 input  reg op,
    output reg signed [DATA_WIDTH-1:0] Out,
	 output reg N, //Negativo
	 output reg V, //Overflow
	 output reg Z  //Zero
);
	
	reg signed [DATA_WIDTH/2 - 1:0] Integer_A;
	reg signed [DATA_WIDTH/2 - 1:0] Integer_B;
	
	reg [DATA_WIDTH/2 - 1:0] Fractional_A;
	reg [DATA_WIDTH/2 - 1:0] Fractional_B;

	reg signed [DATA_WIDTH/2 - 1:0] temp_Out_Integer;
	reg [DATA_WIDTH/2 - 1:0] temp_Out_Fractional;
	reg signed [DATA_WIDTH-1:0] temp_Out;
	
	reg signed [DATA_WIDTH/2 - 1:0] max_pos;
	reg signed [DATA_WIDTH/2 - 1:0] max_neg;
	
	reg c;
	
	reg A_sign;
	reg B_sign;
	
	//Se dividen las entradas en parte entera y parte fraccional
	assign Integer_A 	   = A[DATA_WIDTH-1:DATA_WIDTH/2];
	assign Fractional_A  = A[DATA_WIDTH/2 - 1:0];
	assign Integer_B     = B[DATA_WIDTH-1:DATA_WIDTH/2];
	assign Fractional_B  = B[DATA_WIDTH/2 - 1:0];
	
	
	assign A_sign  = A[DATA_WIDTH-1];
	assign B_sign  = B[DATA_WIDTH-1];
	
	initial begin
		max_pos =  2**(DATA_WIDTH/2 -1) -1;
		max_neg = -2**(DATA_WIDTH/2 -1);
	end
	
	function logic abs_A_greater_or_equal_abs_B (logic signed [DATA_WIDTH-1:0] a, logic signed [DATA_WIDTH-1:0] b);
		if (a >= 0 && b >= 0) //caso positivo
			return (a >= b);
		else if (a < 0 && b < 0) //Caso negativo
			return (b >= a);
		else
			return (a >= b); // Caso mixto
	endfunction
	
	//ALU operations
	always @(*) begin
		c = 0;
		temp_Out = 0;
		temp_Out_Integer = 0;
		temp_Out_Fractional = 0;
	
		//Logica para verificar que caso esta presente
		case ({op, A_sign, B_sign})
			//Casos de suma
			({1'b0, 1'b0, 1'b0}):begin //Caso positiva + positivo
					
				//Logica parte fraccional
				for (int i = 0; i < DATA_WIDTH/2; i++) begin
					temp_Out_Fractional[i] = Fractional_A[i] ^ Fractional_B[i] ^ c;
					
					if((Fractional_A[i] && Fractional_B[i]) || (Fractional_A[i] && c) || (c && Fractional_B[i]))
						c = 1;
					else
						c = 0;
				end

				temp_Out[DATA_WIDTH/2 - 1:0] = temp_Out_Fractional[DATA_WIDTH/2-1:0];
				
				
				//Logica parte entera
				temp_Out_Integer = Integer_A + Integer_B + c;
				
				if (temp_Out_Integer[DATA_WIDTH/2-1] == 0 && temp_Out_Integer >= max_pos) begin
					V = 1;
					temp_Out_Integer = max_pos;
				end
				else if (temp_Out_Integer[DATA_WIDTH/2-1] == 1 && temp_Out_Integer <= max_neg) begin
					V = 1;
					temp_Out_Integer = max_neg;
				end
				else V=0;
				
				temp_Out[DATA_WIDTH-1:DATA_WIDTH/2] = temp_Out_Integer[DATA_WIDTH/2-1:0];
				
			end
			({1'b0, 1'b0, 1'b1}):begin //Caso positivo + negativo
				//Caso positivo + negativo = positivo
				if (abs_A_greater_or_equal_abs_B(Integer_A,Integer_B)) begin
					//Logica parte fraccional
					for (int i = 0; i < DATA_WIDTH/2; i++) begin
						temp_Out_Fractional[i] = Fractional_A[i] ^ Fractional_B[i] ^ c;
						
						if((Fractional_A[i] < Fractional_B[i]) || (A[i] == 0 && B[i] == 0 && c))
							c = 1;
						else
							c = 0;
					end
					
					temp_Out[DATA_WIDTH/2 - 1:0] = temp_Out_Fractional[DATA_WIDTH/2-1:0];
					
					//Logica parte entera
					temp_Out_Integer = Integer_A + Integer_B - c;
					
					if (temp_Out_Integer[DATA_WIDTH/2-1] == 0 && temp_Out_Integer >= max_pos) begin
						V = 1;
						temp_Out_Integer = max_pos;
					end
					else if (temp_Out_Integer[DATA_WIDTH/2-1] == 1 && temp_Out_Integer <= max_neg) begin
						V = 1;
						temp_Out_Integer = max_neg;
					end
					else V=0;
					
					temp_Out[DATA_WIDTH-1:DATA_WIDTH/2] = temp_Out_Integer[DATA_WIDTH/2-1:0];
	
				end
				//Caso positivo + negativo = negativo
				else begin
					//Logica parte fraccional
					for (int i = 0; i < DATA_WIDTH/2; i++) begin
						temp_Out_Fractional[i] = Fractional_A[i] ^ Fractional_B[i] ^ c;
							
						if((Fractional_A[i] > Fractional_B[i]) || (A[i] == 0 && B[i] == 0 && c))
							c = 1;
						else
							c = 0;
					end
					
					temp_Out[DATA_WIDTH/2 - 1:0] = temp_Out_Fractional[DATA_WIDTH/2-1:0];
					
					//Logica parte entera
					temp_Out_Integer = Integer_A + Integer_B + c;
					
					if (temp_Out_Integer[DATA_WIDTH/2-1] == 0 && temp_Out_Integer >= max_pos) begin
						V = 1;
						temp_Out_Integer = max_pos;
					end
					else if (temp_Out_Integer[DATA_WIDTH/2-1] == 1 && temp_Out_Integer <= max_neg) begin
						V = 1;
						temp_Out_Integer = max_neg;
					end
					else V=0;
					
					temp_Out[DATA_WIDTH-1:DATA_WIDTH/2] = temp_Out_Integer[DATA_WIDTH/2-1:0];
	
				end
			end
			
			({1'b0, 1'b1, 1'b0}):begin //Caso negativo + positivo
				//Caso negativo + positivo = negativo
				if (abs_A_greater_or_equal_abs_B(Integer_A,Integer_B)) begin
					//Logica parte fraccional
					for (int i = 0; i < DATA_WIDTH/2; i++) begin
						temp_Out_Fractional[i] = Fractional_A[i] ^ Fractional_B[i] ^ c;
							
						if((Fractional_A[i] < Fractional_B[i]) || (A[i] == 0 && B[i] == 0 && c))
							c = 1;
						else
							c = 0;
					end
					
					temp_Out[DATA_WIDTH/2 - 1:0] = temp_Out_Fractional[DATA_WIDTH/2-1:0];
					
					//Logica parte entera
					temp_Out_Integer = Integer_A + Integer_B + c;
					
					if (temp_Out_Integer[DATA_WIDTH/2-1] == 0 && temp_Out_Integer >= max_pos) begin
						V = 1;
						temp_Out_Integer = max_pos;
					end
					else if (temp_Out_Integer[DATA_WIDTH/2-1] == 1 && temp_Out_Integer <= max_neg) begin
						V = 1;
						temp_Out_Integer = max_neg;
					end
					else V=0;
					
					temp_Out[DATA_WIDTH-1:DATA_WIDTH/2] = temp_Out_Integer[DATA_WIDTH/2-1:0];
	
				end
				//Caso negativo + positivo = positivo
				else begin
					//Logica parte fraccional
					for (int i = 0; i < DATA_WIDTH/2; i++) begin
						temp_Out_Fractional[i] = Fractional_A[i] ^ Fractional_B[i] ^ c;
						
						if((Fractional_A[i] > Fractional_B[i]) || (A[i] == 0 && B[i] == 0 && c))
							c = 1;
						else
							c = 0;
					end
					
					temp_Out[DATA_WIDTH/2 - 1:0] = temp_Out_Fractional[DATA_WIDTH/2-1:0];
					
					//Logica parte entera
					temp_Out_Integer = Integer_A + Integer_B - c;
					
					if (temp_Out_Integer[DATA_WIDTH/2-1] == 0 && temp_Out_Integer >= max_pos) begin
						V = 1;
						temp_Out_Integer = max_pos;
					end
					else if (temp_Out_Integer[DATA_WIDTH/2-1] == 1 && temp_Out_Integer <= max_neg) begin
						V = 1;
						temp_Out_Integer = max_neg;
					end
					else V=0;
					
					temp_Out[DATA_WIDTH-1:DATA_WIDTH/2] = temp_Out_Integer[DATA_WIDTH/2-1:0];
					
				end
			end
			
			({1'b0, 1'b1, 1'b1}):begin //Caso negativo + negativo
			//Logica parte fraccional
				for (int i = 0; i < DATA_WIDTH/2; i++) begin
					temp_Out_Fractional[i] = Fractional_A[i] ^ Fractional_B[i] ^ c;
					
					if((Fractional_A[i] && Fractional_B[i]) || (Fractional_A[i] && c) || (c && Fractional_B[i]))
						c = 1;
					else
						c = 0;
				end

				temp_Out[DATA_WIDTH/2 - 1:0] = temp_Out_Fractional[DATA_WIDTH/2-1:0];
				
				
				//Logica parte entera
				temp_Out_Integer = Integer_A + Integer_B - c;
				
				if (temp_Out_Integer[DATA_WIDTH/2-1] == 0 && temp_Out_Integer >= max_pos) begin
					V = 1;
					temp_Out_Integer = max_pos;
				end
				else if (temp_Out_Integer[DATA_WIDTH/2-1] == 1 && temp_Out_Integer <= max_neg) begin
					V = 1;
					temp_Out_Integer = max_neg;
				end
				else V=0;
				
				temp_Out[DATA_WIDTH-1:DATA_WIDTH/2] = temp_Out_Integer[DATA_WIDTH/2-1:0];
			end
			/*
			//Casos de resta
			({1'b0, 1'b0, 1'b0}):begin //Caso positiva - positivo
			end
			({1'b0, 1'b0, 1'b1}):begin //Caso positivo - negativo
			end
			({1'b0, 1'b1, 1'b0}):begin //Caso negativo - positivo
			end
			({1'b0, 1'b1, 1'b1}):begin //Caso negativo - negativo
			end
			*/
			
			default: begin// Unsupported operation
				temp_Out = 0;
				V = 0;
			end
		endcase
	end
	
	assign Out = temp_Out;
	assign N   = Out[DATA_WIDTH-1];
	assign Z   = ~|Out;
	
endmodule
