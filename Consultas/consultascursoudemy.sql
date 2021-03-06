#CONSULTAS A SAKILA


use sakila;

#EJERCICIO PRACTICO 19
select * from film_text
where title in('ZORRO ARK','VIRGIN DAISY','UNITED PILOT');

#EJERCICIO PRACTICO 20
select * from city
where city in('Chiayi','Dongying','Fukuyama','Kilis');

#EJERCICIO PRACTICO 23
select * from payment
where (amount between 2.99 and 4.99) and staff_id = 2 and customer_id = (1 and 2);


#EJERCICIO PRACTICO 24 
#BETWEEN
select * from address
where(city_id between 300 and 350);

#EJERCICIO PRACTICO 25
#BETWEEN
select * from film
where(rental_rate between 0.99 and 2.99) and length >= 50 and replacement_cost < 20;

#EJERCICIO PRACTICO 30
#LIKE
select * from film
where release_year = 2006 and title like('ALI%');

#EJERCICIO PRACTICO 36
#INNER JOIN
select a.address,c.city,co.country from address a inner join city c on(a.city_id = c.city_id) inner join country co on(c.country_id = co.country_id);

select * from customer;

#EJERCICIO 37
#LEFT JOIN
select c.first_name,a.address,s.store_id from customer c
left join address a on(c.address_id = a.address_id)
left join store s on(s.address_id = a.address_id);


#EJERCICIO 38
#RIGHT JOIN
select r.rental_id,s.first_name from rental r
inner join staff s on(r.staff_id = s.staff_id);


#EJERCICIO PRACTICO 48
#GROUP BY
select customer_id, MAX(rental_date) from rental group by customer_id;


#EJERCICIO PRACTICO 51
#HAVING
select last_name,count(*) from actor group by last_name having count(*)>2;


select *,CONCAT(first_name, ' ',last_name) as 'full_name' from customer;

#ROUND - REDONDEAR 
select * from payment;
select *,ROUND(amount,0) FROM payment;

#UPER Y LOWER CASE
select *,lcase(title) from film;


#EJERCICIO PRACTICO 57
select *,char_length(email) as 'Longitud de Mail' from customer;

#EJERCICIO PRACTICO 58
select *,CONCAT(first_name,' ',last_name,' ',email) from customer;

#EJERCICIO PRACTICO 59
select *,CONCAT_WS(' ',film_id,title,description,release_year,language_id,original_language_id,rental_duration,rental_rate,length,replacement_cost,rating,special_features,last_update) as 'BALA' from film;

#EJERCICIO PRACTICO 60
#Consulta la tabla payment y has un group by por customer_id para el promedio de amount, despu??s usa la funci??n ROUND() para redondear a cero decimales el promedio.
select customer_id, ROUND(avg(amount)) as 'promedio' from payment group by customer_id having avg(amount);


#EJEMPLOS DE CASE
select address,address2,
case 
	when address2 is null then 'SIN SEGUNDA DIRECCION'
    ELSE 'Con direccion' 
end as Comentario 
from address;

select * from payment;

select payment_id,amount,
case 
	when amount < 1 then 'precio minimo'
    when amount between 1 and 3 then 'precio intermedio'
    else 'Precio maximo'
end as Comentario
from payment;


#EJERCICIO 64
#CASE
select * from film;

select film_id,rental_rate,
case
	when rental_rate < 1 then 'Pelicula mala'
    when rental_rate between 1 and 3 then 'Pelicula buena'
    when rental_rate > 3 then'Pelicula excelente'
end as 'Comentario'
from film;



#EJEMPLOS SUBCONSULTAS
 select title from film where title like 'K%' or title like 'Q%' and title in
 (
 select title from film where language_id in
	(
		select language_id from language where name = 'English'
	)
);

#EJEMPLO SUBCONSULTA
#VER ACTORES QUE HICIERON ALONE TRIP
select first_name,last_name from actor where actor_id in
(
select actor_id from film_actor where film_id in
	(
    select film_id from film where title = 'Alone Trip'
    )
);

#EJEMPLO SUBCONSULTA 3

select * from film_category;

select title from film where film_id in 
(
select film_id from film_category where category_id in
	(
    select category_id from category where name = 'Family'
    )
);


select * from film_category;

#EJERCICIO PARA ESTUDIANTE 68
select CONCAT(first_name,' ',last_name)as 'FullName',email  from customer where customer_id in 
(
select customer_id from rental where rental_id in
	(
    select rental_id from inventory where film_id in
		(
        select film_id from film_category where category_id = 1
        )
	)
);


#CREATE VIEW
create view ingresos_por_genero as
select name,sum(amount) from category
inner join film_category on category.category_id = film_category.category_id
inner join inventory on film_category.film_id = inventory.film_id
inner join rental on inventory.inventory_id = rental.inventory_id
inner join payment on rental.rental_id = payment.rental_id
group by name
order by sum(amount) desc limit 5;

select * from ingresos_por_genero;

#EJERCICIO 70

select * from customer;

create view lista_de_clientes as
select concat(first_name,' ',last_name),a.address,ci.city,co.country from customer c
inner join address a on c.address_id = a.address_id
inner join city ci on a.city_id = ci.city_id
inner join country co on ci.country_id = co.country_id;

select * from lista_de_clientes;

drop view lista_de_clientes;


##PREGUNTAS COMPLEJAS
#QUIEN VENDIO MAS EN AGOSTO 2005?

select s.first_name,s.last_name,sum(p.amount) as 'TOTAL DE VENTAS' from staff s
inner join payment p on s.staff_id = p.staff_id and p.payment_date like '2005-08%';

select f.title,count(fa.actor_id) as 'CONTADOR ACTORES' from film f
inner join film_actor fa on f.film_id = fa.film_id
group by(f.title);

select title,length as 'Cantidad' from film where title = 'Hunchback impossible';

select * from inventory;
