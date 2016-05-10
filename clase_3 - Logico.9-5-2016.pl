%        ############# LISTAS #############
come(homero, [donas, langosta, chuleta]).
come(bart, [dulces]).
come(lisa, [ensalada]).
come(maggie, []).

% Alguien puede comer solo los platos que tenga asignados.
puedeComer(Alguien, Comida):-
	come(Alguien, Comidas),
	member(Comida, Comidas).


% Alguien es gloton si come más de 2 comidas o si come dulces.

esGloton(Alguien):- 
	come(Alguien, Comidas),
	length(Comidas, Longitud),
	Longitud >= 2.

esGloton(Alguien):-
	puedeComer(Alguien, dulces).

% Nivel de irratibilidad de una persona, es la sumatoria de la edad de sus hijos.
persona(homero, 1980).
persona(marge, 1982).
persona(bart, 2006).
persona(lisa, 2008).
persona(maggie, 2015).
persona(abe, 1950).
persona(hebert, 1981).
persona(hugo, 2006).

edad(Persona, Edad):-
	persona(Persona, AnioNac),
	anio(AnioActual),
	Edad is AnioActual - AnioNac.
anio(2016).

padre(homero, bart).
padre(homero, lisa).
padre(homero, maggie).
padre(homero, hugo).
padre(abe, homero).
padre(abe, hebert).

nivelDeIrritabilidad(Persona, Nivel):-
	todasLasEdadesDeLosHijos(Persona, EdadesHijos),
	sumarElementos(EdadesHijos, Nivel).


todasLasEdadesDeLosHijos(Persona, Edades):-
	padre(Persona, _),
	findall(Edad, edadDelHijo(Persona, Edad) , Edades).

edadDelHijo(Persona, Edad):- % este predicado, va a dar todos los resultados posibles.
	padre(Persona, Hijo),
	edad(Hijo, Edad).

todosLosHijos(Persona, Hijos):- %inversible para Persona
	padre(Persona, _),
	findall(Hijo, padre(Persona, Hijo), Hijos).

sumarElementos([], 0).

sumarElementos([N|Ns], Total):-
	sumarElementos(Ns, Subtotal),
	Total is N + Subtotal.

%     ################  FUNCTORES  ################

medioDeTransporte(auto).
medioDeTransporte(bondi).
medioDeTransporte(tren).
medioDeTransporte(avion).

% Para agregar mas informacion, meto los FUNCTORES.
% En este caso agregamos, Cantidad de personas que lleva y ruedas.
transporte(auto(5, 4)).
transporte(bondi(20, 6)).
transporte(tren([locomotora, vagon(40, 8), vagon(40, 8), vagon(20, 8)])).
% transporte(avion(80, 3)).

% Un Transporte dania la capa de ozono cuando tiene mas de 4 ruedas.
daniaCapaDeOzono(Transporte):-
	transporte(Transporte),
	cantidadDeRuedas(Transporte, CantRuedas),
	cantRuedas > 4.

cantidadDeRuedas(auto( _, CantRuedas), CantRuedas).
cantidadDeRuedas(bondi( _, CantRuedas), CantRuedas).
cantidadDeRuedas(vagon( _, CantRuedas), CantRuedas).

cantidadDeRuedas(tren(Vagones), CantRuedas):-
	findall(Rueda, ruedasVagones(Vagones, Rueda), RuedasTotales),
	sumarElementos(RuedasTotales, CantRuedas).

ruedasVagones(Vagones, Ruedas):-
	member(Vagon, Vagones),
	cantidadDeRuedas(Vagon, Ruedas).