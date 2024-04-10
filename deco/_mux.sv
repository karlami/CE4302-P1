module _mux #(parameter integer N) (
	input [N-1:0]in1, 
	input [N-1:0]in2, 
	input sel,
	output [N-1:0] out );
	
  assign out = (sel == 0) ? in1 : in2;
endmodule // mux