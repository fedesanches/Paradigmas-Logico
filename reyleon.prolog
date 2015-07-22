%%%%%%%%%%%%%%%%%%%%%%%%
% Base de Conocimiento %
%%%%%%%%%%%%%%%%%%%%%%%%

% comio(Personaje, Bicho) %
% vaquitasdesanantonio(nombre,peso)
% cucaracha(nombre, tamanio, peso)
% hormigas(nombre) pesan siempre lo mismo
pesoHormiga(2).

comio(pumba, vaquitaSanAntonio(gervasia,3)).
comio(pumba, hormiga(federica)).
comio(pumba, hormiga(tuNoEresLaReina)).
comio(pumba, cucaracha(ginger,15,6)).
comio(pumba, cucaracha(erikElRojo,25,70)).

comio(timon, vaquitaSanAntonio(romualda,4)).
comio(timon, cucaracha(gimeno,12,8)).
comio(timon, cucaracha(cucurucha,12,5)).

comio(simba, vaquitaSanAntonio(remeditos,4)).
comio(simba, hormiga(schwartzenegger)).
comio(simba, hormiga(niato)).
comio(simba, hormiga(lula)).

comio(shenzi,hormiga(conCaraDeSimba)).

% peso(Personaje, Peso)

peso(pumba, 100).
peso(timon, 50).
peso(simba, 200).

peso(scar, 300).
peso(shenzi, 400).
peso(banzai, 500).

peso(vaquitaSanAntonio(_,Peso),Peso).
peso(cucaracha(_,_,Peso),Peso).
peso(hormiga(_),Peso):- pesoHormiga(Peso).



% persigue(Perseguidor, Perseguido)
persigue(scar, timon).
persigue(scar, pumba).
persigue(shenzi, simba).
persigue(shenzi, scar).
persigue(banzai, timon).

persigue(scar, mufasa).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fin Base de Conocimiento %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% EJERCICIO NUMERO 1 %
% A - cucaracha mayor peso %
jugosita(cucaracha(Nombre,Tamanio,Peso)):-
	bicho(cucaracha(Nombre, Tamanio, Peso)),
	bicho(cucaracha(_,Tamanio, OtroPeso)),
	Peso > OtroPeso.

bicho(UnBicho):- comio(_,UnBicho).

% B - comio al menos dos hormigas %
hormigofilico(P):-
	comio(P, hormiga(UnaHormiga)),
	comio(P, hormiga(OtraHormiga)),
	UnaHormiga \= OtraHormiga.

% C - no comio cucarachas %
cucarachofobico(P):-
	peso(P,_),
	not(comio(P,cucaracha(_,_,_))).

% D - conjunto de picarones,Un personaje es picarón si comió una
% cucaracha jugosita ó si se come a Remeditos la vaquita. Además, pumba
% es picarón de por sí.

esPicaron(P):- comio(P,Bicho), jugosita(Bicho).
esPicaron(P):- comio(P,vaquitaSanAntonio(remeditos,_)).
esPicaron(pumba).

picarones(L) :- findall(P, esPicaron(P), L).

% EJERCICIO NUMERO 2 %
% A - engordan igual a los pesos de los bichos que comio %
cuantoEngorda(P, Engorde) :-
	peso(P,_),
	findall(Peso, engorda(P,Peso), L),
	sumlist(L,Engorde).

%se usa la que se encuentra mas abajo
%engorda(P, Peso):-
%       seCome(P, Victima),
%	peso(Victima, Peso).

seCome(P,Victima):- comio(P,Victima).

% B - cuando un personaje persigue a otro, se lo come %
seCome(P,Victima) :- persigue(P, Victima).

%C - hay que tener en cuenta lo que ya comieron %
engorda(P, PesoTotal):-
	seCome(P,Victima),
	peso(Victima, Peso),
	cuantoEngorda(Victima,Engorde),
	PesoTotal is Peso + Engorde.

% EJERCICIO NUMERO 3 %
rey(P) :-
	soloLoPersigueUno(P),
	todosLoAdoran(P).

soloLoPersigueUno(P) :-
	findall(P, persigue(_,P),L),
	length(L,C),
	C = 1.

todosLoAdoran(P) :-
	forall(animal(A), adora(A,P)).

animal(A) :- bicho(A).
animal(A) :- peso(A,_).

adora(A,P) :- not(seCome(P,A)).

