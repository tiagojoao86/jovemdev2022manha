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
