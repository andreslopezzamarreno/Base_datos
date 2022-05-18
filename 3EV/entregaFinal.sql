-- Entrega final de base de datos de Andrés López Zamarreño

drop database entregafinal;
create database if not exists entregaFinal;
use entregaFinal;

-- Creacion de tablas

create table if not exists tipo(
	id int auto_increment primary key not null,
	tipo varchar(10) not null
);

create table if not exists novios(
	id int auto_increment primary key not null,
    nombre varchar(20) not null not null,
    apellido varchar(20) not null,
    fecha_nacimiento date not null,
    sexo enum('H','M') not null,
    inicio_novios date not null
);

create table if not exists miembro_familia (
	id int auto_increment primary key not null,
	nombre varchar(30) not null,
	apellido varchar(30) not null,
    tipo int not null,
    fecha_nacimiento date not null,
    sexo enum('H','M') not null,
    id_novio int,
	FOREIGN KEY (tipo) REFERENCES tipo(id),
	FOREIGN KEY (id_novio) REFERENCES novios(id)
);

create table if not exists estudios(
	id int auto_increment primary key not null,
    nombre varchar(100) not null,
    años int 
);

 create table if not exists estudios_miembro(
	id_estudio int not null,
	id_miembro int not null,
	terminado boolean not null,
	años_tardados int,
	lugar varchar(50) not null,
	primary key(id_estudio, id_miembro),
	FOREIGN KEY (id_estudio) REFERENCES estudios(id),
	FOREIGN KEY (id_miembro) REFERENCES miembro_familia(id)
 );

create table if not exists relaciones(
	miembro varchar(30) not null,
    id_miembro int not null,
    novio varchar(30) not null,
	id_novio int primary key not null,
    tiempo varchar(100) not null,
    FOREIGN KEY (id_novio) REFERENCES novios(id),
    FOREIGN KEY (id_miembro) REFERENCES miembro_familia(id)
);

-- insercion de datos

insert into tipo(tipo) values("padre");
insert into tipo(tipo) values("madre");
insert into tipo(tipo) values("hijo");
insert into tipo(tipo) values("hija");

insert into novios (nombre,apellido,fecha_nacimiento,sexo,inicio_novios) values ("Marcos","Carrascal", '1996/01/19','H','2021/08/14');
insert into novios (nombre,apellido,fecha_nacimiento,sexo,inicio_novios) values ("Borja","Sanz", '1995/08/14','H','2021/11/24');
insert into novios (nombre,apellido,fecha_nacimiento,sexo,inicio_novios) values ("Ester","Sanz", '2006/12/08','M','2021/03/31');
insert into novios (nombre,apellido,fecha_nacimiento,sexo,inicio_novios) values ("Lucia","Pérez", '2007/02/04','M','2022/05/05');

insert into miembro_familia (nombre,apellido,tipo,fecha_nacimiento,sexo,id_novio) values("Ramon","Lopez",1,'1966/02/11','H',null);
insert into miembro_familia (nombre,apellido,tipo,fecha_nacimiento,sexo,id_novio) values("Marta","Zamarreño",2,'1966/05/03','M',null);
insert into miembro_familia (nombre,apellido,tipo,fecha_nacimiento,sexo,id_novio) values("Celia","Lopez",4,'1965/07/06','M',1);
insert into miembro_familia (nombre,apellido,tipo,fecha_nacimiento,sexo,id_novio) values("Sofia","Lopez",4,'1996/10/11','M',2);
insert into miembro_familia (nombre,apellido,tipo,fecha_nacimiento,sexo,id_novio) values("Arturo","Lopez",3,'1999/02/25','H',null);
insert into miembro_familia (nombre,apellido,tipo,fecha_nacimiento,sexo,id_novio) values("Andres","Lopez",3,'2001/01/23','H',null);
insert into miembro_familia (nombre,apellido,tipo,fecha_nacimiento,sexo,id_novio) values("Isabel","Lopez",4,'2003/11/24','M',null);
insert into miembro_familia (nombre,apellido,tipo,fecha_nacimiento,sexo,id_novio) values("Jose","Lopez",3,'2005/06/01','H',3);
insert into miembro_familia (nombre,apellido,tipo,fecha_nacimiento,sexo,id_novio) values("Francisco","Lopez",3,'2007/08/31','H',4);

