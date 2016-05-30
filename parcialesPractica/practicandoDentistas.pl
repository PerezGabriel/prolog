

%% BUSCAR LOS EJERCICIOS EN EL DOCUMENTO:
%% 						 "#1" 
%% 						 "#2"
%% 						 "#3" 



%% DEFINICIONES
dentista(pereyra).
dentista(deLeon).
puedeAtenderA(pereyra, pacienteObraSocial(karlsson, 1231, osde)).
puedeAtenderA(pereyra, pacienteParticular(rocchio, 24)).
puedeAtenderA(deLeon, pacienteClinica(dodino, odontoklin)).

% costo de servicios para cada obra social
costo(osde, tratamientoConducto, 200).
costo(omint, tratamientoConducto, 250).

% costo de servicios por atención particular
costo(tratamientoConducto, 1200).

% porcentaje que se cobra a clínicas asociadas
clinica(odontoklin, 80).

%% #1
%% Se pide:
%% 1) Agregar el conocimiento sobre los pacientes que puede atender un dentista
%% (predicado puedeAtenderA/2):
%% - El doctor Cureta puede atender a todos los pacientes particulares de más de
%% 60 años y a los pacientes de la clínica Sarlanga.
%% - El doctor Patolinger puede atender todos los pacientes que puede atender
%% Pereyra y los que no puedan atenderse con De León.
%% - El doctor Saieg puede atender a todos los pacientes.
%% No es necesario que el predicado sea inversible.

puedeAtenderA(cureta, pacienteParticular(_ , Anios)):- Anios > 60.
puedeAtenderA(cureta, pacienteClinica(_, sarlanga)).

puedeAtenderA(patolinger, Paciente):-
	puedeAtenderA(pereyra, Paciente),
	not(puedeAtenderA(deLeon, Paciente)).
puedeAtenderA(saieg, _).

%% #2
%% 2) Relacionar el precio de un servicio para un paciente
%% - Para los pacientes de obra social, se determina en base al predicado
%% costo/3 (no es que lo pague el cliente, lo paga la obra social pero no
%% importa a los fines prácticos del enunciado)
%% - Para los pacientes particulares, se determina en base al predicado costo/2
%% (no interviene ninguna obra social). Si el paciente tiene más de 45 años, se
%% le cobra un adicional de 50 $.
%% - Para los pacientes que vienen de una clínica con la que tienen convenio, se
%% le aplica el porcentaje de lo que costaría a un particular (según el predicado
%% clinica/2, ej: si el servicio particular sale 1000 y la clínica tiene un
%% porcentaje de 70, el precio de ese servicio es de 700 $).
%% El predicado debe ser inversible para los últimos dos argumentos.
%% ?- precio(pacienteObraSocial(karlsson, 1231, osde), Servicio, Precio).
%% Servicio = tratamientoConducto
%% Precio = 200  es lo que le cobran a los pacientes de Osde

precio(Paciente, Sercicio, Precio):-
	precioSegun(Paciente, Servicio, Precio).

%% AUX
adicionalEdad(Edad, 50):-	Edad > 45.
adicionalEdad(Edad, 0):- Edad =< 45.

precioSegun(pacienteObraSocial( _, _, ObSocial), Servicio, Precio):-	
	costo(ObSocial, Servicio, Precio).

precioSegun(Paciente, Servicio, Precio):-
	costo(Servicio, Costo),
	modificadorPaciente(Paciente, Precio, Costo).

modificadorPaciente(pacienteClinica(_, Clinica), Precio, Costo):-
	clinica(Clinica, Porcentaje), 
	Precio is Precio * Porcentaje.

modificadorPaciente(pacienteParticular(_, Edad), Costo, Precio, Costo):-
	adicionalEdad(Edad, Modificador),
	Precio is Modificador + Costo.
%% #4
%% 3) Se agrega la información de los servicios que realizó cada dentista, con formato
%% servicioRealizado(fecha, dentista, servicio(servicio, functor paciente))
servicioRealizado(fecha(10, 11, 2010), pereyra, servicio(tratamientoConducto, pacienteObraSocial(karlsson, 1231, osde))).
servicioRealizado(fecha(16, 11, 2010), pereyra,servicio (tratamientoConducto, pacienteClinica(dodino, odontoklin))).
servicioRealizado(fecha(21, 12, 2010), deLeon, servicio(tratamientoConducto, pacienteObraSocial(karlsson, 1231, osde))).
%% Relacionar cuánto facturó un dentista en un mes determinado (considerar sólo
%% el mes, no el año):
%% ? montoFacturacion(pereyra, 11, Cuanto).
%% Cuanto = 1160 (200 de karlsson + 960 de Dodino, 80% de 1200)
%% El predicado debe ser inversible para el primer y el tercer argumento.

montoFacturacion(Dentista, Mes, Cuanto):- % Tipico Acumulador.
	dentista(Dentista),
	findall(Cobro, facturaEnMes(Dentista, Mes, Cobro), ListaCobros),
	sum_list(ListaCobros, Cuanto).

facturaEnMes(Dentista, Mes, Cobro):-
	servicioRealizado(fecha(_, Mes, _), Dentista, servicio(Servicio, Paciente)),
	precio(Paciente, Servicio, Cobro).


