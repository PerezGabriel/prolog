
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

escucha(javi, elbordo).

juega(javi,Juego):-
	juega(fer, Juego).
juega(javi, Juego):-
	escucha(Alguien, sigRagga),
	juega(Alguien, Juego).



jueganALoMismo(Persona, OtraPersona):-
	juega(Persona, Juego),
	juega(OtraPersona, Juego),
	Persona \= OtraPersona.