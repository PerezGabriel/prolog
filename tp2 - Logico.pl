% EJERCICIO 1.
profesion(ted, arquitecto).
profesion(lily, maestra).
profesion(lily, consultoraDeArte).
profesion(marshall, abogado).
profesion(robin, periodista).

% EJERCICIO 2.
seRieCon(lily, marshall).
seRieCon(marshall, lily).
seRieCon(barney, ted).
seRieCon(tracy, ted).

tiene(ted, libro(pabloNeruda, confiesoQueHeVivido)).
tiene(ted, paraguas(amarillo)).
tiene(ted, instrumento(piano)).
tiene(barney, traje(armani, seda, negro)).
tiene(marshall, instrumento(piano)).
tiene(tracy, instrumento(bajo)).
tiene(tracy, paraguas(amarillo)).
tiene(tracy, libro(pabloNeruda, librito)).


laMadre(Alguien):-
	seRieCon(Alguien, ted),
	tiene(Alguien, paraguas(amarillo)),
	tiene(Alguien, instrumento(bajo)),
	tiene(Alguien, libro(pabloNeruda, _)).

% EJERCICIO 3.
elMejor(Alguien):-
    edad(Alguien, EdadMinima),
    forall(edad(_ , Edad), EdadMinima =< Edad).

% EJERCICIO 4.
esMalo(chiste(_, _, Reidores)):-
    length(Reidores, 0).

esMalo(cumpleanios(_, Invitados)):-
    member(barney, Invitados).

malDia(Alguien, Fecha):-
    findall(SucesoMalo, sucesoMaloEnFecha(Alguien, SucesoMalo, Fecha), SucesosMalos),
    length(SucesosMalos, Cantidad),
   	Cantidad >= 2. % not(between(0,1, Cantidad)).

sucesoMaloEnFecha(Alguien, SucesoMalo, Fecha):-
    evento(Alguien, SucesoMalo, Fecha),
    esMalo(SucesoMalo).







 /* MUMUKI KIERE ESTA
 esMalo(chiste(_, _, Reidores)):-
    length(Reidores, 0).

esMalo(cumpleanios(_, Invitados)):-
    member(barney, Invitados).

malDia(Alguien, Fecha):-
    tuvoMasDeUnSucesoMalo(Alguien, Fecha). % para que se entienda que hace.

tuvoMasDeUnSucesoMalo(Alguien, Fecha):-
    evento(Alguien, SucesoMalo1, Fecha),
    esMalo(SucesoMalo1),
    evento(Alguien, SucesoMalo2, Fecha),
    esMalo(SucesoMalo2),
    SucesoMalo1 \= SucesoMalo2.
  */

% EJERCICIO 5.

esLegendario(barney, _).

esLegendario(_, chiste(bueno, _, _)).

esLegendario(_, cumpleanios( _, Invitados)):-
    not(member(cabra, Invitados)).

fechaLegendaria(Fecha):-
    evento(_, _, Fecha),
    forall(evento(Persona, Suceso, Fecha), esLegendario(Persona, Suceso)). 

/* rebuscada
fechaLegendaria(Fecha):-
    evento(_, _, Fecha),
    findall(Legend, funcion(Fecha, Suceso, Legend), ListaLegend),
    member(noLegendario, listaLegend).

funcion(Fecha, Suceso, noLegendario):-
    evento(_, Suceso, Fecha),
    not(esLegendario(Suceso)).
*/