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
    cod_genre: range_genre;
    puntaje_prom: real;
  end;
  
  lista_movies = ^nodo;
  
  nodo = record
    dato: pelicula;
    sig: lista_movies;
  end;   
  
  vector_genre = array[range_genre]of lista_movies;


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
procedure cargarPeliculas(var v:vector_genre);

  //Proceso leerPeli
  procedure leerPeli(var p:pelicula);
  begin
    
  end;

var
  p:pelicula;
begin
  leerPeli(p);
  while(p.cod_peli <> -1)do begin
    agregarPelicula(v[p.cod_genre], p);
    leerPeli(p);
  end;
end;
  
//Programa Principal.  
var
  v: vector_genre;
BEGIN
  inicializarVectorListas(v); //Inicializo las listas en cada posicion del vector.
  cargarPeliculas(v); //Cargo las peliculas y las agrego a la lista correspondiente dentro del vector.
  imprimirVectorPeliculas(v); //Imprimo todas las peliculas del vector, que se encuetran agrupadas en una lista, y a su vez por genero dentro del vector.
END.

