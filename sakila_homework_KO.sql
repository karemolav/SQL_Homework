USE  sakila;
-- 1a:
SELECT first_name, last_name FROM sakila.actor;
-- 1b:
SELECT concat(first_name," ", last_name) AS Actor_Name
FROM actor;
-- 2a:
SELECT actor_id, first_name, last_name 
FROM actor where first_name = 'Joe';
-- 2b:
SELECT last_name 
FROM actor where last_name like '%GEN%'
--  2c:
SELECT last_name, first_name 
FROM actor where last_name like '%LI%'
order by last_name, first_name;
-- 2d:
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');
-- 3a:
ALTER TABLE actor
ADD COLUMN Description BLOB;
-- 3b
ALTER TABLE actor
DROP COLUMN Description;
-- 4a:
SELECT last_name, COUNT(last_name) as "Last Name Counts"
FROM actor
GROUP BY last_name;
-- 4b:
SELECT last_name, COUNT(last_name) as "Last Name Counts"
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) >=2;
-- 4c:
UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';
-- 4d:
UPDATE actor
SET first_name = 'GROUCHO'
WHERE first_name = 'HARPO' ;
 -- 5a:
 show create table address;
 -- 6a:
SELECT first_name, last_name, address
FROM staff
INNER JOIN address
ON staff.address_id = address.address_id
 -- 6b:
SELECT staff.first_name, staff.last_name, SUM(payment.amount) as Total_Amount
FROM staff
INNER JOIN payment
ON staff.staff_id = payment.staff_id
where payment_date between " 20050801" AND "20050901"
GROUP BY staff.staff_id;
-- 6c:
SELECT title, COUNT(actor_id) as Number_of_Actors
FROM film 
INNER JOIN film_actor
ON film.film_id = film_actor.film_id
GROUP BY title;
-- 6d:
SELECT title, COUNT(inventory_id) as Copies_of_the_Film
FROM film
INNER JOIN inventory
ON film.film_id = inventory.film_id
WHERE title = "Hunchback Impossible";
-- 6e:
SELECT last_name, first_name, SUM(amount) as Total_Amount_Paid
FROM payment 
INNER JOIN customer 
ON payment.customer_id = customer.customer_id
GROUP BY payment.customer_id
ORDER BY last_name;
-- 7a:
SELECT title FROM film
WHERE language_id in
	(SELECT language_id 
	FROM language
	WHERE name = "English" )
AND (title LIKE "K%") OR (title LIKE "Q%");
-- 7b:
SELECT last_name, first_name
FROM actor
WHERE actor_id in
	(SELECT actor_id FROM film_actor
	WHERE film_id in 
		(SELECT film_id FROM film
		WHERE title = "Alone Trip"));
-- 7c:
SELECT  first_name, last_name, email
FROM customer
LEFT JOIN address
ON customer.address_id = address.address_id
WHERE city_id in (179, 196, 300, 313,383, 430, 565)
order by first_name;
-- or:
SELECT country, first_name, last_name, email
FROM  customer cu
JOIN address a
ON (cu.address_id=a.address_id)
JOIN city c 
ON (a.city_id=c.city_id)
JOIN country ctry
ON (c.country_id=ctry.country_id)
WHERE country = 'Canada'
order by first_name;
-- 7d:
SELECT title, category
FROM film_list
WHERE category = 'Family';
-- 7e:
SELECT film.title, COUNT(film.film_id) AS Count_of_Rented_Movies
FROM  film
JOIN inventory
ON (film.film_id= inventory.film_id)
JOIN rental 
ON (inventory.inventory_id=rental.inventory_id)
GROUP BY title 
ORDER BY count_of_rented_movies DESC;
-- 7f:
SELECT  s.store_id,SUM(amount) AS Business_in_Dollars
FROM store s
INNER JOIN staff st 
ON s.store_id = st.store_id
INNER JOIN payment p
ON p.staff_id = st.staff_id 
GROUP BY s.store_id
ORDER BY business_in_dollars ASC;
-- 7g:
SELECT store_id, city, country
FROM store s
JOIN address a
ON (s.address_id=a.address_id)
JOIN city c 
ON (a.city_id=c.city_id)
JOIN country ctry
ON (c.country_id=ctry.country_id);
-- 7h:
SELECT name AS Top_Five, SUM(amount) AS Gross_Revenue
FROM category c
INNER JOIN film_category fc
ON  c.category_id = fc.category_id
INNER JOIN inventory i
ON fc.film_id = i.film_id
INNER JOIN rental r
ON i.inventory_id = r.inventory_id
INNER JOIN payment p 
ON r.rental_id = p.rental_id
GROUP BY top_five 
ORDER BY gross_revenue  DESC
LIMIT 5;
-- 8a:
CREATE VIEW Top_Five_Genres_by_Gross_Revenue AS

SELECT name AS Top_Five, SUM(amount) AS Gross_Revenue
FROM category c
INNER JOIN film_category fc
ON  c.category_id = fc.category_id
INNER JOIN inventory i
ON fc.film_id = i.film_id
INNER JOIN rental r
ON i.inventory_id = r.inventory_id
INNER JOIN payment p 
ON r.rental_id = p.rental_id
GROUP BY top_five 
ORDER BY gross_revenue   DESC
LIMIT 5;
-- 8b:
SELECT * FROM Top_Five_Genres_by_Gross_Revenue;
-- 8c:
DROP VIEW Top_Five_Genres_by_Gross_Revenue;
