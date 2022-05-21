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



-- 1. Inserta un nuevo fabricante indicando su código y su nombre.
INSERT INTO fabricante VALUES(10, 'Apple');

-- 2. Inserta un nuevo fabricante indicando solamente su nombre.
INSERT INTO fabricante (nombre) values ('oppo');

/*3. Inserta un nuevo producto asociado a uno de los nuevos
fabricantes. La sentencia de inserción debe
incluir: código, nombre, precio y código_fabricante.*/
INSERT INTO producto VALUES(12, 'Iphone 13',1000, 10);


/*4. Crea una nueva tabla con el nombre fabricante_productos que tenga
las siguientes columnas: nombre_fabricante, nombre_producto y precio.
Una vez creada la tabla inserta todos los registros de la base de
datos tienda en esta tabla haciendo uso de única operación de
inserción. ( No hace falta crear fk)*/
drop table if exists fabricante_productos;
create table fabricante_productos (
	nombre_fabricante varchar(100),
    nombre_producto varchar(100),
    precio int
 ); 
 
 insert into fabricante_productos(nombre_fabricante,nombre_producto,precio) select fabricante.nombre, producto.nombre, producto.precio from fabricante, producto 
 where fabricante.codigo = producto.codigo_fabricante;

create table fabricante_productos select fabricante.nombre, producto.nombre as nombreProducto, producto.precio from fabricante, producto 
 where fabricante.codigo = producto.codigo_fabricante;

select * from fabricante_productos;
/*5. Elimina el fabricante Asus. ¿Es posible eliminarlo? Si no fuese
posible, ¿qué cambios debería realizar para que fuese posible
borrarlo?
 SET FOREIGN_KEY_CHECKS = 0;*/
SET FOREIGN_KEY_CHECKS = 0;
delete fabricante from fabricante where nombre like 'Asus'; 

/*6. Actualiza el precio de todos los productos sumándole 5 € al precio
actual.*/
update producto set precio = precio + 5; 

-- 7. Elimina todas las impresoras que tienen un precio menor de 200 €.
delete producto from producto where precio < 200 and nombre like 'Impresora%';

/* 8. Elimina al fabricante cuyo valor de sus productos es el menor. Es decir el
fabricante que la suma del precio de sus productos sea la menor.*/
delete fabricante from fabricante inner join (select fabricante.codigo, fabricante.nombre from producto,fabricante where producto.codigo_fabricante = fabricante.codigo 
group by codigo order by sum(producto.precio) limit 1) as tabla2 on fabricante.codigo = tabla2.codigo;
