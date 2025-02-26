{
   3.- Netflix ha publicado la lista de películas que estarán disponibles durante el mes de diciembre de 2022. De cada película se conoce: código de película, código de género (1: acción, 2: aventura, 3: drama, 4: suspenso, 5: comedia, 6: bélica, 7: documental y 8: terror) y puntaje promedio otorgado por las críticas. 
Implementar un programa modularizado que:
a. Lea los datos de películas y los almacene por orden de llegada y agrupados por código de género, en una estructura de datos adecuada. La lectura finaliza cuando se lee el código de la película -1. 
b. Una vez almacenada la información, genere un vector que guarde, para cada género, el código de película con mayor puntaje obtenido entre todas las críticas.
c. Ordene los elementos del vector generado en b) por puntaje utilizando alguno de los dos métodos vistos en la teoría. 
d. Luego de ordenar el vector, muestre el código de película con mayor puntaje y el código de película con menor puntaje.

   
}

program Ejercicio3;
const 
  dimF= 8;
type
  range_genre = 1..dimF;
  
  pelicula = record
    cod_peli: integer;
    cod_genre: integer;
    puntaje_prom: real;
  end;
  
  lista_movies = ^nodo;
  
  nodo = record
    dato: pelicula;
    sig: lista_movies;
  end;   
  
  vector_genre = array[range_genre]of lista_movies;
  
  vector_maximos = array[range_genre]of pelicula;
  
  vector_ult = array[range_genre] of lista_movies;


//Procesos.

//Proceso inicializarVectorListas.
procedure inicializarVectorListas(var v:vector_genre);
var
  i:integer;
begin
  for i:= 1 to dimF do 
    v[i]:= nil;
end;

//Proceso cargarPeliculas.
procedure cargarPeliculas(var v:vector_genre; var vu:vector_ult);

  //Proceso leerPeli
  procedure leerPeli(var p:pelicula);
  begin
    writeln('Ingrese el codigo de la pelicula: ');
    readln(p.cod_peli);
    if(p.cod_peli <> -1)then begin
      writeln('Ingrese el codigo de Genero de la pelicula: ');
      readln(p.cod_genre);
      writeln('Ingrese el puntaje Promedio de la pelicula: ');
      readln(p.puntaje_prom);
      writeln(' ');
      writeln('-----------------------------------');
      writeln(' ');
    end;
  end;
  
  
  //Proceso agregarPelicula. Agrego en Orden de llegada, es decir el algoritmo es un agregar atras.
  procedure agregarPelicula(var l,ult:lista_movies; p:pelicula);
  var
    aux:lista_movies;
  begin
    new(aux);
    aux^.dato:= p;
    aux^.sig:= nil;
    
    if(l = nil)then 
      l:= aux
    else 
      ult^.sig:= aux;
    ult:= aux;
  end;
  
  
  //Proceso inicializarVectorUltimos.
  procedure inicializarVectorUltimos(var vu:vector_ult);
  var
    i:integer;
  begin
    for i:= 1 to dimF do
      vu[i]:= nil;
  end;

var
  p:pelicula;
begin
  inicializarVectorUltimos(vu); //Inicializo los punteros que van a apuntar al ultimo elemento de cada lista de cada genero.
  leerPeli(p);
  while(p.cod_peli <> -1)do begin
    agregarPelicula(v[p.cod_genre], vu[p.cod_genre], p); //vu[p.cod_genre]: esto es el puntero "ult", que va a apuntar al ultimo elemento de cada lista de cada genero.
    leerPeli(p);
  end;
end;


//Proceso imprimirVectorPeliculas.
procedure imprimirVectorPeliculas(v:vector_genre);


  //Proceso imprimirLista.
  procedure imprimirLista(l:lista_movies);
  begin
    while (l <> nil)do begin
      writeln('   Codigo de Pelicula: ', l^.dato.cod_peli);
      writeln('   Codigo de Genero: ', l^.dato.cod_genre);
      writeln('   Puntaje Promedio: ', l^.dato.puntaje_prom:2:2);
      writeln('-----------------------------------');
      
      l:= l^.sig;
    end;
  end;

var
  i:integer;
begin 
  writeln(' ');
    writeln('-----------------------------------');
    writeln('Vector de Peliculas.');
    writeln('-----------------------------------');
  for i:= 1 to dimF do begin
    writeln(' ');
    writeln('Peliculas de Genero: ', i);
    imprimirLista(v[i]);
    writeln(' ');
  end;
end;


