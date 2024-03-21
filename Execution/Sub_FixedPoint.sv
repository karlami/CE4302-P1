//Se define un tamaño de 16 para poder manejar numeros de punto fijo del tipo Q7.8
module Sub_FixedPoint #(parameter DATA_WIDTH = 16)( 
    input  reg signed [DATA_WIDTH-1:0] A,
	 input  reg signed [DATA_WIDTH-1:0] B,
    output reg signed [DATA_WIDTH-1:0] Out,
	 output reg N, //Negativo
	 output reg V, //Overflow
	 output reg Z  //Zero
);
	
	reg signed [DATA_WIDTH/2 - 1:0] Integer_A;
	reg signed [DATA_WIDTH/2 - 1:0] Integer_B;
	
	reg signed [DATA_WIDTH/2 - 1:0] Fractional_A;
	reg signed [DATA_WIDTH/2 - 1:0] Fractional_B;

	reg signed [DATA_WIDTH/2-1:0] temp_Out_Integer;
	reg signed [DATA_WIDTH/2-1:0] temp_Out_Fractional;
	reg signed [DATA_WIDTH-1:0] temp_Out;
	
	reg signed [DATA_WIDTH/2-1:0] max_pos;
	reg signed [DATA_WIDTH/2-1:0] max_neg;
	
	initial begin
		max_pos =  2**(DATA_WIDTH/2)-1;
		max_neg = -2**(DATA_WIDTH/2)-1;
		
		//Se dividen las entradas en parte entera y parte fraccional
		Integer_A 	  = A[DATA_WIDTH-1:DATA_WIDTH/2];
		Fractional_A  = A[DATA_WIDTH/2-1:0];
		Integer_B     = B[DATA_WIDTH-1:DATA_WIDTH/2];
		Fractional_B  = B[DATA_WIDTH/2-1:0];	
		
	end
	
	//ALU operations
	always @(*) begin
		//Logica parte entera
		temp_Out_Integer = Integer_A - Integer_B;
		
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
		
		//Logica parte fraccional
		temp_Out_Fractional = Fractional_A - Fractional_B;
		temp_Out[DATA_WIDTH/2-1:0] = temp_Out_Fractional[DATA_WIDTH/2-1:0];	 

	end
	
	assign Out = temp_Out;
	assign N   = Out[DATA_WIDTH-1];
	assign Z   = ~|Out;

endmodule
