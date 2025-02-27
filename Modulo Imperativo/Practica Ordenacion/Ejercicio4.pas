{
   4.- Una librería requiere el procesamiento de la información de sus productos. De cada producto se conoce el código del producto, código de rubro (del 1 al 8) y precio. 
Implementar un programa modularizado que:
a. Lea los datos de los productos y los almacene ordenados por código de producto y agrupados por rubro, en una estructura de datos adecuada. El ingreso de los productos finaliza cuando se lee el precio 0.
b. Una vez almacenados, muestre los códigos de los productos pertenecientes a cada rubro.
c. Genere un vector (de a lo sumo 30 elementos) con los productos del rubro 3. Considerar que puede haber más o menos de 30 productos del rubro 3. Si la cantidad de productos del rubro 3 es mayor a 30, almacenar los primeros 30 que están en la lista e ignore el resto. 
d. Ordene, por precio, los elementos del vector generado en b) utilizando alguno de los dos métodos vistos en la teoría. 
e. Muestre los precios del vector ordenado.

}


program Ejercicio4;
const
  dimF= 8;
  dimFR3= 30; //dimF del vector con productos del rubro 3.

//DECLARACION DE TIPOS
type
  rango_rubro= 1..dimF;
  rango= 1..dimFR3;
  
  product = record
    cod_product: integer;
    cod_rub: rango_rubro;
    precio: real;
  end;
  
  lista = ^nodo;
  
  nodo = record
    dato: product;
    sig: lista;
  end;
  
  v_rubros = array [rango_rubro]of lista;
  
  v_rubro3 = array [rango] of product;

//PROCESOS

//Proceso inicializarVectorRubros.
procedure inicializarVectorRubros(var v: v_rubros);
var
  i:integer;
begin
  for i:= 1 to dimF do 
    v[i]:= nil;
end;  


//Proceso cargarProductos.
procedure cargarProductos(var v:v_rubros);

    //Proceso leerProducto.
    procedure leerProducto(var p:product);
    begin
      writeln(' ');
      writeln('Ingrese el precio del producto: ');
      readln(p.precio);
      
      if(p.precio <> 0)then begin
        writeln('Ingrese el codigo del producto:  ');
        readln(p.cod_product);
        writeln('Ingrese el codigo del rubro: ');
        readln(p.cod_rub);
        writeln(' ');
        writeln('---------------------------------------');
      end;
    end;
    
    //Proceso insertarOrdenado.
    procedure insertarOrdenado(var l:lista; p:product);
    var
      aux,ant,act: lista;
    begin
      new(aux);
      aux^.dato:= p;
      aux^.sig:= nil;
      
      //Lista vacia o insertar a inicio.
      if(l = nil) or (aux^.dato.cod_product < l^.dato.cod_product)then begin
        aux^.sig:= l;
        l:= aux;
      end
      else begin
        ant:= nil;
        act:= l;
        
        //Avanzo hasta encontrar la posicion correcta.
        while(act <> nil)and(act^.dato.cod_product < aux^.dato.cod_product)do begin
          ant:= act;
          act:= act^.sig;
        end;
        
        //Insertar en la posicion encontrada.
        ant^.sig:= aux;
        aux^.sig:= act;
      end;
    end;

var
  p:product;
begin
  leerProducto(p);
  while(p.precio <> 0)do begin
    insertarOrdenado(v[p.cod_rub], p);
    leerProducto(p);
  end;
end;

//Proceso imprimirCodigosRubros.
procedure imprimirCodigosRubros(v:v_rubros);
    
    //Proceso imprimirLista.
    procedure imprimirLista(l:lista);
    begin
      while(l <> nil)do begin
        writeln('Codigo Producto: ', l^.dato.cod_product);
        writeln(' ');
        l:= l^.sig;
      end;
    end;

var
  i:integer;
begin
  writeln(' ');
  writeln('-------------------------------------');
  writeln('Codigos de Producttos  por Rubro:');
  writeln('-------------------------------------');
  for i:= 1 to dimF do begin
    if(v[i] <> nil)then begin
      writeln('Rubro ', i, ': ');
      imprimirLista(v[i]);
    end
    else writeln('Rubro ', i, ' sin productos. ');
    writeln('-------------------------------------');
  end;
end;


//Proceso generarVectorRubro.
procedure generarVectorRubro(var vr:v_rubro3; v:v_rubros; var dimL:integer);

    //Proceso cargarVector.
    procedure cargarVector(var vr:v_rubro3; l:lista; var dimL:integer);
    begin
      while(l <> nil)and(dimL < dimFR3)do begin
        dimL:= dimL + 1;
        vr[dimL]:= l^.dato;
        
        //Me muevo al siguiente elemento de la lista..
        l:= l^.sig;
      end;
    end;

begin
  dimL:= 0;
  
  if(v[3] = nil)then 
    writeln('El rubro 3 no tiene productos cargados.')
  else begin 
    cargarVector(vr,v[3],dimL);
    writeln('Vector Rubro 3 cargado con ', dimL, ' productos.');
  end;
end;


//Proceso ordenarvectorR3.
procedure ordenarVectorR3(var vr:v_rubro3; dimL:integer);
var
 i,j:integer;
 prod:product;
begin
  for i:= 2 to dimL do begin
    prod:=vr[i];
    j:= i - 1;
    
    while(j > 0)and(vr[j].precio > prod.precio)do begin
      vr[j + 1]:= vr[j];
      j:= j - 1;
    end;
    
    vr[j + 1]:= prod;
  end;
end;

//Proceso imprimirVector.
procedure imprimirVector(vr:v_rubro3; dimL:integer);
var
  i:integer;
begin
  writeln(' ');
  writeln('-------------------------------');
  writeln('PRECIOS PRODUCTOS');
  writeln('-------------------------------');
  for i:= 1 to dimL do begin
    writeln('Precio: ', vr[i].precio:0:2);
    writeln('-------------------------------');
    writeln(' ');
  end;
end;


//PROGRAMA PRINCIPAL
var
  vr:v_rubro3;
  v:v_rubros;
  dimL:integer;
BEGIN
  inicializarVectorRubros(v); //Inicializo los punteros de las listas de cada rubro en nil.
  cargarProductos(v); //Leo y cargo llos prooductos ingresados por teclado.
  imprimirCodigosRubros(v); //Imprimo los codigos de todos los productos de cada rubro.
  generarVectorRubro(vr, v, dimL); //Genero un vector con a lo sumo los primeros 30 productos del rubro 3.
  ordenarVectorR3(vr, dimL); //Ordeno el vector con los productos del rubro 3 por precio, a traves del metodo de Insercion.
  imprimirVector(vr,dimL); //Imprimo el vector Ordenado por precio de producto, de los productos del rubro 3.
END.

