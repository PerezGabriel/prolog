
/* 5.7 */
esPeligroso(Nombre):-
	personaje(Nombre,PerteneceACasa),
	esPersonajePeligroso(PerteneceACasa).

esPersonajePeligroso(lannister(Monedas)):-
	Monedas >= 300.
esPersonajePeligroso(stark(_ , _)).
	
