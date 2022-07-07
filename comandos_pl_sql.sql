DO $$
    DECLARE
        tabela record;
        numero integer;
        nome varchar;
        descricao text;
    BEGIN
        numero = 1;
        FOR tabela IN (select actor_id, first_name from actor) LOOP
            IF (MOD(tabela.actor_id,2) = 0) THEN
                BEGIN
                    update actor set last_update = now() where actor_id = tabela.actor_id;
                    RAISE NOTICE 'Actor ID: (%) - %', tabela.actor_id, tabela.first_name;
                    EXCEPTION
                        WHEN OTHERS THEN ROLLBACK;
                END;
            END IF;
        end loop;
end;
$$ language plpgsql;

CREATE OR REPLACE FUNCTION conta_atores_fc(nome_p varchar) RETURNS varchar AS $$
    DECLARE
        resultado varchar;
    BEGIN
        select string_agg(first_name, ';') into resultado
            from actor where first_name ilike '%'||nome_p||'%';

        return resultado;
    end;
$$ language plpgsql;

CREATE OR REPLACE FUNCTION conta_atores_pc(nome_p varchar) RETURNS void AS $$
DECLARE
    resultado varchar;
BEGIN
    select string_agg(first_name, ';') into resultado
    from actor where first_name ilike '%'||nome_p||'%';

    RAISE INFO 'Nomes: %', resultado;
end;
$$ language plpgsql;

/*
1 - Crie uma function para retornar o nome completo do ator
(nome sobrenome), recebendo por parâmetro o actor_id;
2 - Crie uma procedure que cria uma coluna na tabela actor,
chamada full_name varchar(200), depois preencha essa
coluna com o nome completo de cada ator (nome sobrenome);
*/

CREATE OR REPLACE FUNCTION get_nome_completo_ator(actor_id_p INTEGER) RETURNS VARCHAR AS $$
    DECLARE
        retorno VARCHAR;
    BEGIN
        SELECT concat(first_name, ' ', last_name) INTO retorno
        FROM actor WHERE actor_id = actor_id_p;

        RETURN retorno;
    END;
$$ language plpgsql;

select get_nome_completo_ator(1);
select get_nome_completo_ator(2);

CREATE OR REPLACE FUNCTION create_nome_completo_ator() RETURNS void AS $$
    DECLARE
        atores RECORD;
    BEGIN
        ALTER TABLE actor ADD COLUMN IF NOT EXISTS full_name VARCHAR(200);
        --UPDATE actor SET full_name = get_nome_completo_ator(actor_id);
        FOR atores IN (SELECT actor_id FROM actor) LOOP
            UPDATE actor SET full_name =
                get_nome_completo_ator(atores.actor_id)
                WHERE actor_id = atores.actor_id;
        end loop;
    end;
$$ language plpgsql;

select create_nome_completo_ator();
ALTER TABlE actor DROP COLUMN full_name;
select * from actor;

-------- TRIGGER ----------
ALTER TABLE customer ADD COLUMN total_amount numeric DEFAULT 0;
select * from payment;

CREATE OR REPLACE FUNCTION atualiza_amount_customer_fc() RETURNS TRIGGER AS $$
    BEGIN
        RAISE NOTICE 'OP %', TG_OP;
        IF (TG_OP = 'INSERT') THEN
            UPDATE customer SET total_amount = COALESCE(total_amount, 0) + NEW.amount
            WHERE customer_id = NEW.customer_id;
        END IF;
        IF (TG_OP = 'UPDATE') THEN
            UPDATE customer SET total_amount = COALESCE(total_amount, 0) + NEW.amount - OLD.amount
            WHERE customer_id = NEW.customer_id;
        END IF;

        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER atualiza_amount_customer_tg AFTER UPDATE OR INSERT
    ON payment FOR EACH ROW
    EXECUTE PROCEDURE atualiza_amount_customer_fc();

-- DROP TRIGGER atualiza_amount_customer_tg ON customer;

SELECT total_amount, * FROM customer WHERE customer_id = 8;

SELECT * FROM rental WHERE customer_id = 8 order by rental_date desc;
INSERT INTO rental (RENTAL_DATE, INVENTORY_ID, CUSTOMER_ID, RETURN_DATE, STAFF_ID)
VALUES (NOW(), 2867, 8, NOW() + interval '3' day, 1);

SELECT NOW() + interval '3' day ;
SELECT * FROM payment WHERE customer_id = 8 ORDER BY payment_date DESC;
-- 16050
--DELETE FROM payment WHERE payment_id = 32101;
INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date)
VALUES (8, 1, 16050, 25.50, NOW());

UPDATE payment SET amount = 50.00 WHERE payment_id = 32102;

/*
3 - Crie uma trigger para que sempre que for inserido um ator novo,
preencha a coluna criada na tarefa anterior com o nome completo do ator
(nome sobrenome);
 */
CREATE OR REPLACE FUNCTION preenche_full_name_fc() RETURNS TRIGGER AS $$
    BEGIN
        IF (TG_OP = 'INSERT') THEN
            /* QUANDO AFTER
            UPDATE actor SET full_name = first_name || ' ' || last_name
            WHERE actor_id = NEW.actor_id;*/

            /* QUANDO BEFORE */
            NEW.full_name = NEW.first_name || ' ' || NEW.last_name;
        END IF;
        IF (TG_OP = 'UPDATE') THEN
            /* QUANDO AFTER
                UPDATE actor SET full_name = first_name || ' ' || last_name
                WHERE actor_id = NEW.actor_id;

                QUANDO A TRIGGER FAZ UPDATE NA TABELA A QUAL ELA ESTÁ ASSOCIADA
               NÃO PODEMOS CHAMAR O COMANDO DE UPDATE POIS, ELE IRÁ
               ACIONAR A TRIGGER NOVAMENTE
             */
            /* QUANDO BEFORE */
            NEW.full_name = NEW.first_name || ' ' || NEW.last_name;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER preenche_full_name_tg BEFORE UPDATE OR INSERT
    ON actor FOR EACH ROW
EXECUTE PROCEDURE preenche_full_name_fc();

drop trigger preenche_full_name_tg on actor;

insert into actor (first_name, last_name)
values ('Tiago', 'Pereira') RETURNING actor_id;

insert into actor (first_name, last_name)
values ('João', 'Pereira') RETURNING actor_id;

SELECT * FROM actor WHERE actor_id = 206;
select * from actor where actor_id = 208;
