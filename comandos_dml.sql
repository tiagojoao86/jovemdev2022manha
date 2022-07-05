SELECT title, description, rating
FROM film
WHERE release_year = 2006
  AND (rating = 'PG-13' OR rating = 'R')
ORDER BY
title ASC
;

SELECT title, description, rating
FROM film
WHERE title ilike '%a mão%'
ORDER BY
    title ASC
;

INSERT INTO film (title, description, release_year,
                  language_id, rental_rate,
                  length, replacement_cost, rating, special_features)
VALUES ('A MÃO QUE BALANÇA O BERÇO', 'ERA MÃO QUE BALANÇAVA O BERÇO', 1980, 1, 1.00,
        90, 20.00, 'R', '{Bastidores}');

SELECT * FROM film WHERE film_id = 1003;
UPDATE film SET description = 'UMA OBRA DE ALFRED HITCHCOCK' WHERE film_id = 1003;

DELETE FROM film WHERE film_id IN (1003, 1004, 1005);

#RESOLUÇÃO ATIVIDADE #01
SELECT actor_id, first_name, last_name, last_update
FROM actor
ORDER BY first_name ASC;

INSERT INTO actor(FIRST_NAME, LAST_NAME)
VALUES ('Rubens', 'Junior');

INSERT INTO actor(FIRST_NAME, LAST_NAME)
VALUES ('Marta', 'Oliveira');

SELECT * FROM actor WHERE first_name = 'Marta' AND last_name = 'Oliveira';
DELETE FROM actor WHERE actor_id = 202;

SELECT * FROM actor WHERE first_name = 'Rubens' AND last_name = 'Junior';
SELECT * FROM actor WHERE actor_id = 201;
UPDATE actor SET first_name = 'Rubens Luis' WHERE actor_id = 201;

SELECT payment_id, customer_id,
       staff_id, rentaL_id, amount,
       round(amount - (amount * 0.1),2) as total_desconto,
       payment_date,
       amount + (amount * 0.1)
FROM payment;

-- #Limit e Offset
SELECT *
FROM film
ORDER BY film_id
OFFSET 20 LIMIT 10
;

-- FUNÇÕES DE AGRUPAMENTO
-- MAX, MIN, SUM, AVG, COUNT, HAVING
SELECT MAX(amount) AS pagamento, customer_id
FROM payment
WHERE customer_id = 273
GROUP BY customer_id
;

SELECT MIN(amount) AS pagamento, customer_id
FROM payment
WHERE customer_id = 273
GROUP BY customer_id
;

SELECT SUM(amount) AS pagamento, customer_id
FROM payment
WHERE customer_id = 273
GROUP BY customer_id
;

SELECT AVG(amount) AS pagamento, customer_id
FROM payment
WHERE customer_id = 273
GROUP BY customer_id
;

SELECT COUNT(amount) qtd_pagamentos, customer_id cod_cliente
FROM payment
WHERE customer_id = 273
GROUP BY customer_id
;

SELECT COUNT(amount) qtd_pagamentos, customer_id cod_cliente
FROM payment
GROUP BY customer_id
HAVING
COUNT(amount) > 30
;

SELECT SUM(amount) pagamentos, customer_id cod_cliente
FROM payment
GROUP BY customer_id
HAVING
SUM(amount) > 200.00
;

SELECT SUM(amount) pagamentos,
       customer_id cod_cliente
FROM payment
GROUP BY customer_id
HAVING
COUNT(amount) > 40
;

-- # RESOLUÇÃO ATIVIDADE 2
SELECT SUM(amount) pagamentos,
       customer_id cod_cliente
FROM payment
GROUP BY customer_id
ORDER BY pagamentos desc
;

SELECT COUNT(rental_id) qtd_locacoes,
       customer_id cod_cliente
FROM rental
GROUP BY customer_id
ORDER BY qtd_locacoes ASC;

SELECT max(rental_date) data_locacao,
       customer_id cod_cliente
FROM rental
GROUP BY customer_id
ORDER BY data_locacao DESC
LIMIT 1;

SELECT min(rental_date) data_locacao,
       customer_id cod_cliente
FROM rental
GROUP BY customer_id
ORDER BY data_locacao DESC
LIMIT 1;

SELECT ROUND(AVG(amount),2) AS pagamento,
       customer_id
FROM payment
GROUP BY customer_id
ORDER BY pagamento DESC
;

SELECT SUM(amount) pagamentos,
       customer_id cod_cliente
FROM payment
GROUP BY customer_id
HAVING
        SUM(amount) > 200.00
;

--- # JOIN INNER JOIN (JOIN), LEFT JOIN, RIGHT JOIN
SELECT SUM(p.amount) pagamentos,
       c.customer_id cod_cliente,
       c.first_name nom_cliente
FROM payment p
INNER JOIN customer c ON p.customer_id = c.customer_id
--INNER JOIN customer c USING (customer_id)
GROUP BY c.customer_id, c.first_name
HAVING
        SUM(p.amount) > 200.00
;

SELECT a.actor_id, a.first_name, f.film_id, f.title
FROM actor a
RIGHT JOIN film_actor fa ON a.actor_id = fa.actor_id
RIGHT JOIN film f ON fa.film_id = f.film_id
WHERE a.actor_id is null
order by f.film_id
;

SELECT a.actor_id, a.first_name, f.film_id, f.title
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
LEFT JOIN film f ON fa.film_id = f.film_id
WHERE f.film_id is null
order by f.film_id
;

-- STRING_AGG
SELECT string_agg(rental_id::text, '/'), customer_id
from rental
group by customer_id;

/*
 Realizar Select na tabela “inventory” fazendo união com a
 tabela “film” e mostre o inventory_id e o título do filme

 Realizar Select na tabela “Rental” mostrando a data
 do aluguel, o nome completo do customer, do staff e o
 título do filme

 Realizar Select na tabela “Filme” mostrando a
 lista de nome dos atores, separados por “;”

 */

SELECT i.inventory_id, f.title
FROM inventory i
JOIN film f on i.film_id = f.film_id;

SELECT to_char(r.rental_date, 'dd/mm/yyyy') as rental_date,
       concat(c.first_name, ' ', c.last_name) as customer_full_name,
       concat(s.first_name, ' ', s.last_name) as staff_full_name,
       f.title
FROM rental r
JOIN customer c on r.customer_id = c.customer_id
JOIN staff s on r.staff_id = s.staff_id
JOIN inventory i on r.inventory_id = i.inventory_id
JOIN film f on i.film_id = f.film_id;

SELECT f.title, string_agg(a.first_name, ';')
FROM film f
JOIN film_actor fa on f.film_id = fa.film_id
JOIN actor a on fa.actor_id = a.actor_id
GROUP BY f.title;
