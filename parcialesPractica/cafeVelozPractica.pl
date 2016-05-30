% jugadores conocidos
jugador(maradona).
jugador(chamot).
jugador(balbo).
jugador(caniggia).
jugador(passarella).
jugador(pedemonti).
jugador(basualdo).

% relaciona lo que toma cada jugador
tomo(maradona, sustancia(efedrina)).
tomo(maradona, compuesto(cafeVeloz)).
tomo(caniggia, producto(cocacola, 2)).
tomo(chamot, compuesto(cafeVeloz)).
tomo(balbo, producto(gatoreit, 2)).

% relaciona la máxima cantidad de un producto que 1 jugador puede ingerir
maximo(cocacola, 3).
maximo(gatoreit, 1).
maximo(naranju, 5).

% relaciona las sustancias que tiene un compuesto
composicion(cafeVeloz, [efedrina, ajipupa, extasis, whisky, cafe]).

% sustancias prohibidas por la asociación
sustanciaProhibida(efedrina). 
sustanciaProhibida(cocaina).


%% EJERCICIO 1
tomo(pasarella, Algo):-	not(tomo(maradona, Algo)).

tomo(pedemonti, Algo):-	tomo(maradona, Algo).
tomo(pedemonti, Algo):- tomo(chamot, Algo).

%% EJERCICIO 2
puedeSerSuspendido(Jugador):- 	
	tomo(Jugador, Algo),
	prohibido(Algo).


%% AUX
prohibido(Algo):-
	tiene(Algo,Sustancia),
	sustanciaProhibida(Sustancia).

prohibido(producto(Bebida, Cantidad)):-
	maximo(Bebida, CantMax),
	Cant > CantMax.

tiene(sustancia(Sustancia), Sustancia).

tiene(compuesto(Compuesto), Sustancia):-
	composicion(Compuesto, ListaSustancias),
	member(Sustancia, ListaSustancias).

%% EJERCICIO 3
amigo(maradona, caniggia).
amigo(caniggia, balbo).
amigo(balbo, chamot).
amigo(balbo, pedemonti).


malaInfluencia(Jugador1, Jugador2):-
	puedeSerSuspendido(Jugador1),
	puedeSerSuspendido(Jugador2),
	seConocen(Jugador1, Jugador2).


%% AUX
 amigo(Alguien, Amigo):-
	amigo(Amigo, Alguien),
	Amigo \= Alguien.

seConocen(ALguien, Jugador):-
	amigo(Alguien, Jugador).

seConocen(Alguien, Jugador):-
	amigo(Jugador, Amigo),
	seConocen(Alguien, Amigo).


%% EJERCICIO 4
atiende(cahe, maradona).
atiende(cahe, chamot).
atiende(cahe, balbo).
atiende(zin, caniggia).
atiende(cureta, pedemonti).
atiende(cureta, basualdo).

chanta(Medico):-
	medico(Medico),
	forall(atiende(Medico, Jugador), puedeSerSuspendido(Jugador)).

%% AUX
 medico(cache).
 medico(zin).
 medico(cureta).

%% EJERCICIO 5
nivelFalopez(efedrina, 10).
nivelFalopez(cocaina, 100).
nivelFalopez(extasis, 120).
nivelFalopez(omeprazol, 5).

cuantaFalopaTiene(Nivel, Jugador):-
	jugador(Jugador),
	findall(NivelIngerido, ingirio(Jugador,NivelIngerido), ListaNiveles),
	sum_list(ListaNiveles, Nivel).

%% AUX
ingirio(Jugador, NivelIngerido):-
	tomo(Jugador, Algo),
	tiene(Algo, Sustancia),
	nivelFalopez(Sustancia, NivelIngerido).

sum_list([],0).
sum_list([X|XS], Suma):-
	sum_list(XS, SumaAnt),
	Suma is X + SumaAnt.

%% EJERCICIO 6
medicoConProblemas(Medico):-
	medico(Medico),
	atiende(Medico, Jugador1),
	atiende(Medico, Jugador2),
	Jugador1 \= Jugador2,
	esConflictivo(Jugador1),
	esConflictivo(Jugador2).
	

esConflictivo(Jugador):-
	puedeSerSuspendido(Jugador).
esConflictivo(Jugador):-
	seConocen(maradona, Jugador).

%% EJERCICIO 7
programaTVFantinesco(Lista):-