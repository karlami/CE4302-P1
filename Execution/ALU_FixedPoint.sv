//Se define un tamaño de 16 para poder manejar numeros de punto fijo del tipo Q7.8
module ALU_FixedPoint #(parameter DATA_WIDTH = 16)( 
    input reg signed [DATA_WIDTH-1:0] A,
	 input reg signed [DATA_WIDTH-1:0] B,
	 input logic [1:0] opcode,
    output reg signed [DATA_WIDTH-1:0] Out,
	 output reg N, //Negativo
	 output reg V, //Overflow
	 output reg Z  //Zero
);

	 reg signed [DATA_WIDTH-1:0] OutAdd, OutSub, OutMult;
	 reg NAdd, NSub, NMult; //Negativo
	 reg VAdd, VSub, VMult; //Overflow
	 reg ZAdd, ZSub, ZMult;  //Zero
	
	Add_FixedPoint #(.DATA_WIDTH(DATA_WIDTH)) Add(
    .A(A),
    .B(B),
    .Out(OutAdd),
	 .N(NAdd),
	 .V(VAdd),
	 .Z(ZAdd)
   );
	
	Sub_FixedPoint #(.DATA_WIDTH(DATA_WIDTH)) Sub(
    .A(A),
    .B(B),
    .Out(OutSub),
	 .N(NSub),
	 .V(VSub),
	 .Z(ZSub)
   );
	
	Mult_FixedPoint #(.DATA_WIDTH(DATA_WIDTH)) Mult(
    .A(A),
    .B(B),
    .Out(OutMult),
	 .N(NMult),
	 .V(VMult),
	 .Z(ZMult)
   );
	
	always_comb begin
        // Select operation based on opcode
        case (opcode)
				2'b00: // Addition
				begin
					Out = OutAdd;
					N   = NAdd;
					V	 = VAdd;
					Z   = ZAdd;
				end
            2'b01: // Subtraction
				begin 
					Out = OutSub;
					N   = NSub;
					V	 = VSub;
					Z   = ZSub;
				end
            2'b10: // Multiplication
				begin
					Out = OutMult;
					N   = NMult;
					V	 = VMult;
					Z   = ZMult;
				end
            default: // Handle default case
				begin
					Out = 0;
					N   = 0;
					V	 = 0;
					Z   = 0;
				end
				
        endcase
    end
	
endmodule
