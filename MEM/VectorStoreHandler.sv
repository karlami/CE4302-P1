module VectorStoreHandler #(parameter DATA_WIDTH=16)(
			  input logic [18:0] Address,
			  input logic clk,Vectorop,WriteEn,
			  input logic [DATA_WIDTH-1:0] Result,
			  input logic [DATA_WIDTH-1:0] VectorResult [DATA_WIDTH-1:0],
			  output logic BlockPipeStr,
			  output logic [18:0] Out_Address,
			  output logic [DATA_WIDTH-1:0] MemorydataWrite);
			  
			  logic [3:0] mem_adder =4'b0000;
			  logic auxBlockPipeStr=0;
			  logic [DATA_WIDTH-1:0] MemorydataWriteaux;
			  
			  always_ff @(posedge clk) begin
					if (clk) begin
						if (Vectorop && WriteEn) begin
							if(mem_adder==15)begin
								auxBlockPipeStr=0;
								Out_Address<=Address+mem_adder;
								MemorydataWriteaux = VectorResult[mem_adder];
								mem_adder<=4'b0000;
							end else begin
								auxBlockPipeStr=1;
								Out_Address<=Address+mem_adder;
								MemorydataWriteaux = VectorResult[mem_adder];
								mem_adder<=mem_adder+1;					
							end
							
						end else if (WriteEn) begin
							Out_Address<=Address;
							MemorydataWriteaux = Result;
						end
					end
			 end
			assign BlockPipeStr=auxBlockPipeStr;
			assign MemorydataWrite = MemorydataWriteaux;
endmodule
