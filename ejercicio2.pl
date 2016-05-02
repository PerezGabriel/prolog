/* 2.1 */
honesto(roque).
joven(roque).
contador(roque).
ingeniero(ana).
honesto(ana).
abogado(cecilia).

/* 2.2 */
puedeAndar(contaduria, Candidato):-
    contador(Candidato),
    honesto(Candidato).
    
puedeAndar(ventas, Candidato):-
    ambicioso(Candidato),
    tieneExperiencia(Candidato).

puedeAndar(ventas, lucia).

tieneExperiencia(Empleado):-
    trabajoEn(Empleado, _).

/* 2.3 */
puedeAndar(proyectos, fulgencio).
puedeAndar(ventas, clotilde).

puedeAndar(proyectos, Alguien):-
    ingeniero(Alguien),
    conExperiencia(Alguien).
puedeAndar(proyectos, Alguien):-
    abogado(Alguien),
    joven(Alguien).

puedeAndar(logistica, Alguien):-
    profesional(Alguien),
    joven(Alguien).
puedeAndar(logistica, Alguien):-
    profesional(Alguien),
    conExperiencia(Alguien).

profesional(Alguien):-
    ingeniero(Alguien).
profesional(Alguien):-
    abogado(Alguien).

/* 2.4 */
trabajaEn(Sector, Alguien):-
    empleado(Sector,Alguien,cadete).
trabajaEn(Sector, Alguien):-
    empleado(Sector,Alguien,gerente).
    
empleado(administracion, ana, cadete).
empleado(administracion, hugo, cadete).
empleado(administracion, felipe, gerente).
empleado(ventas, maria, gerente).
empleado(ventas, juan, cadete).
empleado(ventas, roque, cadete).
empleado(compras, nora, gerente).
empleado(compras, pedro, cadete). 

/* 2.5 */
trabajaCon(Alguien, Otro):-
    trabajaEn(Sector, Alguien),
    trabajaEn(Sector, Otro),
    noEsElMismo(Alguien, Otro).
    
noEsElMismo(Alguien, Otro):-
    Alguien \= Otro.

/* 2.6 */
daOrdenes(Emisor, Receptor):-
	empleado(Sector, Emisor, gerente),
	empleado(Sector,Receptor, cadete).
/*
tieneCargoSuperior(Superior, Inferior):-
	esGerente(Superior),
	esCadete(Inferior).

esGerente(Alguien):-	empleado(Sector, Nombre, gerente).
esCadete(Alguien):-		empleado(Sector, Nombre, cadete).
*/

/* 2.7 */
grupo(colombia, a).
grupo(camerun, a).
grupo(jamaica, a).
grupo(italia, a).
grupo(argentina, b).
grupo(nigeria, b).
grupo(japon, b).
grupo(escocia, b).

rival(UnPais, OtroPais):-
	grupo(UnPais, Grupo),
	grupo(OtroPais, Grupo),
	noEsElMismo(UnPais, OtroPais).

/* 2.8 */
melancolico(maria).
soniador(maria).
sereno(juan).
reflexivo(jose).
decidido(sara).
decidido(jorge).
reflexivo(jorge).
/*
esCompatible(Chica, Nene):-	melancolico(Chica),	sereno(Nene), noEsElMismo(Chica, Nene).
esCompatible(Chica, Nene):-	decidido(Chica), reflexivo(Nene), noEsElMismo(Chica, Nene).
esCompatible(Chica, Nene):-	soniador(Chica), decidido(Nene), noEsElMismo(Chica, Nene).
*/
esCompatible(Chica, Nene):-
	compatibilidad(Chica, Nene),
	noEsElMismo(Chica, Nene).

compatibilidad(Chica, Nene):-	melancolico(Chica),	sereno(Nene).
compatibilidad(Chica, Nene):-	decidido(Chica), reflexivo(Nene).
compatibilidad(Chica, Nene):-	soniador(Chica), decidido(Nene).

/* 2.9 */


	














