/* Ejercicio 1 */
escucha(nahue, losPiojos).
escucha(nahue, zonaGanjah).
escucha(nahue, sigRagga).
escucha(fer, manuChao).
escucha(tato, sigRagga).

juega(fer, futbol).
juega(nico, basquet).
juega(tato, futbol).
juega(tato, hearthstone).

escucha(javi, elBordo).

juega(javi,Juego):-
	juega(fer, Juego).
juega(javi, Juego):-
	escucha(Alguien, sigRagga),
	juega(Alguien, Juego).

/* Ejercicio 2 */
hincha(fer, boca).
hincha(nico, river).
hincha(tato, newells).
rivales(boca, river).
rivales(sanLorenzo, huracan).

enemigos(Persona, OtraPersona):-
	hinchanPorRivales(Persona, OtraPersona),
	sinGustosComunes(Persona, OtraPersona).

rivalidad(Equipo, OtroEquipo):-
	rivales(Equipo, OtroEquipo).
rivalidad(Equipo,OtroEquipo):-
	rivales(OtroEquipo,Equipo).

gustoEnComun(Persona, OtraPersona):-
	escuchanLoMismo(Persona, OtraPersona).
gustoEnComun(Persona, OtraPersona):-
	jueganALoMismo(Persona, OtraPersona).

hinchanPorRivales(Persona, OtraPersona):-
	hincha(Persona, Equipo),
	hincha(OtraPersona, OtroEquipo),
	rivalidad(Equipo, OtroEquipo).

hinchanPorElMismo(Persona, OtraPersona):-
	hincha(Persona, Equipo),
	hincha(OtraPersona, Equipo),
	Persona \= OtraPersona.
escuchanLoMismo(Persona, OtraPersona):-
	escucha(Persona, Banda),
	escucha(OtraPersona, Banda),
	Persona \= OtraPersona.
jueganALoMismo(Persona, OtraPersona):-
	juega(Persona, Juego),
	juega(OtraPersona, Juego),
	Persona \= OtraPersona.
sinGustosComunes(Persona, OtraPersona):-
	not(gustoEnComun(Persona, OtraPersona)).

/* Ejercicio 3 */
toca(zonaGanjah, lunaPark).
toca(elBordo, lunaPark).
toca(viejasLocas, fortin).

partido(futbol, boca, river, bombonera).
partido(basquet, velez, river, fortin).
partido(futbol, racing, newells, cilindro).
partido(futbol, river, boca, monumental).

fanatico(fer).
fanatico(nico).

asiste(Persona, Lugar):-
	toca(Banda, Lugar),
	escucha(Persona, Banda),
	not(escuchaMasDeUnaBanda(Persona)).
	
asiste(Persona, Lugar):-
	juega(Persona, Deporte),
	partido(Deporte, EquipoLocal, _, Lugar),
	hincha(Persona, EquipoLocal).

asiste(Persona, Lugar):-
	fanatico(Persona),
	juega(Persona, Deporte),
	partido(Deporte, _ , EquipoVisitante, Lugar),
	hincha(Persona, EquipoVisitante).

escuchaMasDeUnaBanda(Persona):-
	escucha(Persona, Banda),
	escucha(Persona, OtraBanda),
	Banda \= OtraBanda.

hinchaDeAlguno(Persona, Equipo, _):-
	hincha(Persona, Equipo).
hinchaDeAlguno(Persona, _, OtroEquipo):-
	hincha(Persona, OtroEquipo).

/* Ejercicio 4 */
vende(topshow, lunaPark, 8).
vende(ticketek, bombonera, 10).
vende(ticketek, fortin, 10).
vende(bombonera, bombonera, 0).

capacidad(lunaPark, 10000).
capacidad(bombonera, 50000).
capacidad(fortin, 49000).
capacidad(monumental, 65000).

compradorPretencioso(fer).

pretenciones(fer, Vendedor, Lugar):-
	capacidad(Lugar, Capacity),
	Capacity =< 50000,
	vende(Vendedor, Lugar, _), % inversible para Vendedor
	Vendedor \= ticketek.

compra(Persona, Vendedor, PrecioFinal):-
	precioFinal(Vendedor, Lugar, PrecioFinal),
	pretenciones(Persona, Vendedor, Lugar).

compra(Persona, Vendedor, PrecioFinal):-
	asiste(Persona, Lugar),
	precioFinal(Vendedor, Lugar, PrecioFinal),
	not(compradorPretencioso(Persona)).

precioBase(Lugar, Base):-
	capacidad(Lugar, Capacity),
	Base is Capacity / 100.

precioFinal(Vendedor, Lugar, PrecioFinal):-
	precioBase(Lugar, Base),
	vende(Vendedor, Lugar, ComisionVendedor),
	porcentaje(Base, ComisionVendedor, Resultado),
	PrecioFinal is Base +  Resultado.

porcentaje(Base, Porcentaje, Resultado):-
	Resultado is Base * Porcentaje / 100.
