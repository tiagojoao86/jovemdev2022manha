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
