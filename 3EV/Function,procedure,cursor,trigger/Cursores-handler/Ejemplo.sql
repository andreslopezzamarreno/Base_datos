# Selecciona nombre de una gama y los inserta en la tabla nombres
use jardineria;

create table nombres (
id int AUTO_INCREMENT primary key,
nombre varchar ( 100)
);

delimiter $$
create procedure producto (in param_gama varchar (50))
begin
	declare valor varchar (100);
	declare hecho int default 0;
	# declarar cursor
	declare productos_gama_cursor CURSOR FOR
	select nombre from producto where gama = param_gama;

# Manejar el handler
	declare continue handler for not found set hecho = 1;

# abrir cursor
	open productos_gama_cursor;

	bucle:LOOP
		fetch productos_gama_cursor into valor;
        
		if hecho = 1 then
			leave bucle;
		end if;
        
		insert into nombres (nombre) values (valor);
	end loop bucle;

	close productos_gama_cursor;
end $$

call producto ('Frutales');

select * from nombres;