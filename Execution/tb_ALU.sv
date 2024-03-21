`timescale 1ns/1ns

module tb_ALU;
    // Parameters
    parameter DATA_WIDTH = 16;
    parameter NUM_LANES = 16;

    // Signals
    logic [DATA_WIDTH-1:0] operand1, operand2, result;
    logic [4:0] opcode;

    // Instantiate the SIMD_ALU module
    ALU #(DATA_WIDTH, NUM_LANES) simd_alu (
        .operand1(operand1),
        .operand2(operand2),
        .opcode(opcode),
        .result(result)
    );

    // Testbench stimulus
    initial begin
        // Test case 1: ADD operation
        operand1 = 16'b0000000000000010;
        operand2 = 16'b0100000000000001;
        opcode = 5'b00000;
		  result = 16'b0100000000000011;

        #10;

        // Verify the result for ADD operation
        if (result != (operand1 + operand2)) begin
            $display("Test case 1 failed");
				$display("operand1 = %b, operand2 = %b,  result = %b", operand1, operand2, result);
			end
			else begin
				$display("Test case 1 Successfull");
			end
			

        // Test case 2: SUB operation
        operand1 = 16'b0000000000001010;
        operand2 = 16'b0000000000000001;
        opcode = 5'b00001;
		  result = 16'b0000000000001001;

        #10;

        // Verify the result for ADD operation
        if (result != (operand1 - operand2)) begin
            $display("Test case 2 failed");
				$display("operand1 = %b, operand2 = %b,  result = %b", operand1, operand2, result);
			end
			else begin
				$display("Test case 2 Successfull");
			end
			
		  // Test case 3: Fixed ADD operation
        operand1 = 16'b0000101010000000;
        operand2 = 16'b0000000111000000;
        opcode = 	  5'b01000;
		  result =   16'b0000110011000000;

        #10;

       // Verify the result for ADD operation
        if (result != (operand1 + operand2)) begin
            $display("Test case 3 failed");
				$display("operand1 = %b, operand2 = %b,  result = %b", operand1, operand2, result);
			end
			else begin
				$display("Test case 3 Successfull");
			end
    end
endmodule
