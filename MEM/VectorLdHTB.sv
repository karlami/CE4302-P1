module VectorLdHTB();

logic [18:0] Address,Addressaux;
logic clk,Vectorop,WriteEn;
logic [15:0] MemDataRd;
logic [15:0] VectorRead [15:0];
logic BlockPipeStr;
logic [18:0] OutAddress;

VectorLoadHandler #(.DATA_WIDTH(16)) VldHdlr (Address,clk,Vectorop,WriteEn,MemDataRd,VectorRead,BlockPipeStr,OutAddress);

initial begin

Address = 19'd0;
Addressaux = 19'd0;
MemDataRd = 16'd0;
clk=0;
Vectorop=0;
WriteEn=0;


for(int i=0;i<16;i++)begin
	clk = ~ clk;
	#10;
	clk = ~ clk;
	assert (BlockPipeStr == 1'b0) $display("correcto_1");
	else $error ("Fallo Bloqueo Pipe");
	#10;
	
end

Address = 19'd0;
MemDataRd = 16'd0;
clk=0;
Vectorop=1;
WriteEn=0;


for(int i=0;i<16;i++)begin
	clk = ~ clk;
	Addressaux<=Address+i;
	MemDataRd<=MemDataRd+1;
	#10;
	clk = ~ clk;
	assert (BlockPipeStr == 1) $display("correcto_2.1");
	else $error ("Fallo Bloqueo Pipe");
	assert (OutAddress == Addressaux) $display("correcto_2.2");
	else $error ("Fallo Direccion");
	assert (VectorRead[i] == i) $display("correcto_2.3");
	else $error ("Fallo asignación");	
	#10;
	
end


Address = 19'd0;
MemDataRd = 16'd0;
clk=0;
Vectorop=1;
WriteEn=1;


for(int i=0;i<16;i++)begin
	clk = ~ clk;
	#10;
	clk = ~ clk;
	assert (BlockPipeStr == 1'b0) $display("correcto_3");
	else $error ("Fallo Bloqueo Pipe");
	#10;
	
end
end
endmodule
