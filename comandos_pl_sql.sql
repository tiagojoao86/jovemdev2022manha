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
