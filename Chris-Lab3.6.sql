use sakila;

#List each pair of actors that have worked together.

select f1.film_id, f2.actor_id as actor_1, f1.actor_id as actor_2
from film_actor f1
join film_actor f2 
on f1.film_id = f2.film_id
and f1.actor_id < f2.actor_id;

#For each film, list actor that has acted in more films.

select a.actor_id, a.first_name, a.last_name, count(film_id)
from actor a
left join film_actor fa
using (actor_id)
group by a.actor_id, a.first_name, a.last_name
order by count(film_id) desc;


select fa.film_id, fa.actor_id
from film_actor fa
where actor_id in (select a.actor_id
from actor a
left join actor
using (actor_id)
where film_id > 1
group by fa.film_id, fa.actor_id
order by fa.film_id);

SELECT
	film_id, first_name, last_name
FROM
	actor
JOIN
(SELECT
	film_id, actor_id
FROM
	(SELECT
		film_id, actor_id, RANK() OVER (PARTITION BY film_id ORDER BY number_of_films DESC) AS actor_ranking
	FROM
		(SELECT
			film_id, actor_id, COUNT(*) OVER (PARTITION BY actor_id) AS number_of_films
		FROM
			film_actor)
		AS film_actors)
	AS film_rankings
WHERE
	actor_ranking = 1)
AS selected_actors
ON selected_actors.actor_id = actor.actor_id;
