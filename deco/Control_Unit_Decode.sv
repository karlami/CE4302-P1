module Control_Unit_Decode(input logic [4:0] Opcode, 
						  input logic clk, rst,
						  output logic [3:0] ALUOp, 
						  output logic RegDst,ALUSrc,MemRead,MemWrite,MemtoReg,RegWrite,Branch,BranchOp,RegSrc1,RegSrc2,ALUDest,
						  output logic Vector_Op,PF_op,ImmSrc,Integer_op);
	
	always_ff @(posedge clk or posedge rst) begin

		if (rst) begin 
			RegDst <= 0; 			
			RegSrc1 <= 1'b0;
			RegSrc2 <= 1'b0;
			ALUOp <= 4'b0000; 		
			ALUSrc <= 0; 			
			MemRead <= 0; 			
			MemWrite <= 0;
			MemtoReg <= 0;			
			RegWrite <= 0;			
			Branch <= 0;			
			BranchOp <= 1'b0; 	
			ALUDest<= 1'b0;
			Vector_Op<= 1'b0;
			PF_op <= 1'b0;
			ImmSrc <= 1'b0;
			Integer_op <= 1'b0;
		end 

		else begin 
			case (Opcode)
				//Operador ADD, #1
				5'b00000: begin
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
				
				Vector_Op<= 1'b0;    //Es una operacion vectorial
				PF_op <= 1'b0;			//Es un operacion Punto Fijo
				ImmSrc <= 1'b0;		//Es un inmediatos
				Integer_op <= 1'b1; 
				end
				
				// Operador G3_SUB,#2
				5'b00001: begin
				RegDst <= 1; 		
				RegSrc1 <= 1'b1;
				RegSrc2 <= 1'b1;
				ALUOp <= 4'b0001; 	//Todavia no estan las ALUS por lo tanto no se cual operacion es por lo tanto, es 0000 en todas	
				ALUSrc <= 0; 	 		//Como no trabajamos con inmediatos el ALUSrc es siempre CERO		
				MemRead <= 0;			//Leer de memoria 			
				MemWrite <= 0;			//Escribir en memoria
				MemtoReg <= 0;			//El valor que quiero es de memoria o del output del ALU
				RegWrite <= 0;		
				Branch <= 0;			//Indicar si es un branch
				BranchOp <= 1'b0; 	//Indicar si es un B o BLT 		
				ALUDest<= 1'b1;		//Escribo en un registro es 1 sino es 0 
				
				Vector_Op<= 1'b0;
				PF_op <= 1'b0;
				ImmSrc <= 1'b0;
				Integer_op <= 1'b1;
				end
				
							
				//Operador G3_MUL, #3
				5'b00010: begin
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
				
				Vector_Op<= 1'b0;
				PF_op <= 1'b0;
				ImmSrc <= 1'b0;
				Integer_op <= 1'b1;
				end
				
						
				
				//Operador G3_LDR,#4
				5'b00100: begin
				RegDst <= 1; 		
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
				
				Vector_Op<= 1'b0;
				PF_op <= 1'b0;
				ImmSrc <= 1'b0;
				Integer_op <= 1'b1;	
				end
				
				
						
				
				//Operador G3_ STR,#5
				5'b00101: begin
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
				
				Vector_Op<= 1'b0;
				PF_op <= 1'b0;
				ImmSrc <= 1'b0;
				Integer_op <= 1'b1;
				end
				

				// G3_FADD, #6
				5'b01000: begin
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
				
				Vector_Op<= 1'b0;
				PF_op <= 1'b1;
				ImmSrc <= 1'b0;
				Integer_op <= 1'b0;
				end
				
				
				//G3_FSUB, #7
				5'b01001: begin
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
				
				Vector_Op<= 1'b0;
				PF_op <= 1'b1;
				ImmSrc <= 1'b0;
				Integer_op <= 1'b0;
				end
				

				//G3_FMUL,#8
				5'b01010: begin
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
				
				Vector_Op<= 1'b0;
				PF_op <= 1'b1;
				ImmSrc <= 1'b0;
				Integer_op <= 1'b0;
				end
				

				//G3_FLDR,#9
				5'b01100: begin
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
				
				Vector_Op<= 1'b0;
				PF_op <= 1'b1;
				ImmSrc <= 1'b0;
				Integer_op <= 1'b0;
				end
				

				//G3_ FSTR, #10
				5'b01101: begin
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
				
				Vector_Op<= 1'b0;
				PF_op <= 1'b1;
				ImmSrc <= 1'b0;
				Integer_op <= 1'b0;
				end
				
				

				//G3_VADD, #11
				5'b10000: begin
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
				
				Vector_Op<= 1'b1;
				PF_op <= 1'b0;
				ImmSrc <= 1'b0;
				Integer_op <= 1'b0;
				end
				
				//G3_VSUB,#12
				5'b10001: begin
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
				
				Vector_Op<= 1'b1;
				PF_op <= 1'b0;
				ImmSrc <= 1'b0;
				Integer_op <= 1'b0;
				end
						
				//G3_VMUL,#13
				5'b10010: begin
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
				
				Vector_Op<= 1'b1;
				PF_op <= 1'b0;
				ImmSrc <= 1'b0;
				Integer_op <= 1'b0;
				end
				
	
				//G3_VLDR,#14
				5'b10100: begin
				RegDst <= 1; 		
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
				
				Vector_Op<= 1'b1;
				PF_op <= 1'b0;
				ImmSrc <= 1'b0;
				Integer_op <= 1'b0;
				end
				
				//G3_ VSTR, #15
				5'b 10101: begin
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
				
				Vector_Op<= 1'b1;
				PF_op <= 1'b0;
				ImmSrc <= 1'b0;
				Integer_op <= 1'b0;
				end
						
				//G3_MOVI, #16
				5'b11000: begin
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
				
				Vector_Op<= 1'b0;
				PF_op <= 1'b0;
				ImmSrc <= 1'b0;
				Integer_op <= 1'b0;
				end
					
				//G3_ MOVR,#17
				5'b11001: begin
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
				
				Vector_Op<= 1'b0;
				PF_op <= 1'b0;
				ImmSrc <= 1'b0;
				Integer_op <= 1'b0;
				end
						
				//G3_CMP,#18
				5'b11100: begin
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
				
				Vector_Op<= 1'b0;
				PF_op <= 1'b0;
				ImmSrc <= 1'b0;
				Integer_op <= 1'b0;
				end
				
						
				//G3_B,#19
				5'b11101: begin
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
				
				Vector_Op<= 1'b0;
				PF_op <= 1'b0;
				ImmSrc <= 1'b0;
				Integer_op <= 1'b0;
				end
				
				
				//G3_BLT,#20
				5'b11110: begin
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
				
				Vector_Op<= 1'b0;
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
				Vector_Op<= 1'bx;
				PF_op <= 1'bx;
				ImmSrc <= 1'bx;
				Integer_op <= 1'bx;
				end 
				
			endcase
		end
	end
endmodule
