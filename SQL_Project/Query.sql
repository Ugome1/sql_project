/*Query 1 - query used for the first insight*/

WITH t1 AS (
   SELECT f.title AS movie, c.name AS category, r.rental_id AS rental_no
     FROM category AS c
     JOIN film_category AS fc
       ON c.category_id = fc.category_id
     JOIN film AS f
       ON fc.film_id = f.film_id
     JOIN inventory AS i
       ON f.film_id = i.film_id
     JOIN rental AS r
       ON i.inventory_id = r.inventory_id)
SELECT t1.movie AS film_title, t1.category AS category_name, COUNT(t1.rental_no) AS rental_count
  FROM t1
 GROUP BY 1,2
 ORDER BY 2,1





/*Query 2 - query used for the second insight*/

SELECT *
  FROM (SELECT f.title AS movie, c.name AS category, f.rental_duration,
       NTILE(4) OVER (ORDER BY f.rental_duration) AS standard_quartile
       FROM category AS c
  JOIN film_category AS fc
    ON c.category_id = fc.category_id
  JOIN film AS f
    ON fc.film_id = f.film_id) AS t1
 WHERE t1.category IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')





/*Query 3 - query used for the third insight*/

WITH t1 AS (SELECT f.title AS movie, c.name AS cate, f.rental_duration,
            NTILE(4) OVER (ORDER BY f.rental_duration) AS stan_quart
            FROM category AS c
            JOIN film_category AS fc
              ON c.category_id = fc.category_id
            JOIN film AS f
              ON fc.film_id = f.film_id
        ORDER BY 2)
SELECT t1.cate category, t1.stan_quart standard_quartile, COUNT(t1.cate) count
FROM t1
GROUP BY 1,2
ORDER BY 1,3
WHERE t1.cate IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
ORDER BY 1,2




/*Query 4 - query used for the four insight*/

SELECT DATE_PART('month', r.rental_date) AS rental_month,
       DATE_PART('year', r.rental_date) AS rental_year,
       s.store_id,
       COUNT(r.rental_id) count_rentals
  FROM rental AS r
  JOIN payment AS p
    ON r.customer_id = p.customer_id
  JOIN staff AS s
    ON s.staff_id = p.staff_id
  JOIN store AS st
    ON st.store_id = s.store_id
 GROUP BY 1,2,3
 ORDER BY 4 DESC
