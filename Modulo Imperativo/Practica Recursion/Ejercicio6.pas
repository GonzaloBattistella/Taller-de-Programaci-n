{
  6.- Realizar un programa que lea números y que utilice un procedimiento recursivo 
  * que escriba el equivalente en binario de un número decimal. 
  * El programa termina cuando el usuario ingresa el número 0 (cero). 

  Ayuda:  Analizando las posibilidades encontramos que: Binario (N) es N si el valor es menor a 2. 
  * ¿Cómo obtenemos los dígitos que componen al número? 
  * ¿Cómo achicamos el número para la próxima llamada recursiva? 
  * Ejemplo: si se ingresa 23, el programa debe mostrar: 10111.

}

program Ejercicio6;

type
  lista =^nodo;
  
  nodo = record
    dato:integer;
    sig:lista;
  end;
  
//PROCESOS.

//CARGAR LISTA
procedure cargarListaNumeros(var l:lista);

  //LEER NUMERO.
  procedure leerNumero(var num:integer);
  begin
    writeln(' ');
    writeln('Ingrese un numero: ');
    read(num);
  end;
  
  
  //AGREGAR NUMERO.
  procedure agregarNumero(var l:lista; num:integer);
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
  leerNumero(num);
  while(num <> 0)do begin
    agregarNumero(l,num); //Agrego Adelante
    leerNumero(num);
  end;
end;


//IMPRIMIR LISTA.
procedure imprimirLista(l:lista);
begin
  writeln(' ');
  writeln('--------------------------------------------');
  writeln('LISTA DE NUMEROS');
  writeln('--------------------------------------------');
  while(l <> nil)do begin
    writeln('NUMERO: ', l^.dato);
    writeln('--------------------------------------------');
    l:= l^.sig;
  end;
end;


//DECIMAL A BINARIO.
procedure dec_a_bin(l:lista);

    //DECIMAL A BINARIO RECURSIVO.
    procedure dec_a_bin_recursivo(num: integer);
    begin
      if(num > 0)then begin
        dec_a_bin_recursivo(num div 2); //Hago la division entera.
        write(num mod 2); //Muestro en pantalla el resto de la division entera.
      end;
    end;

begin
  writeln('');
  writeln('--------------------------------------------');
  writeln('LISTA NUMEROS CONVERTIDOS');
  writeln('--------------------------------------------');
  while(l <> nil)do begin
    write('DECIMAL: ', l^.dato);
    if(l^.dato = 0)then
      writeln(0)
    else begin
      writeln(' ');
      dec_a_bin_recursivo(l^.dato);
    end;
    writeln(' ');
    writeln('--------------------------------------------');
    l:= l^.sig;
  end;
end;

//PROGRAMA PRINCIPAL.
var
  l:lista;
BEGIN
  cargarListaNumeros(l); //Cargo la lista con numero enteros hasta que se ingresa el valor 0.
  imprimirLista(l);
  dec_a_bin(l); //proceso recursivo en el cual se pasan los numeros decimales de una lista a binario y se muestran en pantalla.
END.