//Proceso generarVectorMaximos.
procedure generarVectorMaximos(v:vector_genre; var vm:vector_maximos);

  
  //Proceso inicializarVectorMaximos.
  procedure inicializarVectorMaximos(var vm:vector_maximos);
      
      //proceso ini_pelicula.
      procedure ini_pelicula(var p: pelicula);
      begin
        p.cod_peli:= 0;
        p.cod_genre:= 0;
        p.puntaje_prom:= 0;
      end;
      
      
  var
    i:integer;
  begin
    for i:= 1  to dimF do
      ini_pelicula(vm[i]); //Inicializo el registro de tipo pelicula con los campos en cero, para cada posicion del vector.
      //Con esto evito el problema a la hora de que para algun genero no hay peliculas.
  end;
  
  
  //Funcion maxPeli.
  function maxPeli(l:lista_movies): pelicula;
  var
    max:real;
    max_p:pelicula;
  begin 
    max:= -1;
    
    while(l <> nil) do begin
      if(l^.dato.puntaje_prom > max)then begin
        max:= l^.dato.puntaje_prom;
        max_p:= l^.dato;
      end;
      
      l:= l^.sig; //Me muevo al siguiente elemento de la lista.
    end;
    
    maxPeli:= max_p;
  end;


var
  i:integer;
begin
  inicializarVectorMaximos(vm); //Tengo que inicializar todos los campos del vector, para cubrir el caso en que un genero no tenga peliculas.
  for i:= 1 to dimF do begin
    if(v[i] <> nil)then
      vm[i]:= maxPeli(v[i]);
  end;
end;


//Proceso ordenarVectorMaximos a traves del metodo de SELECCION.
procedure ordenarVectorMaximos(var vm: vector_maximos; var dimL: integer);
var
  vAux:vector_maximos;
  i,j,pos: integer;
  peli: pelicula;
begin
  dimL:= 0;
  
  //filtrar los valores validos.
  for i:= 1 to dimF do begin
    if(vm[i].puntaje_prom <> 0)then begin
      dimL:= dimL + 1;
      vAux[dimL]:= vm[i];
    end;
  end;
  
  //oredenar el vector Auxiliar.
  for i:= 1 to dimL - 1 do begin
    pos:= i;
    for j:= i + 1 to dimL do begin
      if(vAux[j].puntaje_prom < vAux[pos].puntaje_prom)then pos:= j;
    end;
    
    //Realizamos el intercambio.
    peli:= vAux[pos];
    vAux[pos]:= vAux[i];
    vAux[i]:= peli;
  end;
  
  //Copiar el vector ordenado de vueltta al original.
  for i:= 1 to dimL do
    vm[i]:= vAux[i];
end;


//Proceso imprimirVectorMaximos.
procedure imprimirVectorMaximos(vm:vector_maximos; dimL:integer);
var
  i:integer;
begin
  writeln(' ');
  writeln('-------------------------------------');
  writeln('Vector de Maximos');
  writeln('-------------------------------------');
  for i:= 1 to dimL do begin
    writeln('Genero ', vm[i].cod_genre, ' : ', vm[i].puntaje_prom:2:2);
    writeln(' ');
    writeln('-------------------------------------');
  end;
end;


//Proceso imprimirMaxYMin.
procedure imprimirMaxYMin(vm:vector_maximos; dimL:integer);
begin
  writeln(' ');
  writeln('El codigo de la pelicula con menor puntaje es: ', vm[1].cod_peli, ' con el puntaje: ', vm[1].puntaje_prom:2:2);
  writeln(' ');
  writeln('El codigo de la pelicula con mayor puntaje es: ', vm[dimL].cod_peli, ' con el puntaje: ', vm[dimL].puntaje_prom:2:2);
  writeln(' ');
end;

  
//Programa Principal.  
var
  v: vector_genre;
  vm: vector_maximos;
  vu: vector_ult;
  dimL:integer;
BEGIN
  inicializarVectorListas(v); //Inicializo las listas en cada posicion del vector.
  cargarPeliculas(v, vu); //Cargo las peliculas y las agrego a la lista correspondiente dentro del vector.
  imprimirVectorPeliculas(v); //Imprimo todas las peliculas del vector, que se encuetran agrupadas en una lista, y a su vez por genero dentro del vector.
  generarVectorMaximos(v,vm); //Genero un vector donde para cada genero me guardo la pelicula con mayor puntaje promedio.
  ordenarVectorMaximos(vm, dimL); //Ordeno el vector con los puntajes promedio, de manor a mayor.
  imprimirVectorMaximos(vm, dimL); //A la hora de imprimir, si algun genero no tiene peliculas cargadas, el numero de genero va a ser 0.
  imprimirMaxYMin(vm, dimL); //Muestro en pantalla el codigo de la pelicula con mayor y menor puntaje promedio.
END.

