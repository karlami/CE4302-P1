module mux2_1_TB();


logic [15:0] d0,d1;
logic s;
logic [15:0] out;

mux2_1 #(.WIDTH(16)) mux1(d0,d1,s,out);


initial begin


d0 = 16'd1;
d1 = 16'd15;

s = 0;
#10;
assert (out == 16'd1) $display("correcto");
else $error ("Fallo caso s = 0");


#10;
s = 1;

#10;
assert (out == 16'd15) $display("correcto");
else $error ("Fallo caso s = 1");
#10;



end



endmodule