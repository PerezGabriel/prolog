% 4.1
area(X, Y, Area):- Area is X * Y.

% 4.2
mitad(Numero, Mitad):-
    Mitad is Numero / 2.

% 4.3
esAlcoholica(Bebida):-
    esVino(Bebida).
esAlcoholica(Bebida):-
    esWhisky(Bebida).

% 4.4

/*
calcularPrecio(Cliente, Bebida, PVenta):-
	costo(Bebida, Costo),
	recargo(Cliente, Bebida, Porcentaje),
	PVenta is Costo * (1 + (Porcentaje / 100)).

recargo(Cliente, Bebida, Porcentaje):-
	esComerciante(Cliente),
	porcentajeSegunBebidaComerciante(Bebida, Porcentaje).

recargo(Cliente, Bebida, Porcentaje):-
	esParticular(Cliente),
	porcentajeSegunBebidaParticular(Bebida, Porcentaje).

porcentajeSegunBebidaComerciante(Bebida, Porcentaje):-
	esAgua(Bebida),
	Porcentaje is 25.
porcentajeSegunBebidaComerciante(Bebida, Porcentaje):-
	esGaseosa(Bebida),
	Porcentaje is 0.
porcentajeSegunBebidaComerciante(Bebida, Porcentaje):-
	esAlcoholica(Bebida),
	Porcentaje is 30.

porcentajeSegunBebidaParticular(Bebida, Porcentaje):-
	esAgua(Bebida),
	Porcentaje is 30.
porcentajeSegunBebidaParticular(Bebida, Porcentaje):-
	esGaseosa(Bebida),
	Porcentaje is 40.
porcentajeSegunBebidaParticular(Bebida, Porcentaje):-
	esAlcoholica(Bebida),
	esImportada(Bebida),
	Porcentaje is 70.
porcentajeSegunBebidaParticular(Bebida, Porcentaje):-
	esAlcoholica(Bebida),
	esNacional(Bebida),
	Porcentaje is 60.
*/

% 4.5
triple(Numero, SuTriple):-
    SuTriple is Numero * 3.

% 4.6
tipoDeAplicacion(Parametros, Pasados, Tipo):-
    Pasados = Parametros,
    Tipo = total.
tipoDeAplicacion(Parametros, Pasados, Tipo):-
    Cota is Parametros - 1,
    between(1, Cota,Pasados),
    Tipo = parcial.

tipoDeAplicacion(_, 0, sinAplicar).

% 4.7
puntajeLanzamientoPrecision(Competidor, Puntaje):-
	metrosLanzamiento(Competidor, Metros),
	puntosSegunMetrosLanzamiento(Metros, Puntaje).

puntosSegunMetrosLanzamiento(Metros, Puntaje):-
	between(9, 11, Metros),
	Puntaje is 10.
puntosSegunMetrosLanzamiento(Metros, Puntaje):-
	between(7, 8, Metros),
	Puntaje is 6.
puntosSegunMetrosLanzamiento(Metros, Puntaje):-
	between(12, 15, Metros),
	Puntaje is 6.
puntosSegunMetrosLanzamiento(Metros, Puntaje):-
	between(0, 6, Metros),
	Puntaje is 0.
puntosSegunMetrosLanzamiento(Metros, Puntaje):-
	Metros > 15, 
	Puntaje is 0.

% 4.8
puntajeFuerzaMartillo(Competidor, Puntaje):-
	metrosMartillo(Competidor, Metros),
	puntosSegunMetrosMartillo(Metros, Puntaje).

puntosSegunMetrosMartillo(Metros, Puntaje):-
	between(0, 4, Metros),
	Puntaje is 3.
puntosSegunMetrosMartillo(Metros, Puntaje):-
	between(5, 10, Metros),
	Puntaje is 6.
puntosSegunMetrosMartillo(Metros, Puntaje):-
	Metros > 10,
	PuntosExtra is (Metros - 10) * 2,
	Puntaje is 9 + PuntosExtra.

% 4.9
puntajeEquilibrioEscoba(Competidor, Puntaje):-
	metrosEscoba(Competidor, Metros),
	Puntaje is round(Metros / 3).

% 4.10
puntajeTotal(Competidor, PuntajeTotal):-
	todosPasanDe5(Competidor),
	sumatoriaTodosLosPuntajes(Competidor,PuntajeTotal).

puntajeTotal(Competidor, PuntajeTotal):-
	not(todosPasanDe5(Competidor)),
	PuntajeTotal is 0.

todosPasanDe5(Competidor):-
	puntajeFuerzaMartillo(Competidor, PuntajeMartillo),
	puntajeEquilibrioEscoba(Competidor, PuntajeEscoba),
	puntajeLanzamientoPrecision(Competidor, PuntajePresicion),
	PuntajeEscoba >= 5,
	PuntajeMartillo >= 5,
	PuntajePresicion >= 5.

sumatoriaTodosLosPuntajes(Competidor, PuntajeTotal):-
	puntajeFuerzaMartillo(Competidor, PuntajeMartillo),
	puntajeEquilibrioEscoba(Competidor, PuntajeEscoba),
	puntajeLanzamientoPrecision(Competidor, PuntajePresicion),
	PuntajeTotal is PuntajeMartillo + PuntajeEscoba + PuntajePresicion.

% 4.11
vive(mansion, agatha).
vive(mansion, carnicero).
vive(mansion, charles).

odia(charles, Odiado):-
	vive(mansion, Odiado),
	not(odia(agatha, Odiado)).

odia(agatha, Odiado):-
	vive(mansion, Odiado),
	Odiado \= carnicero.

odia(carnicero, Odiado):-
	odia(agatha, Odiado).

masRico(agatha, Quien):-
	vive(mansion, Quien),
	not(odia(carnicero, Quien)).

asesino(agatha, Asesino):-
    odia(Asesino, agatha),
    not(masRico(Victima, Asesino)),
    vive(mansion, Asesino).

% 4.12
alHorno(Equipo):-
	perteneceA(_, Equipo), % GENERADOR, TIENE AL MENOS 1
	participantesDebiles(Equipo).

alHorno(Equipo):-
	perteneceA(_, Equipo),% GENERADOR, TIENE AL MENOS 1
	participantesfueraDeJuego(Equipo).


participantesDebiles(Equipo):-
	forall(perteneceA(Participante, Equipo), estaDebil(Participante)).
estaDebil(Participante):-
	nivelDeEnergia(Participante, Nivel),
	between(0,9, Nivel).

participantesfueraDeJuego(Equipo):-
	forall(perteneceA(Participante, Equipo), fueraDeJuego(Participante)).

% 4.13
equipoCipayo(Equipo):-
	masDeUnParticipanteCipayo(Equipo).


masDeUnParticipanteCipayo(Equipo):-
	perteneceA(Participante, Equipo),
	perteneceA(OtroParticipante, Equipo),
	perteneceA(Participante, OtroEquipo),
	perteneceA(OtroParticipante, OtroEquipo),
	Equipo \= OtroEquipo,
	Participante \= OtroParticipante.