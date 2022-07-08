select * from pg_catalog.pg_stat_activity
where datname = 'newdvdrental';

select pg_cancel_backend(pid)
from pg_catalog.pg_stat_activity
where datname = 'newdvdrental';

select pg_terminate_backend(pid)
from pg_catalog.pg_stat_activity
where datname = 'newdvdrental';

CREATE DATABASE newdvdrental_bkp
WITH TEMPLATE 'newdvdrental';

DROP DATABASE newdvdrental;
CREATE DATABASE newdvdrental
    WITH TEMPLATE 'newdvdrental_bkp';

CREATE TABLE actor_bkp_20220708 AS WITH tmp AS
    (SELECT * FROM actor) SELECT * FROM tmp;

select * from actor_bkp_20220708;
drop table actor_bkp_20220708;

CREATE TABLE film_actor_bkp_20220708 AS WITH tmp AS
        (delete from film_actor where actor_id in (123,102)
            RETURNING *)
SELECT * FROM tmp;
select * from film_actor_bkp_20220708;

CREATE TABLE actor_bkp_20220708 AS WITH tmp AS
    (delete from actor where actor_id in (123,102)
        RETURNING *)
SELECT * FROM tmp;
select * from actor_bkp_20220708;


CREATE ROLE usuario_integracao LOGIN NOSUPERUSER
    INHERIT NOCREATEDB NOCREATEROLE
    NOREPLICATION;

ALTER USER usuario_integracao WITH PASSWORD '123456';

GRANT SELECT ON actor TO usuario_integracao;
REVOKE SELECT ON actor FROM usuario_integracao;
