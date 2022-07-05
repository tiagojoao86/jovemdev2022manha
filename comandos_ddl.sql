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
