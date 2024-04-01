//Se define un tamaño de 16 para poder manejar numeros de hasta +-127
module ALU_Integer #(parameter DATA_WIDTH = 16)( 
    input reg signed [DATA_WIDTH-1:0] A,
	 input reg signed [DATA_WIDTH-1:0] B,
	 input logic [1:0] opcode,
    output reg signed [DATA_WIDTH-1:0] Out,
	 output reg N, //Negativo
	 output reg V, //Overflow
	 output reg Z  //Zero
);

	reg signed [2*DATA_WIDTH-1:0] temp_Out;
	reg signed [DATA_WIDTH-1:0] max_pos;
	reg signed [DATA_WIDTH-1:0] max_neg;
	
	initial begin
		max_pos =  2**(DATA_WIDTH-1)-1;
		max_neg = -2**(DATA_WIDTH-1); 
	end
	
	//ALU operations
	always @(*) begin
		case (opcode)
			//Integer Cases
			2'b00: begin // ADD operation
			  temp_Out = A + B;
			  if (temp_Out[2*DATA_WIDTH-1] == 0 && temp_Out >= max_pos) begin
					V = 1;
					temp_Out = max_pos;
			  end
			  else if (temp_Out[2*DATA_WIDTH-1] == 1 && temp_Out <= max_neg) begin
					V = 1;
					temp_Out = max_neg;
			  end
			  else V = 0;
			end
			
			2'b01: begin // SUB operation
			  temp_Out = A - B;
			  if (temp_Out[2*DATA_WIDTH-1] == 0 && temp_Out >= max_pos) begin
					V = 1;
					temp_Out = max_pos;
			  end
			  else if (temp_Out[2*DATA_WIDTH-1] == 1 && temp_Out <= max_neg) begin
					V = 1;
					temp_Out = max_neg;
			  end
			  else V = 0;
			end
			
			2'b10: begin// MUL operation
			  temp_Out = A * B;
			  if (temp_Out[2*DATA_WIDTH-1] == 0 && temp_Out >= max_pos) begin
					V = 1;
					temp_Out = max_pos;
			  end
			  else if (temp_Out[2*DATA_WIDTH-1] == 1 && temp_Out <= max_neg) begin
					V = 1;
					temp_Out = max_neg;
			  end
			  else V = 0;
			end
					  
			default: begin// Unsupported operation
				temp_Out = 0;
				V = 0;
			end
		endcase
	end
	
	assign Out = temp_Out[DATA_WIDTH-1:0];
	assign N   = Out[DATA_WIDTH-1];
	assign Z   = ~|Out;

	
endmodule
