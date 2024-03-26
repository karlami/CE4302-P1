module adder_tb;

    parameter WIDTH = 8;
    parameter CLK_PERIOD = 10;
	 logic clk;

    logic [WIDTH-1:0] a, b;
    logic [WIDTH-1:0] y;

    adder #(WIDTH) dut (
        .a(a),
        .b(b),
        .y(y)
    );

    always #((CLK_PERIOD)/2) clk = ~clk;

    initial begin
        // Case 1
        a = 8'b0000_0001;
        b = 8'b0000_0001;
        #10;
        $display("Case 1: a=%b, b=%b, y=%b", a, b, y);

        // Case 2
        a = 8'b0000_0010;
        b = 8'b0000_0011;
        #10;
        $display("Case 2: a=%b, b=%b, y=%b", a, b, y);

        // Case 3
        a = 8'b1111_1111;
        b = 8'b0000_0001;
        #10;
        $display("Case 3: a=%b, b=%b, y=%b", a, b, y);

        $finish;
    end

endmodule