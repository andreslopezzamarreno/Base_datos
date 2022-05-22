create database if not exists ejercicioCalculadora;
use ejercicioCalculadora;

create table calculadora(
  id int auto_increment primary key,
  operacion varchar(20),
  resultado int,
  fecha datetime
 );
 
drop procedure if exists calcular; 

delimiter $$
create procedure calcular(in numero1 int,in numero2 int, in operacion varchar(20) )
begin

declare resultado int;

if operacion = "suma" then 
	if (select comprobacion()) then
		set resultado = numero1 + numero2;
		insert into calculadora (operacion,resultado,fecha) values (operacion,resultado,now());
	else 
		truncate table calculadora;
        select 'registros borrados';
	end if;

elseif operacion = "resta" then 
	if (select comprobacion()) then
		select resultado = numero1 - numero2;
		insert into calculadora (operacion,resultado,fecha) values (operacion,resultado,datetime);
	else 
		truncate table calculadora;
		delete from calculadora;
	end if;

elseif operacion = "multiplicacion" then 
	if (select comprobacion()) then
		select resultado = numero1 * numero2;
		insert into calculadora (operacion,resultado,fecha) values (operacion,resultado,now());
	else 
		truncate table calculadora;
		delete from calculadora;
	end if;

elseif operacion = "division" then 
	if (select comprobacion()) then
		set resultado = numero1 / numero2;
		insert into calculadora (operacion,resultado,fecha) values (operacion,resultado,now());
	else 
		truncate table calculadora;
		delete from calculadora;
	end if;
else 
	select 'alguno de los valores es incocrrecto';
end if;
END $$
delimiter ;


drop function if exists comprobacion;

DELIMITER $$
CREATE FUNCTION comprobacion()
RETURNS boolean
BEGIN
declare bandera int;
set bandera = (select count(id) from calculadora);
IF bandera <5 THEN
	return true;
else 
	return false;
END IF;
END $$
delimiter ;

call calcular(2,2,"suma");

select * from calculadora;