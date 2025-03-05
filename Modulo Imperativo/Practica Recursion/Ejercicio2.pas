{
   2.- Realizar un programa que lea números hasta leer el valor 0 e imprima, 
   * para cada número leído, sus dígitos en el orden en que aparecen en el número. 
   * Debe implementarse un módulo recursivo que reciba el número e imprima lo pedido. 
   * Ejemplo si se lee el valor 256, se debe imprimir 2  5  6
}


program Ejercicio2;
type
  lista = ^nodo;
  
  nodo = record
    dato: integer;
    sig:lista;
  end;

//PROCESOS.

//Proceso cargarLista.
procedure cargarLista(var l:lista);

  //Proceso agregarNum.
  procedure agregarNum(var l:lista; num:integer);
  var
    aux:lista;
  begin
    new(aux);
    aux^.dato:= num;
    aux^.sig:= nil;
    
    if(l = nil)then
      l:= aux
    else begin
      aux^.sig:= l;
      l:= aux;
    end;
  end;

var
  num:integer;
begin
  writeln('Ingrese un numero: ');
  readln(num);
  while(num <> 0)do begin
    agregarNum(l, num);
    writeln('Ingrese un numero: ');
    readln(num);
  end;
  writeln(' ');
end;

//Proceso imprimirLista.
procedure imprimirLista(l:lista);

  //Proceso imprimirNumero.
  procedure imprimirNumero(numero:integer);
  var
    digito:integer;
  begin
    if(numero <> 0)then begin
      digito:= numero mod 10;
      imprimirNumero(numero div 10);
      write(digito, ' ');
    end;
  end;

var
  numero:integer;
begin
  if(l <> nil)then begin
    numero:= l^.dato;
    imprimirNumero(numero);
    writeln(' ');
    writeln('--------------------------');
    imprimirLista(l^.sig);
  end;
end;
  
//PROGRAMA PRINCIPAL.
var
  l:lista;
BEGIN
  cargarLista(l); //cargo la lista con numeros leidos desde el teclado hasta que se ingresa el numero 0.
  imprimirLista(l);	
END.

