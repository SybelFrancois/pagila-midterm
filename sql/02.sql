/*
 * Write a SQL query SELECT query that:
 * computes the country with the most customers in it. 
 */


select country.country from country

  join city using (country_id)
  join address using (city_id)
  join customer using (address_id)

group by country.country

having count(customer_id) = (select max(customer_count) from (

        select count(customer_id) as customer_count from country

          join city using (country_id)
          join address using (city_id)
          join customer using (address_id)

        group by country.country) as counts
);
