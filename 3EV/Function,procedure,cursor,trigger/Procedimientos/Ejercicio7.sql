/*
Crea una base de datos llamada procedimientos que contenga
una tabla llamada pares y otra tabla llamada impares. Las dos tablas
deben tener única columna llamada número y el tipo de dato de esta
columna debe ser INT UNSIGNED.
*/
drop database if exists procedimientos;
create database procedimientos;
use procedimientos;


create table pares(
	 numero int unsigned
);

create table impares(
	 numero int unsigned
);

/*
Una vez creada la base de datos y las tablas deberá crear un
procedimiento llamado calcular_pares_impares con las siguientes
características. El procedimiento recibe un parámetro de entrada
llamado tope de tipo INT UNSIGNED y deberá almacenar en la tabla pares aquellos
números pares que existan entre el número 1 el valor introducido como
parámetro. Habrá que realizar la misma operación para almacenar los números
impares en la tabla impares.
Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de
las tablas antes de insertar los nuevos valores.
Utilice un bucle WHILE para resolver el procedimiento.
*/
drop procedure paresimpares;

delimiter $$
create procedure paresimpares(in tope int)
begin
	declare contador int;
    set contador = 0;
    truncate table pares;
    truncate table impares;
    while contador < tope do 
		if contador %2 = 0 then 
			insert into pares values (contador);
        else 
			insert into impares values (contador);
        end if;
        set contador = contador + 1;
    end while;
end $$

delimiter $$
call paresimpares(5);

select * from pares;
select * from impares;