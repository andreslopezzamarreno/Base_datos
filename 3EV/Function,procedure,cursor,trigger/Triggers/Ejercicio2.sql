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

delimiter $$
create procedure crear_email(in nombre varchar(15),in apellido1 varchar(15),in apellido2 varchar(15),in dominio varchar(15),out email varchar(50))
begin
	set email = concat(left(nombre,1),left(apellido1,3),left(apellido2,3),'@',dominio);
end $$

delimiter $$
call crear_email('andres','lopez','zamarreño','gmail.com',@email);
select @email;

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

insert into alumnos(nombre,apellido1,apellido2,email) values ('juan','perez','rodriguez',null);
insert into alumnos(nombre,apellido1,apellido2,email) values ('Jessica','Marulanda','Quintero',null);
insert into alumnos(nombre,apellido1,apellido2,email) values ('Andres','Lopez','Zamarreño',null);

/*
1. Modifica el ejercicio anterior y añade un nuevo trigger con las
siguientes características:
La tabla log_cambios_email contiene los siguientes campos:
	id: clave primaria (entero autonumérico)
	id_alumno: id del alumno (entero)
	fecha_hora: marca de tiempo con el instante del cambio (fecha y hora)
	old_email: valor anterior del email (cadena de caracteres)
	new_email: nuevo valor con el que se ha actualizado
*/
CREATE TABLE log_cambios_email(
	id int auto_increment primary key,
	id_alumno int,
	fecha_hora datetime,
	old_email varchar(30),
	new_email varchar (30),
	foreign key(id_alumno) references alumnos(id)
);

/*
Trigger: trigger_guardar_email_after_update:
	Se ejecuta sobre la tabla alumnos.
	Se ejecuta después de una operación de actualización.
	Cada vez que un alumno modifique su dirección de email se deberá
insertar un nuevo registro en una tabla llamada log_cambios_email.
*/
delimiter $$
create trigger trigger_guardar_email_after_update
after update
on alumnos for each row
begin
	if old.email <> new.email then
	insert into log_cambios_email(id_alumno,fecha_hora,old_email,new_email) values (old.id,now(),old.email,new.email);
	end if;
end $$

UPDATE alumnos set email = 'nuevomail@gmail.com' where id= 3;
UPDATE alumnos set email = 'jperrod@gmail.com' where id= 1;
select * from alumnos;
select * from log_cambios_email;