module Execution #(parameter DATA_WIDTH = 16)(
    input signed [DATA_WIDTH-1:0] A,
    input signed [DATA_WIDTH-1:0] B,
    input logic [4:0] opcode,
    output reg signed [DATA_WIDTH-1:0] Out
);
	 reg signed [DATA_WIDTH-1:0]   temp_out;
    reg signed [DATA_WIDTH/2-1:0] Out_integer;
	 reg signed [DATA_WIDTH-1:0]   Out_fixed1;
	 reg signed [DATA_WIDTH-1:0]   Out_fixed2;
	 reg signed [DATA_WIDTH-1:0]   Out_fixed3;
	 reg signed [DATA_WIDTH-1:0]   Out_fixed4;
	 reg signed [DATA_WIDTH-1:0]   Out_fixed5;
	 reg signed [DATA_WIDTH-1:0]   Out_fixed6;
	 
	 reg N_integer;
	 reg V_integer;
	 reg Z_integer;
	 
	 reg N_fixed1;
	 reg V_fixed1;
	 reg Z_fixed1;
	 
	 reg N_fixed2;
	 reg V_fixed2;
	 reg Z_fixed2;
	 
	 reg N_fixed3;
	 reg V_fixed3;
	 reg Z_fixed3;
	 
	 reg N_fixed4;
	 reg V_fixed4;
	 reg Z_fixed4;
	 
	 reg N_fixed5;
	 reg V_fixed5;
	 reg Z_fixed5;
	 
	 reg N_fixed6;
	 reg V_fixed6;
	 reg Z_fixed6;
	 
	 logic [1:0] opcode_integer;
	 logic [1:0] opcode_fixed;
	 
	 ALU_Integer #(.DATA_WIDTH(DATA_WIDTH)) alu_int(
		 .A(A),
		 .B(B),
		 .opcode(opcode_integer),
		 .Out(Out_integer),
		 .N(N_integer),
		 .V(V_integer),
		 .Z(Z_integer)
	 );
	 
	 ALU_FixedPoint #(.DATA_WIDTH(DATA_WIDTH)) alu_fixed1(
		 .A(A),
		 .B(B),
		 .opcode(opcode_fixed),
		 .Out(Out_fixed1),
		 .N(N_fixed1),
		 .V(V_fixed1),
		 .Z(Z_fixed1)
	 );
	 
	 ALU_FixedPoint #(.DATA_WIDTH(DATA_WIDTH)) alu_fixed2(
		 .A(A),
		 .B(B),
		 .opcode(opcode_fixed),
		 .Out(Out_fixed2),
		 .N(N_fixed2),
		 .V(V_fixed2),
		 .Z(Z_fixed2)
	 );
	 
	 ALU_FixedPoint #(.DATA_WIDTH(DATA_WIDTH)) alu_fixed3(
		 .A(A),
		 .B(B),
		 .opcode(opcode_fixed),
		 .Out(Out_fixed3),
		 .N(N_fixed3),
		 .V(V_fixed3),
		 .Z(Z_fixed3)
	 );
	 
	 ALU_FixedPoint #(.DATA_WIDTH(DATA_WIDTH)) alu_fixed4(
		 .A(A),
		 .B(B),
		 .opcode(opcode_fixed),
		 .Out(Out_fixed4),
		 .N(N_fixed4),
		 .V(V_fixed4),
		 .Z(Z_fixed4)
	 );
	 
	 ALU_FixedPoint #(.DATA_WIDTH(DATA_WIDTH)) alu_fixed5(
		 .A(A),
		 .B(B),
		 .opcode(opcode_fixed),
		 .Out(Out_fixed5),
		 .N(N_fixed5),
		 .V(V_fixed5),
		 .Z(Z_fixed5)
	 );
	 
	 ALU_FixedPoint #(.DATA_WIDTH(DATA_WIDTH)) alu_fixed6(
		 .A(A),
		 .B(B),
		 .opcode(opcode_fixed),
		 .Out(Out_fixed6),
		 .N(N_fixed6),
		 .V(V_fixed6),
		 .Z(Z_fixed6)
	 );
	 
	 

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
                    temp_out = 0;
        endcase
		  
		  assign Out = temp_out;
		  
    end
endmodule
