% Base de Conocimiento %

factura( 1001, juan, fecha(25,12,2010)).
factura( 1002, maria, fecha(12,11,2010)).
factura( 1003, juan, fecha(15,12,2010)).
factura( 1004, juan, fecha(15,11,2010)).

itemFactura( 1001, leche, 2).
itemFactura( 1001, huevos, 3).
itemFactura( 1001, azucar, 1).
itemFactura( 1002, leche, 12).
itemFactura( 1002, arroz, 8).
itemFactura( 1003, huevos, 1).
itemFactura( 1003, leche, 1).

precio( leche, 2).
precio( huevos, 1).
precio( arroz, 3).
precio( azucar, 3).

% Fin Base de Conocimento %

% Ejercicio Numero 1 %
% a %
masDeUnaCompra(P,Mes) :-
	findall(Mes, factura(_,P,fecha(_,Mes,_)), L),
	length(L,Cantidad),
	Cantidad > 1.

% b %
nuncaCompraron(L) :- findall(P, not(factura(_,P,_)),L).

% c %
productoComprado3Facturas(Producto) :-
	findall(Producto,itemFactura(_,Producto,_),L),
	length(L,C),
	C>=3.

productosCodiciados(L) :-
	findall(Producto, (itemFactura(_,Producto,Cantidad),Cantidad >=3), L).

productosCodiciados(L) :-
	findall(Producto, (precio(Producto,_),productoComprado3Facturas(Producto)),L).
