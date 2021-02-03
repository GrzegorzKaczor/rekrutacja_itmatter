BEGIN;
CREATE TABLE IF NOT EXISTS notes
(
    id                 CHARACTER VARYING(36)       NOT NULL,
    title              CHARACTER VARYING(100)      NOT NULL,
    contents           CHARACTER VARYING(1000)     NOT NULL,
    creation_date_time timestamp without time zone NOT NULL DEFAULT now(),
    PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS account_information
(
    id      CHARACTER VARYING(36) NOT NULL,
    name    CHARACTER VARYING(20) NOT NULL,
    surname CHARACTER VARYING(20) NOT NULL,
    age     NUMERIC,
    PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS account
(
    id                     CHARACTER VARYING(36) NOT NULL,
    password               CHARACTER VARYING(36) NOT NULL,
    blocked                BOOLEAN               NOT NULL DEFAULT false,
    account_information_id CHARACTER VARYING(36) NOT NULL,
    notes_id               CHARACTER VARYING(36) NOT NULL,

    CONSTRAINT account_information_id FOREIGN KEY (account_information_id)
        REFERENCES account_information (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,

    CONSTRAINT notes_id FOREIGN KEY (notes_id)
        REFERENCES notes (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,

    PRIMARY KEY (id)
);
COMMIT;

SELECT n
FROM notes AS n
         INNER JOIN account AS a ON n.id = a.notes_id
         INNER JOIN account_information ai on a.account_information_id = ai.id
WHERE ai.name = 'Jan' AND ai.surname = 'Kowalski';
