{
 1.- Implementar un programa que invoque a los siguientes módulos.
a. Implementar un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y los almacene en un vector con dimensión física igual a 10.
b. Implementar un módulo que imprima el contenido del vector.
c. Implementar un módulo recursivo que imprima el contenido del vector.
d. Implementar un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y retorne la cantidad de caracteres leídos. 
El programa debe informar el valor retornado.
e. Implementar un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y retorne una lista con los caracteres leídos.
f. Implemente un módulo recursivo que reciba la lista generada en d. e imprima los valores de la lista en el mismo orden que están almacenados.
g. Implemente un módulo recursivo que reciba la lista generada en d. e imprima los valores de la lista en orden inverso al que están almacenados.
  
}


program Ejercicio1;
const
  dimF = 10;
type
  vector = array [1..dimF] of char;
  
  lista = ^nodo;
  
  nodo = record 
    dato: char;
    sig: lista;
  end;

//PROCESOS

//Inciso A
  procedure cargarVector(var v:vector; var dimL:integer);
  
    //CargarVectorRecursivo
    procedure cargarVectorRecursivo(var v:vector; var dimL:integer);
    var
      caracter:char;
    begin
      if(dimL < dimF)then begin
        writeln('Ingrese un caracter: ');
        readln(caracter);
        if(caracter <> '.')then begin
          dimL:= dimL + 1;
          v[dimL]:= caracter;
          cargarVectorRecursivo(v,dimL);
        end;
      end;
    end;
  
  begin
    dimL:=0;
    cargarVectorRecursivo(v,dimL);
  end;
  
//Inciso C.
procedure imprimirVectorRecursivo(v:vector; dimL:integer);
begin
  if(dimL >= 1)then begin
    imprimirVectorRecursivo(v, dimL - 1);
    writeln('|');
    writeln(v[dimL]);
  end;
end;

//Inciso D.
function leerSecuencia():integer;
var
  caracter: char;
begin
  writeln('Ingrese un caracter: ');
  readln(caracter);
  if(caracter <> '.')then 
    leerSecuencia := leerSecuencia() + 1
  else
    leerSecuencia := 1;
end;

//Inciso E.
procedure cargarListaRecursivo(var l:lista);

  //Proceso agregarChar.
  procedure agregarChar(var l:lista; caracter:char);
  var
    aux:lista;
  begin
    new(aux);
    aux^.dato:= caracter;
    aux^.sig:= nil;
    
    if(l = nil)then 
      l:= aux
    else begin
      aux^.sig:= l;
      l:= aux;
    end;
  end;

var
  caracter: char;
begin
  writeln('Ingrese un caracter: ');
  readln(caracter);
  if(caracter <> '.')then begin
    agregarChar(l, caracter);
    cargarListaRecursivo(l);
  end;
end;


//Inciso F.
procedure imprimirListaRecursivo(l:lista);
begin
  if(l <> nil)then begin
    write('|');
    write(l^.dato);
    imprimirListaRecursivo(l^.sig);
  end;
end;


//Inciso G.
procedure imprimirListaRecursivoInverso(l:lista);
begin
  if(l <> nil)then begin
    imprimirListaRecursivoInverso(l^.sig);
    write('|');
    write(l^.dato);
  end;
end;

//PROGRAMA PRINCIPAL.
var
  v:vector;
  dimL, cantCaracteres:integer;
  l:lista;
BEGIN
	cargarVector(v,dimL); //Cargo el vector con la secuencia de caracteres terminada en un '.'.
  writeln(' ');
  imprimirVectorRecursivo(v,dimL); //Proceso para imprimir un vector, de manera recursiva.
  writeln(' ');
  cantCaracteres := leerSecuencia(); //Se lee una secuencia de caracteres terminada en un punto y retorno la cantidad de caracteres leidos.
  writeln('Cantidad de Caracteres leidos: ', cantCaracteres); 
  writeln(' ');
  cargarListaRecursivo(l); //Se lee una secuencia de caracteres y se agrega a una lista, todo de manera recursiva.
  writeln(' ');
  imprimirListaRecursivo(l); //Proceso recursivo que imprime la lista en el orden que se encuentran cargados los elementos.
  writeln(' ');
  imprimirListaRecursivoInverso(l); //Proceso que imprime la lista de forma recursiva en orden inverso.
END.

