% grupoSensante(Madre, Grupo).
grupoSensante(angelica, [capheus, sun, nomi, kala, riley, lito, will, wolfgang]).

%% #1
%% 1.	Saber si una persona está conectadoCon/2 otra persona, sabiendo que:
%% a.	Todo sensante está conectado con su madre.
%% b.	Sensantes de un mismo grupo están conectados.
%% c.	Jonas y Angélica están conectados.
%% d.	El Sr. Whispers está conectado a todo aquel que lo vio a los ojos. Por ahora Jonas y Angélica  lo miraron a los ojos
%% Nota: No hace falta que esta relación sea simétrica.

conectadoCon(Persona, Madre):-
	grupoSensante(Madre, Grupo),
	member(Persona, Grupo).

conectadoCon(Persona, Otra):-
	compartenGrupo(_, Persona, Otra). %en compartenGrupo se valida que sean distintas.

conectadoCon(jonas, angelica).
conectadoCon(srWhispers, Otra):-
	loVioALosOjos(srWhispers, Otra).


%% AUX
loVioALosOjos(srWhispers, jonas).
loVioALosOjos(srWhispers, angelica).

compartenGrupo(Grupo, Persona, Otra):-
	grupoSensante(_, Grupo),
	member(Persona, Grupo),
	member(Otra, Grupo),
	Persona \= Otra.

%% #2
%% 2.	Poseemos información sobre los gustos de las personas:
leGusta(capheus, actor(jeanClaudeVanDamme)).
leGusta(capheus, cancion(whatsUp)).
leGusta(sun, deporte(kickboxing)).
leGusta(sun, cancion(whatsUp)).
leGusta(nomi, persona(amanita)).
leGusta(nomi, cancion(whatsUp)).
leGusta(kala, persona(wolfgang)).
leGusta(kala, cancion(whatsUp)).
leGusta(riley, persona(will)).
leGusta(riley, cancion(whatsUp)).
leGusta(lito, persona(hernando)).
leGusta(lito, cancion(whatsUp)).
leGusta(will, cancion(whatsUp)).
leGusta(wolfgang, persona(kala)).
leGusta(wolfgang, cancion(whatsUp)).

%% a.	Se quiere saber si dos personas hacen una parejaSensante/2, esto significa que se gustan mutuamente y pertenecen al mismo grupo. 
%% En nuestro ejemplo, Kala y Wolfgang hacen una pareja sensante.
%% b.	Indicar si un gusto es sintonizador/1, o sea, si le gusta a todas las personas que conforman algún grupo sensante.
%% En nuestro ejemplo, la canción What’s Up es sintonizador.

parejaSensante(Persona, Otra):-
	compartenGrupo(_, Persona, Otra),
	seGustanMutuamente(Persona, Otra).

sintonizador(Gusto):- % FUNCTOR
	grupoSensante(_, Grupo),
	forall(member(Persona, Grupo), leGusta(Persona, Gusto)).

%% ESTA SOLUCION NO CREO QUE SEA LA PEDIDA
%% sintonizador(Gusto):-
%% 	obtenerGusto(Algo, Gusto),
%% 	leGusta(_ , Algo),
%% 	grupoSensante(_, Grupo),
%% 	forall(member(Persona, Grupo), leGusta(Persona, Algo)).
%% 
%% obtenerGusto(cancion(Gusto), Gusto).
%% obtenerGusto(persona(Gusto), Gusto).
%% obtenerGusto(deporte(Gusto), Gusto).
%% obtenerGusto(actor(Gusto), Gusto).

%% AUX
seGustanMutuamente(Persona, Otra):-
	gustaDe(Persona, Otra),
	gustaDe(Otra, Persona).

gustaDe(Persona, Otra):-
	leGusta(Persona, Gusto),
	personaEnGusto(Gusto, Otra).

personaEnGusto(persona(Persona), Persona).
personaEnGusto(actor(Persona), Persona).  % no se si va, pero por las dudas.

%% #3
%% 3.	También sabemos dónde se encuentran los sensantes:
viveEn(capheus, nairobi).
viveEn(sun, seul).
viveEn(nomi, sanFrancisco).
viveEn(kala, mumbai).
viveEn(riley, londres).
viveEn(lito, mexicoDF).
viveEn(will, chicago).
viveEn(wolfgang, berlin).

%% Queremos saber si un grupo está disperso/1. Esto se cumple para cualquier grupo sensante cuyos integrantes viven todos en distintos países.
%% En nuestro ejemplo, el grupo de Angélica está disperso.
disperso(Grupo):-
	compartenGrupo(Grupo, Persona, Otra),
	not(compatriotas(Persona, Otra)).

%% AUX
compatriotas(Persona, Otra):-
	vivenEn(Persona, Pais),
	viveEn(Otra, Pais),
	Persona \= Otra. 	% para la aplicacion que creo el predicado,
						% esto ya está validado en "compartenGrupo/Grupo, 2"

%% #4
%% 4.	Por último, queremos analizar información sobre sus habilidades:
%% % habilidad(Persona, conductor(NombreDeVehículo,CantPasajeros)).
habilidad(capheus, conductor(vanDamm, 25)).
habilidad(sun, negocios).
habilidad(sun, pelear).
habilidad(sun, coser).
habilidad(nomi, bloguera).
habilidad(nomi, delincuente(hacker)).
habilidad(kala, quimica).
habilidad(riley, dj).
habilidad(lito, actor).
habilidad(will, policia).
habilidad(wolfgang, inteligente).
habilidad(wolfgang, pelear).
habilidad(wolfgang, delincuente(ladronDeJoyas)).

%% 	Se desea saber si una persona es habilidosa/1. Esto ocurre cuando tiene al menos 3 habilidades buenas. Se sabe que salvo ser delincuente, policía o conductor de un vehículo chico (en donde entren menos de 20 personas), todo el resto de las habilidades son buenas.
%% En nuestro ejemplo, la única habilidosa es Sun.

habilidosa(Persona):-
	tieneBuenasAlMenos(3, Persona).



%% AUX
tieneBuenasAlMenos(Num, Persona):-
	habilidad(Persona, _),
	findall(Habilidad, habilidadBuenaDe(Persona, Habilidad), Habilidades),
	length(Habilidades, TotalHabilidades),
	TotalHabilidades >= Num.

habilidadBuenaDe(Persona, Habilidad):-
	habilidad(Persona, Habilidad),
	not(habilidadNoBuena(Habilidad)). 
	%% estan definidas las no buenas.

habilidadNoBuena(delincuente(_)).
habilidadNoBuena(policia).
habilidadNoBuena(conductor(_, CantPasajeros)):-	CantPasajeros < 20.