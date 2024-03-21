
module tb_fetch_adder();
parameter N_tb = 4;

logic [N_tb-1:0] op1;
logic [N_tb-1:0] op2;
logic [N_tb-1:0] out, outExpected;
logic sel;

fetch_adder #(.N(N_tb)) UUT (op1, op2, sel, out);


initial begin 

	$display("Testbench - Fetch Add");
	
	// CASE 1: 0+1=1
	outExpected = 4'b0001;
	sel = 0;
	op1 = 4'd0;
	op2 = 4'd1;
	
	
	#10;
	assert (out == outExpected) 
			$display ($sformatf("Exito para op1 = %b, op2 = %b", op1, op2));
		else $error($sformatf("Fallo para op1 = %b, op2 = %b, Valor esperado = %b y valor obtenido = %b", op1, op2, outExpected, out));
		
	

	
	// CASE 2: 1+4=5
	outExpected = 4'b0101;
	
	op1 = 4'd1;
	op2 = 4'd4;
	
	#10;
	assert (out == outExpected) 
			$display ($sformatf("Exito para op1 = %b, op2 = %b", op1, op2));
		else $error($sformatf("Fallo para op1 = %b, op2 = %b, Valor esperado = %b y valor obtenido = %b", op1, op2, outExpected, out));
		
	
	end
	
endmodule