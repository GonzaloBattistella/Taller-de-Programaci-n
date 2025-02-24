{
   2.- El administrador de un edificio de oficinas cuenta, en papel, con la información del pago de las expensas de dichas oficinas. 
Implementar un programa modularizado que:
a. Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada oficina se ingresa el código de identificación, DNI del propietario y valor de la expensa. La lectura finaliza cuando se ingresa el código de identificación -1, el cual no se procesa.
b. Ordene el vector, aplicando el método de inserción, por código de identificación de la oficina.
c. Ordene el vector aplicando el método de selección, por código de identificación de la oficina.
}

program Ejercicio2MetodoInsercion;
const
  dimF=300;
type
  oficina = record
    codigo: integer;
    dni: integer;
    expensa: real;
  end;
  
  vector_ofi = array[1..dimF]of oficina;

var
  o: oficina;
  v: vector_ofi;
  dimL: integer;
BEGIN
	cargarOficinas(v,o,dimL);
	ordenarVectorInsercion(v,dimL);
  imprimirVector(v,dimL);
END.

