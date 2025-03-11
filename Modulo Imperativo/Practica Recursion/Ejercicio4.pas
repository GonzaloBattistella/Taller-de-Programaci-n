{
  4.- Escribir un programa que:
  a. Implemente un módulo recursivo que genere un vector de 20 números enteros “random” mayores a 0 y menores a 100. 
  b. Implemente un módulo recursivo que devuelva el máximo valor del vector. 
  c. Implementar un módulo recursivo que devuelva la suma de los valores contenidos en el vector.

}


program Ejercicio4;
const
  dimF = 20;
  type
  vector_numeros = array [1..dimF] of integer;


//PROCESOS

//INCISO A
procedure cargarVector(var v:vector_numeros; var dimL:integer);
var
  num:integer;
begin
  num:= random(100);
  while(num = 0)do //si es igual a cero genero otro numero
    num:= random(100);
  if(dimL < dimF)then begin
    dimL:= dimL + 1;
    v[dimL]:= num;
    cargarVector(v,dimL); //Llamado recursivo
  end;
end;

//PROCESO IMPRIMIR VECTOR.
procedure imprimirVector(v:vector_numeros; dimL:integer);
var
  i:integer;
begin
  writeln('-----------------------------------');
  writeln('VECTOR DE NUMEROS');
  writeln('-----------------------------------');
  
  for i:= 1 to dimL do begin
    writeln('Numero: ', v[i]);
    writeln('-----------------------------------');
  end;
end;

//INCISO B
function maximo(v:vector_numeros; dimL:integer):integer;
var
  max: integer;
begin
  if(dimL = 1)then 
    maximo:= v[1]
  else begin
    max:= maximo(v,dimL - 1);
    if(v[dimL] > max)then
      maximo:= v[dimL]
    else
      maximo:= max;
  end;
end;

//INCISO C.
function sumaTotal(v:vector_numeros; dimL:integer):integer;
begin
  if(dimL = 0)then
    sumaTotal:= 0
  else
    sumaTotal:= v[dimL] + sumaTotal(v, dimL - 1);
end;

//PROGRAMA PRINCIPAL
var 
  v:vector_numeros;
  dimL:integer;
BEGIN
  dimL:= 0;
  Randomize;
  cargarVector(v,dimL); //Proceso recursivo en cual cargo el arreglo con 20 numeros mayores que 0 y menores que 100.
  imprimirVector(v,dimL); //No lo pide el enunciado, es para verificar como se cargan los numeros en el vector.
  writeln(' ');
  writeln('El valor maximo del vector es: ', maximo(v,dimL)); //Funcion recursiva que retorna el valor maximo del vector.
  writeln(' ');
  writeln('La suma total de los valores del vector es: ', sumaTotal(v,dimL)); //Funcion recursiva que retorna la suma total de todos los numeros del vector.
  writeln(' ');
END.

