//Se define un tamaño de 16 para poder manejar numeros de punto fijo del tipo Q7.8
module ALU_FixedPoint #(parameter DATA_WIDTH = 16)( 
	input reg signed [DATA_WIDTH-1:0] A,
	input reg signed [DATA_WIDTH-1:0] B,
	input reg [1:0] opcode,
	output reg signed [DATA_WIDTH-1:0] Out,
	output reg C, //Carry de fraccional a entero
	output reg N, //Negativo
	output reg V, //Overflow
	output reg Z  //Zero
);

	reg signed [DATA_WIDTH-1:0] OutAddSub, OutMult;
	reg CAddSub, CMult; //Carry
	reg NAddSub, NMult; //Negativo
	reg VAddSub, VMult; //Overflow
	reg ZAddSub, ZMult;  //Zero
	
	reg opAddSub;

	Add_Sub_FixedPoint #(.DATA_WIDTH(DATA_WIDTH)) AddSub(
	.A(A),
	.B(B),
	.op(opAddSub),
	.Out(OutAddSub),
	.C(CAddSub),
	.N(NAddSub),
	.V(VAddSub),
	.Z(ZAddSub)
	);

	Mult_FixedPoint #(.DATA_WIDTH(DATA_WIDTH)) Mult(
	.A(A),
	.B(B),
	.Out(OutMult),
	.C(CMult),
	.N(NMult),
	.V(VMult),
	.Z(ZMult)
	);

	always @(*) begin
		C = 0;
		opAddSub = 1'b0;
		// Select operation based on opcode
		case (opcode)
			2'b00: // Addition
			begin
				opAddSub = 1'b0;
				Out = OutAddSub;
				C   = CAddSub;
				N   = NAddSub;
				V	 = VAddSub;
				Z   = ZAddSub;
			end
			2'b01: // Subtraction
			begin
				opAddSub = 1'b1;
				Out = OutAddSub;
				C   = CAddSub;
				N   = NAddSub;
				V	 = VAddSub;
				Z   = ZAddSub;
			end
			2'b10: // Multiplication
			begin
				Out = OutMult;
				C   = CMult;
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
