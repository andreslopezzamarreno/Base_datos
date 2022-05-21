DROP DATABASE IF EXISTS empleados;
CREATE DATABASE empleados CHARACTER SET utf8mb4;
USE empleados;

CREATE TABLE departamento (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  presupuesto DOUBLE UNSIGNED NOT NULL,
  gastos DOUBLE UNSIGNED NOT NULL
);

CREATE TABLE empleado (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nif VARCHAR(9) NOT NULL UNIQUE,
  nombre VARCHAR(100) NOT NULL,
  apellido1 VARCHAR(100) NOT NULL,
  apellido2 VARCHAR(100),
  codigo_departamento INT UNSIGNED,
  FOREIGN KEY (codigo_departamento) REFERENCES departamento(codigo)
);

INSERT INTO departamento VALUES(1, 'Desarrollo', 120000, 6000);
INSERT INTO departamento VALUES(2, 'Sistemas', 150000, 21000);
INSERT INTO departamento VALUES(3, 'Recursos Humanos', 280000, 25000);
INSERT INTO departamento VALUES(4, 'Contabilidad', 110000, 3000);
INSERT INTO departamento VALUES(5, 'I+D', 375000, 380000);
INSERT INTO departamento VALUES(6, 'Proyectos', 0, 0);
INSERT INTO departamento VALUES(7, 'Publicidad', 0, 1000);

INSERT INTO empleado VALUES(1, '32481596F', 'Aarón', 'Rivero', 'Gómez', 1);
INSERT INTO empleado VALUES(2, 'Y5575632D', 'Adela', 'Salas', 'Díaz', 2);
INSERT INTO empleado VALUES(3, 'R6970642B', 'Adolfo', 'Rubio', 'Flores', 3);
INSERT INTO empleado VALUES(4, '77705545E', 'Adrián', 'Suárez', NULL, 4);
INSERT INTO empleado VALUES(5, '17087203C', 'Marcos', 'Loyola', 'Méndez', 5);
INSERT INTO empleado VALUES(6, '38382980M', 'María', 'Santana', 'Moreno', 1);
INSERT INTO empleado VALUES(7, '80576669X', 'Pilar', 'Ruiz', NULL, 2);
INSERT INTO empleado VALUES(8, '71651431Z', 'Pepe', 'Ruiz', 'Santana', 3);
INSERT INTO empleado VALUES(9, '56399183D', 'Juan', 'Gómez', 'López', 2);
INSERT INTO empleado VALUES(10, '46384486H', 'Diego','Flores', 'Salas', 5);
INSERT INTO empleado VALUES(11, '67389283A', 'Marta','Herrera', 'Gil', 1);
INSERT INTO empleado VALUES(12, '41234836R', 'Irene','Salas', 'Flores', NULL);
INSERT INTO empleado VALUES(13, '82635162B', 'Juan Antonio','Sáez', 'Guerrero', NULL);


/*Lista el código de los departamentos de los empleados que aparecen en la
tabla empleado, eliminando los códigos que aparecen repetidos.*/
Select distinct código_departamento from empleado;

/*Lista el código de los empleados junto al nif, pero el nif deberá aparecer en
dos columnas, una mostrará únicamente los dígitos del nif y la otra la letra.*/
select empleado.codigo, left(empleado.nif,8) as digitos, right(empleado.nif,1) as
letra from empleado order by empleado.codigo;

/*Lista el nombre de cada departamento y el valor del presupuesto actual del
que dispone. Para calcular este dato tendrá que restar al valor del
presupuesto inicial (columna presupuesto) los gastos que se han generado
(columna gastos). Tenga en cuenta que en algunos casos pueden existir
valores negativos. Utilice un alias apropiado para la nueva columna columna
que está calculando.*/
select departamento.nombre, departamento.presupuesto - gastos as
presupuesto_actual from departamento;

/*Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos que
tienen mayor presupuesto.*/
select departamento.nombre, departamento.presupuesto from departamento order by departamento.presupuesto desc limit 3;
-- tambien como
select nombre, presupuesto from departamento order by presupuesto desc limit 3;


/*Devuelve una lista con el nombre y el gasto, de los 2 departamentos que tienen
menor gasto.*/
select departamento.nombre, departamento.gastos from departamento order by gastos limit 2;


