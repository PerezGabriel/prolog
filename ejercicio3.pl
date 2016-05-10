/* 3.1 */
padre(homero, bart).
padre(homero, lisa).
padre(homero, maggie).
padre(homero, hugo).
padre(abraham, homero).
padre(abraham, hebert).

/* 3.2 */

hermano(Alguien, SuHermano):-
	padre(Padre, Alguien),
	padre(Padre, SuHermano),
	Alguien \= SuHermano.

tio(Tio, Sobrino):-
	padre(Padre, Sobrino),
	hermano(Padre, Tio).

/* 3.3 */

/* */
/* 3.4 */
edad(maggie, 1).
edad(bart, 10).
edad(lisa, 8).
edad(homero, 36).
edad(marge,34).

abuelo(Abu, Nieto):-
	padre(Abu, Papa),
	padre(Papa, Nieto).

baboso(Abu, Nieto):-
	abuelo(Abu, Nieto),
	edad(Nieto, Edad),
	Edad < 2.

/* 3.5 */
cuantaNaftaConsume(Longitud, Nafta):-
    Nafta is Longitud / 15.

/* 3.6 */


/* 3.10 */
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


% SOLUCION EN EL PIZARRON. BIEN CHETA
cotaMax(5).

todosSuperan(Competidor):-
	martilloSupera(Competidor),
	escobaSupera(Competidor),
	lanzamientoSupera(Competidor).

martilloSupera(Competidor):-
	puntajeFuerzaMartillo(Competidor, Puntaje),
	superaMax(Puntaje).

escobaSupera(Competidor):-
	puntajeEquilibrioEscoba(Competidor, Puntaje),
	superaMax(Puntaje).

lanzamientoSupera(Competidor):-
	puntajeLanzamientoPrecision(Competidor, Puntaje),
	superaMax(Puntaje).

puntajeTotal(Competidor, 0):-
	esParticipante(Competidor), %para ligarla, y volverla inversible.
	not(todosSuperan(Competidor)).

esParticipante(Competidor):-
	puntajeEquilibrioEscoba(Competidor, _). %para cualquiera de ellos o la condicion q sea participante.