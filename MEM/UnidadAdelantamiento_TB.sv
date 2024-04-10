module UnidadAdelantamiento_TB();

logic [3:0] RA,RB,RL;
logic AdelantamientoA,AdelantamientoB,load;

UnidadAdelantamiento UA(RL,RA,RB,load,AdelantamientoA,AdelantamientoB);


initial begin

RA = 4'd7;
RB = 4'd1;
RL= 4'd5;
load = 1;
#10;

//Los registros de operación son diferentes al registro de carga y se cargo en memoria
assert (AdelantamientoA==0&&AdelantamientoB==0) $display("correcto");
else $error ("Fallo caso registros diferentes y carga de memoria");

#10;
RL=4'd7;

#10;
//Registro A es igual al de carga y se cargo en memoria
assert (AdelantamientoA == 1&&AdelantamientoB==0) $display("correcto");
else $error ("Fallo caso registro A igual y carga de memoria");

#10;
RL=4'd1;

#10;
//Registro B es igual al de carga y se cargo en memoria
assert (AdelantamientoA == 0 && AdelantamientoB==1) $display("correcto");
else $error ("Fallo caso registro B igual y carga de memoria");


#10;
load=0;

#10;
//Uno de los registros es igual al de carga y se cargo en memoria
assert (AdelantamientoA == 0&&AdelantamientoB==0) $display("correcto");
else $error ("Fallo caso registros iguales sin carga de memoria");



end



endmodule