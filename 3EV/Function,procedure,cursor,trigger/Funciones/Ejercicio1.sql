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


SET GLOBAL log_bin_trust_function_creators = 1;


/*
1. Escribe una función para la base de datos tienda que devuelva el
número total de productos que hay en la tienda
*/
drop function numproductos;

delimiter $$
create function numproductos()returns int
begin 
	declare numero_productos int;
    set numero_productos = (select count(codigo) from producto);
    return numero_productos;
end $$
delimiter ;

select numproductos();

/*
2. Escribe una función para la base de datos tienda que devuelva el valor
medio del precio de los productos de un determinado fabricante que se
recibirá como parámetro de entrada. El parámetro de entrada será el
nombre del fabricante.
*/
drop function mediaFabricante;

delimiter $$
create function mediaFabricante(fabricante varchar(50))returns float
begin 
	declare media float;
    set media = (select avg(producto.precio) from producto,fabricante where producto.codigo_fabricante = fabricante.codigo and fabricante.nombre like fabricante);
    return media;    
end $$
delimiter ;

select mediaFabricante('asus');

/*
3. Escribe una función para la base de datos tienda que devuelva el valor
máximo del precio de los productos de un determinado fabricante que se
recibirá como parámetro de entrada. El parámetro de entrada será el
nombre del fabricante.
*/
drop function maxfabricante;

delimiter $$
create function maxfabricante(fabricante varchar(50))returns float
begin
	declare maximo float;
    set maximo = (select max(producto.precio) from fabricante,producto where fabricante.codigo = producto.codigo_fabricante and fabricante.nombre like fabricante);
    return maximo;
end$$
delimiter ;

select maxfabricante('asus');

/*
4. Escribe una función para la base de datos tienda que devuelva el valor
mínimo del precio de los productos de un determinado fabricante que se
recibirá como parámetro de entrada. El parámetro de entrada será el
nombre del fabricante.
*/
drop function minfabricante;

delimiter $$
create function minfabricante(fabricante varchar(50))returns float
begin
	declare minimo float;
    set minimo = (select min(producto.precio) from fabricante,producto where fabricante.codigo = producto.codigo_fabricante and fabricante.nombre like fabricante);
    return minimo;
end$$
delimiter ;

select minfabricante('asus');