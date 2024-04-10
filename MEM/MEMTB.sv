`timescale 1 ps / 1 ps
module MEMTB();

logic clk,rst,RegWrite,MemWrite,Vectorop, MemtoReg, RegWrite_out, MemtoReg_out, BlockPipe;
logic [18:0] Address;
logic [15:0] Vectorresult [15:0];
logic [15:0] ALUresult;
logic [15:0] Alu_out,data_out;
logic [15:0] VectorResult_out [15:0];

MEM memory(clk,rst,RegWrite,MemWrite,Vectorop,MemtoReg,Address,Vectorresult,ALUresult,RegWrite_out,MemtoReg_out,BlockPipe,Alu_out,data_out,VectorResult_out);

initial begin
//Variables datos
ALUresult=16'd10;
Address=19'd0;
Vectorresult[0] = 16'd0;
Vectorresult[1] = 16'd1;
Vectorresult[2] = 16'd2;
Vectorresult[3] = 16'd3;
Vectorresult[4] = 16'd4;
Vectorresult[5] = 16'd5;
Vectorresult[6] = 16'd6;
Vectorresult[7] = 16'd7;
Vectorresult[8] = 16'd8;
Vectorresult[9] = 16'd9;
Vectorresult[10] = 16'd10;
Vectorresult[11] = 16'd11;
Vectorresult[12] = 16'd12;
Vectorresult[13] = 16'd13;
Vectorresult[14] = 16'd14;
Vectorresult[15] = 16'd15;

//Variables control
clk=0;
rst=0;
//Variables operación ("add" escalar)
RegWrite=0;
MemWrite=1;
Vectorop=0;
MemtoReg=0;

#10;
clk = ~ clk;
rst = ~rst;
#10;
rst = ~rst;
clk = ~ clk;
#10;
clk = ~ clk;
#10;
clk = ~ clk;
MemWrite=0;	
#10;
clk = ~ clk;
#10;
clk = ~ clk;
#10;
clk = ~ clk;
#10;
clk = ~ clk;
assert (RegWrite_out == RegWrite) $display("correcto RegWrite 1");
else $error ("Fallo RegWrite 1");
assert (MemtoReg_out == MemtoReg) $display("correcto MemtoReg 1");
else $error ("Fallo  MemtoReg 1");
assert (BlockPipe == 1'b0) $display("correcto Block 1");
else $error ("Fallo Bloqueo Pipe 1");
assert (Alu_out == ALUresult) $display("correcto ALUResult 1");
else $error ("Fallo ALUResult 1");

//Variables operación ("str" vectorial)
RegWrite=0;
Vectorop=1;
MemWrite=1;
#10;
clk = ~ clk;
#10;
for(int i=0;i<16;i++)begin
	clk = ~ clk;
	assert (data_out == i) $display("correcto Store Vect 3");
	else $error ("Error Store Vect 3");
	#10;
	clk = ~ clk;
	#10;
end
clk = ~ clk;
#10;
MemWrite=0;
clk = ~ clk;
#10;
clk = ~ clk;
#10;
clk = ~ clk;
#10;
clk = ~ clk;
#10;
clk = ~ clk;
#10;
clk = ~ clk;



end

endmodule
