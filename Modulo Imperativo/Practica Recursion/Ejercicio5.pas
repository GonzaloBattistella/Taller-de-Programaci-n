{
  5.- Implementar un módulo que realice una búsqueda dicotómica en un vector, utilizando el siguiente encabezado:
   	Procedure busquedaDicotomica (v: vector; ini,fin: indice; dato:integer; var pos: indice); 

  Nota: El parámetro “pos” debe retornar la posición del dato o -1 si el dato no se encuentra en el vector.

}


program Ejercicio5;
const
  dimF = 20;
type
  vector = array [1..dimF] of integer;

//PROCESOS
procedure cargarVector(var v:vector; var dimL:integer);
var
  num:integer;
begin
  writeln('Ingrese un numero: ');
  num:= random(100);
  while(num <> 0) and (dimL < dimF)do begin
    dimL:= dimL + 1;
    v[dimL]:= num;
    writeln('Ingrese un numero: ');
    num:= random(100);
  end;
end;

//IMPRIMIR VECTOR.
procedure imprimirVector(v:vector; dimL:integer);
var
  i:integer;
begin
  writeln('----------------------------------------');
  writeln(' VECTOR DE NUMEROS ');
  writeln('----------------------------------------');
  for i:= 1 to dimL do begin
    writeln('NUMERO: ', v[i]);
    writeln('----------------------------------------');
  end;
  writeln();
end;


//ORDENAR VECTOR: SELECCION.
procedure ordenarVector(var v:vector; dimL:integer);
var
  i,j,pos,num:integer;
begin
  for i:= 1 to dimL - 1 do begin
    pos:= i;
    for j:= i + 1 to dimL do
      if (v[j] < v[pos]) then pos:= j;
    //Realizo el intercambios
    num:= v[pos];
    v[pos]:= v[i];
    v[i]:= num;  
  end;
end;

//BUSQUEDA DICOTOMICA.
procedure busquedaDicotomica (v:vector; ini,fin,num:integer; var pos:integer);
var
  medio:integer;
begin
  if(ini > fin)then 
    pos:= -1 //El arreglo esta vacio
  else begin
    medio:= ((ini + fin) div 2);
  
    //pregunto por el elemento del medio.
    if(v[medio] = num)then
      pos:= medio
    else if (v[medio] > num)then
      busquedaDicotomica(v,ini,medio - 1,num,pos) //Busco en la mitad izquierda
    else
      busquedaDicotomica(v,medio + 1, fin,num,pos); //Busco en la mitad derecha
  end;
end;


//PROGRAMA PRINCIPAL
var
  v:vector;
  dimL:integer;
  pos,num:integer;
BEGIN
  Randomize;
  cargarVector(v,dimL); //Proceso que carga el vector con numeros enteros randoms.
  ImprimirVector(v,dimL); //Muestro el vector cargado
  ordenarVector(v,dimL); //Ordeno el vector por metodo de seleccion
  imprimirVector(v,dimL);
  writeln(' ');
  writeln('Ingrese un numero a buscar en el arreglo: ');
  read(num);
  writeln(' ');
  busquedaDicotomica(v,1,dimL,num,pos); //Busqueda dicotomica, retorna en la variable pos -1 si o se encuentra, o la posicion en el vector del elemento buscado
  if(pos = -1)then
    writeln('El numero buscado no se encuentra en el arreglo ')
  else
    writeln('El numero buscado, se encuentra en la poscicion ', pos, ' del arreglo. ');
  writeln(' ');
END.

