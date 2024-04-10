//Se define un tamaño de 16 para poder manejar numeros de punto fijo del tipo Q7.8
module Fixed_Add #(parameter DATA_WIDTH = 16)( 
    input  reg signed [DATA_WIDTH-1:0] A,
	 input  reg signed [DATA_WIDTH-1:0] B,
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
	
	//Se dividen las entradas en parte entera y parte fraccional
	assign Integer_A 	   = A[DATA_WIDTH-1:DATA_WIDTH/2];
	assign Fractional_A  = A[DATA_WIDTH/2 - 1:0];
	assign Integer_B     = B[DATA_WIDTH-1:DATA_WIDTH/2];
	assign Fractional_B  = B[DATA_WIDTH/2 - 1:0];
	
	// Instanciar el modulo de suma fraccionaria
   fractional_add #(DATA_WIDTH)  fract_add (
      .A(Fractional_A),
      .B(Fractional_B),
      .Out(temp_Out_Fractional)
	);
	
	initial begin
		max_pos =  2**(DATA_WIDTH/2 -1) -1;
		max_neg = -2**(DATA_WIDTH/2 -1);
	end
	
	//ALU operations
	always @(*) begin
		//Logica parte entera
		temp_Out_Integer = Integer_A + Integer_B;
		
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
		
		//Logica parte fraccional se trata directamente en el fractional_add	

		temp_Out[DATA_WIDTH/2 - 1:0] = temp_Out_Fractional[DATA_WIDTH/2-1:0];
	end
	
			
	assign Out = temp_Out;
	assign N   = Out[DATA_WIDTH-1];
	assign Z   = ~|Out;
	
endmodule