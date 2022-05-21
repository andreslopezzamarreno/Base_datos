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

-- base de datos jardineria

-- 1. Inserta una nueva oficina en Almería.
insert into oficina values ('ALM-ES','Almeria','España','Almeria','04001','642 057 393','c/mucha 69', 'c/poca 67');

-- 2. Inserta un empleado para la oficina de Almería que sea representante de ventas.
insert into empleado values (32,'alberto', 'iniesta', 'perez' ,'2444','adfadsf@gmail.com', 'ALM-ES', 1 , 'representante de ventas');

-- 3. Inserta un cliente que tenga como representante de ventas el empleado que hemos creado en el paso anterior.
insert into cliente values (39, 'fruterias paco', 'alvaro', 'lopez', '926124334',9364875887,'C/Peru 79',null,'boadilla','madrid','Spain',28660,32,8000);

-- 4. Actualiza el código del cliente que hemos creado en el paso anterior.
update cliente set codigo_cliente = 40 where codigo_cliente = 39;

-- 5. Borra el cliente y averigua si hubo cambios en las tablas relacionadas.
delete from cliente where codigo_cliente = 40;

-- 6. Elimina los clientes que no hayan realizado ningún pedido.
delete cliente from cliente left join pedido on cliente.codigo_cliente = pedido.codigo_cliente where pedido.codigo_cliente is null;

-- 7. Incrementa en un 20% el precio de los productos que no tengan pedidos.
update producto left join detalle_pedido on producto.codigo_producto = detalle_pedido.codigo_producto and detalle_pedido.codigo_producto is null 
set producto.precio_venta = (producto.precio_venta*1.2);

-- 8. Borra los pagos del cliente con menor límite de crédito.
delete pago from pago inner join cliente on cliente.codigo_cliente = pago.codigo_cliente where cliente.limite_credito = (select min(limite_credito) from cliente);

-- 9. (Pregunta TOP) Establece a 0 el límite de crédito del cliente que menos unidades pedidas tenga del producto 11679.


/*10. (Pregunta TOP) Modifica la tabla detalle_pedido para insertar un campo
numérico llamado iva. Mediante otra transacción, establece el valor de
ese campo a 18 para aquellos registros cuyo pedido tenga fecha a partir
de Enero de 2009.*/
