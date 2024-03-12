module regFile (
  input clk, 
  input rst, 
  input writeEn,
  input [15:0] src1, 
  input [15:0] src2, 
  input [15:0] dest,
  input [15:0] writeVal,
  output [15:0] reg1, 
  output [15:0] reg2);

  reg [`REG_FILE_SIZE-1:0] regMem [0:11];
  integer i;

  always @ (negedge clk, posedge rst) begin
    if (rst) regMem <= '{ default: '0};
    else if (writeEn) regMem[dest] <= writeVal;
  end

  assign reg1 = (regMem[src1]);
  assign reg2 = (regMem[src2]);
endmodule // regFile