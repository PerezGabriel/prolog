%% FORALL
ejemplo:-
fijar(Fijo),  %GENERADOR
forall(fucion(Fijo,AEvaluar), evaluacion(AEvaluar)).

%% FINDALL

%% MEMBER
member(Elemento, Lista).

%% APPEND
append([1,2],[3,4],X)
X=[1,2,3,4]
size([a,b,c], N)
N= 3