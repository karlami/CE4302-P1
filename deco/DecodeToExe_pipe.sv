module DecodeToExe_pipe(input logic clk, reset,
	 // inputs de stage de writeback
	 input we3,
    input [31:0] wb_result,
    input [4:0] wb_rd,
	 
    input [31:0] de_instr,
    input [31:0] de_pc,
    input [31:0] de_pc_plus4,
	 
	 //Outputs del PC
	 output reg [31:0] ex_pc,
    output reg [31:0] ex_pc_plus_4,

    // outputs del register file
    output reg [31:0] ex_rd1,
    output reg [31:0] ex_rd2,

    output reg [4:0] ex_rs1,
    output reg [4:0] ex_rs2,
	 
	 //Output del inmediato
	 output reg [31:0] ex_imm_ext,
	 
	 //OutPuts del control_unit_escalar
	 output reg [3:0] ex_ALUOp, 
	 output reg ex_RegDst,ex_ALUSrc,ex_MemRead,ex_MemWrite,
	 output reg ex_MemtoReg,ex_RegWrite,ex_Branch,ex_BranchOp,ex_RegSrc1,ex_RegSrc2,ex_ALUDest,
	 output reg ex_PF_op,ex_ImmSrc,ex_Integer_op
);

  
  
  logic [31:0] imm_out;
 
  //Senales intermedias del register file
  logic [4:0] rs1;
  logic [4:0] rs2;
  logic [31:0] rd1;
  logic [31:0] rd2;
  
  //Senales intermedias del control_unit_escalar es decir la salidas 
  logic [3:0] ALUOp;
  logic RegDst,ALUSrc,MemRead,MemWrite,MemtoReg,RegWrite,Branch,BranchOp,RegSrc1,RegSrc2,ALUDest;
  logic PF_op,ImmSrc,Integer_op;
  
  //Hay que cambiar por el momento para que sean nuestras instrucciones  
  assign rs1 = de_instr[15:11];
  assign rs2 = de_instr[20:16];
  
  assign Opcode = de_instr[31:27];

  register_file_escalar reg_file (
      .clk(clk),  // recibe clk negado
      .we3(we3),
      .a1(rs1),
      .a2(rs2),
      .a3(wb_rd),
      .wd3(wb_result),
		
      // outputs
      .rd1(rd1),
      .rd2(rd2)
  );
  
  //Unidad de control escalar
    Control_Unit_Decode Control_Unit_Dec(
        .Opcode(Opcode),
		  //outputs
        .ALUOp(ALUOp),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .Branch(Branch),
        .BranchOp(BranchOp),
        .RegSrc1(RegSrc1),
        .RegSrc2(RegSrc2),
        .ALUDest(ALUDest),
        .PF_op(PF_op),
        .ImmSrc(ImmSrc),
        .Integer_op(Integer_op)
    );

  signExtendImm ExtendImm(
		//Hay que cambiarlo para que sea coherente con nuestra arquitectura
      .in (de_instr[31:6]),
      //output
      .out(imm_out)
  );




always @(posedge clk) begin
    if (reset) begin
		//Outputs del register file
      ex_rd1            <= 0;
      ex_rd2            <= 0;
      ex_rs1            <= 0;
      ex_rs2            <= 0;
		//Outputs del PC
      ex_pc             <= 0;
      ex_pc_plus_4      <= 0;
		
		//Output del inmediato
      ex_imm_ext        <= 0;
		
		//outpus del control_unit_escalar
		ex_ALUOp				<= 0;
		ex_RegDst			<= 0;
		ex_ALUSrc 			<= 0;
		ex_MemRead			<= 0;
		ex_MemWrite			<= 0;
		ex_MemtoReg			<= 0;
		ex_RegWrite			<= 0;
		ex_Branch			<= 0;
		ex_BranchOp			<= 0;
		ex_RegSrc1			<= 0;
		ex_RegSrc2			<= 0;
		ex_ALUDest			<= 0;
		ex_PF_op				<= 0;
		ex_ImmSrc			<= 0;
		ex_Integer_op		<= 0;
		
		
		
    end else begin
		//Outputs del register file
      ex_rd1            <= rd1;
      ex_rd2            <= rd2;
      ex_rs1            <= rs1;
      ex_rs2            <= rs2;
		
		//Outputs del PC
		ex_pc             <= de_pc;
      ex_pc_plus_4      <= de_pc_plus4;
		
		//Output del inmediato 
      ex_imm_ext        <= imm_out;
		
		//Outputs del control_unit_escalar
		ex_ALUOp				<= ALUOp;
		ex_RegDst			<= RegDst;
		ex_ALUSrc 			<= ALUSrc;
		ex_MemRead			<= MemRead;
		ex_MemWrite			<= MemWrite;
		ex_MemtoReg			<= MemtoReg;
		ex_RegWrite			<= RegWrite;
		ex_Branch			<= Branch;
		ex_BranchOp			<= BranchOp;
		ex_RegSrc1			<= RegSrc1;
		ex_RegSrc2			<= RegSrc2;
		ex_ALUDest			<= ALUDest;
		ex_PF_op				<= PF_op;
		ex_ImmSrc			<= ImmSrc;
		ex_Integer_op		<= Integer_op;

		
    end
  end
endmodule