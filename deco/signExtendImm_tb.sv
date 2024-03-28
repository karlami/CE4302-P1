module signExtendImm_tb;

  parameter INTEGER_WIDTH = 32;
  parameter IMM_WIDTH = 19;
  
  reg signed [IMM_WIDTH-1:0] in;
  wire signed [INTEGER_WIDTH-1:0] out;
  
  signExtendImm #(IMM_WIDTH) dut (
    .in(in),
    .out(out)
  );
  reg clk;
  always #5 clk = ~clk;
  initial begin
    clk = 0;
    
    in = 19'sd12345;
    #10;
    $display("Test Case 1: Input: %d, Output: %d", in, out);
    
    in = -19'sd54321;
    #10;
    $display("Test Case 2: Input: %d, Output: %d", in, out);
    
    $finish;
  end

endmodule
