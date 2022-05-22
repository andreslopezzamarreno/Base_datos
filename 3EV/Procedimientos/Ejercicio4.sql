/*
Crear una base de datos llamada primitiva. Esta base de datos tendrá una tabla
llamada pronóstico con la columna número (int).
Crear un procedimiento que no reciba ningún parámetro de entrada que genere 6
números aleatorios del 0 al 49 y los inserte en la tabla pronóstico. Esta será la
combinación ganadora.
4. Crear con while.
5. Se debe borrar los registros de la tabla cada vez que se genere una combinación
ganadora.
*/
drop database primitiva;
create database if not exists primitiva;
use primitiva;

create table pronostico(
numero int
);

-- -------------------------------
drop procedure generaraleatorios;

delimiter $$
create procedure generaraleatorios()
begin
	declare aleatorio int;
    declare contador int;
    declare comprobacion int;
    set contador = 0;
    set comprobacion = (select count(numero) from pronostico);
	if comprobacion > 0 then 
		delete from pronostico;
	end if;
    
    while contador < 6 do
		set aleatorio =  round(rand() * 49,0);
		insert into pronostico values (aleatorio);
		set contador = contador + 1;
	end while;
end $$


call generaraleatorios();

select * from pronostico;
-- -------------------------------
/*
Crear con loop.
*/
elimiter $$
create procedure generaraleatoriosloop ()
begin
	declare numero int;
	declare contador int;
	set contador = 1;
	truncate table pronostico;
	etiqueta1:loop
    
		if contador > 6 then
			leave etiqueta1;
        else
			set numero=round(rand()*49,0);
			insert into pronostico (numero) values (numero);
		end if;
        
		set contador = contador +1;
	end loop;
    
end $$

call generaraleatoriosloop;
