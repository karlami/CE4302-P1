module ExecutionToMemory #(parameter DATA_WIDTH = 16)(
    input signed [DATA_WIDTH-1:0] A,
    input signed [DATA_WIDTH-1:0]  B,
    input logic [4:0] opcode,
    output reg signed [DATA_WIDTH-1:0] result
);
    logic [DATA_WIDTH-1:0] temp_result;

    //ALU operations
    always_comb begin
        case (opcode)
		  /*
				//Integer Cases
            5'b00000:// ADD operation\
						  temp_result = A +  B;
            5'b00001: // SUB operation\
						  temp_result = A -  B;
				5'b00010: // MUL operation
                    temp_result[0] = A *  B;
						  
				//Fixed Cases
				5'b010000: // ADD operation\
                    temp_result = A +  B;
            5'b01001:  // SUB operation
                    temp_result[0] = A -  B;
						  result = temp_result[0];
				5'b01010:  // MUL operation
                    temp_result[0] = A *  B;
						  result = temp_result[0];
				
				//Vectorial Cases
				5'b10000: // ADD operation
                for (int i = 0; i < NUM_LANES; i++)
                    temp_result[i] = A +  B;
            5'b10001: // SUB operation
                for (int i = 0; i < NUM_LANES; i++)
                    temp_result[i] = A -  B;
				5'b10010: // MUL operation
                for (int i = 0; i < NUM_LANES; i++)
                    temp_result[i] = A *  B;
						  
				*/
            default: // Unsupported operation
                    temp_result = 0;
        endcase
		  
		  assign result = temp_result;
    end
endmodule