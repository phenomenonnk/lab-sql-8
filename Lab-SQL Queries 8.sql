use sakila;
-- 1.
-- Rank films by length (filter out the rows that have nulls or 0s in length column).
-- In your output, only select the columns title, length, and the rank.
select *, rank() over (order by length) as 'rank by length' -- we could also use dense_rank() or row_number() instead of rank()
from sakila.film
where length <> " " or length !=0 ; 

-- 2.
-- Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column).
-- In your output, only select the columns title, length, rating and the rank.
select *, row_number() over (order by rating) as 'rank by rating' -- we could also use dense_rank() or rank() instead of row_number()
from sakila.film
where rating <> " " or length !=0 ;

-- 3.
-- How many films are there for each of the categories in the category table. Use appropriate join to write this query
select fc.category_id, c.name, count(fc.film_id) as quantity_of_films from sakila.film_category as fc
join sakila.category as c using(category_id) -- or join sakila.category as c on fc.category_id=c.category_id
group by category_id, c.name -- or group by fc.category_id, c.name
order by category_id;

-- 4.
-- Which actor has appeared in the most films?
select a.actor_id, a.first_name, a.last_name, count(fa.film_id) as number_of_films from sakila.actor as a
join sakila.film_actor as fa using(actor_id) -- or join sakila.film_actor as fa on a.actor_id=fa.actor_id
group by actor_id, first_name, last_name
order by number_of_films desc
limit 1;

-- 5.
-- Most active customer (the customer that has rented the most number of films)
select c.customer_id, c.first_name, c.last_name, count(r.rental_id) as number_of_rented_films from sakila.customer as c
join sakila.rental as r on c.customer_id=r.customer_id -- or join sakila.rental as r using(customer_id)
group by c.customer_id, c.first_name, c.last_name
order by number_of_rented_films desc
limit 1;

-- Bonus: Which is the most rented film? The answer is Bucket Brotherhood This query might require using more than one join statement. Give it a try.
-- We will talk about queries with multiple join statements later in the lessons.
select f.film_id, f.title, count(r.inventory_id) as number_of_being_rented from film as f
join inventory as i on f.film_id=i.film_id
join rental as r on i.inventory_id=r.inventory_id
group by f.film_id, f.title
order by number_of_being_rented desc
limit 1;

