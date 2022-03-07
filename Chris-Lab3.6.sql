use sakila;

#List each pair of actors that have worked together.

select f1.film_id, f2.actor_id as actor_1, f1.actor_id as actor_2
from film_actor f1
join film_actor f2 
on f1.film_id = f2.film_id
and f1.actor_id < f2.actor_id;

#For each film, list actor that has acted in more films.

select fa.film_id, fa.actor_id
from film_actor fa
where actor_id in (select a.actor_id
from actor a
left join actor
using (actor_id)
where film_id > 1
group by fa.film_id, fa.actor_id
order by fa.film_id);
