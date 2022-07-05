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
