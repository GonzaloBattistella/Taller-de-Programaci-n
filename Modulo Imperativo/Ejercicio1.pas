{1.- Implementar un programa que procese la información de las ventas de productos de un comercio (como máximo 20). 
De cada venta se conoce código del producto (entre 1 y 15) y cantidad vendida (como máximo 99 unidades).  El ingreso de las ventas finaliza con el código 0 (no se procesa).
a. Almacenar la información de las ventas en un vector. El código debe generarse automáticamente (random) y la cantidad se debe leer. 
b. Mostrar el contenido del vector resultante.
c. Ordenar el vector de ventas por código.
d. Mostrar el contenido del vector resultante.
e. Eliminar del vector ordenado las ventas con código de producto entre dos valores que se ingresan como parámetros. 
f. Mostrar el contenido del vector resultante.
g. Generar una lista ordenada por código de producto de menor a mayor a partir del vector resultante del inciso e., sólo para los códigos pares.
h. Mostrar la lista resultante.}



program ejercico1;
const 
  dimF = 20;
type
  cod_range = 0..15;
  cant_sell_range = 1..99;
  range = 0..dimF;
 
  venta = record 
    cod_product : cod_range;
    cant_sell_product : cant_sell_range;
  end;

  ventas = Array [1..dimF] of venta;
  
  lista = ^nodo;
  
  nodo = record
	dato: venta;
	sig: lista;
  end;

//Procesos.

//Proceso Cargar Ventas
procedure cargarVentas(var r:venta; var v:ventas; var dimL: range);

  procedure LeerVenta(var r:venta);
  begin
    r.cod_product := Random(16);
    if(r.cod_product <> 0) then begin
      writeln('codigo: ', r.cod_product);
      writeln('Ingrese la cantidad de unidades vendidas: ');
      readln(r.cant_sell_product);
    end;
  end;

begin
  Randomize;
  dimL := 0;

  LeerVenta(r);
  while (r.cod_product <> 0) and (dimL < dimF) do begin
    dimL := dimL + 1;
    v[dimL] := r;
    LeerVenta(r);
  end;
end;

//Proceso Ordenar Vector.
procedure ordenarVector(var v:ventas; dimL: range);
var
	i,j,pos: integer;
	item:venta;
begin
	for i:= 1 to dimL - 1 do begin
		pos := i;
		for j:= i + 1 to dimL do begin
			if(v[j].cod_product < v[pos].cod_product)then pos:= j;
		end;
		
		//Realizamos el intercambio.
		item:= v[pos];
		v[pos]:= v[i];
		v[i]:= item; 
	end;
end;

//Proceso Eliminar Ventas.
procedure eliminarVentasRango(var v:ventas; var dimL:range);
	
	//Función que retorna la posición del primer elemento con codigo igual o mayor al valor inferior ingresado.
	function buscarPosicion(v:ventas; dimL:range; elemABuscar:range):range;
	var
		pos:integer;
	begin
		pos:= 1;
		while(pos <= dimL)and(elemABuscar > v[pos].cod_product)do begin
			pos:= pos + 1;
		end;
		
		if(pos > dimL)then 
			buscarPosicion:= 0
		else 
			buscarPosicion:= pos - 1;
	end;
	
	//Funcion que retorna la posicion del elemento con codigo menor o igual al valor superior ingresado.
	function buscarPosicionDesde(v:ventas; dimL,elemABuscar,pos:range):range;
	begin
		while(pos <= dimL) and (elemABuscar >= v[pos].cod_product)do begin
			pos:= pos + 1;
		end;
		
		if(pos > dimL)then 
			buscarPosicionDesde:= dimL
		else 
			buscarPosicionDesde:= pos;
	end;	
var
  valorInf,valorSup:range;
  posInf,posSup,i,salto:range;
begin
	writeln('Ingrese el valor Inferior del rango: ');
	readln(valorInf);
	writeln('Ingrese el valor superior del rango: ');
	readln(valorSup);
	
	posInf:= buscarPosicion(v,dimL,valorInf);
	writeln('Posicion Inferior: ', posInf);
	if(posInf <> 0)then begin
		posSup:= buscarPosicionDesde(v,dimL,valorSup,posInf);
		writeln('Posicion Superior: ', posSup);
		writeln(' ');
		salto:= (posSup - posInf);
		
		//Hago los corrimientos.
		for i:= posSup + 1 to dimL do
			v[i - salto]:= v[i];
		dimL:= dimL - salto;
	end;
end;

//Proceso generar Lista.
procedure generarLista(v:ventas; dimL:range; var l:lista);
	
	//Funcion cumple. Retorna true en caso que el codigo del producto sea par, caso contrario retorna false;
	function cumple(cod:integer):boolean;
	begin
		cumple:= cod MOD 2 = 0;
	end;
	
	//Proceso agregar atras.
	procedure agregarAtras(var l:lista; r:venta);
	var
		aux,ult:lista;
	begin
		new(aux);
		aux^.dato:= r;
		aux^.sig:= nil;
		
		//Si la lista esa vacia
		if(l = nil)then begin
			l:= aux;
			ult:= l;
		end
		else begin
			ult^.sig:= aux;
			ult:= aux;
		end;
	end;

var
	i: range;
begin
	l:= nil;
	for i:= 1 to dimL do begin
		if(cumple(v[i].cod_product))then begin
			agregarAtras(l, v[i]);
		end;
	end;
end;

//Proceso Imprimir Lista.
procedure imprimirLista(l:lista);
begin
	writeln('----------------------------------');
	writeln('Lista Resultante');
	while(l <> nil)do begin  
		writeln('----------------------------------');
		writeln('codigo: ', l^.dato.cod_product);
		writeln('Unidades Vendidas: ', l^.dato.cant_sell_product);
		writeln('----------------------------------');
		l:= l^.sig;
	end;
end;


//Proceso Imprimir Vector.
procedure imprimirVector(v:ventas; dimL:range);
var
  i:integer;
begin
  writeln('--------------------------------');
  writeln('Vector de Ventas');
  writeln('--------------------------------');
  for i:= 1 to dimL do begin
    writeln('Codigo Producto: ', v[i].cod_product);
    writeln('Cantidad Vendida: ', v[i].cant_sell_product);
    writeln('--------------------------------');  
  end;
end;

//Programa Principal.
var
  r:venta;
  v:ventas;
  dimL:range;
  l: lista;
begin
  cargarVentas(r,v,dimL); //Cargo el vector con las ventas realizadas.
  imprimirVector(v, dimL); //Imprimir el vector.
  ordenarVector(v,dimL); //Ordeno el vector por codigo de producto.
  imprimirVector(v,dimL);
  eliminarVentasRango(v,dimL); //Elimino las ventas en el arreglo con codigo de producto entre dos valores ingresados por teclado.
  imprimirVector(v,dimL);
  generarLista(v,dimL,l); //Genero una lista ordenada de menor a mayor con las ventas, con codigos pares.
  imprimirLista(l); //Imprimo los elementos que se encuentran cargados en la lista.
end.
