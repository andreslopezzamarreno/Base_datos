create table ganadores (
	id int auto_increment primary key,
	nombre varchar (50),
	fecha date,
	cod_cliente int ,
	foreign key (cod_cliente) references cliente(codigo_cliente)
);

/*
Realizar un procedimiento llamado sorteo que reciba un parámetro de entrada con el
número de ganadores y los registre en la tabla ganadores.
Los clientes deben ser seleccionados aleatoriamente. El algoritmo del sorteo consiste
en generar un número aleatorio y quien tenga ese código será el afortunado.
Hay que tener en cuenta que el número aleatorio no puede ser mayor que el número de
registros que tiene la tabla cliente.
Podemos usar la función rand(). Ej: rand()*10+1 → Genera un número aleatorio entre los 10 primeros
números.
El procedimiento debe controlar al menos que si hay algún error debe mostrar un mensaje
“Error. Ha ocurrido un error. Vuelva a intentarlo.” y salga del procedimiento.
*/
-- SET GLOBAL FOREIGN_KEY_CHECKS=0;

-- drop procedure if exists sorteo;
-- truncate table ganadores;

delimiter $$
create procedure sorteo(in numGanadores int)
begin
	declare aleatorio int;
    declare numclientes int;
    declare cnt int;
    declare nombre_ganador varchar(50);
    declare id_anterior int;
    -- declare exit handler for sqlexception select 'Ha habido algun error. Vuelva a intentarlo';
    set cnt = 0;
    set numclientes = (select count(codigo_cliente) from cliente);
    set id_anterior = (select cod_cliente from ganadores order by id desc limit 1);
    while cnt < numGanadores do
		set aleatorio =  rand()*numclientes+1;
        /*
		OPCIONAL: +0,5 puntos si controlas en el procedimiento sorteo que el último cliente elegido de
		cada promoción no puede ser elegido en el sorteo vigente. Para ello deberá mostrar un control
		de errores personalizado que informe al usuario con el texto “ Abusón, no puedes ganar dos
		promociones seguidas!” SÓLO el último elegido de la promoción sorteada.
		*/
		IF aleatorio = id_anterior
			THEN SIGNAL SQLSTATE '45000'
			SET message_text = 'Abusón, no puedes ganar dos promociones seguidas!';
		else 
			set nombre_ganador = (select nombre_cliente from cliente where codigo_cliente = aleatorio);
			insert into ganadores (nombre, fecha, cod_cliente) values (nombre_ganador,now(),aleatorio);
		END IF;
        
		set cnt = cnt + 1;
    end while;
    
end $$

call sorteo(2);

-- select * from ganadores;

/*
Añade una columna llamada observaciones en la tabla cliente. A continuación crear un
trigger llamado trigger_insertar_observaciones que después de insertar un ganador,
inserte automáticamente a cada cliente, en la columna observaciones, el texto “Ha
ganado un premio en la fecha...”
*/
ALTER TABLE cliente ADD observaciones VARCHAR(300);

-- drop trigger if exists trigger_insertar_observaciones;

delimiter $$
create trigger trigger_insertar_observaciones
after insert 
on ganadores for each row
begin
	update cliente set observaciones = concat('Ha ganado un premio en la fecha ',now()) where codigo_cliente = new.cod_cliente;
end $$

select * from cliente;

/*
Crear un procedimiento llamado productos_ganados que almacene en un parámetro
de salida los productos que se van a otorgar a cada ganador.
Los productos que se van a otorgar a los ganadores serán los 3 productos más caros de
la tienda.
*/
-- drop procedure if exists productos_ganados;

delimiter $$ 
create procedure productos_ganados(out products varchar(1000))
begin
	DECLARE termina INT DEFAULT 0;
    declare nombre_producto varchar(50);
	DECLARE productos_ganados CURSOR FOR
	SELECT nombre from producto order by precio_venta desc limit 3;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET termina= 1;
    set products = '';
	OPEN productos_ganados;
	bucle:LOOP
		FETCH productos_ganados INTO nombre_producto;
		IF termina= 1 THEN 
			LEAVE bucle;
		END IF;
        set products = concat(products,' ; ',nombre_producto);
	END LOOP;
	CLOSE productos_ganados;
end $$

delimiter ;
call productos_ganados(@products);
select @products;
