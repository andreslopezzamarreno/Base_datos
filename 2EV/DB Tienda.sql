DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE tienda;

CREATE TABLE fabricante (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio DOUBLE NOT NULL,
  codigo_fabricante INT UNSIGNED NOT NULL,
  FOREIGN KEY (codigo_fabricante) REFERENCES fabricante(codigo)
);

INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');

INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

-- Lista el nombre de todos los productos que hay en la tabla producto.
select nombre from producto;

-- Lista los nombres y los precios de todos los productos de la tabla producto.
select nombre, precio from producto;

-- Lista todas las columnas de la tabla producto.
select * from producto;

-- Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD) con 2 decimales.
select nombre, precio, truncate(precio * 1.10, 2) from producto;

-- Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a mayúscula.
select upper(nombre), precio from producto;

-- Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a minúscula.
select lower(nombre), precio from producto;

-- Lista el nombre de todos los fabricantes en una columna, y en otra columna obtenga en mayúsculas los dos primeros caracteres del nombre del fabricante.
select nombre, left(nombre, 2 ) from fabricante;

-- Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.
select nombre, round(precio) from producto;

-- Lista los nombres y los precios de todos los productos de la tabla producto, truncando el valor del precio para mostrarlo sin ninguna cifra decimal.
select nombre, truncate(precio,0) from producto;

-- Lista el código de los fabricantes que tienen productos en la tabla producto.
select codigo_fabricante from producto;

-- Lista el código de los fabricantes que tienen productos en la tabla producto, eliminando los códigos que aparecen repetidos.
select distinct codigo_fabricante from producto;

-- Lista los nombres de los fabricantes ordenados de forma ascendente.
select nombre from fabricante order by nombre asc;

-- Lista los nombres de los fabricantes ordenados de forma descendente.
select nombre from fabricante order by nombre desc;

-- Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.
select nombre from producto order by nombre, precio desc;

-- Devuelve una lista con las 5 primeras filas de la tabla fabricante.
select * from fabricante limit 5;

-- Devuelve una lista con 2 filas a partir de la cuarta fila de la tabla fabricante. La cuarta fila también se debe incluir en la respuesta.
select * from fabricante limit 3,2;

-- Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)
select nombre, precio from producto order by precio limit 1;

-- Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)
select nombre, precio from producto order by precio desc limit 1;

-- Lista el nombre de todos los productos del fabricante cuyo código de fabricante es igual a 2.
select nombre from producto where codigo_fabricante = '2';

-- Lista el nombre de los productos que tienen un precio menor o igual a 120€.
select nombre from producto where precio <= 120;

-- Lista el nombre de los productos que tienen un precio mayor o igual a 400€.
select nombre from producto where precio >= 400;

-- Lista el nombre de los productos que no tienen un precio mayor o igual a 400€.
select nombre from producto where precio < 400;

-- Lista todos los productos que tengan un precio entre 80€ y 300€. Sin utilizar el operador BETWEEN.
select nombre from producto where precio>80 and precio<300;

-- Lista todos los productos que tengan un precio entre 60€ y 200€. Utilizando el operador BETWEEN.
select nombre from producto where precio between 60 and 200;

-- Lista todos los productos que tengan un precio mayor que 200€ y que el código de fabricante sea igual a 6.
select * from producto where precio >200 and codigo_fabricante = 6;

-- Lista todos los productos donde el código de fabricante sea 1, 3 o 5 Sin utilizar el operador IN.
select * from producto where codigo_fabricante = 1 or codigo_fabricante = 3 or codigo_fabricante = 5;

-- Lista todos los productos donde el código de fabricante sea 1, 3 o 5 Utilizando el operador IN.
select * from producto where codigo_fabricante in(1,3,5);

-- Lista el nombre y el precio de los productos en céntimos (Habrá que multiplicar por 100 el valor del precio). Cree un alias para la columna que contiene el precio que se llame céntimos.
select nombre, (precio*100) as centimos from producto;

-- Lista los nombres de los fabricantes cuyo nombre empiece por la letra S.
select nombre from fabricante where nombre like 's%';

-- Lista los nombres de los fabricantes cuyo nombre termine por la vocal e.
select nombre from fabricante where nombre like '%e';

