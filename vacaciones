% Base de conocimiento %

lugar(iguazu, cataratas).
lugar(marDelPlata, playa).
lugar(marDelPlata, alfajores).

distancia(marDelPlata, 400).
distancia(iguazu, 1500).

leGusta(juan, sierra).
leGusta(ana, playa).
leGusta(ana, cataratas).

tieneVacaciones(ana).
tieneVacaciones(juan).

trabajo(ana, doctor, 5000).
trabajo(juan, ingeniero, 8000).

%Fin base de conocimiento %

sePuedeIrDeVacaciones(P, Lugar) :- tieneVacaciones(P), dineroAlcanza(P), leGustaLugar(P,Lugar).

       dineroAlcanza(P) :- trabajo(P,_, Sueldo), Sueldo >= 4000.

       leGustaLugar(P, Lugar) :- leGusta(P,C), lugar(Lugar, C).
       leGustaLugar(_,Lugar) :- lugar(Lugar,_), distancia(Lugar, D), D<500.


