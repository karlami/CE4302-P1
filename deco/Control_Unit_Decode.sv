module Control_Unit_Decode(input logic [4:0] Opcode,
						  output logic [3:0] ALUOp, 
						  output logic RegDst,ALUSrc,MemRead,MemWrite,MemtoReg,RegWrite,Branch,BranchOp,RegSrc1,RegSrc2,ALUDest,
						  output logic PF_op,ImmSrc,Integer_op);
	
	typedef enum bit [4:0]{
    G3_ADD = 5'b00000,
	 G3_SUB=5'b00001,
	 G3_MUL=5'b00010,
	 G3_LDR=5'b00100,
	 G3_STR=5'b00101,
	 G3_FADD=5'b01000,
	 G3_FSUB=5'b01001,
	 G3_FMUL=5'b01010,
	 G3_FLDR=5'b01100,
	 G3_FSTR=5'b01101,
	 G3_MOVI=5'b11000,
	 G3_MOVR=5'b11001,
	 G3_CMP=5'b11100,
	 G3_B=5'b11101,
	 G3_BLT= 5'b11110
}op_type;
  
	always @(*) begin 
			case (Opcode)
				//Operador ADD, #1
				G3_ADD: begin
				RegDst <= 1; 		//G3_ADD r0, r1, r2, señalar que tiene que escribir en el registro R0	
				RegSrc1 <= 1'b1;
				RegSrc2 <= 1'b1;
				ALUOp <= 4'b0000; 	//Todavia no estan las ALUS por lo tanto no se cual operacion es por lo tanto, es 0000 en todas	
				ALUSrc <= 0; 	 		//Como no trabajamos con inmediatos el ALUSrc es siempre CERO		
				MemRead <= 0;			//Leer de memoria 			
				MemWrite <= 0;			//Escribir en memoria
				MemtoReg <= 0;			//El valor que quiero es de memoria o del output del ALU
				RegWrite <= 0;		
				Branch <= 0;			//Indicar si es un branch
				BranchOp <= 1'b0; 	//Indicar si es un B o BLT 		
				ALUDest<= 1'b1;		//Escribo en un registro es 1 sino es 0 
				
				PF_op <= 1'b0;			//Es un operacion Punto Fijo
				ImmSrc <= 1'b0;		//Es un inmediatos
				Integer_op <= 1'b1; 
				end
				
				// Operador G3_SUB,#2
				G3_SUB: begin
				RegDst <= 1; 		
				RegSrc1 <= 1'b1;
				RegSrc2 <= 1'b1;
				ALUOp <= 4'b001; 	//Todavia no estan las ALUS por lo tanto no se cual operacion es por lo tanto, es 0000 en todas	
				ALUSrc <= 0; 	 		//Como no trabajamos con inmediatos el ALUSrc es siempre CERO		
				MemRead <= 0;			//Leer de memoria 			
				MemWrite <= 0;			//Escribir en memoria
				MemtoReg <= 0;			//El valor que quiero es de memoria o del output del ALU
				RegWrite <= 0;		
				Branch <= 0;			//Indicar si es un branch
				BranchOp <= 1'b0; 	//Indicar si es un B o BLT 		
				ALUDest<= 1'b1;		//Escribo en un registro es 1 sino es 0 
				
				PF_op <= 1'b0;
				ImmSrc <= 1'b0;
				Integer_op <= 1'b1;
				end
				
							
				//Operador G3_MUL, #3
				G3_MUL: begin
				RegDst <= 1; 			
				RegSrc1 <= 1'b1;
				RegSrc2 <= 1'b1;
				ALUOp <= 4'b0000; 	//Todavia no estan las ALUS por lo tanto no se cual operacion es por lo tanto, es 0000 en todas	
				ALUSrc <= 0; 	 		//Como no trabajamos con inmediatos el ALUSrc es siempre CERO		
				MemRead <= 0;			//Leer de memoria 			
				MemWrite <= 0;			//Escribir en memoria
				MemtoReg <= 0;			//El valor que quiero es de memoria o del output del ALU
				RegWrite <= 0;		
				Branch <= 0;			//Indicar si es un branch
				BranchOp <= 1'b0; 	//Indicar si es un B o BLT 		
				ALUDest<= 1'b1;		//Escribo en un registro es 1 sino es 0 
				
				PF_op <= 1'b0;
				ImmSrc <= 1'b0;
				Integer_op <= 1'b1;
				end
				
						
				
				//Operador G3_LDR,#4
				G3_LDR: begin
				RegDst <= 1; 		
				RegSrc1 <= 1'b1;
				RegSrc2 <= 1'b1;
				ALUOp <= 4'b0100; 	//Todavia no estan las ALUS por lo tanto no se cual operacion es por lo tanto, es 0000 en todas	
				ALUSrc <= 0; 	 		//Como no trabajamos con inmediatos el ALUSrc es siempre CERO		
				MemRead <= 1;			//Leer de memoria 			
				MemWrite <= 0;			//Escribir en memoria
				MemtoReg <= 1;			//El valor que quiero es de memoria o del output del ALU
				RegWrite <= 1;		
				Branch <= 0;			//Indicar si es un branch
				BranchOp <= 1'b0; 	//Indicar si es un B o BLT 		
				ALUDest<= 1'b1;		//Escribo en un registro es 1 sino es 0 
				
				PF_op <= 1'b0;
				ImmSrc <= 1'b0;
				Integer_op <= 1'b1;	
				end
				
				
						
				
				//Operador G3_ STR,#5
				G3_STR: begin
				RegDst <= 1; 		
				RegSrc1 <= 1'b0;
				RegSrc2 <= 1'b0;
				ALUOp <= 4'b0000; 	//Todavia no estan las ALUS por lo tanto no se cual operacion es por lo tanto, es 0000 en todas	
				ALUSrc <= 0; 	 		//Como no trabajamos con inmediatos el ALUSrc es siempre CERO		
				MemRead <= 0;			//Leer de memoria 			
				MemWrite <= 1;			//Escribir en memoria
				MemtoReg <= 0;			//El valor que quiero es de memoria o del output del ALU
				RegWrite <= 0;		
				Branch <= 0;			//Indicar si es un branch
				BranchOp <= 1'b0; 	//Indicar si es un B o BLT 		
				ALUDest<= 1'b1;		//Escribo en un registro es 1 sino es 0 
				
				PF_op <= 1'b0;
				ImmSrc <= 1'b0;
				Integer_op <= 1'b1;
				end
				

				// G3_FADD, #6
				G3_FADD: begin
				RegDst <= 1; 	
				RegSrc1 <= 1'b1;
				RegSrc2 <= 1'b1;
				ALUOp <= 4'b0000; 	//Todavia no estan las ALUS por lo tanto no se cual operacion es por lo tanto, es 0000 en todas	
				ALUSrc <= 0; 	 		//Como no trabajamos con inmediatos el ALUSrc es siempre CERO		
				MemRead <= 0;			//Leer de memoria 			
				MemWrite <= 0;			//Escribir en memoria
				MemtoReg <= 0;			//El valor que quiero es de memoria o del output del ALU
				RegWrite <= 0;		
				Branch <= 0;			//Indicar si es un branch
				BranchOp <= 1'b0; 	//Indicar si es un B o BLT 		
				ALUDest<= 1'b1;		//Escribo en un registro es 1 sino es 0 
				
				PF_op <= 1'b1;
				ImmSrc <= 1'b0;
				Integer_op <= 1'b0;
				end
				
				
				//G3_FSUB, #7
				G3_FSUB: begin
				RegDst <= 1; 		
				RegSrc1 <= 1'b1;
				RegSrc2 <= 1'b1;
				ALUOp <= 4'b0000; 	//Todavia no estan las ALUS por lo tanto no se cual operacion es por lo tanto, es 0000 en todas	
				ALUSrc <= 0; 	 		//Como no trabajamos con inmediatos el ALUSrc es siempre CERO		
				MemRead <= 0;			//Leer de memoria 			
				MemWrite <= 0;			//Escribir en memoria
				MemtoReg <= 0;			//El valor que quiero es de memoria o del output del ALU
				RegWrite <= 0;		
				Branch <= 0;			//Indicar si es un branch
				BranchOp <= 1'b0; 	//Indicar si es un B o BLT 		
				ALUDest<= 1'b1;		//Escribo en un registro es 1 sino es 0 
				
				PF_op <= 1'b1;
				ImmSrc <= 1'b0;
				Integer_op <= 1'b0;
				end
				

				//G3_FMUL,#8
				G3_FMUL: begin
				RegDst <= 1; 			
				RegSrc1 <= 1'b1;
				RegSrc2 <= 1'b1;
				ALUOp <= 4'b0000; 	//Todavia no estan las ALUS por lo tanto no se cual operacion es por lo tanto, es 0000 en todas	
				ALUSrc <= 0; 	 		//Como no trabajamos con inmediatos el ALUSrc es siempre CERO		
				MemRead <= 0;			//Leer de memoria 			
				MemWrite <= 0;			//Escribir en memoria
				MemtoReg <= 0;			//El valor que quiero es de memoria o del output del ALU
				RegWrite <= 0;		
				Branch <= 0;			//Indicar si es un branch
				BranchOp <= 1'b0; 	//Indicar si es un B o BLT 		
				ALUDest<= 1'b1;		//Escribo en un registro es 1 sino es 0 
				
				PF_op <= 1'b1;
				ImmSrc <= 1'b0;
				Integer_op <= 1'b0;
				end
				

				//G3_FLDR,#9
				 G3_FLDR: begin
				RegDst <= 1; 		//G3_ADD r0, r1, r2, señalar que tiene que escribir en el registro R0	
				RegSrc1 <= 1'b1;
				RegSrc2 <= 1'b1;
				ALUOp <= 4'b0000; 	//Todavia no estan las ALUS por lo tanto no se cual operacion es por lo tanto, es 0000 en todas	
				ALUSrc <= 0; 	 		//Como no trabajamos con inmediatos el ALUSrc es siempre CERO		
				MemRead <= 1;			//Leer de memoria 			
				MemWrite <= 0;			//Escribir en memoria
				MemtoReg <= 1;			//El valor que quiero es de memoria o del output del ALU
				RegWrite <= 1;		
				Branch <= 0;			//Indicar si es un branch
				BranchOp <= 1'b0; 	//Indicar si es un B o BLT 		
				ALUDest<= 1'b1;		//Escribo en un registro es 1 sino es 0 
				
				PF_op <= 1'b1;
				ImmSrc <= 1'b0;
				Integer_op <= 1'b0;
				end
				

				//G3_ FSTR, #10
				G3_FSTR: begin
				RegDst <= 1; 		
				RegSrc1 <= 1'b0;
				RegSrc2 <= 1'b0;
				ALUOp <= 4'b0000; 	//Todavia no estan las ALUS por lo tanto no se cual operacion es por lo tanto, es 0000 en todas	
				ALUSrc <= 0; 	 		//Como no trabajamos con inmediatos el ALUSrc es siempre CERO		
				MemRead <= 0;			//Leer de memoria 			
				MemWrite <= 1;			//Escribir en memoria
				MemtoReg <= 0;			//El valor que quiero es de memoria o del output del ALU
				RegWrite <= 0;		
				Branch <= 0;			//Indicar si es un branch
				BranchOp <= 1'b0; 	//Indicar si es un B o BLT 		
				ALUDest<= 1'b1;		//Escribo en un registro es 1 sino es 0 
				
				PF_op <= 1'b1;
				ImmSrc <= 1'b0;
				Integer_op <= 1'b0;
				end
						
				//G3_MOVI, #16
				G3_MOVI: begin
				RegDst <= 1; 		
				RegSrc1 <= 1'b1;
				RegSrc2 <= 1'b1;
				ALUOp <= 4'b0000; 	//Todavia no estan las ALUS por lo tanto no se cual operacion es por lo tanto, es 0000 en todas	
				ALUSrc <= 1; 	 		//Aqui es uno para inmediato	
				MemRead <= 0;			//Leer de memoria 			
				MemWrite <= 0;			//Escribir en memoria
				MemtoReg <= 0;			//El valor que quiero es de memoria o del output del ALU
				RegWrite <= 0;		
				Branch <= 0;			//Indicar si es un branch
				BranchOp <= 1'b0; 	//Indicar si es un B o BLT 		
				ALUDest<= 1'b1;		//Escribo en un registro es 1 sino es 0 
				
				PF_op <= 1'b0;
				ImmSrc <= 1'b0;
				Integer_op <= 1'b0;
				end
					
				//G3_ MOVR,#17
				G3_MOVR: begin
				RegDst <= 1; 			
				RegSrc1 <= 1'b1;
				RegSrc2 <= 1'b1;
				ALUOp <= 4'b0000; 	//Todavia no estan las ALUS por lo tanto no se cual operacion es por lo tanto, es 0000 en todas	
				ALUSrc <= 0; 	 		//Como no trabajamos con inmediatos el ALUSrc es siempre CERO		
				MemRead <= 0;			//Leer de memoria 			
				MemWrite <= 0;			//Escribir en memoria
				MemtoReg <= 0;			//El valor que quiero es de memoria o del output del ALU
				RegWrite <= 0;		
				Branch <= 0;			//Indicar si es un branch
				BranchOp <= 1'b0; 	//Indicar si es un B o BLT 		
				ALUDest<= 1'b1;		//Escribo en un registro es 1 sino es 0 
				
				PF_op <= 1'b0;
				ImmSrc <= 1'b0;
				Integer_op <= 1'b0;
				end
						
				//G3_CMP,#18
				G3_CMP: begin
				RegDst <= 1; 		
				RegSrc1 <= 1'b1;
				RegSrc2 <= 1'b1;
				ALUOp <= 4'b0000; 	//Todavia no estan las ALUS por lo tanto no se cual operacion es por lo tanto, es 0000 en todas	
				ALUSrc <= 0; 	 		//Como no trabajamos con inmediatos el ALUSrc es siempre CERO		
				MemRead <= 0;			//Leer de memoria 			
				MemWrite <= 0;			//Escribir en memoria
				MemtoReg <= 0;			//El valor que quiero es de memoria o del output del ALU
				RegWrite <= 0;		
				Branch <= 0;			//Indicar si es un branch
				BranchOp <= 1'b0; 	//Indicar si es un B o BLT 		
				ALUDest<= 1'b1;		//Escribo en un registro es 1 sino es 0 
				
				PF_op <= 1'b0;
				ImmSrc <= 1'b0;
				Integer_op <= 1'b0;
				end
				
						
				//G3_B,#19
				G3_B: begin
				RegDst <= 1; 		
				RegSrc1 <= 1'b1;
				RegSrc2 <= 1'b1;
				ALUOp <= 4'b0100; 	//Todavia no estan las ALUS por lo tanto no se cual operacion es por lo tanto, es 0000 en todas	
				ALUSrc <= 0; 	 		//Como no trabajamos con inmediatos el ALUSrc es siempre CERO		
				MemRead <= 0;			//Leer de memoria 			
				MemWrite <= 0;			//Escribir en memoria
				MemtoReg <= 0;			//El valor que quiero es de memoria o del output del ALU
				RegWrite <= 0;		
				Branch <= 0;			//Indicar si es un branch
				BranchOp <= 1'b0; 	//Indicar si es un B o BLT 		
				ALUDest<= 1'b1;		//Escribo en un registro es 1 sino es 0 
				
				PF_op <= 1'b0;
				ImmSrc <= 1'b0;
				Integer_op <= 1'b0;
				end
				
				//G3_BLT,#20
				G3_BLT: begin
				RegDst <= 1; 		
				RegSrc1 <= 1'b1;
				RegSrc2 <= 1'b1;
				ALUOp <= 4'b0000; 	//Todavia no estan las ALUS por lo tanto no se cual operacion es por lo tanto, es 0000 en todas	
				ALUSrc <= 0; 	 		//Como no trabajamos con inmediatos el ALUSrc es siempre CERO		
				MemRead <= 0;			//Leer de memoria 			
				MemWrite <= 0;			//Escribir en memoria
				MemtoReg <= 0;			//El valor que quiero es de memoria o del output del ALU
				RegWrite <= 0;		
				Branch <= 0;			//Indicar si es un branch
				BranchOp <= 1'b0; 	//Indicar si es un B o BLT 		
				ALUDest<= 1'b1;		//Escribo en un registro es 1 sino es 0 
				
				PF_op <= 1'b0;
				ImmSrc <= 1'b0;
				Integer_op <= 1'b0;
				end
				
				default: begin
				RegDst <= 1'bx; 			
				RegSrc1 <= 1'bx;
				RegSrc2 <= 1'bx;
				ALUOp <= 4'bxxxx; 	//Todavia no estan las ALUS por lo tanto no se cual operacion es por lo tanto, es 0000 en todas	
				ALUSrc <= 1'bx; 	 		//Como no trabajamos con inmediatos el ALUSrc es siempre CERO		
				MemRead <= 1'bx;			//Leer de memoria 			
				MemWrite <= 1'bx;			//Escribir en memoria
				MemtoReg <= 1'bx;			//El valor que quiero es de memoria o del output del ALU
				RegWrite <= 1'bx;		
				Branch <= 1'bx;			//Indicar si es un branch
				BranchOp <= 1'bx; 	//Indicar si es un B o BLT 		
				ALUDest<= 1'bx;		//Escribo en un registro es 1 sino es 0 
				
				PF_op <= 1'bx;
				ImmSrc <= 1'bx;
				Integer_op <= 1'bx;
				end 
			endcase
		end
endmodule
