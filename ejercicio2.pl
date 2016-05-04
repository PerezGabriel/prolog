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

esDeseable(Mujer):- 
    esCompatible(Mujer, UnTipo),
    esCompatible(Mujer, OtroTipo),
    UnTipo \= OtroTipo.
esDeseable(Hombre):-
    esCompatible(UnaMinita, Hombre),
    esCompatible(OtraMinita, Hombre),
    UnaMinita \= OtraMinita.



/* 2.10 */
gustaDe(luis, nora).
gustaDe(roque, ana).
gustaDe(roque, nora).
gustaDe(marcos, zulema).
gustaDe(juan, nuria).
gustaDe(zulema,ana).

gustaDe(Chico, zulema):-
    gustaDe(Chico, ana),
    Chico \= zulema,
    Chico \= juan. /* porque si no 2 veces lo compara con zulema */
    

gustaDe(juan, Chica):-
    gustaDe(roque, Chica).

/* 2.11 */
compiten(Uno, Otro):-
    gustaDe(Uno, Alguien),
    gustaDe(Otro, Alguien),
    Uno \= Otro.

/* 2.12 */
puedeIr(nico).
puedeIr(daniel).

puedeIr(Alguien):-
    carilindo(Alguien).

puedeIr(Alguien):-
    alumno(Alguien, Profe),
    puedeIr(Profe).


alumno(luisa, daniel).
alumno(juan, daniel).
alumno(ana, luisa).
alumno(diana, nico).
alumno(nahuel, nico).
alumno(tamara, nahuel).
alumno(claudio, ruben).
alumno(jose, ruben).
alumno(alvaro, jose).
alumno(alvaro, luisa).

carilindo(brad).
carilindo(leo).
carilindo(johnny).

simpatico(luciano).
simpatico(lautaro).

/* 2.13 */
atraeA(mabel, rosa).
atraeA(ana, rosa).
atraeA(mara, celeste).
atraeA(mara, lila).
atraeA(pablo, azul).
atraeA(adrian, amarillo).
atraeA(ana, naranja).
atraeA(juan, naranja).
atraeA(mabel, rojo).

mujer(mabel).
mujer(ana).
mujer(mara).

varon(pablo).
varon(adrian).
varon(juan).

portenio(mabel).
portenio(mara).
portenio(pablo).

esMayor(ana).
esMayor(pablo).

pastel(celeste).
pastel(rosa).
pastel(lila).

atraeA(Alguien, rojo):-
    esMayor(Alguien),
    varon(Alguien).

atraeA(juan, Color):-
    pastel(Color).

atraeA(Persona, azul):-
    mujer(Persona).

atraeA(Persona, amarillo):-
    portenio(Persona).

/* 2.14 */
puedeIluminarseCon(Dia, Color):-
    cuandoAsistira(Persona,Dia),
    cuandoAsistira(OtraPersona,Dia),
    atraeA(Persona, Color),
    atraeA(OtraPersona, Color),
    distintoSexo(Persona, OtraPersona).

cuandoAsistira(mabel, viernes).
cuandoAsistira(ana, viernes).
cuandoAsistira(adrian, viernes).
cuandoAsistira(pablo, viernes).
cuandoAsistira(mara, sabado).
cuandoAsistira(mabel, sabado).
cuandoAsistira(adrian, sabado).
cuandoAsistira(juan, sabado).
cuandoAsistira(juan, domingo).

cuandoAsistira(Persona, domingo):-
    esMayor(Persona).

distintoSexo(Persona, OtraPersona):-
    varon(Persona), mujer(OtraPersona).
distintoSexo(OtraPersona, Persona):-
    varon(Persona), mujer(OtraPersona).

/* 2.15 */
tipo(siguiente, entero, entero).
tipo(anterior, entero, entero).
tipo(longitud, lista, entero).

tipoDeLaComposicion(Funo, Fdos, IN, OUT):-
    tipo(Fdos, IN, OUTdos),
    tipo(Funo, OUTdos, OUT).

/* 2.16 */
puedoUsar(sumar, num).
puedoUsar(restar, num).
puedoUsar(sumar, num).
puedoUsar(dividir, fractional).
puedoUsar(mostrar, show).

heredaDe(fractional,num).
heredaDe(int, num).
heredaDe(int, show).
heredaDe(float, show).
heredaDe(double, show).
heredaDe(fractional, show).
heredaDe(double, show).
heredaDe(bool, show).

puedoUsar(Operacion,Typeclass):-
    heredaDe(Typeclass, TypeSuper),
    puedoUsar(Operacion, TypeSuper).
