/*1. Crea una base de datos llamada test que contenga una
tabla llamada alumnos con las siguientes columnas.
Tabla alumnos:
	id (entero)
	nombre (cadena de caracteres)	
    apellido1 (cadena de caracteres)
	apellido2 (cadena de caracteres)
	email (cadena de caracteres)
*/
drop database test;
create database test;
use test;

create table alumnos(
	id int auto_increment primary key,
	nombre varchar(30) not null,
	apellido1 varchar(30) not null,
	apellido2 varchar(30) not null,
	email varchar(100)
);

insert into alumnos(nombre,apellido1,apellido2) values ('Jessica','Marulanda','Quintero');
insert into alumnos(nombre,apellido1,apellido2) values ('Andres','Lopez','Zamarreño');
insert into alumnos(nombre,apellido1,apellido2) values ('Alvaro','Sanchez','Ruiz');
insert into alumnos(nombre,apellido1,apellido2) values ('Enrique','Coca','Calderon');

/*
Escriba un procedimiento llamado crear_email que dados los parámetros de
entrada: nombre, apellido1, apellido2 y dominio, cree una dirección de email y la
devuelva como salida.
	Procedimiento: crear_email
	Entrada:
		o nombre (cadena de caracteres)
		o apellido1 (cadena de caracteres)
		o apellido2 (cadena de caracteres)
		o dominio (cadena de caracteres)
	Salida:
		o email (cadena de caracteres)
        
	devuelva una dirección de correo electrónico con el siguiente formato:
	El primer carácter del parámetro nombre.
	Los tres primeros caracteres del parámetro apellido1.
	Los tres primeros caracteres del parámetro apellido2.
	El carácter @.
	El dominio pasado como parámetro.
*/
drop procedure if exists crear_email;

delimiter $$
create procedure crear_email(in nombre varchar(15),in apellido1 varchar(15),in apellido2 varchar(15),in dominio varchar(15),out email varchar(50))
begin
	set email = concat(left(nombre,1),left(apellido1,3),left(apellido2,3),'@',dominio);
end $$

delimiter $$
call crear_email('andres','lopez','zamarreño','gmail.com',@email);
select @email;


/*
Una vez creada la tabla escriba un trigger con las siguientes características:
	Trigger: trigger_crear_email_before_insert
		o Se ejecuta sobre la tabla alumnos.
		o Se ejecuta antes de una operación de inserción.
		o Si el nuevo valor del email que se quiere insertar es NULL,
		entonces se le creará automáticamente una dirección de email y
		se insertará en la tabla.
		o Si el nuevo valor del email no es NULL se guardará en la tabla el
		valor del email.
Nota: Para crear la nueva dirección de email se deberá hacer uso del
procedimiento crear_email.
*/

delete trigger trigger_crear_email_before_insert;

delimiter $$
create trigger trigger_crear_email_before_insert
before insert
on alumnos for each row
begin
	if new.email is null then
		call crear_email(new.nombre, new.apellido1, new.apellido2, 'gmail.com', @email);
		set new.email = @email;
    end if;
end $$

delimiter $$
insert into alumnos(nombre,apellido1,apellido2,email) values ('juan','perez','rodriguez',null);

select * from alumnos;