/*Devuelve una lista con el nombre de los departamentos y el gasto, de aquellos
que tienen menos de 5000 euros de gastos.*/
select nombre, gastos from departamento where gastos < 5000;


/*Devuelve una lista con el nombre de los departamentos que tienen un
presupuesto entre 100000 y 200000 euros. Utilizando el operador BETWEEN.*/
select departamento.nombre from departamento where
departamento.presupuesto between 100000 and 200000;

/*Devuelve una lista con el nombre de los departamentos, gastos y presupuesto,de aquellos departamentos donde los gastos sean mayores que el presupuesto del
que disponen.*/
select departamento.nombre, departamento.gastos, departamento.presupuesto
from departamento where departamento.gastos > departamento.presupuesto;

/*Devuelve una lista con el nombre de los departamentos, gastos y presupuesto,
de aquellos departamentos donde los gastos sean iguales al presupuesto del que
disponen.*/
select departamento.nombre, departamento.gastos, departamento.presupuesto
from departamento where departamento.gastos = departamento.presupuesto;

/*Lista todos los datos de los empleados cuyo segundo apellido sea NULL.*/
select * from empleado where apellido2 is null;

/*Lista todos los datos de los empleados cuyo segundo apellido sea Díaz o Moreno.
Sin utilizar el operador IN.*/

/*Lista todos los datos de los empleados cuyo segundo apellido sea Díaz  Moreno.
Utilizando el operador IN.*/

/*Devuelve un listado con el código y el nombre del departamento, solamente de
aquellos departamentos que tienen empleados.*/

/* Devuelve un listado con los datos de los empleados que trabajan en el
departamento de Sistemas, Contabilidad o I+D. Ordena el resultado alfabéticamente.*/
select * from empleado where codigo_departamento in(2,4,5);

/*Devuelve un listado donde sólo aparezcan aquellos empleados que no tienen
ningún departamento asociado.*/

/*Devuelve un listado con los empleados que no tienen ningún departamento
asociado y los departamentos que no tienen ningún empleado asociado. Ordene el
listado alfabéticamente por el nombre del departamento.*/

/*Calcula el nombre del departamento y el presupuesto que tiene asignado, del
departamento con menor presupuesto.*/

/* Devuelve el nombre del departamento con mayor presupuesto y la cantidad que
tiene asignada.*/


/*Devuelve los nombres de los departamentos que no tienen empleados
asociados.*/








-- El departamento con mayor presupuesto.
select nombre from departamento where presupuesto = (select max(presupuesto) from departamento);

/*Los nombres de los empleados que pertenezcan a departamentos donde su gasto
sea mayor a la media de gasto de todos departamentos.*/
select empleado.nombre from empleado, departamento where empleado.codigo_departamento = departamento.codigo 
and departamento.gastos > (select avg(gastos) from departamento);

/*Devuelve el nombre de los departamentos que tienen menos empleados que el
departamento de Desarrollo.*/
select departamento.nombre from departamento, empleado where empleado.codigo_departamento = departamento.codigo group by departamento.nombre 
having count(empleado.nombre) < (select count(empleado.nombre) from departamento, empleado 
where empleado.codigo_departamento = departamento.codigo and departamento.nombre like 'Desarrollo');

-- Selecciona los empleados que no tienen departamento (subconsulta con IN)
select * from empleado where empleado.codigo not in (select empleado.codigo from departamento inner join empleado 
on empleado.codigo_departamento = departamento.codigo); 

/*Devuelve los nombres de los departamentos que tienen empleados
asociados. (Utilizando IN o NOT IN).*/
select departamento.nombre from departamento where departamento.codigo in(select empleado.codigo_departamento from empleado,departamento 
where empleado.codigo_departamento = departamento.codigo);

/*Devuelve el nombre del departamento y el balance (presupuesto -
gastos) de todos aquellos que sean superiores a 114001.*/
select departamento.nombre, balancedepart.balance from departamento inner join (select departamento.codigo, presupuesto-gastos as balance from departamento 
where presupuesto- gastos >114001)as balancedepart on departamento.codigo = balancedepart.codigo;