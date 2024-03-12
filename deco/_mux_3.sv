module _mux_3 #(parameter integer N) (in1, in2, in3, sel, out);
  input logic [N-1:0] in1, in2, in3;
  input logic [1:0] sel;
  output logic  [N-1:0] out;

  always_comb begin
    case (sel)
      2'd0: out = in1;
      2'd1: out = in2;
      2'd2: out = in3;
      default: out = 'bx;
    endcase
  end
endmodule // mux3