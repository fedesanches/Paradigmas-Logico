%%%%%%%%%%%%%%%%%%%%%%%%
% Base de Conocimiento %
%%%%%%%%%%%%%%%%%%%%%%%%

% viveEn(Monstruo, Lugar) %
viveEn(dracula, castillo).
viveEn(godzilla, espacio).
viveEn(sullivan, espacio).
viveEn(mLegrand, tv).
viveEn(frankenstein, castillo).
viveEn(barney, tv).
viveEn(allien, espacio).

% maneja(Monstruo, Vehiculo) %
maneja(godzilla, auto(4)). % Los autos poseen su capacidad %
maneja(barney, colectivo(fucsia,10,5)). % Colectivos se sabe color, asientos simples y dobles %
maneja(sullivan, nave([2,3,1])). % La cantidad de personas que entran en la navel en total %
maneja(allien, nave([3,4])).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fin Base de Conocimiento %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% EJERCICIO 1 - Un monstruo no tiene vehiculo %

estaDeAPie(M) :-
	not(maneja(M,_)).

% EJERCICIO 2 - puedeLlevar/2 si ambos viven en el mismo lugar y el primero tiene vehiculo %

puedeLlevar(M1, M2):-
	maneja(M1,_),
	viveEn(M1,L),
	viveEn(M2,L),
	M1 \= M2.

% EJERCICIO 3 - cantidadPasajeros/2 cantidad de pasajeros que un
% monstruo puede llevar %

% Caso Auto %
cantidadPasajeros(M, P):-
	maneja(M,auto(C)),
	P is (C-1).

% Caso Colectivo %
cantidadPasajeros(M, P):-
	maneja(M, colectivo(_,AS,AD)),
	P is (AS + (AD * 2) - 1).

% Caso Nave %
cantidadPasajeros(M, P):-
	maneja(M, nave(L)),
	sumlist(L, C),
	P is (C-1).

% EJERCICIO 4 - lugarVehiculizado/1 todos los que viven ahi tienen un
% vehiculo para mas de 10 personas %

lugarVehiculizado(L):-
	viveEn(M,L),
	forall(viveEn(M,L),maneja(M,_)),
	forall(cantidadPasajeros(M,P),P > 10).

