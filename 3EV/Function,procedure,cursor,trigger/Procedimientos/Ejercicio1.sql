create database empleados3;
use empleados3;

create table empleados(
  documento char(8),
  nombre varchar(20),
  apellido varchar(20),
  sueldo decimal(6,2),
  cantidadhijos int,
  seccion varchar(20),
  primary key(documento)
 );

--  Ingrese algunos registros:
 insert into empleados values('22222222','Juan','Perez',300,2,'Contaduria');
 insert into empleados values('22333333','Luis','Lopez',700,0,'Contaduria');
 insert into empleados values ('22444444','Marta','Perez',500,1,'Sistemas');
 insert into empleados values('22555555','Susana','Garcia',400,2,'Secretaria');
 insert into empleados values('22666666','Jose Maria','Morales',1200,3,'Secretaria');
 
/*Creamos un procedimiento que recibe un número de documento y un entero como parámetro de entrada y salida y nos devuelva la cantidad de hijos
que tenga ese empleado.*/
 
 drop procedure if exists cantidad_hijos;
 
 delimiter $$;
 create procedure cantidad_hijos(in documento2 varchar(15),out cantidad int)
 begin
	set cantidad = (select cantidadhijos from empleados where documento = documento2);
 end $$;
 delimiter ; 
 
 call cantidad_hijos('22333333',@cantidad);
 select @cantidad;
 