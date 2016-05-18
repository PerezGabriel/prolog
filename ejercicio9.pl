/* 9.1 */
personaje(pumkin,     ladron([licorerias, estacionesDeServicio])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent,    mafioso(maton)).
personaje(jules,      mafioso(maton)).
personaje(marsellus,  mafioso(capo)).
personaje(winston,    mafioso(resuelveProblemas)).
personaje(mia,        actriz([foxForceFive])).
personaje(butch,      boxeador).

%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

/* RESUELTO POR MI

esPeligroso(Nombre):-
	personaje(Nombre, mafioso(maton)).

esPeligroso(Nombre):-
	personaje(Nombre, ladron(Objetivos)),
	member(licorerias, Objetivos).

esPeligroso(Nombre):-
	trabajaPara(Nombre, Empleado),
	esPeligroso(Empleado).
*/

% CORRECCION EN CLASE mumuki la rechaza

esPeligroso(Nombre):-
	haceActividadPeligrosa(Nombre).
esPeligroso(Nombre):-
	tieneEmpleadosPeligrosos(Nombre).

haceActividadPeligrosa(Nombre):-
	personaje(Nombre, Actividad),
	actividadPeligrosa(Actividad).

actividadPeligrosa(mafioso(maton)).

actividadPeligrosa(ladron(Objetivos):-
	member(licorerias, Objetivos).

tieneEmpleadosPeligrosos(Nombre):-
	trabajaPara(Nombre, Empleado),
	esPeligroso(Empleado).

/* 9.1 */
amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).

pareja(marsellus, mia).
pareja(pumkin, honeyBunny).


/*
duoTemible(Partner, Compa):-
	sonPeligrosos(Partner, Compa),
	socios(Partner, Compa).

sonPeligrosos(Partner, Compa):-
	esPeligroso(Partner),
	esPeligroso(Compa).

socios(Partner, Compa):-
	pareja(Partner, Compa).
socios(Partner, Compa):-
	amigo(Partner, Compa).
socios(Partner, Compa):-
	pareja(Compa, Partner).
socios(Partner, Compa):-
	amigo(Compa, Partner).
*/
%SOLUCION QUE LE GUSTÓ A MUMUKI
duoTemible(Partner, Compa):-
	esPeligroso(Partner),
	esPeligroso(Compa),
	socios(Partner, Compa).

socios(Partner, Compa):-
	pareja(Partner, Compa).
socios(Partner, Compa):-
	amigo(Partner, Compa).

/* 9.3 */

%encargo(Solicitante, Encargado, Tarea).
%las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).

estaEnProblemas(butch).

estaEnProblemas(Nombre):-
	cuidaParejaDeJefePeligroso(Nombre).

estaEnProblemas(Nombre):- 
	buscaUnBoxer(Nombre).

cuidaParejaDeJefePeligroso(Nombre):-
	trabajaPara(Empleador, Nombre),
	esPeligroso(Empleador),
	encargo(Empleador, Nombre, cuidar(Protegido)),
	pareja(Empleador, Protegido).

buscaUnBoxer(Nombre):-
	personaje(Nombre, _), % esta de mas
	encargo(_, Nombre, buscar(Buscado, _)),
	personaje(Buscado, boxeador).

/* 9.4 */
% LA PREGUNTA ES DE INTEGRIDAD, SI SE CUMPLE EN TODOS LOS CASOS.
% ACA HAY QUE USAR EL PARA TODO, O BIEN SE PUEDE NEGAR UNO
%	|- PARA TODO SE CUMPLE.
%	|- EXISTE UNO QUE NO CUMPLA.


sanCayetano(Alguien):-
	loTieneCerca(Alguien, _), % GENERADOR
	forall(loTieneCerca(Alguien, Encargado), encargado(Alguien, Encargado, _)).
	
loTieneCerca(Uno, Otro):-
	amigo(Uno, Otro).
loTieneCerca(Uno, Otro):-
	trabajaPara(Uno, Otro).

/* 9.5 */ 
elMasAtareado(Nombre):-
	personaje(Nombre, _),
	forall(personaje(Cualquier, _), tieneMenosOIgualEncargos(Cualquier, Alguien)),

tieneMenosOIgualEncargos(Cualquier, Alguien):-
	cantEncargos(Cualquier, Cantidad),
	cantEncargos(Alguien, PocaCantidad),
	PocaCantidad =< Cantidad.

cantEncargos(Alguien, Cantidad):-
	encargo(_Alguien, _),
	findall(Encargo, encargo(_Alguien, Encargo), Encargos),
	length(Encargos, Cantidad).

% solucion en el pizarron:
/*
elMasAtareado(Persona):-
	cantEncargos(Alguien, CantidadMax),
	forall(cantEncargos(_, Cantidad), Cantidad =< CantidadMax). la cantidad de encargo de cualquiera tiene que ser menor o igual q la de la persona en cuestion
*/