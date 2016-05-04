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