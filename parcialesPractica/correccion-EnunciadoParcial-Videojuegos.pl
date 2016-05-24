%% juego(juego, plataforma soportada)
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

%% portatil(plataforma)
portatil(psp).
portatil(gameboy).
portatil(gameboyColor).

%% usuarios(juego, plataforma, cantidad).
usuarios(minecraft,playstation(2), 40000).
usuarios(minecraft, playstation(3), 36700).
usuarios(saga(finalFantasy, 1), gameboy, 400).
usuarios(saga(finalFantasy, 2), gameboy, 220).
usuarios(superMario, xbox, 980).
usuarios(saga(finalFantasy, 3), gameboy, 70).
usuarios(saga(finalFantasy, 3), gameboyColor, 100).

%% empresa(empresa, plataforma que vende)
empresa(sony, playstation(_)).
empresa(nintendo, xbox).
empresa(nintendo, xcube).
empresa(nintendo, gameboy).
empresa(lenovo, pc([windows,linux])).
empresa(microsoft, pc([windows])).
empresa(apple, pc([mac])).

%% Ej. 1
/*
	VEO 2 CASOS, ENTONCES TENGO UN OR, QUE LO SEPARO DONDE YA NO PUEDA SEGUIR, QUE ES EN LA EMPRESA.
*/
tienePlataformaQueSoporta(Empresa, Juego):-
	juego(Juego, Plataforma),
	vendePlataforma(Empresa, Plataforma). % EL OR LO DIVIDO EN ESTE PREDICADO

vendePlataforma(Empresa, Consola):-
	Consola \= pc(_),
	empresa(Empresa, Consola).

vendePlataforma(Empresa, pc(SosSoportados)):-
	empresa(Empresa, pc(SosOfrecidos)),
	member(So,SosSoportados),
	member(So,SosOfrecidos).

%% Ej. 2

/*
propietario(Empresa, Juego):- % primera aproximacion.
	tienePlataformaQueSoporta(Empresa, Juego),
	findall(OtraEmpresa, tienePlataformaQueSoporta(OtraEmpresa, Juego), Empresas),
	not(hayOtro(Empresa, Empresas)).

hayOtro(Elemento, Lista):-
	member(OtroElemento, Lista),
	Elemento \= OtroElemento.
*/
propietario(Empresa, Juego):-
	tienePlataformaQueSoporta(Empresa, Juego),
	not(otraEmpresaQueSoporta(Empresa, Juego)).

otraEmpresaQueSoporta(Empresa, Juego):-
	tienePlataformaQueSoporta(OtraEmpresa, Juego),
	Empresa \= OtraEmpresa.

 %% Ej. 3
prefierenPortatiles(Juego):-
	estaParaNoPortatil(Juego),
	seJuegaSoloEnPortatil(Juego).

seJuegaSoloEnPortatil(Juego):-
	forall(usuarios(Juego, ConsolaJugada, _), portatil(ConsolaJugada)).

estaParaNoPortatil(Juego):-
	juego(Juego, Consola),
	not(portatil(Consola)).

 %% Ej. 4
nivelFanatismo(Juego, Nivel):-
	usuariosTotales(Juego, Cantidad),
	Nivel is Cantidad /10000.

usuariosTotales(Juego, CantTotal):-
	usuarios(Juego, _, _),
	findall(CantUsrs, usuarios(Juego, _, CantUsrs), Cantidades),
	sumList(Cantidades, CantTotal).

%% Ej. 5
esPirateable(Juego):-
	correSobrePlataformaHackeable(Juego),
	tieneMasDe5MilUsrs(Juego).

correSobrePlataformaHackeable(Juego):-
	juego(Juego, Plataforma),
	esHackeable(Plataforma).

esHackeable(pc(_)).
esHackeable(psp).
esHackeable(playstation(Version)):-
	Version < 3.

tieneMasDe5MilUsrs(Juego):-
	usuariosTotales(Juego, CantTotal),
	CantTotal > 5000.

%% Ej. 6
%% a
ultimoDeLaSaga(Titulo, saga(Titulo, Version)):- 
	juego(saga(Titulo, Version), _),
	esLaUltima(Titulo, Version).

esLaUltima(Titulo, Version):-
	forall(juego(saga(Titulo, OtraVersion),_), Version >= OtraVersion).
/*
%% por el negativo
%% esLaUltima(Titulo, Version):-
%% 	juego(saga(Titulo, OtraVersion),_),
%% 	not(OtraVersion > Version).

%% b
*/
buenaSaga(Titulo):-
	ultimoDeLaSaga(Titulo, UltimoDeLaSaga),
	usuariosTotales(UltimoDeLaSaga, Cantidad),
	mantieneLaMitadDeUsrs(UltimoDeLaSaga, Cantidad).
	
mantieneLaMitadDeUsrs(saga(_, 1),_).
mantieneLaMitadDeUsrs(saga(Titulo, Version), Cantidad):-
	VerAnterior is Version -1,
	usuariosTotales(saga(Titulo, VerAnterior), CantidadAnterior),
	mantuvoMitad(CantidadAnterior, Cantidad),
	mantieneLaMitadDeUsrs(saga(Titulo, VerAnterior), CantidadAnterior).

mantuvoMitad(CantidadAnterior, Cantidad):-
	Mitad is CantidadAnterior / 2,
	Cantidad >= Mitad.