-- Lista los nombres de los fabricantes cuyo nombre contenga el carácter w.
select nombre from fabricante where nombre like '%w%';

-- Lista los nombres de los fabricantes cuyo nombre sea de 4 caracteres.
select nombre from fabricante where nombre like '____'; 

-- Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.
select nombre from producto where nombre like '%Portatil%';

-- Devuelve una lista con el nombre de todos los productos que contienen la cadena Monitor en el nombre y tienen un precio inferior a 215 €
select nombre from producto where nombre like '%Monitor%' and precio < 215;

/*Lista el nombre y el precio de todos los productos que tengan un precio mayor o igual a 180€. Ordene el resultado en primer lugar
por el precio (en orden descendente) y en segundo lugar por el
nombre (en orden ascendente).*/

select nombre, precio from producto where precio >= 180 order by precio desc, nombre;

-- Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.
select producto.nombre, producto.nombre, fabricante.nombre from producto, fabricante where fabricante.codigo = producto.codigo_fabricante ;

-- Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. Ordene el resultado por el nombre del fabricante, por orden alfabético.
select producto.nombre, producto.precio, fabricante.nombre from producto, fabricante where fabricante.codigo = producto.codigo_fabricante order by fabricante.nombre;

-- Devuelve una lista con el código del producto, nombre del producto, código del fabricante y nombre del fabricante, de todos los productos de la base de datos.
select producto.codigo,producto.nombre,fabricante.codigo,fabricante.nombre from producto, fabricante where fabricante.codigo = producto.codigo_fabricante ;

-- Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.
select producto.nombre, producto.precio,fabricante.nombre from producto,fabricante where producto.codigo_fabricante = fabricante.codigo order by producto.precio desc limit 5;
-- o tambien vale
select producto.nombre, max(producto.precio),fabricante.nombre from producto, fabricante where fabricante.codigo = producto.codigo_fabricante ;

-- Devuelve una lista de todos los productos del fabricante Lenovo.
select * from producto inner join fabricante on producto.codigo_fabricante = fabricante.codigo where fabricante.nombre like 'Lenovo';
-- o tambien vale
select producto.*, fabricante.nombre from producto,fabricante where fabricante.codigo = producto.codigo_fabricante and codigo_fabricante = (select codigo from fabricante where upper(nombre) like 'LENOVO');

-- Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200€.
select producto.*, fabricante.nombre from producto, fabricante where fabricante.codigo = producto.codigo_fabricante and fabricante.nombre like 'Crucial' and producto.precio >200;

-- Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate. Sin utilizar el operador IN.
select producto.*, fabricante.nombre from producto, fabricante where fabricante.codigo = producto.codigo_fabricante and (fabricante.nombre like 'Asus' or fabricante.nombre like 'Hewlett-Packard'or fabricante.nombre like 'Seagate');
-- o tambien vale
select * from producto inner join fabricante on producto.codigo_fabricante = fabricante.codigo where fabricante.nombre like 'Asus' or fabricante.nombre like 'Hewlett-Packard'or fabricante.nombre like 'Seagate';

-- Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. Utilizando el operador IN.
select producto.*, fabricante.nombre from producto, fabricante where fabricante.codigo = producto.codigo_fabricante and fabricante.nombre in('Asus','Hewlett-Packard','Seagate');

-- Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre termine por la vocal e.
select producto.nombre, producto.precio from producto,fabricante where fabricante.codigo = producto.codigo_fabricante and producto.nombre like '%e';

-- Devuelve un listado con el nombre y el precio de todos los productos cuyo nombre de fabricante contenga el carácter w en su nombre.
select producto.nombre, producto.precio from producto, fabricante where fabricante.codigo = producto.codigo_fabricante and fabricante.nombre like '%W%';

/*Devuelve un listado con el nombre de producto, precio y nombre de
fabricante, de todos los productos que tengan un precio mayor o
igual a 180€. Ordene el resultado en primer lugar por el precio (en
orden descendente) y en segundo lugar por el nombre (en orden
ascendente)*/
select producto.nombre, producto.precio, fabricante.nombre from producto, fabricante where producto.codigo_fabricante= fabricante.codigo and producto.precio>= 180 order by producto.precio desc,producto.nombre;

