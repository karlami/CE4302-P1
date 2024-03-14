module Decode_2(input logic clk, reset, RegWrite,
	input logic [31:0] PCIn, InstrIn,
	input logic [31:0] ResultW,
	input logic [3:0] WA3W,
	output logic [31:0] RD1,RD2, ImmaExt,
	output logic [3:0] WA3
);


logic [31:0] PCPlus8;
logic [3:0] RA1, RA2;

adder #(32) pcadd2(PCIn, 32'b100, PCPlus8); //Se añade el mas +1

// register file logic

assign RA1 = InstrIn[25:22];

assign RA2 = InstrIn[17:14];


regfile rf(clk, RegWrite, RA1, RA2, WA3W, ResultW, PCPlus8, RD1, RD2);

assign WA3 = InstrIn[21:18];


signExtendImm ext(InstrIn[23:0], ImmaExt);

endmodule