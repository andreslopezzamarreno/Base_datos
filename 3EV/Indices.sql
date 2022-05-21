/*1. Consulte cuáles son los índices que hay en la
tabla producto utilizando las instrucciones SQL que nos permiten
obtener esta información de la tabla.*/
show index from producto;

/*2. Haga uso de EXPLAIN para obtener información sobre cómo se están
realizando las consultas y diga cuál de las dos consultas realizará
menos comparaciones para encontrar el producto que estamos
buscando.*/
explain SELECT * FROM producto WHERE codigo_producto = 'OR-114'; -- 1 rows
explain SELECT * FROM producto WHERE nombre = 'Evonimus Pulchellus'; -- 276 rows

/*3. Suponga que estamos trabajando con la base de datos jardineria y
queremos saber optimizar las siguientes consultas. ¿Cuál de las
dos sería más eficiente?. Se recomienda hacer uso de EXPLAIN para
obtener información sobre cómo se están realizando las consultas.*/
explain SELECT AVG(total) FROM pago WHERE YEAR(fecha_pago) = 2008; -- 25 rows
explain SELECT AVG(total) FROM pago WHERE fecha_pago >= '2008-01-01' AND fecha_pago <= '2008-12-31'; -- 25 rows esta es mas optima

/*6. Crea un índice de tipo FULLTEXT sobre las
columnas nombre y descripcion de la tabla producto.*/
create fulltext index idx_nombre_descripcion on producto(nombre,descripcion);

/*7. Una vez creado el índice del ejercicio anterior realiza las siguientes
consultas haciendo uso de la función MATCH, para buscar todos los
productos que:*/
-- Contienen la palabra planta en el nombre o en la descripción.
SELECT * FROM producto WHERE MATCH(nombre, descripcion) AGAINST ('planta');
-- Contienen la palabra planta seguida de cualquier carácter o conjunto de caracteres, en el nombre o en la descripción.
SELECT * FROM producto WHERE MATCH(nombre, descripcion) AGAINST ('planta%');
-- Contienen la palabra tronco o la palabra árbol en el nombre o en la descripción.
SELECT * FROM producto WHERE MATCH(nombre,descripcion) AGAINST('arbol tronco' IN BOOLEAN MODE);
-- Contienen la palabra tronco y la palabra árbol en el nombre o en la descripción.
SELECT * FROM producto WHERE MATCH(nombre,descripcion) AGAINST('+tronco+arbol' IN BOOLEAN MODE);
-- Contiene la frase proviene de las costas en el nombre o en la descripción.
SELECT * FROM producto WHERE MATCH(nombre, descripcion) AGAINST ('proviene de las costas');

/*Crea un índice de tipo INDEX compuesto por las
columnas apellido_contacto y nombre_contacto de la tabla cliente.*/
CREATE INDEX idx_apellidoContacto_nombreContacto ON cliente(apellido_contacto,nombre_contacto);

/*9. Una vez creado el índice del ejercicio anterior realice las siguientes
consultas haciendo uso de EXPLAIN:*/
-- Busca el cliente Javier Villar. ¿Cuántas filas se han examinado hasta encontrar el resultado?
 explain select * from cliente where concat_ws(' ', nombre_contacto,apellido_contacto) like 'Javier Villar' ; -- 19 rows
-- Busca el cliente anterior utilizando solamente el apellido Villar. ¿Cuántas filas se han examinado hasta encontrar el resultado?
 explain select * from cliente where apellido_contacto like 'Villar';-- 1 rows
 /*Busca el cliente anterior utilizando solamente el nombre Javier. ¿Cuántas filas se han examinado hasta encontrar el resultado? ¿Qué ha ocurrido en este caso?*/
explain select * from cliente where nombre_contacto like 'Javier' ; -- 19 rows

/*10. Calcula cuál podría ser un buen valor para crear un índice sobre un
prefijo de la columna nombre_cliente de la tabla cliente. Tenga en cuenta
que un buen valor será aquel que nos permita utilizar el menor número
de caracteres para diferenciar todos los valores que existen en la
columna sobre la que estamos creando el índice.*/
/*En primer lugar calculamos cuántos valores distintos existen en la
columna nombre_cliente. Necesitarás utilizar la función COUNT y DISTINCT.*/
select distinct count(nombre_cliente) from cliente;
/*Haciendo uso de la función LEFT ve calculando el número de caracteres
que necesitas utilizar como prefijo para diferenciar todos los valores de
la columna. Necesitarás la función COUNT, DISTINCT y LEFT.*/
select distinct count(nombre_cliente) from cliente ;
