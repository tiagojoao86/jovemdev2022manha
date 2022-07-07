-- CREATE DATABASE jovemdev;

CREATE TABLE aluno_jovemdev (
    aluno_jovemdev_id SERIAL PRIMARY KEY,
    nom_aluno VARCHAR(200) NOT NULL,
    num_cpf VARCHAR(11) NOT NULL UNIQUE,
);

CREATE TABLE turma_jovemdev (
    turma_jovemdev_id SERIAL PRIMARY KEY,
    nom_turma VARCHAR(100) NOT NULL UNIQUE
);

ALTER TABLE aluno_jovemdev ADD COLUMN turma_jovemdev_id INTEGER;

ALTER TABLE aluno_jovemdev
    ADD CONSTRAINT aluno_jovemdev_turma_jovemdev_id_fkey
    FOREIGN KEY (turma_jovemdev_id)
        REFERENCES turma_jovemdev(turma_jovemdev_id);

ALTER TABLE aluno_jovemdev
    ADD CONSTRAINT nom_aluno_aluno_jovemdev_check_size
    CHECK (char_length(nom_aluno) > 5);

ALTER TABLE aluno_jovemdev
    ADD COLUMN dat_nascimento DATE NOT NULL DEFAULT '2000-01-01';

INSERT INTO turma_jovemdev(nom_turma) VALUES ('Matutino');

select * from turma_jovemdev;
select * from aluno_jovemdev;

--------------- VIEWS
CREATE OR REPLACE VIEW staff_vw AS
    SELECT s.staff_id,
           concat(s.first_name, ' ', s.last_name) as nome,
           a.address,
           a.postal_code,
           a.phone,
           c.city
    FROM staff s
    JOIN address a ON s.address_id = a.address_id
    JOIN city c on a.city_id = c.city_id;


SELECT s.nome, s.address, string_agg(rental_id::text, ';')
FROM staff_vw s
JOIN rental r on r.staff_id = s.staff_id
group by s.nome, s.address
;
