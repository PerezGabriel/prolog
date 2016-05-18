% vimos los ejercicios 3.7, 8.6 en adelante, 9 completo.

% forall/2 

% para todo-> V: (conjunto ) => ( condicion)
% el para todo, tiene 2 cosas, un conjunto de donde se sacan y evaluan los datos,
% y una condicion que es con la que se evaluan.

%ejemplo: paraTodo n entre 1 y 10 son menores a 100.

% forall(between(1,10,N), N < 100)

% forall(between(10,1,N), N < 100)  en este caso, el precedente(conjunto) da falso , 
% el forall va a dar verdadero    porque actúa como un entonces. conjunto => condicion.