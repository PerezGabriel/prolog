tipoDeAplicacion(Total, Total, total).
tipoDeAplicacion(Parametros, Pasados, parcial):-
    Cota is Parametros - 1,
    between(1, Cota, Pasados).
    
tipoDeAplicacion(_, 0, sinAplicar).