insert into estudios (nombre,años)values ("EGB",8);
insert into estudios (nombre,años)values ("BUP",3);
insert into estudios (nombre,años)values ("COU",1);
insert into estudios (nombre,años)values ("Guarderia",3);
insert into estudios (nombre,años)values ("Infantil",3);
insert into estudios (nombre,años)values ("Primaria",6);
insert into estudios (nombre,años)values ("ESO",4);
insert into estudios (nombre,años)values ("Bachillerato",2);
insert into estudios (nombre,años)values ("Ingeria de telecomunicaciones",6);
insert into estudios (nombre,años)values ("Veterinaia",5);
insert into estudios (nombre,años)values ("Filologia inglesa",4);
insert into estudios (nombre,años)values ("Derecho",4);
insert into estudios (nombre,años)values ("DAM",2);
insert into estudios (nombre,años)values ("Enfermeria",5);
insert into estudios (nombre,años)values ("Master acceso abogacía",null);
insert into estudios (nombre,años)values ("Oposicion ayudante instituciones penitenciarias",null);
insert into estudios (nombre,años)values ("Oposicion profesor ingles secundaria",null);
insert into estudios_miembro values (1,1,true,6,"Madrid,Madrid");
insert into estudios_miembro values (2,1,true,4,"Madrid,Madrid");
insert into estudios_miembro values (3,1,true,2,"Madrid,Madrid");
insert into estudios_miembro values (9,1,true,6,"Madrid,Madrid");
insert into estudios_miembro values (1,2,true,6,"Valverde del camino,Huelva");
insert into estudios_miembro values (2,2,true,4,"Majadahonda,Madrid");
insert into estudios_miembro values (3,2,true,2,"Majadahonda,Madrid");
insert into estudios_miembro values (10,2,true,6,"Madrid,Madrid");
insert into estudios_miembro values (4,3,true,3,"Alcorcon,Madrid");
insert into estudios_miembro values (5,3,true,3,"Alcorcon,Madrid");
insert into estudios_miembro values (6,3,true,6,"Boadilla del monte,Madrid");
insert into estudios_miembro values (7,3,true,4,"Alcorcon,Madrid");
insert into estudios_miembro values (8,3,true,2,"Alcorcón,Madrid");
insert into estudios_miembro values (11,3,true,4,"Madrid,Madrid");
insert into estudios_miembro values (17,3,false,1,"Madrid");
insert into estudios_miembro values (4,4,true,3,"Alcorcon,Madrid");
insert into estudios_miembro values (5,4,true,3,"Alcorcon,Madrid");
insert into estudios_miembro values (6,4,true,6,"Boadilla del monte,Madrid");
insert into estudios_miembro values (7,4,true,4,"Alcorcon,Madrid");
insert into estudios_miembro values (8,4,true,2,"Alcorcón,Madrid");
insert into estudios_miembro values (12,4,true,5,"Mostoles,Madrid");
insert into estudios_miembro values (15,4,false,1,"Madrid");
insert into estudios_miembro values (16,4,false,1,"Madrid");
insert into estudios_miembro values (5,5,true,3,"Boadilla del monte,Madrid");
insert into estudios_miembro values (6,5,true,6,"Boadilla del monte,Madrid");
insert into estudios_miembro values (7,5,true,4,"Alcorcon,Madrid");
insert into estudios_miembro values (8,5,true,3,"Alcorcón,Madrid");
insert into estudios_miembro values (13,5,true,2,"Alcorcón,Madrid");
insert into estudios_miembro values (4,6,true,3,"Boadilla del monte,Madrid");
insert into estudios_miembro values (5,6,true,3,"Boadilla del monte,Madrid");
insert into estudios_miembro values (6,6,true,6,"Alcorcón,Madrid");
insert into estudios_miembro values (7,6,true,4,"Alcorcón,Madrid");
insert into estudios_miembro values (8,6,true,2,"Alcorcón,Madrid");
insert into estudios_miembro values (13,6,false,1,"Alcorcón,Madrid");
insert into estudios_miembro values (4,7,true,3,"Boadilla del monte,Madrid");
insert into estudios_miembro values (5,7,true,3,"Boadilla del monte,Madrid");
insert into estudios_miembro values (6,7,true,6,"Alcorcón,Madrid");
insert into estudios_miembro values (7,7,true,4,"Alcorcón,Madrid");
insert into estudios_miembro values (8,7,true,2,"Alcorcón,Madrid");
insert into estudios_miembro values (14,7,false,1,"Pozuelo,Madrid");
insert into estudios_miembro values (4,8,true,3,"Boadilla del monte,Madrid");
insert into estudios_miembro values (5,8,true,3,"Alcorcón,Madrid");
insert into estudios_miembro values (6,8,true,6,"Alcorcón,Madrid");
insert into estudios_miembro values (7,8,true,4,"Alcorcón,Madrid");
insert into estudios_miembro values (8,8,false,1,"Alcorcón,Madrid");
insert into estudios_miembro values (5,9,true,3,"Alcorcón,Madrid");
insert into estudios_miembro values (6,9,true,6,"Alcorcón,Madrid");
insert into estudios_miembro values (7,9,false,3,"Alcorcón,Madrid");
/*
-- creacion de tabla que contenga informacion de otras tablas,insercion de datos a traves de consulta. Luego borrarla

-- Tabla de que esta estudiando actualmente cada miembro y donde 

create table estudioActual as
select miembro_familia.id as id_miembro,miembro_familia.nombre as nombre, estudios.nombre as nstudio,estudios_miembro.lugar as lugar 
from miembro_familia inner join estudios_miembro on miembro_familia.id = estudios_miembro.id_miembro
inner join estudios on estudios_miembro.id_estudio = estudios.id where estudios_miembro.terminado = false;

select * from estudioActual;
drop table estudioActual;

-- creacion de dos vistas

-- vista de cuantos estudios "avanzados" (a partir de bachillerato) tiene cada miembro de la familia

create view numeroTitulos as
select miembro_familia.nombre as miembro, count(estudios_miembro.id_estudio) as numTitulos
from miembro_familia inner join estudios_miembro on miembro_familia.id = estudios_miembro.id_miembro
where estudios_miembro.id_estudio = 3 or estudios_miembro.id_estudio >7 and estudios_miembro.terminado = true group by estudios_miembro.id_miembro; 

select * from numerotitulos;

-- vista de cantidad de cada tipo de miembro hay: padre, madre, hijo, hija

create view cantidadTipo as
select tipo.tipo , count(miembro_familia.id) as cantidad 
from tipo inner join miembro_familia on tipo.id = miembro_familia.tipo group by miembro_familia.tipo;

select * from cantidadTipo;

-- insercion de indices

CREATE FULLTEXT INDEX nombre_apellido ON miembro_familia(nombre,
apellido);

-- insercion de roles y privilegios

create role if not exists 'administrador','padre','hijo';
grant all on entregafinal.* to 'administrador';
grant select, insert, delete on entregafinal.* to 'padre';
grant select on entregafinal.* to 'hijo';
create user 'hijos'@'localhost' identified by 'admin';
create user 'padres'@'localhost' identified by 'admin';
grant 'hijo' to 'hijos'@'localhost';
grant 'padre' to 'padres'@'localhost';

-- función y procedimiento
SET GLOBAL log_bin_trust_function_creators = 1;
-- calculo de cuanto llevan las relaciones dentro de la familia 

DELIMITER $$
CREATE FUNCTION tiempoRelacion(fecha date) RETURNS varchar(200)
BEGIN
declare diferencia float;
declare dias float;
declare dias2 int;
declare meses int;
declare años float;
declare años2 int;
declare meses2 float;
declare meses3 int;
set diferencia = datediff(now(),fecha);
set diferencia = diferencia/30.44;
set meses = floor(diferencia);
set dias = diferencia-meses;
set dias2 = 30.44 * dias;
set años = meses/12;
set años2 = floor(años);
set meses2 = años - años2;
set meses3 = 12 * meses2;
RETURN (concat(años2," año(s) ",meses3," mes(es) ",dias2," dia(s)"));
END $$
DELIMITER ;

-- procedimiento

 delimiter $$
 create procedure actualizarRelaciones()
 begin
	truncate table relaciones;
	insert into relaciones select miembro_familia.nombre,miembro_familia.id, novios.nombre,novios.id,tiempoRelacion(novios.inicio_novios) 
    from miembro_familia inner join novios on miembro_familia.id_novio = novios.id;
 end
 $$
 delimiter ;

call actualizarRelaciones;
select * from relaciones;
*/