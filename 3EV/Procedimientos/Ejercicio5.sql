use jardineria;

/*
Escribe un procedimiento que reciba el nombre de un país como
parámetro de entrada y realice una consulta sobre la tabla cliente para
obtener todos los clientes que existen en la tabla de ese país.
*/
drop procedure clientespais;

delimiter $$
create procedure clientespais(in country varchar(50))
begin
	select * from cliente where pais like country;
end $$

call clientespais('Australia');

/*
Escribe un procedimiento que reciba como parámetro de entrada una
forma de pago, que será una cadena de caracteres
(Ejemplo: PayPal, Transferencia, etc). Y devuelva como salida el pago de
máximo valor realizado para esa forma de pago. Deberá hacer uso de la
tabla pago de la base de datos jardineria.
*/
drop procedure metodopago;

delimiter $$
create procedure metodopago(in metodo varchar(20),out cantidad decimal)
begin
	set cantidad = (select max(total) from pago where forma_pago like metodo);
end $$

delimiter $$
call metodopago('transferencia',@cantidad);
select @cantidad

/*
3. Escribe un procedimiento que reciba como parámetro de entrada una
forma de pago, que será una cadena de caracteres
(Ejemplo: PayPal, Transferencia, etc). Y devuelva como salida los
siguientes valores teniendo en cuenta la forma de pago seleccionada
como parámetro de entrada:
	el pago de máximo valor,
	el pago de mínimo valor,
	el valor medio de los pagos realizados,
	la suma de todos los pagos,
	el número de pagos realizados para esa forma de pago.
Deberá hacer uso de la tabla pago de la base de datos jardineria.
*/
drop procedure pagos;

delimiter $$
create procedure pagos(in metodo varchar(50),out max decimal, out min decimal,out average decimal, out sum decimal,out numpagos decimal)
begin
	set max = (select max(total) from pago where forma_pago like metodo);
    set min = (select min(total) from pago where forma_pago like metodo);
    set average = (select avg(total) from pago where forma_pago like metodo);
    set sum = (select sum(total) from pago where forma_pago like metodo);
    set numpagos = (select count(total) from pago where forma_pago like metodo);
end $$

delimiter $$
call pagos('Paypal',@max,@min,@average,@sum,@sumpagos);
select @max,@min,@average,@sum,@sumpagos;
