module vector_control_unit(input logic [4:0] Opcode,
						  output logic [1:0] ALU_Vectorial, 
						  output logic VectDst,Vector_Read,MemWrite_vector,Vect_Write,Vect_Src1,Vect_Src2);

						  
typedef enum bit [4:0]{
    G3_VADD= 5'b10000,
	 G3_VSUB=5'b10001,
	 G3_VMUL=5'b10010,
	 G3_VLDR=5'b10100,
	 G3_VSTR=5'b10101
}op_type_1;


	always @(*) begin
		case(Opcode)
		   G3_VADD: begin
				ALU_Vectorial<=2'b00;
				VectDst<=1;
				Vector_Read<=0;
				MemWrite_vector<=0;
				Vect_Write<=0;
				Vect_Src1<=1;
				Vect_Src2<=1;
			end
			G3_VSUB: begin
				ALU_Vectorial<=2'b01;;
				VectDst<=1;
				Vector_Read<=0;
				MemWrite_vector<=0;
				Vect_Write<=0;
				Vect_Src1<=1;
				Vect_Src2<=1;
			end
			G3_VMUL: begin
				ALU_Vectorial<=2'b10;;
				VectDst<=1;
				Vector_Read<=0;
				MemWrite_vector<=0;
				Vect_Write<=0;
				Vect_Src1<=1;
				Vect_Src2<=1;
			end
			G3_VLDR: begin
				ALU_Vectorial<=2'b11;;
				VectDst<=1;
				Vector_Read<=1;
				MemWrite_vector<=0;
				Vect_Write<=1;
				Vect_Src1<=1;
				Vect_Src2<=0;
			end
			G3_VSTR: begin
				ALU_Vectorial<=2'b11;;
				VectDst<=1;
				Vector_Read<=0;
				MemWrite_vector<=1;
				Vect_Write<=0;
				Vect_Src1<=1;
				Vect_Src2<=0;
			end
			default: begin
				ALU_Vectorial<=2'bxx;;
				VectDst<=1'bx;
				Vector_Read<=1'bx;
				MemWrite_vector<=1'bx;
				Vect_Write<=1'bx;
				Vect_Src1<=1'bx;
				Vect_Src2<=1'bx;
			end
		endcase
	end
	

endmodule 