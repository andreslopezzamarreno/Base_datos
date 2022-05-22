/*
1. Escribe un procedimiento que no tenga ningún parámetro de entrada ni
de salida y que muestre el texto ¡Hola mundo!.
*/

drop procedure helloWorld;

delimiter $$;
create procedure helloWorld()
begin
	declare texto varchar(30);
	set texto = '¡hola mundo!';
    select texto;
end $$;
delimiter $$;

call helloWorld();


/*2. Escribe un procedimiento que reciba un número real de entrada y
muestre un mensaje indicando si el número es positivo, negativo o cero.
*/
drop procedure signonumero;

delimiter $$
create procedure signonumero(in parametro int,out texto varchar(30))
begin    
	if parametro > 0 then
		set texto = 'El numero es positivo';
	elseif parametro < 0 then
		set texto = 'El numero es negativo';
	else 
		set texto = 'El numero es 0';
	end if;
end $$

delimiter $$
call signonumero(-2,@texto);
select @texto;

/*
3. Escribe un procedimiento que reciba como parámetro de entrada un
valor numérico que represente un día de la semana y que devuelva una
cadena de caracteres con el nombre del día de la semana
correspondiente. Por ejemplo, para el valor de entrada 1 debería
devolver la cadena lunes.
*/
drop procedure diasemana;

delimiter $$
create procedure diasemana (in valor int, out texto varchar(40))
begin
	if valor = 1 then
    set texto = 'Lunes';
    
    elseif valor = 2 then
    set texto = 'Martes';
    
    elseif valor = 3 then
    set texto = 'Miercoles';
    
    elseif valor = 4 then
    set texto = 'Jueves';
    
    elseif valor = 5 then
    set texto = 'Viernes';
    
    elseif valor = 6 then
    set texto = 'Sabado';
    
    elseif valor = 7 then
    set texto = 'Domingo';
    
    else 
    set texto = 'El numero no coincide';
    end if;
end  $$

delimiter $$
call diasemana(9,@texto);
select @texto;
