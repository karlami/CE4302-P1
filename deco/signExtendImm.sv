module signExtendImm (
    input signed [18:0] in,    // 19-bit immediate value input
    output signed [31:0] out   // 32-bit extended output
);

  // Sign extension
  always @* begin
    out = {{12{in[18]}}, in};  // Repeat the most significant bit of 'in' 12 times and concatenate 'in'
  end

endmodule // signExtendImm
