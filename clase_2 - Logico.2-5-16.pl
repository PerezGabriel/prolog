/* predicado is:
	El predicado is deja relacionar el resultado de una cuenta con un individuo.
	por ejemplo en la consola:
	> X is 1 + 2.
	> X = 3.

	está relacionando la variable X con el resultado de 1 + 2.
*/
anio(2016).
persona(homero, 1980).
persona(marge, 1982).
persona(bart, 2006).
persona(lisa, 2008).
persona(maggie, 2015).
persona(abe, 1950).
persona(hebert, 1981).

/* consultas de la base de conocimientos.

?- persona(homero, 1970).		individual
false.

?- persona(homero, 1980).		individual
true.

?- persona(Alguien, Anio).		existencial
Alguien = homero,
Anio = 1980 .

?- persona(Alguien, Anio).		existencial.
Alguien = homero,
Anio = 1980 ;
Alguien = marge,
Anio = 1982 ;
Alguien = bart,
Anio = 2006 ;
Alguien = lisa,
Anio = 2008 ;
Alguien = maggie,
Anio = 2015 ;
Alguien = abe,
Anio = 1950 ;
Alguien = hebert,
Anio = 1981.
*/
/* Ahora creando el predicado edad */

edad(Persona, Edad):-
	persona(Persona, AnioNac),
	anio(AnioActual),
	Edad is AnioActual - AnioNac.
/* aca juega un papel importante la "Unificacion", por ejemplo AnioActual, se liga cuandos se consulta
	anio(AnioActual), y Persona se liga cuando se consulta edad(Persona, Edad). */

/* INVERSIBILIDAD, es sobre algun parametro o ambos, quiere decir, que es inversible respecto a ese parametro, 
	si se pueden hacer consultas existenciales sobre el mismo. se dice completamente inversible si es inversible
	para todos sus parametros. Es uno de los temas centrales del paradigma Lógico.
	
	Por ejemplo, el siguiente predicado no es inversible ya que sus reglas no lo son.
*/
notaAprobada(Nota):-
	Nota >= 4,
	Nota =< 10.
/* pero la siguiente deifinicion si es de un predicado inversible. */

notaAprobada2(Nota):-
	between(4, 10 , Nota).

/* Escribiendo Hechos: */

persona(hugo, 2006).

padre(homero, bart).
padre(homero, lisa).
padre(homero, maggie).
padre(homero, hugo).
padre(abe, homero).
padre(abe, hebert).

/* La definicion de abuelo no es la mejor de la siguiente manera. */

abueloMal(abe, lisa).
abueloMal(abe, maggie).
abueloMal(abe, bart).

/* sería mejor escribirlo con algunas reglas basadas en los hechos declarados. */

abuelo(Abuelo, Nieto):-
	padre(Padre, Nieto),
	padre(Abuelo, Padre).

/* Consultando en la consola. consulta hasta que no encuentra mas y devuelve falso. pero el resultado
	de la consulta es Verdadero. 

?- abuelo(Abuelo, Nieto).
Abuelo = abe,
Nieto = bart ;
Abuelo = abe,
Nieto = lisa ;
Abuelo = abe,
Nieto = maggie ;
Abuelo = abe,
Nieto = hugo ;
false.
?-
*/

/* ahora queremos saber si fueron abandonados, lo que escribimos como hechos, porque no se deduce de nada
	que tengamos anteriormente.
*/

fueAbandonado(herbert).
fueAbandonado(hugo).

/*
Alguien tiene el pelo normal cuando NO tuvo hijos, para eso usamos el not.
el not, es un predicado que recibe otro predicado, lo cual muestra un ORDEN SUPERIOR
*/

tienePeloNormalMAL(Alguien):-
	not(padre(Alguien, _ )).


/* vemos un problema, que lo de adentro del not no está ligado, debería estar ligado porque si no tira basura
tira solamente lo que no está en el dominio como true.

la solucion piola es:
*/

padre(marge, maggie). /* lo ponemos para que no tenga el pelo normal*/


tienePeloNormal(Alguien):-
	persona(Alguien, _), /*predicado generador*/
	not(padre(Alguien, _ )).

/* En la consola:

?- tienePeloNormal(Alguien).
Alguien = bart ;
Alguien = lisa ;
Alguien = maggie ;
Alguien = hebert ;
Alguien = hugo.
*/

tienePeloMal(Alguien):- /* esta manera, tiene porblemas de inversibilidad */
	Alguien \= homero,
	Alguien \= abe.

tienePelo(Alguien):-
	persona(Alguien, _ ), /* de esta manera, ya es inversible, porque liga la variable Alguien, a las personas*/
	Alguien \= homero,
	Alguien \= abe.

/* en la consola:

?- tienePelo(Quien).
Quien = marge ;
Quien = bart ;
Quien = lisa ;
Quien = maggie ;
Quien = hebert ;
Quien = hugo.
*/
/* para la clase que viene hay que hacer el TP*/