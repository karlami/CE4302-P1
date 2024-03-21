// Mux para que sume 4 o un offset

//module fetch_mux #(parameter integer N = 8) 
//(
//	input clk,
//	input logic[N-1:0] op1, 
//	input logic[N-1:0] op2, 
//	input logic sel, 
//	output logic [N-1:0] out
//);
//
//	logic[N-1:0] out_aux;
//	
//	always @*
//	begin
//		if (sel == 0) begin
//			out_aux = op1;
//		end else begin
//			out_aux = op2;
//		end
//	end
//  assign out = out_aux;
//  
//endmodule 


module fetch_mux #(parameter integer N = 8) 
(
	input logic[N-1:0] op1, 
	input logic[N-1:0] op2, 
	input logic sel, 
	output logic [N-1:0] out
);

	wire [N-1:0] out_aux;

	assign out_aux = (sel == 0) ? op1 : op2;
	assign out = out_aux;
  
endmodule 
