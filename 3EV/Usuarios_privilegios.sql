-- 1. Crear un usuario llamado userdam con contraseña ‘admin’.
create user 'userdam'@'localhost' identified by 'admin';

-- 2.Acceder desde su cuenta y ver qué pasa


-- 3.Le otorgamos TODOS los permisos SOLAMENTE en la base de datos librería.
grant all privileges on libreria.* to 'userdam'@'localhost';

-- 4.Le otorgamos permisos de CONSULTA, INSERCIÓN Y MODIFICACIÓN a la tabla PERSONA de la base de datos UNIVERSIDAD.
grant select,insert,update on universidad.persona to 'userdam'@'localhost';

/*5.Le otorgamos todos los privilegios en la base de datos de jardinería de tal manera que userdam 
pueda otorgar los mismos privilegios a otros usuarios.*/
grant all privileges on jardineria.* to 'userdam'@'localhost' with grant option;

-- 6.Quitarle todos los permisos a ese usuario.
revoke all privileges on *.* from 'userdam'@'localhost';

-- 7.Comprobar si se ha efectuado el cambio accediendo desde su cuenta.


/*8.Creamos dos roles: administrador, usuario para administrar la base de datos
EMPLEADOS.
Usuario: Tendrá los privilegios de consultar
Administrador: Tendrá todos los privilegios.*/
CREATE ROLE IF NOT EXISTS 'administrador', 'usuario';
grant select on empleados.* to 'usuario';
grant all on empleados.* to 'administrador';

-- 9.Otorgamos el rol usuario a nuestro userdam
grant 'usuario' to 'userdam'@'localhost';

-- 10.Comprobamos que puede acceder a la info de esa base de datos.
show grants for 'userdam'@'localhost';
show grants for 'usuario';

-- 11.Le quitamos el rol al usuario.
revoke 'usuario' from 'userdam'@'localhost';

-- 12.Borramos el rol.
drop role 'usuario';

-- 13.Borramos el usuario.
drop user 'userdam'@'localhost';