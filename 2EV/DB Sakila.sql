select * from film where length = (select max(length) from film);
-- o tambien vale 
select title, max(length) from film;

-- Película con menor duración.
select * from film where length = (select min(length) from film);
-- o tambien vale 
select title, min(length) from film;

-- Mostrar las ciudades del country Spain (multitabla).

-- Mostrar el country, la ciudad y dirección de cada miembro del staff.

/*Tabla con info de clientes y además una tabla con todo el dinero que se han gastado
en pedidos.*/
select customer.*, gastocliente.gastototal from customer inner join
(select customer.customer_id,sum(payment.amount) as gastototal from customer inner join payment on customer.customer_id = payment.customer_id 
group by customer.customer_id) as gastocliente on  customer.customer_id = gastocliente.customer_id;

/*6. Tabla con el id y el nombre del cliente que menos ha gastado ( con subconsulta en la
clausula from)*/
select customer.customer_id as id, customer.first_name as nombre, gastocliente.gastototal from customer inner join
(select customer.customer_id, sum(payment.amount) as gastototal from customer inner join payment on customer.customer_id = payment.customer_id 
group by customer.customer_id) as gastocliente on  customer.customer_id = gastocliente.customer_id ORDER BY gastocliente.gastototal limit 1;

/*7. Listado de clientes que se hayan gastado menos de 110 dólares (Actualmente la
cantidad está en euros, 1 euro = 1,18 dólares).Con subconsulta en la clausula from)*/
select distinct customer.*, gastocliente.gastototal from customer inner join (select customer_id, sum(amount * 1.18) as gastototal from payment group by customer_id 
having gastototal < 110) as gastocliente on customer.customer_id = gastocliente.customer_id;