/*Devuelve un listado con el código y el nombre de fabricante,
solamente de aquellos fabricantes que tienen productos asociados
en la base de datos.*/
select fabricante.codigo, fabricante.nombre from fabricante, producto where fabricante.codigo = producto.codigo_fabricante;
-- o tambien vale
select fabricante.codigo, fabricante.nombre from fabricante inner join producto on producto.codigo_fabricante = fabricante.codigo;

/*Devuelve un listado de todos los fabricantes que existen en la base
de datos, junto con los productos que tiene cada uno de ellos. El
listado deberá mostrar también aquellos fabricantes que no tienen
productos asociados.*/
select * from fabricante left join producto on fabricante.codigo= producto.codigo_fabricante union select * from producto right join fabricante on fabricante.codigo= producto.codigo_fabricante;

-- Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
select * from fabricante left join producto on fabricante.codigo = producto.codigo_fabricante where producto.codigo_fabricante is null;

-- Calcula la media del precio de todos los productos.
select avg(precio) from producto group by producto.nombre ;
-- tambien vale 
select producto.codigo,avg(producto.precio) as media from producto group by producto.codigo;

--  Calcula el número de valores distintos de código de fabricante aparecen en la tabla productos.
select count(distinct producto.codigo_fabricante) from producto;

-- Calcula la suma de los precios de todos los productos.
select sum(distinct producto.precio) from producto;

-- Calcula el número de productos que tiene el fabricante Asus.
select count(producto.nombre) from fabricante, producto where fabricante.codigo= producto.codigo_fabricante and fabricante.nombre like 'Asus';
-- o tambien vale 
select count(distinct producto.nombre) from producto inner join fabricante on producto.codigo_fabricante = fabricante.codigo where fabricante.nombre = 'Asus';

/*Muestra el precio máximo, precio mínimo, precio medio y el número
total de productos que tiene el fabricante Crucial.*/
select max(precio),min(precio), avg(precio) from producto, fabricante where producto.codigo_fabricante = fabricante.codigo and fabricante.nombre like 'Crucial';

/*Muestra el precio máximo, precio mínimo y precio medio de los
productos de cada uno de los fabricantes. El resultado mostrará el
nombre del fabricante junto con los datos que se solicitan.*/
select fabricante.nombre,max(precio),min(precio), avg(precio) from producto, fabricante where producto.codigo_fabricante = fabricante.codigo group by fabricante.nombre ;

/* Muestra el precio máximo, precio mínimo, precio medio y el número
total de productos de los fabricantes que tienen un precio medio
superior a 200€. No es necesario mostrar el nombre del fabricante,
con el código del fabricante es suficiente.*/
select fabricante.nombre,max(precio),min(precio), avg(precio),count(producto.codigo) from producto, fabricante where producto.codigo_fabricante = fabricante.codigo group by fabricante.nombre having avg(producto.precio)>=200;

-- Devuelve un listado con los nombres de los fabricantes que tienen 2 o más productos.
select fabricante.nombre, count(producto.codigo) from fabricante, producto where producto.codigo_fabricante = fabricante.codigo group by nombre having count(producto.codigo) >= 2;

/*Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene cada uno con un precio superior o igual a 220 €.
 No es necesario mostrar el nombre de los fabricantes que no tienen productos que cumplan la condición.*/
select fabricante.nombre, count(producto.codigo) from fabricante,producto where producto.codigo_fabricante = fabricante.codigo and producto.precio >=220 group by fabricante.nombre; 

-- Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.
select producto.nombre, producto.precio from fabricante,producto where producto.codigo_fabricante = fabricante.codigo and fabricante.nombre like 'Asus' having producto.precio > (select avg(producto.precio) from producto,fabricante) ;
select producto.nombre, producto.precio from fabricante, producto
where fabricante.codigo =producto.codigo_fabricante and
fabricante.nombre like 'Asus' HAVING producto.precio >= (select avg(producto.precio) from
producto,fabricante where fabricante.codigo =producto.codigo_fabricante and
fabricante.nombre like 'Asus');

-- Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos los productos de la base de datos.
select producto.nombre, producto.precio from fabricante, producto where fabricante.codigo = producto.codigo_fabricante and
fabricante.nombre like 'Asus' HAVING producto.precio >= AVG(producto.precio);