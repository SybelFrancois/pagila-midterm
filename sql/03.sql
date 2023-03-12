/*
 * Write a SQL query SELECT query that:
 * List the first and last names of all actors who have appeared in movies in the "Children" category,
 * but that have never appeared in movies in the "Horror" category.
 */


/*The below query outputs actors appearing in at least 1 children's movie*/

select distinct(first_name), last_name from actor
  join film_actor USING (actor_id)
  join film_category USING (film_id)
  join category using (category_id)
where category.name = 'Children'

and 

actor_id not in (
    select distinct actor_id from film_actor
      join film_category USING (film_id)
      join category USING (category_id)
where category.name = 'Horror'
) 

order by last_name, first_name;
