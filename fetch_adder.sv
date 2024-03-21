//module fetch_adder #(parameter integer N = 8)
//(
//	input logic[N-1:0] op1,
//	input logic[N-1:0] op2,
//	input logic sel, 
//	output logic[N-1:0] out
//);
//
//	reg out_aux;
//	
//	always @*
//	begin
//		if (sel == 0) begin
//			out_aux = op1 + op2;
//		end else begin
//			out_aux = op2;
//		end
//	end
//	
//  assign out = out_aux;
//endmodule

//module fetch_adder #(parameter integer N = 8)
//(
//	input logic[N-1:0] op1,
//	input logic[N-1:0] op2,
//	input logic sel, 
//	output logic[N-1:0] out
//);
//
//	assign out = (sel == 0) ? (op1 + op2) : op2;
//
//endmodule

module fetch_adder #(parameter integer N = 8)
(
	input logic[N-1:0] op1,
	input logic[N-1:0] op2,
	input logic sel, 
	output logic[N-1:0] out
);

	assign out = (sel == 0) ? (op1 + 4) : op2;

endmodule
