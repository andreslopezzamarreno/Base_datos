drop database if exists vistasempleados;
create database vistasempleados;
use vistasempleados;

create table secciones(
  codigo int auto_increment primary key,
  nombre varchar(30),
  sueldo decimal(5,2)
 );

 create table empleados(
  legajo int primary key auto_increment,
  documento char(8),
  sexo char(1),
  apellido varchar(40),
  nombre varchar(30),
  domicilio varchar(30),
  seccion int not null,
  cantidadhijos int,
  estadocivil char(10),
  fechaingreso date
 );


 insert into secciones(nombre,sueldo) values('Administracion', 300);
 insert into secciones(nombre,sueldo) values('Contaduría', 400);
 insert into secciones(nombre,sueldo) values('Sistemas', 500);

 insert into empleados (documento,sexo,apellido,nombre,domicilio,seccion,cantidadhijos,estadocivil,fechaingreso)
   values ('22222222','f','Lopez','Ana','Colon 123',1,2,'casado','1990-10-10');
 insert into empleados (documento,sexo,apellido,nombre,domicilio,seccion,cantidadhijos,estadocivil,fechaingreso)   
   values('23333333','m','Lopez','Luis','Sucre 235',1,0,'soltero','1990-02-10');
 insert into empleados (documento,sexo,apellido,nombre,domicilio,seccion,cantidadhijos,estadocivil,fechaingreso)
   values('24444444','m','Garcia','Marcos','Sarmiento 1234',2,3,'divorciado','1998-07-12');
 insert into empleados (documento,sexo,apellido,nombre,domicilio,seccion,cantidadhijos,estadocivil,fechaingreso)
   values('25555555','m','Gomez','Pablo','Bulnes 321',3,2,'casado','1998-10-09');
 insert into empleados (documento,sexo,apellido,nombre,domicilio,seccion,cantidadhijos,estadocivil,fechaingreso)
   values('26666666','f','Perez','Laura','Peru 1254',3,3,'casado','2000-05-09');

-- 1. Eliminamos la vista "vista_empleados" si existe:
drop view if exists vista_empleados;

/*2. Creamos la vista  "vista_empleados", que es resultado de una
combinación en la cual se muestran 4 campos:
NOMBRE + APELLIDO,SEXO,SECCIÓN, CANTIDAD DE HIJOS*/
create view vista_empleados as
select concat_ws(' ',empleados.nombre,empleados.apellido) as nombreApellido, empleados.sexo, secciones.nombre,empleados.cantidadhijos 
from empleados, secciones where empleados.seccion = secciones.codigo;

-- 3. Vemos la información de la vista:
select nombreApellido, nombre, cantidadhijos from vista_empleados;

-- 4. Realizamos una consulta a la vista como si se tratara de una tabla:
select * from vista_empleados;

-- 5. Eliminamos la vista "vista_empleados_ingreso" si existe:
drop view if exists vista_empleados_ingreso;

/*6. Creamos otra vista de "empleados" denominada
"vista_empleados_ingreso" que almacena la cantidad de
empleados por año:*/
create view vista_empleados_ingreso as select year(fechaingreso) , count(documento) from empleados group by year(fechaingreso);

-- 7. Vemos la información que suministra la vista:
select * from vista_empleados_ingreso;
