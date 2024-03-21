//Se define un tamaño de 16 para poder manejar numeros de punto fijo del tipo Q7.8
module fractional_add #(parameter DATA_WIDTH = 8)( 
    input  reg [DATA_WIDTH-1:0] A,
	 input  reg [DATA_WIDTH-1:0] B,
    output reg [DATA_WIDTH-1:0] Out
);
	reg carry;
	
	always @(*) begin
		carry = 0;
		
		for (int i = 0; i < DATA_WIDTH; i++) begin
			Out[i] = A[i] ^ B[i] ^ carry;
			
			if((A[i] && B[i]) || (A[i] && carry) || (carry && B[i]))
				carry = 1;
			else
				carry = 0;
		end
	end
	
endmodule
