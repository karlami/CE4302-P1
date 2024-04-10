module vector_mux2_1_TB();


logic [15:0] d0[15:0];
logic [15:0] d1[15:0];
logic s;
logic [15:0] out[15:0];

mux2_1 #(.WIDTH(16), .VECTOR_LENGTH(16)) mux1(d0,d1,s,out);


initial begin

for(int i=0;i<16;i++)begin
	d0[i] = i;
	d1[i] = 15-i;
end
s = 0;
#10;
for(int i=0;i<16;i++)begin
	assert (out[i] == d0[i]) $display("correcto");
	else $error ("Fallo caso s = 0");
end

#10;
s = 1;

#10;
for(int i=0;i<16;i++)begin
	assert (out[i] == d1[i]) $display("correcto");
	else $error ("Fallo caso s = 0");
end
#10;



end



endmodule