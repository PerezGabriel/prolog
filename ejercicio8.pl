/* 8.6 */



necesita(maria, pala).
necesita(maria, sierra).
necesita(jose, sarten).
necesita(hector, sarten).

cuantoFalta(Cuanto):-
	findall(Elemento, necesita( _, Elemento) /* elementosNecesarios(Elemento)*/, Lista),
	list_to_set(Lista, Set),
	length(Set, Cuanto).

elementosNecesarios(Elemento):-
	necesita( _, Elemento).

/* 8.7 */
%datos necesarios para pruebas
herramientaDemandada(martillo).
herramientaDemandada(pala).
herramientaDemandada(sierra).
herramientaDemandada(sarten).

costoHerramienta(martillo, 2).
costoHerramienta(pala, 5).
costoHerramienta(sierra,10).
costoHerramienta(sarten, 3).

costoTotalDeHerramientasDemandadas(Total):-
	findall(Precio, costoHerramienta(_))
