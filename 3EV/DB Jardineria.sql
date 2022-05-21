drop database libreria;
create database libreria;
use libreria;
 create table libros(
  codigo int unsigned auto_increment,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(20),
  precio decimal(5,2) unsigned,
  primary key(codigo)
 );

 create table editoriales(
 id int not null auto_increment primary key,
  nombre varchar(20)
 );

 insert into libros values (1,'El aleph','Borges','Emece',23.5);
 insert into libros values (2,'Alicia en el pais de las maravillas',
                            'Lewis Carroll','Planeta',15);
 insert into libros values (3,'Matematica estas ahi','Paenza','Emece',34.6);
 insert into libros values (4,'Martin Fierro','Jose Hernandez','Paidos',43.5);
 insert into libros values (5,'Martin Fierro','Jose Hernandez','Planeta',12);
 insert into libros values (6,'Aprenda PHP','Mario Molina','Paidos',21.8);
 insert into libros values (7,'Aprenda Java','Mario Molina','Paidos',55.4);
 insert into libros values (8,'Alicia a traves del espejo','Lewis Carroll','Emece',18);
 insert into libros values (9,'Antologia poetica','Borges','Paidos',47.9);
 
-- Crear una tabla llamada “cantidadporeditorial” que contenga los campos nombres y cantidad.
set @@AUTOCOMMIT = 0;
create table cantidadporeditorial(
nombre varchar(100) primary key,
cantidad int
);

-- Insertamos registros en esta tabla realizando una consulta.
insert into cantidadporeditorial(nombre,cantidad) select editorial,count(codigo) from libros group by editorial;

-- Crear un nuevo campo en esa tabla que se llame “valorlibros”
alter table cantidadporeditorial add valorlibros int not null;

-- Actualizamos los valores de ese campo a través de una consulta/s.
update cantidadporeditorial set valorlibros = (select sum(precio) from libros 
where libros.editorial = cantidadporeditorial.nombre);

select* from cantidadporeditorial;