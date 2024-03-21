module signExtendImm #(parameter integer N)
(
  input [N-1:0] in,
  output [N-1:0] out
);
  // Extensión de signo
  // si el bit más significativo (in[N]) es 1, se extiende el signo 
  // añadiendo 1 en los bits adicionales, y si es 0, se extiende con 0
  always @* begin
    if (in[N] == 1) begin
        out = {N-8{1'b1}, in};
    end else begin
        out = {N-8{1'b0}, in};
    end
end

endmodule // signExtendImm