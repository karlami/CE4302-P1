module VectorStrHTB();

logic [18:0] Address,Addressaux;
logic clk,Vectorop,WriteEn;
logic [15:0] Result;
logic [15:0] VectorRes [15:0];
logic BlockPipeStr;
logic [18:0] OutAddress;
logic [15:0] MemorydataWrite;



VectorStoreHandler #(.DATA_WIDTH(16)) VldHdlr (Address,clk,Vectorop,WriteEn,Result,VectorRes,BlockPipeStr,OutAddress,MemorydataWrite);

initial begin

Address = 19'd0;
Addressaux = 19'd0;
Result = 16'd10;
clk=0;
Vectorop=0;
WriteEn=0;
for(int i=0;i<16;i++)begin
	VectorRes[i] = i;
end

clk = ~ clk;
#10;
assert (BlockPipeStr == 1'b0) $display("correcto_1");
else $error ("Fallo Bloqueo Pipe");
clk = ~ clk;
#10;

WriteEn=1;//Se va a escribir pero no un vector no se bloquea y la salida es igual al escalar

clk = ~ clk;
#10;
clk = ~ clk;
assert (BlockPipeStr == 1'b0) $display("correcto_2.1");
else $error ("Fallo Bloqueo Pipe");
assert (MemorydataWrite == Result) $display("correcto_2.2");
else $error ("Fallo Salida Escalar");
assert (OutAddress == 1'd0) $display("correcto_2.2");
else $error ("Fallo Direccion Escalar");
#10;

Vectorop=1;//Se escribirá en memoria un vector, debe stall 16 ciclos e ir cargandolo

for(int i=0;i<16;i++)begin
	clk = ~ clk;
	#10;
	clk = ~ clk;
	assert (BlockPipeStr == 1) $display("correcto_3.1");
	else $error ("Fallo Bloqueo Pipe");
	assert (MemorydataWrite == i) $display("correcto_3.2");
	else $error ("Fallo Salida Vect");
	assert (OutAddress == i) $display("correcto_3.3");
	else $error ("Fallo Direccion Vect");

	#10;	
end

end

endmodule
