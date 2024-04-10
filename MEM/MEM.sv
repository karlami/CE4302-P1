module MEM #(parameter DATA_WIDTH=16)(input logic clk,rst,RegWrite,MemWrite,Vectorop, MemtoReg,
			  input logic [18:0] Address,
			  input logic [DATA_WIDTH-1:0] Vectorresult [DATA_WIDTH-1:0],
			  input logic [DATA_WIDTH-1:0] ALUresult,
			  output logic RegWrite_out, MemtoReg_out, BlockPipe,
			  output logic [DATA_WIDTH-1:0] Alu_out,data_out,
			  output logic [DATA_WIDTH-1:0] VectorResult_out [DATA_WIDTH-1:0]);
			  
			  logic [DATA_WIDTH-1:0] DatatoMem;
			  logic [18:0] AddresstoMem,AddresstoMemLd,AddresstoMemStr;
			  logic BlockPipeStr,BlockPipeLd;

			  
			  VectorStoreHandler #(.DATA_WIDTH(DATA_WIDTH))MemStrHandle(Address,~clk,Vectorop,MemWrite,ALUresult,Vectorresult,BlockPipeStr,AddresstoMemStr,DatatoMem);
			  
			  mux2_1 #(.WIDTH(19)) mux_addr(AddresstoMemLd,AddresstoMemStr,MemWrite,AddresstoMem);
			  
			  //RAM ram(rst,AddresstoMem,~clk,DatatoMem,MemWrite,data_out);
			  aux_RAM ram (AddresstoMem,clk,DatatoMem,MemWrite,data_out);
			  
			  VectorLoadHandler #(.DATA_WIDTH(DATA_WIDTH))MemLdHandle(Address,clk,Vectorop,MemWrite,data_out,VectorResult_out,BlockPipeLd,AddresstoMemLd);
			  
			  assign RegWrite_out=RegWrite;
			  assign BlockPipe=BlockPipeStr || BlockPipeLd;
			  assign Alu_out=ALUresult;
			  assign MemtoReg_out=MemtoReg;
			
endmodule
