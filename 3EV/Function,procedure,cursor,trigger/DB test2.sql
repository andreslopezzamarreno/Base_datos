/*
Escribe las sentencias SQL necesarias para crear una base de
datos llamada test, una tabla llamada alumnos y 4 sentencias de
inserción para inicializar la tabla. La tabla alumnos está formada por las
siguientes columnas:
	id (entero sin signo y clave primaria)
	nombre (cadena de caracteres)
	apellido1 (cadena de caracteres)
	apellido2 (cadena de caracteres
	fecha_nacimiento (fecha)
*/
drop database test2;
create database test2;
use test2;

create table alumnos(
	id int auto_increment primary key,
	nombre varchar(30) not null,
	apellido1 varchar(30) not null,
	apellido2 varchar(30) not null,
	fecha_nacimiento varchar(100)
);

/*
Una vez creada la tabla se decide añadir una nueva columna a la tabla
llamada edad que será un valor calculado a partir de la
columna fecha_nacimiento. Escriba la sentencia SQL necesaria para modificar
la tabla y añadir la nueva columna.
*/
ALTER TABLE alumnos ADD edad VARCHAR(20) NULL;

insert into alumnos(nombre,apellido1,apellido2,fecha_nacimiento) values ('Jessica','Marulanda','Quintero','1999/11/09');
insert into alumnos(nombre,apellido1,apellido2,fecha_nacimiento) values ('Andres','Lopez','Zamarreño','2001/01/23');
insert into alumnos(nombre,apellido1,apellido2,fecha_nacimiento) values ('Alvaro','Sanchez','Ruiz','2002/12/06');
insert into alumnos(nombre,apellido1,apellido2,fecha_nacimiento) values ('Enrique','Coca','Calderon','2008/02/15');

/*
Escriba una función llamada calcular_edad que reciba una fecha y devuelva el
número de años que han pasado desde la fecha actual hasta la fecha pasada
como parámetro: TIMESTAMPDIFF
	Función: calcular_edad
	Entrada: Fecha
	Salida: Número de años (entero)
*/
delimiter $$
create function calcular_edad(fecha date)returns int
begin
	declare edad int;
	set edad=(TIMESTAMPDIFF(YEAR,fecha,now()));
	RETURN edad;
end $$

select calcular_edad('1992-01-05');

/*
Ahora escriba un procedimiento que permita calcular la edad de todos los
alumnos que ya existen en la tabla. Para esto será necesario crear
un procedimiento llamado actualizar_columna_edad que calcule la edad de
cada alumno y actualice la tabla. Este procedimiento hará uso de la
función calcular_edad que hemos creado en el paso anterior.
*/
drop procedure actualizar_columna_edad;

delimiter $$
create procedure actualizar_columna_edad()
begin
	declare fecha_nacimiento date;
	declare edad int;
    declare id int;
    declare hecho int default 0;
	
    -- declarar cursor
    declare fecha_alumnos CURSOR FOR
	select alumnos.id,alumnos.fecha_nacimiento from alumnos;
    
    -- Manejar el handler
	declare continue handler for not found set hecho = 1;

	-- abrir cursor
	open fecha_alumnos;

	bucle:LOOP
	fetch fecha_alumnos into id,fecha_nacimiento;
		
		if hecho = 1 then
			leave bucle;
		end if;
        set edad = calcular_edad(fecha_nacimiento);
		UPDATE alumnos SET alumnos.edad = edad WHERE alumnos.id = id;
	end loop bucle;
	close fecha_alumnos;

end $$

call actualizar_columna_edad;

/*
1. Modifica la tabla alumnos del ejercicio anterior para añadir una nueva
columna email.
*/
ALTER TABLE alumnos ADD email VARCHAR(50) NULL;

/*
Una vez que hemos modificado la tabla necesitamos
asignarle una dirección de correo electrónico de forma automática.
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
delimiter $$
create procedure crear_email(in nombre varchar(15),in apellido1 varchar(15),in apellido2 varchar(15),in dominio varchar(15),out email varchar(50))
begin
	set email = concat(left(nombre,1),left(apellido1,3),left(apellido2,3),'@',dominio);
end $$

/*
Ahora escriba un procedimiento que permita crear un email para todos los
alumnos que ya existen en la tabla. Para esto será necesario crear
un procedimiento llamado actualizar_columna_email que actualice la
columna email de la tabla alumnos. Este procedimiento hará uso del
procedimiento crear_email que hemos creado en el paso anterior.
*/
DROP procedure actualizar_columna_email;

delimiter $$
create procedure actualizar_columna_email(in dominio varchar(20))
begin
	DECLARE termina INT DEFAULT 0;
	DECLARE id INT;
	DECLARE nombre,apellido1,apellido2 VARCHAR(50);
	DECLARE email VARCHAR(150);
    
	DECLARE datos_alumnos CURSOR FOR
	SELECT alumnos.id,alumnos.nombre,alumnos.apellido1,alumnos.apellido2 FROM alumnos;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET termina= 1;

	OPEN datos_alumnos;
    
	bucle:LOOP
		FETCH datos_alumnos INTO id,nombre,apellido1,apellido2;
        
		IF termina= 1 THEN 
			LEAVE bucle;
		END IF;
        
		CALL crear_email(nombre,apellido1,apellido2,dominio,@email);
        
		UPDATE alumnos SET alumnos.email=@email WHERE alumnos.id=id;
        
	END LOOP;
    
	CLOSE datos_alumnos;
end$$

CALL actualizar_columna_email('gmail.com');

/*
OPCIONAL
Escribe un procedimiento llamado crear_lista_emails_alumnos que devuelva la lista de
emails de la tabla alumnos separados por un punto y coma.
Ejemplo: juan@iescelia.org;maria@iescelia.org;pepe@iescelia.org;lucia@iesceli
a.org.
*/
drop procedure crear_lista_emails_alumnos;

delimiter $$
create procedure crear_lista_emails_alumnos(out lista varchar (5000))
begin
	DECLARE termina INT DEFAULT 0;
	DECLARE email2 VARCHAR(100);
    declare puntocoma varchar (5) default ' ; ';
	DECLARE email_alumnos CURSOR FOR
	SELECT email FROM alumnos;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET termina= 1;
    set lista = '';
	OPEN email_alumnos;
    
	bucle:LOOP
		FETCH email_alumnos INTO email2;
        
		IF termina= 1 THEN 
			LEAVE bucle;
		END IF;
		
        set lista = concat(lista,' ; ',email2);
        
	END LOOP;
    
	CLOSE email_alumnos; 
end $$

delimiter ;

call crear_lista_emails_alumnos(@lista);
select @lista;

select * from alumnos;
