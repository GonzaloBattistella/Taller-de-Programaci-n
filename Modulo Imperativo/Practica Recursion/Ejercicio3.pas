{
   3.- Escribir un programa que:
  a. Implemente un módulo recursivo que genere una lista de números enteros “random” mayores a 0 y menores a 100. Finalizar con el número 0.
  b. Implemente un módulo recursivo que devuelva el mínimo valor de la lista. 
  c. Implemente un módulo recursivo que devuelva el máximo valor de la lista. 
  d. Implemente un módulo recursivo que devuelva verdadero si un valor determinado se encuentra en la lista o falso en caso contrario. 
}


program Ejercicio3;
type
  lista = ^nodo;
  
  nodo = record
    dato: Integer;
    sig: lista;
  end;

//PROCESOS 

//INCISO A.
procedure cargarListaRecursivo(var l:lista);

  //Proceso agregarNum, se agrega el numero adelante de la lista.
  procedure agregarNum(var l:lista; num: integer);
  var
    aux:lista;
  begin
    //Creo el nuevo nodo
    new(aux);
    aux^.dato:= num;
    aux^.sig:= nil;
    
    //Agrego el numero al inicio de la lista.
    aux^.sig:= l;
    l:= aux;
  end;

var
  num: integer;
begin
  num:= Random(100);
  if(num <> 0)then begin
    agregarNum(l,num);
    cargarListaRecursivo(l);
  end;
end;


//PROCESO IMPRIMIR LISTA.
procedure imprimirLista(l: lista);
begin
  writeln('--------------------------------------');
  writeln('LISTA DE NUMEROS');
  writeln('--------------------------------------');
  while(l <> nil)do begin
    writeln('Numero: ', l^.dato);
    writeln('--------------------------------------');
    l:= l^.sig;
  end;
end;


//INCISO B.
function obtenerMinimo(l:lista): integer;
var
  min:integer;
begin
  if(l = nil)then
    obtenerMinimo:= 9999
  else begin
    min:= obtenerMinimo(l^.sig);
    if(l^.dato < min)then
      obtenerMinimo:= l^.dato
    else
      obtenerMinimo:= min; 
  end;
end; 

//INCISO C.
function obtenerMaximo(l:lista):integer;
var
  max:integer;
begin
  if(l = nil)then
    obtenerMaximo:= -1
  else begin
    max:= obtenerMaximo(l^.sig); //Llamada recursivo
    if(l^.dato > max)then
      obtenerMaximo:= l^.dato
    else
      obtenerMaximo:= max;
  end;
end;


//INCISO D.
procedure buscarNumero(l:lista; num:integer);

  //Funcion buscarNumeroRecursivo.
  function buscarNumeroRecursivo(l:lista; num:integer):boolean;
  begin
    if(l = nil)then 
      buscarNumeroRecursivo:= false
    else begin
      if(l^.dato = num)then
        buscarNumeroRecursivo:= true
      else
        buscarNumeroRecursivo:= buscarNumeroRecursivo(l^.sig, num);
    end;
  end;

begin
  if(buscarNumeroRecursivo(l, num))then
    writeln('El numero ingresado se encuentra en la lista.')
  else
    writeln('El numero ingresado no se encuentra en la lista');
end;

//PROGRAMA PRINCIPAL
var 
  l:lista;
  num:integer;
BEGIN
  Randomize;
  cargarListaRecursivo(l); //Cargo la lista con numeros randoms, mayores que 0 y menores que 100.
  imprimirLista(l); //Imprimo la ista, para verificar que se haya cargado correctamente.
  writeln(' ');
  writeln('El numero minimo de la lista es: ', obtenerMinimo(l)); //Funcion recursiva con la que obtengo el menor numero de la lista.
  writeln(' ');
  writeln('El numero maximo de la lista es: ', obtenerMaximo(l)); //Funcion recursiva que retorna el numero maximo de la lista.
  writeln(' ');
  writeln('Ingrese un numero a buscar: ');
  read(num);
  writeln(' ');
  buscarNumero(l, num);
END.

