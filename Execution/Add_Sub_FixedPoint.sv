//Se define un tamaño de 16 para poder manejar numeros de punto fijo del tipo Q7.8
module Add_Sub_FixedPoint #(parameter DATA_WIDTH = 16)(
	input  reg signed [DATA_WIDTH-1:0] A,
	input  reg signed [DATA_WIDTH-1:0] B,
	input  reg op,
	output reg signed [DATA_WIDTH-1:0] Out,
	output reg C, //Carry de fraccion a entero
	output reg N, //Negativo
	output reg V, //Overflow
	output reg Z  //Zero
);
	
	reg signed [DATA_WIDTH/2 - 1:0] Integer_A;
	reg signed [DATA_WIDTH/2 - 1:0] Integer_B;
	
	reg signed [DATA_WIDTH/2 - 1:0] Integer_A_abs;
	reg signed [DATA_WIDTH/2 - 1:0] Integer_B_abs;
	
	reg [DATA_WIDTH/2 - 1:0] Fractional_A;
	reg [DATA_WIDTH/2 - 1:0] Fractional_B;

	reg signed [DATA_WIDTH/2-1:0] temp_Out_Integer;
	reg signed [DATA_WIDTH-1:0] temp_add;
	
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
		max_pos =  2**(DATA_WIDTH/2 -1) -1; // 127
		max_neg = -2**(DATA_WIDTH/2 -1);    //-128
	end
	
	function logic abs_A_greater_or_equal_abs_B (reg signed [DATA_WIDTH/2-1:0] a, reg signed [DATA_WIDTH/2-1:0] b);
		if(a[DATA_WIDTH/2-1] == 1)
			Integer_A_abs = -a;
		else
			Integer_A_abs = a;
			
		if(b[DATA_WIDTH/2-1] == 1)
			Integer_B_abs = -b;
		else
			Integer_B_abs = b;
			
		return (Integer_A_abs >= Integer_B_abs);
	endfunction
	
	//ALU operations
	always @(*) begin
		c = 0;
		temp_add = 16'd0;
		temp_Out_Fractional = 8'd0;
		temp_Out_Integer = 8'd0;
	
		//Logica para verificar que caso esta presente
		case ({op, A_sign, B_sign})
			//Casos de suma
			({1'b0, 1'b0, 1'b0}):begin //Caso 1: positiva + positivo
				c = 0;
					
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
				temp_add = Integer_A + Integer_B + c;
				
				if (temp_add[DATA_WIDTH-1] == 0 && temp_add >= max_pos) begin
					V = 1;
					temp_Out_Integer = max_pos;
				end
				else if (temp_add[DATA_WIDTH-1] == 1 && temp_add <= max_neg) begin
					V = 1;
					temp_Out_Integer = max_neg;
				end
				else begin
					V=0;
					temp_Out_Integer = temp_add[DATA_WIDTH/2-1:0];
				end
				
				temp_Out[DATA_WIDTH-1:DATA_WIDTH/2] = temp_Out_Integer[DATA_WIDTH/2-1:0];
				
			end
			({1'b0, 1'b0, 1'b1}):begin //Casos 2 y 3: positivo + negativo
				c = 0;
				//Caso 2: positivo + negativo = positivo
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
					temp_add = Integer_A + Integer_B;
					temp_add = temp_add - c;
					
					if (temp_add[DATA_WIDTH-1] == 0 && temp_add >= max_pos) begin
						V = 1;
						temp_Out_Integer = max_pos;
					end
					else if (temp_add[DATA_WIDTH-1] == 1 && temp_add <= max_neg) begin
						V = 1;
						temp_Out_Integer = max_neg;
					end
					else begin
						V=0;
						temp_Out_Integer = temp_add[DATA_WIDTH/2-1:0];
					end
					
					temp_Out[DATA_WIDTH-1:DATA_WIDTH/2] = temp_Out_Integer[DATA_WIDTH/2-1:0];
	
				end
				//Caso 3: positivo + negativo = negativo
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
					temp_add = Integer_A + Integer_B; 
					temp_add = temp_add + c;
					
					if (temp_add[DATA_WIDTH-1] == 0 && temp_add >= max_pos) begin
						V = 1;
						temp_Out_Integer = max_pos;
					end
					else if (temp_add[DATA_WIDTH-1] == 1 && temp_add <= max_neg) begin
						V = 1;
						temp_Out_Integer = max_neg;
					end
					else begin
						V=0;
						temp_Out_Integer = temp_add[DATA_WIDTH/2-1:0];
					end
					
					temp_Out[DATA_WIDTH-1:DATA_WIDTH/2] = temp_Out_Integer[DATA_WIDTH/2-1:0];
	
				end
			end
			
			({1'b0, 1'b1, 1'b0}):begin //Casos 4 y 5: negativo + positivo
				c = 0;
				//Caso 4: negativo + positivo = negativo
				if (abs_A_greater_or_equal_abs_B(Integer_A,Integer_B)) begin
					//Logica parte fraccional
					for (int i = 0; i < DATA_WIDTH/2; i++) begin
						temp_Out_Fractional[i] = Fractional_A[i] ^ Fractional_B[i] ^ c;
							
						if((Fractional_B[i] > Fractional_A[i]) || (A[i] == 0 && B[i] == 0 && c == 1))
							c = 1;
						else
							c = 0;
					end
					
					temp_Out[DATA_WIDTH/2 - 1:0] = temp_Out_Fractional[DATA_WIDTH/2-1:0];
					
					//Logica parte entera
					temp_add = Integer_A + Integer_B;
					temp_add = temp_add + c;
					
					if (temp_add[DATA_WIDTH-1] == 0 && temp_add >= max_pos) begin
						V = 1;
						temp_Out_Integer = max_pos;
					end
					else if (temp_add[DATA_WIDTH-1] == 1 && temp_add <= max_neg) begin
						V = 1;
						temp_Out_Integer = max_neg;
					end
					else begin
						V=0;
						temp_Out_Integer = temp_add[DATA_WIDTH/2-1:0];
					end
					
					temp_Out[DATA_WIDTH-1:DATA_WIDTH/2] = temp_Out_Integer[DATA_WIDTH/2-1:0];
	
				end
				//Caso 5: negativo + positivo = positivo
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
					temp_add = Integer_A + Integer_B;
					temp_add = temp_add - c;
					
					if (temp_add[DATA_WIDTH-1] == 0 && temp_add >= max_pos) begin
						V = 1;
						temp_Out_Integer = max_pos;
					end
					else if (temp_add[DATA_WIDTH-1] == 1 && temp_add <= max_neg) begin
						V = 1;
						temp_Out_Integer = max_neg;
					end
					else begin
						V=0;
						temp_Out_Integer = temp_add[DATA_WIDTH/2-1:0];
					end
					
					temp_Out[DATA_WIDTH-1:DATA_WIDTH/2] = temp_Out_Integer[DATA_WIDTH/2-1:0];
					
				end
			end
			
			({1'b0, 1'b1, 1'b1}):begin //Caso 6: negativo + negativo
				c = 0;
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
				temp_add = Integer_A + Integer_B;
				temp_add = temp_add - c;
				
				if (temp_add[DATA_WIDTH-1] == 0 && temp_add >= max_pos) begin
					V = 1;
					temp_Out_Integer = max_pos;
				end
				else if (temp_add[DATA_WIDTH-1] == 1 && temp_add <= max_neg) begin
					V = 1;
					temp_Out_Integer = max_neg;
				end
				else begin
					V=0;
					temp_Out_Integer = temp_add[DATA_WIDTH/2-1:0];
				end
				
				temp_Out[DATA_WIDTH-1:DATA_WIDTH/2] = temp_Out_Integer[DATA_WIDTH/2-1:0];
			end
			
			//Casos de resta
			({1'b1, 1'b0, 1'b0}):begin //Casos 1 y 2: positiva - positivo
				c = 0;
				//Caso 1: positivo + positivo = positivo
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
					temp_add = Integer_A - Integer_B;
					temp_add = temp_add - c;
					
					if (temp_add[DATA_WIDTH-1] == 0 && temp_add >= max_pos) begin
						V = 1;
						temp_Out_Integer = max_pos;
					end
					else if (temp_add[DATA_WIDTH-1] == 1 && temp_add <= max_neg) begin
						V = 1;
						temp_Out_Integer = max_neg;
					end
					else begin
						V=0;
						temp_Out_Integer = temp_add[DATA_WIDTH/2-1:0];
					end
					
					temp_Out[DATA_WIDTH-1:DATA_WIDTH/2] = temp_Out_Integer[DATA_WIDTH/2-1:0];
	
				end
				//Caso 2: positivo + positivo = negativo
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
					temp_add = Integer_A - Integer_B; 
					temp_add = temp_add + c;
					
					if (temp_add[DATA_WIDTH-1] == 0 && temp_add >= max_pos) begin
						V = 1;
						temp_Out_Integer = max_pos;
					end
					else if (temp_add[DATA_WIDTH-1] == 1 && temp_add <= max_neg) begin
						V = 1;
						temp_Out_Integer = max_neg;
					end
					else begin
						V=0;
						temp_Out_Integer = temp_add[DATA_WIDTH/2-1:0];
					end
					
					temp_Out[DATA_WIDTH-1:DATA_WIDTH/2] = temp_Out_Integer[DATA_WIDTH/2-1:0];
	
				end
			end
			({1'b1, 1'b0, 1'b1}):begin //Caso 3: positivo - negativo
				c = 0;
					
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
				temp_add = Integer_A - Integer_B;
				temp_add = temp_add + c;
				
				if (temp_add[DATA_WIDTH-1] == 0 && temp_add >= max_pos) begin
					V = 1;
					temp_Out_Integer = max_pos;
				end
				else if (temp_add[DATA_WIDTH-1] == 1 && temp_add <= max_neg) begin
					V = 1;
					temp_Out_Integer = max_neg;
				end
				else begin
					V=0;
					temp_Out_Integer = temp_add[DATA_WIDTH/2-1:0];
				end
				
				temp_Out[DATA_WIDTH-1:DATA_WIDTH/2] = temp_Out_Integer[DATA_WIDTH/2-1:0];
			end
			({1'b1, 1'b1, 1'b0}):begin //Caso 4: negativo - positivo
				c = 0;
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
				temp_add = Integer_A - Integer_B;
				temp_add = temp_add - c;
				
				if (temp_add[DATA_WIDTH-1] == 0 && temp_add >= max_pos) begin
					V = 1;
					temp_Out_Integer = max_pos;
				end
				else if (temp_add[DATA_WIDTH-1] == 1 && temp_add <= max_neg) begin
					V = 1;
					temp_Out_Integer = max_neg;
				end
				else begin
					V=0;
					temp_Out_Integer = temp_add[DATA_WIDTH/2-1:0];
				end
				
				temp_Out[DATA_WIDTH-1:DATA_WIDTH/2] = temp_Out_Integer[DATA_WIDTH/2-1:0];
			end
			({1'b1, 1'b1, 1'b1}):begin //Casos 5 y 6: negativo - negativo
				c = 0;
				//Caso 5: negativo - negativo = negativo
				if (abs_A_greater_or_equal_abs_B(Integer_A,Integer_B)) begin
					//Logica parte fraccional
					for (int i = 0; i < DATA_WIDTH/2; i++) begin
						temp_Out_Fractional[i] = Fractional_A[i] ^ Fractional_B[i] ^ c;
							
						if((Fractional_B[i] > Fractional_A[i]) || (A[i] == 0 && B[i] == 0 && c == 1))
							c = 1;
						else
							c = 0;
					end
					
					temp_Out[DATA_WIDTH/2 - 1:0] = temp_Out_Fractional[DATA_WIDTH/2-1:0];
					
					//Logica parte entera
					temp_add = Integer_A - Integer_B;
					temp_add = temp_add + c;
					
					if (temp_add[DATA_WIDTH-1] == 0 && temp_add >= max_pos) begin
						V = 1;
						temp_Out_Integer = max_pos;
					end
					else if (temp_add[DATA_WIDTH-1] == 1 && temp_add <= max_neg) begin
						V = 1;
						temp_Out_Integer = max_neg;
					end
					else begin
						V=0;
						temp_Out_Integer = temp_add[DATA_WIDTH/2-1:0];
					end
					
					temp_Out[DATA_WIDTH-1:DATA_WIDTH/2] = temp_Out_Integer[DATA_WIDTH/2-1:0];
	
				end
				//Caso 6: negativo - negativo = positivo
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
					temp_add = Integer_A - Integer_B;
					temp_add = temp_add - c;
					
					if (temp_add[DATA_WIDTH-1] == 0 && temp_add >= max_pos) begin
						V = 1;
						temp_Out_Integer = max_pos;
					end
					else if (temp_add[DATA_WIDTH-1] == 1 && temp_add <= max_neg) begin
						V = 1;
						temp_Out_Integer = max_neg;
					end
					else begin
						V=0;
						temp_Out_Integer = temp_add[DATA_WIDTH/2-1:0];
					end
					
					temp_Out[DATA_WIDTH-1:DATA_WIDTH/2] = temp_Out_Integer[DATA_WIDTH/2-1:0];
					
				end
			end
			
			
			default: begin// Unsupported operation
				temp_Out = 0;
				c = 0;
				V = 0;
			end
		endcase
	end
	
	assign C = c;
	assign Out = temp_Out;
	assign N   = Out[DATA_WIDTH-1];
	assign Z   = ~|Out;
	
endmodule
