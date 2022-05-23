/*
1. Crea una base de datos llamada cine que contenga dos tablas con las
siguientes columnas.
Tabla cuentas:
 id_cuenta: entero sin signo (clave primaria).
 saldo: real sin signo.
Tabla entradas:
 id_butaca: entero sin signo (clave primaria).
 nif: cadena de 9 caracteres.
*/
drop database cine;
create database cine;
use cine;

CREATE TABLE cuentas (
id_cuenta INTEGER UNSIGNED PRIMARY KEY,
saldo DECIMAL(11,2) UNSIGNED CHECK (saldo >= 0)
);

CREATE TABLE entradas (
id_butaca INTEGER UNSIGNED PRIMARY KEY,
nif VARCHAR(9)
);
INSERT INTO cuentas VALUES(1, 20);
INSERT INTO cuentas VALUES(2, 10);

-- Solución 1: Con DECLARE CONTINUE HANDLER ...
DELIMITER $$
DROP PROCEDURE IF EXISTS comprar_entrada$$
CREATE PROCEDURE comprar_entrada(IN nif VARCHAR(9),
IN id_cuenta INT UNSIGNED,
IN id_butaca INT UNSIGNED,
OUT error TINYINT UNSIGNED)
BEGIN
	DECLARE CONTINUE HANDLER FOR 1264, 1062
	BEGIN
		SET error = 1;
	END;
-- Inicio la transacción
	START TRANSACTION;
	SET error = 0;
-- Cobramos la entrada
	UPDATE cuentas SET saldo = saldo - 5 WHERE cuentas.id_cuenta = id_cuenta;
-- Reservo la butaca
	INSERT INTO entradas VALUES (id_butaca, nif);
-- Compruebo si ha ocurrido algún error
	IF error = 0 THEN
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
END $$

CALL comprar_entrada('11111111A', 1, 10, @error);
CALL comprar_entrada('11111111A', 1, 11, @error);
CALL comprar_entrada('11111111A', 1, 12, @error);
CALL comprar_entrada('11111111A', 1, 13, @error);
CALL comprar_entrada('11111111A', 1, 14, @error);
CALL comprar_entrada('22222222B', 2, 10, @error);
SELECT @error;
SELECT * FROM cuentas;
SELECT * FROM entradas;