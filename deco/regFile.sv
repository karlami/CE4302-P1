module regFile (
  input clk, 
  input rst, 
  input writeEn,
  input [15:0] _x, 
  input [15:0] _b, 
  input [15:0] y,
  input [15:0] writeVal,
  output [15:0] x, 
  output [15:0] _b);

  // N registros de size 16
  reg [15:0] regMem [0:N];

  always @ (negedge clk, posedge rst) begin
    if (rst) regMem <= '{ default: '0};
    else if (writeEn) regMem[dest] <= writeVal;
  end

  assign reg1 = (regMem[src1]);
  assign reg2 = (regMem[src2]);
endmodule // regFile

