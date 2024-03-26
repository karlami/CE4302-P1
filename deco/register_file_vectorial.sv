module register_file_vectorial #(
    parameter WIDTH = 32,
    parameter VECTOR_SIZE = 16,
    parameter NUM_VECTORES = 8
)(
    input clk, we3,
    input [$clog2(NUM_VECTORES)-1:0] v1,
    input [$clog2(NUM_VECTORES)-1:0] v2,
    input [$clog2(NUM_VECTORES)-1:0] v3,
	 //Saca los datos 1 por 1 o los 16 de un solo?
    input [WIDTH-1:0] wd3,
    output [WIDTH-1:0] vd1[VECTOR_SIZE-1:0],
    output [WIDTH-1:0] vd2[VECTOR_SIZE-1:0]
);
	
    reg [WIDTH-1:0] vector[NUM_VECTORES-1:0][VECTOR_SIZE-1:0];
	 
	assign vd1[0] =  (v1 == 0) ? 0 : vector[v1][0];
	assign vd1[1] =  (v1 == 0) ? 0 : vector[v1][1];
	assign vd1[2] =  (v1 == 0) ? 0 : vector[v1][2];
	assign vd1[3] =  (v1 == 0) ? 0 : vector[v1][3];
	assign vd1[4] =  (v1 == 0) ? 0 : vector[v1][4];
	assign vd1[5] =  (v1 == 0) ? 0 : vector[v1][5];
	assign vd1[6] =  (v1 == 0) ? 0 : vector[v1][6];
	assign vd1[7] =  (v1 == 0) ? 0 : vector[v1][7];
	assign vd1[8] =  (v1 == 0) ? 0 : vector[v1][8];
	assign vd1[9] =  (v1 == 0) ? 0 : vector[v1][9];
	assign vd1[10] =  (v1 == 0) ? 0 : vector[v1][10];
	assign vd1[11] =  (v1 == 0) ? 0 : vector[v1][11];
	assign vd1[12] =  (v1 == 0) ? 0 : vector[v1][12];
	assign vd1[13] =  (v1 == 0) ? 0 : vector[v1][13];
	assign vd1[14] =  (v1 == 0) ? 0 : vector[v1][14];
	assign vd1[15] =  (v1 == 0) ? 0 : vector[v1][15];
	
	
	assign vd2[0] =  (v2 == 0) ? 0 : vector[v2][0];
	assign vd2[1] =  (v2 == 0) ? 0 : vector[v2][1];
	assign vd2[2] =  (v2 == 0) ? 0 : vector[v2][2];
	assign vd2[3] =  (v2 == 0) ? 0 : vector[v2][3];
	assign vd2[4] =  (v2 == 0) ? 0 : vector[v2][4];
	assign vd2[5] =  (v2 == 0) ? 0 : vector[v2][5];
	assign vd2[6] =  (v2 == 0) ? 0 : vector[v2][6];
	assign vd2[7] =  (v2 == 0) ? 0 : vector[v2][7];
	assign vd2[8] =  (v2 == 0) ? 0 : vector[v2][8];
	assign vd2[9] =  (v2 == 0) ? 0 : vector[v2][9];
	assign vd2[10] =  (v2 == 0) ? 0 : vector[v2][10];
	assign vd2[11] =  (v2 == 0) ? 0 : vector[v2][11];
	assign vd2[12] =  (v2 == 0) ? 0 : vector[v2][12];
	assign vd2[13] =  (v2 == 0) ? 0 : vector[v2][13];
	assign vd2[14] =  (v2 == 0) ? 0 : vector[v2][14];
	assign vd2[15] =  (v2 == 0) ? 0 : vector[v2][15];
	 
	 always @ (posedge clk) begin
        if (we3) begin
            for (int i = 0; i < VECTOR_SIZE; i = i + 1) begin
                vector[v3][i] <= wd3;
            end
        end
    end


endmodule