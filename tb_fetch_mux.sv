
module tb_fetch_mux();
parameter N_tb = 4;

logic[N_tb-1:0] op1; 
logic[N_tb-1:0] op2; 
logic sel;
logic [N_tb-1:0] out, outExpected;

fetch_mux #(.N(N_tb)) UUT ( op1, op2, sel, out);


initial begin 
	$display("Testbench - Fetch Mux");
//	#1
	// CASE 1: sel=0; -> out = op1
	outExpected = 4'b0000;

	op1 = 4'b0001;
	op2 = 4'b0011;
//	sel = 0;
	
	sel = 1;
	
	#2
	sel = 0;
//	#1	
//	assert (out == outExpected) 
//		$display ($sformatf("Exito para op1 = %b, op2 = %b sel = %b", op1, op2, sel));
//	else $error($sformatf("mmm no no para op1 = %b, op2 = %b sel %b, Valor esperado = %b y valor obtenido = %b", op1, op2, sel, outExpected, out));
//
//	
//	#1
//	// CASE 2: sel=1; -> out = op2
//	outExpected = 4'b0001;
//	
//	sel = 1;
//	#1	
//	assert (out == outExpected) 
//		$display ($sformatf("Exito para op1 = %b, op2 = %b sel = %b", op1, op2, sel));
//	else $error($sformatf("Fallo para op1 = %b, op2 = %b sel %b, Valor esperado = %b y valor obtenido = %b", op1, op2, sel, outExpected, out));
//
//	
//	
	end
	
endmodule
