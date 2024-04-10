//Se define un tamaño de 16 para poder manejar numeros de punto fijo del tipo Q7.8
module Mult_FixedPoint #(parameter DATA_WIDTH = 16)( 
    input  reg signed [DATA_WIDTH-1:0] A,
	 input  reg signed [DATA_WIDTH-1:0] B,
    output reg signed [DATA_WIDTH-1:0] Out,
	 output reg C, //Carry siempre es 0
	 output reg N, //Negativo
	 output reg V, //Overflow
	 output reg Z  //Zero
);
	reg signed [DATA_WIDTH/2 - 1:0] Integer_A;
	reg signed [DATA_WIDTH/2 - 1:0] Integer_B;
	
	reg signed [DATA_WIDTH/2 - 1:0] temp_A;
	reg signed [DATA_WIDTH/2 - 1:0] temp_B;
	
	reg [DATA_WIDTH/2 - 1:0] Fractional_A;
	reg [DATA_WIDTH/2 - 1:0] Fractional_B;
	
	reg signed [DATA_WIDTH - 1:0] A_abs;
	reg signed [DATA_WIDTH - 1:0] B_abs;
	
	reg signed [DATA_WIDTH-1:0] temp_Out;
	reg signed [2*DATA_WIDTH-1:0] temp_mult;
	reg signed [DATA_WIDTH/2-1:0] temp_Out_Integer;
	reg [DATA_WIDTH/2 - 1:0] temp_Out_Fractional;
	
	reg signed [DATA_WIDTH/2-1:0] max_pos;
	
	reg A_sign;
	reg B_sign;
	
	//Se dividen las entradas en parte entera y parte fraccional
	assign temp_A = A[DATA_WIDTH-1:DATA_WIDTH/2];
	assign Fractional_A = A[DATA_WIDTH/2 - 1:0];
	assign temp_B = B[DATA_WIDTH-1:DATA_WIDTH/2];
	assign Fractional_B = B[DATA_WIDTH/2 - 1:0];
	
	//Se extraen los signos originales de cada entrada
	assign A_sign  = A[DATA_WIDTH-1];
	assign B_sign  = B[DATA_WIDTH-1];

	//Se definen los maximos posibles segun el numero de bits
	initial begin
		max_pos =  2**(DATA_WIDTH/2 -1) -1; // 127
	end
	
	//ALU operations
	always @(*) begin
		
		//Se asigna el valor absoluto de cada entrada
		if(A_sign) begin
			//Al invertir el valor se debe de sumar 1 por el complemento de 2
			Integer_A = - temp_A;
			//Integer_A = Integer_A + 1;
			A_abs[DATA_WIDTH-1:DATA_WIDTH/2] = Integer_A;
			A_abs[DATA_WIDTH/2-1:0] = Fractional_A;
		end
		else begin
			Integer_A = temp_A;
			A_abs[DATA_WIDTH-1:DATA_WIDTH/2] = Integer_A;
			A_abs[DATA_WIDTH/2-1:0] = Fractional_A;
		end
		if(B_sign) begin
			//Al invertir el valor se debe de sumar 1 por el complemento de 2
			Integer_B = -temp_B;
			//Integer_B = Integer_B + 1;
			B_abs[DATA_WIDTH-1:DATA_WIDTH/2] = Integer_B;
			B_abs[DATA_WIDTH/2-1:0] = Fractional_B;
		end
		else begin
			Integer_B = temp_B;
			B_abs[DATA_WIDTH-1:DATA_WIDTH/2] = Integer_B;
			B_abs[DATA_WIDTH/2-1:0] = Fractional_B;
		end
		
		temp_mult = A_abs * B_abs;
		
		//Se asignan los 8 mas significativos de la parte fraccional		
		temp_Out_Fractional = temp_mult[DATA_WIDTH-1:DATA_WIDTH/2];
		
		//Soporte de overflow mediante saturación
		if((A_sign == B_sign) && (A_sign == 0 || A_sign) && temp_mult[2*DATA_WIDTH-1:DATA_WIDTH] >= max_pos) begin
			V = 1;
			temp_Out_Integer = max_pos;
		end
		else if ((A_sign || B_sign) && (A_sign != B_sign) && temp_mult[2*DATA_WIDTH-1:DATA_WIDTH] > max_pos) begin
			V = 1;
			temp_Out_Integer = -max_pos;
			temp_Out_Integer = temp_Out_Integer - 1;
		end
		
		else begin
			V=0;
			if ((A_sign || B_sign) && A_sign != B_sign) begin
				//Se asignan los demas 7 bits menos significativos de la parte entera
				temp_Out_Integer[DATA_WIDTH/2-2:0] = temp_mult[(2*DATA_WIDTH - DATA_WIDTH/2) - 2:DATA_WIDTH];
				//Se asigna el equivalente negativo
				temp_Out_Integer = -temp_Out_Integer;
				//Se mantiene el bit de signo
				temp_Out_Integer[DATA_WIDTH/2-1] = 1;
			end
			else begin
				//Se asignan los demas 7 bits menos significativos de la parte entera
				temp_Out_Integer[DATA_WIDTH/2-2:0] = temp_mult[(2*DATA_WIDTH - DATA_WIDTH/2) - 2:DATA_WIDTH];
				//Se mantiene el bit de signo
				temp_Out_Integer[DATA_WIDTH/2-1] = 0;
			end
		end
		
		temp_Out[DATA_WIDTH/2 - 1:0] = temp_Out_Fractional[DATA_WIDTH/2-1:0];
		temp_Out[DATA_WIDTH-1:DATA_WIDTH/2] = temp_Out_Integer[DATA_WIDTH/2-1:0];
		
	end
	
	assign Out = temp_Out;
	assign C   = 0;
	assign N   = Out[DATA_WIDTH-1];
	assign Z   = ~|Out;

endmodule
