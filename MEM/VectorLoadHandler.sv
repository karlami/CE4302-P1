module VectorLoadHandler #(parameter DATA_WIDTH=16)(
			  input logic [18:0] Address,
			  input logic clk,Vectorop,WriteEn,
			  input logic [DATA_WIDTH-1:0] MemoryDataRead,
			  output logic [DATA_WIDTH-1:0] VectorRead [DATA_WIDTH-1:0],
			  output logic BlockPipeLd,
			  output logic [18:0] Out_Address);
			 
			  logic [3:0] mem_adder =4'b0000;
			  logic auxBlockPipeLd=0;
			  
			  
			  
			  always_ff @(posedge clk) begin
					if ( clk) begin
						if (Vectorop && ~WriteEn) begin
							if(mem_adder==15)begin
								auxBlockPipeLd=0;
								Out_Address<=Address+mem_adder;
								VectorRead[mem_adder]=MemoryDataRead;
								mem_adder<=4'b0000;
							end else begin
								auxBlockPipeLd=1;
								Out_Address<=Address+mem_adder;
								VectorRead[mem_adder]=MemoryDataRead;
								mem_adder<=mem_adder+1;
							end
						end
					end
				end
				
				assign BlockPipeLd=auxBlockPipeLd;
endmodule

			  
			  
