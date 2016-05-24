% juego(juego, plataforma soportada)
juego(minecraft, pc([windows,linux,mac])).
juego(minecraft, playstation(2)).
juego(minecraft, playstation(3)).
juego(superMario, xbox).
juego(superMario, xcube).
juego(saga(finalFantasy, 1), gameboy).
juego(saga(finalFantasy, 2), gameboy).
juego(saga(finalFantasy, 3), gameboy).
juego(saga(finalFantasy, 3), gameboyColor).
juego(saga(finalFantasy, 3), xbox).

% portatil(plataforma)
portatil(psp).
portatil(gameboy).
portatil(gameboyColor).

%usuarios(juego, plataforma, cantidad).
usuarios(minecraft,playstation(2), 40000).
usuarios(minecraft, playstation(3), 36700).
usuarios(saga(finalFantasy, 1), gameboy, 400).
usuarios(saga(finalFantasy, 2), gameboy, 220).
usuarios(superMario, xbox, 980).
usuarios(saga(finalFantasy, 3), gameboy, 70).
usuarios(saga(finalFantasy, 3), gameboyColor, 100).

% empresa(empresa, plataforma que vende)
empresa(sony, playstation(_)).
empresa(nintendo, xbox).
empresa(nintendo, xcube).
empresa(nintendo, gameboy).
empresa(lenovo, pc([windows,linux])).
empresa(microsoft, pc([windows])).
empresa(apple, pc([mac])).

% Ej. 1
tienePlataformaQueSoporta(Empresa, Juego):-
	empresa(Empresa, Consola),
	juego(Juego, Consola),
	not(esPc(Consola)).

tienePlataformaQueSoporta(Empresa, Juego):-
	%vendePc(Empresa),
	empresa(Empresa, pc(_))
	compartenSistemas(Empresa, Juego).

			% AUX
esPc(pc(_)).

vendePc(Empresa):-
	empresa(Empresa, pc(_)).

compartenSistemas(Empresa, Juego):-
	empresa(Empresa, pc(SistemasOfrecidos)),
	juego(Juego, pc(SistemasSoportados)),
	tienenAlmenosUnoIgual(SistemasSoportados, SistemasOfrecidos).

tienenAlmenosUnoIgual([Cabeza| _], Lista2):-
          member(Cabeza, Lista2).
tienenAlmenosUnoIgual([_|Cola], Lista2):-
          tienenAlmenosUnoIgual(Cola, Lista2).

% Ej. 2
propietario(Empresa, Juego):-
	empresa(Empresa, _),
	juego(Juego, _),
	forall(juego(Juego, Consola), empresaDuenia(Empresa, Consola)).

empresaDuenia(Empresa, Consola):-
	empresa(Empresa, Consola),
	not(esPc(Consola)).

% ACA AVERIGUAR COMO SERIA PARA LOS JUEGOS DE PC.

% Ej. 3
prefierenPortatiles(Juego):-
	usuarios(Juego, _, _),
	forall(usuarios(Juego, PlataformaJugada, _), portatil(PlataformaJugada)),
	juego(Juego, OtraPlataforma),
	not(portatil(OtraPlataforma)).
	

% Ej. 4
nivelFanatismo(Juego, Nivel):-
	juego(Juego,_),
	findall(Cantidad, usuarios(Juego, _, Cantidad), Cantidades),
	sumLista(Cantidades, Nivel).


			% AUX 	
sumLista([], 0).
sumLista([A|As], Suma):-
	sumLista(As, Suma1),
	Suma is A + Suma1.

% Ej. 5
esPirateable(Juego):-
	juego(Juego, Plataforma),
	tieneMasDe5MilUsrs(Juego),
	esHackeable(Plataforma).
	
			% AUX 
usuariosTotales(Juego, CantTotal):-
	juego(Juego,_),
	findall(Usrs, usuarios(Juego, _, Usrs), Usuarios),
	sumLista(Usuarios, CantTotal).

esHackeable(pc(_)).
esHackeable(psp).
esHackeable(playstation(Version)):-
	Version < 3.

tieneMasDe5MilUsrs(Juego):-
	usuariosTotales(Juego, CantTotal),
	CantTotal > 5000.

% Ej. 6
% a
ultimoDeLaSaga(Titulo, saga(Titulo, Nro)):- 
	juego(saga(Titulo, Nro), _),
	forall(juego(saga(Titulo, OtroNro),_), Nro >= OtroNro).
% b
buenaSaga(Titulo):-
	juego(saga(Titulo, _), _),
	forall(juegoEnSaga(Titulo, Juego), buenJuegoEnSaga(Juego)).


			% AUX 	
juegoEnSaga(Titulo, juego(saga(Titulo, _),_)).


buenJuegoEnSaga(juego(saga(_, 1), _)).
buenJuegoEnSaga(Juego):-
	juegoAnterior(Juego, JuegoAnterior),
	mantieneLaMitadDeUsrs(Juego, JuegoAnterior).

mantieneLaMitadDeUsrs(Juego, JuegoAnterior):-
	usuariosTotales(Juego, Cantidad),
	usuariosTotales(JuegoAnterior, OtraCantidad),
	Mitad is OtraCantidad / 2,
	Cantidad >= Mitad.

juegoAnterior(juego(saga(Titulo,Nro), _), juego(saga(Titulo, NroAnterior),_)):-
	NroAnterior is Nro - 1.

