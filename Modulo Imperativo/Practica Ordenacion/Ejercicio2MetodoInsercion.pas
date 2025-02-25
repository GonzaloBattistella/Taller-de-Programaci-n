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
  
//Procesos

//Proceso cargar Oficinas.
procedure cargarOficinas(var v:vector_ofi; var ofi:oficina; var dimL:integer);

  //Proceso Leer Oficina.
  procedure LeerOficina(var ofi:oficina);
  begin
    writeln('--------------------------------------');
    writeln(' ');
    writeln('Ingrese el codigo de Identificacion: ');
    readln(ofi.codigo);
    
    if(ofi.codigo <> -1)then begin
      writeln('Ingrese el dni del propietario: ');
      readln(ofi.dni);
      writeln('Ingrese el valor de la expensa: ');
      readln(ofi.expensa);
      writeln(' ');
      writeln('--------------------------------------');
    end;
  end;

begin
  dimL:= 0;
  
  LeerOficina(ofi);
  
  while(dimL < dimF) and (ofi.codigo <> -1)do begin
    dimL:= dimL + 1;
    v[dimL]:= ofi;
    LeerOficina(ofi);
  end;
end;


//Proceso Ordenar Vector por método de Inserción. De menor a mayor.
procedure ordenarVectorInsercion(var v:vector_ofi; var dimL:integer);
var
  i,j:integer;
  act:oficina;
begin
  //Recorro los eleentos desde la posicion 2 del arreglo hasta la dimL.
  for i:= 2 to dimL do begin
    act:= v[i];
    j:= i - 1;
    
    //Hago los corrimientos correspondienes para ordenar los numeros en cada iteracion del bucle for de ser necesario.
    while (j > 0) and (v[j].codigo > act.codigo)do begin
      v[j + 1]:= v[j];
      j:= j - 1;
    end;
    
    v[j + 1]:= act;
  end;
end;


//Proceso Imprimir Vector.
procedure imprimirVector(v:vector_ofi; dimL:integer);
var
  i:integer;
begin
  writeln(' ');
  writeln(' ');
  writeln('--------------------------------');
  writeln('Vector de Oficinas');
  writeln('--------------------------------');
  for i:= 1 to dimL do begin
    writeln('Codigo Identificacion: ', v[i].codigo);
    writeln('Dni Propietario: ', v[i].dni);
    writeln('Valor Expensas: ', v[i].expensa:2:2);
    writeln('--------------------------------');  
  end;
end;

var
  ofi: oficina;
  v: vector_ofi;
  dimL: integer;
BEGIN
	cargarOficinas(v,ofi,dimL);
	ordenarVectorInsercion(v,dimL);
  imprimirVector(v,dimL);
END.

