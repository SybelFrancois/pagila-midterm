/*
 * You want to watch a movie tonight.
 * But you're superstitious,
 * and don't want anything to do with the letter 'F'.
 *
 * Write a SQL query that lists the titles of all movies that:
 * 1) do not have the letter 'F' in their title,
 * 2) have no actors with the letter 'F' in their names (first or last),
 * 3) have never been rented by a customer with the letter 'F' in their names (first or last).
 * 4) have never been rented by anyone with an 'F' in their address (at the street, city, or country level).
 *
 * NOTE:
 * Your results should not contain any duplicate titles.
 */

/*Based on the information provided in issue #303, I understand that the solution should account for 
both upper and lowercase 'F'. Therefore, to make the query case-insensitive, I am using "ILIKE". 
If the query should only focus on matching the uppercase 'F', then "LIKE" could be used instead.*/


SELECT DISTINCT title
FROM film
LEFT JOIN (
  SELECT DISTINCT film_id
  FROM inventory
    JOIN rental  using (inventory_id)
    JOIN customer using (customer_id)                                                 
    JOIN address using (address_id)
    JOIN city using (city_id)
    JOIN country using (country_id)
    WHERE country.country ILIKE '%F%' 
    OR city.city ILIKE '%F%' 
    OR address.address ILIKE '%F%'
) t using (film_id)
WHERE
film.title NOT ILIKE '%F%'
 
AND film.film_id NOT IN (
    SELECT DISTINCT film_actor.film_id
    FROM film_actor
      JOIN actor using(actor_id)
      WHERE actor.first_name ILIKE '%F%' 
      OR actor.last_name ILIKE '%F%'
)

AND film.film_id NOT IN (
    SELECT DISTINCT inventory.film_id
    FROM inventory
      JOIN rental using (inventory_id)
      JOIN customer using (customer_id)
      JOIN address using (address_id)
      JOIN city using (city_id)
      JOIN country using (country_id)
      WHERE customer.first_name ILIKE '%F%' 
      OR customer.last_name ILIKE '%F%'
)
AND t.film_id IS NULL 
order by title;

