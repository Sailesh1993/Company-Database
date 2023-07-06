-- Table: Application.titles

-- DROP TABLE IF EXISTS "Application".titles;

CREATE TABLE IF NOT EXISTS "Application".titles
(
    title_id integer NOT NULL DEFAULT nextval('"Application".titles_title_id_seq'::regclass),
    title_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT titles_pkey PRIMARY KEY (title_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "Application".titles
    OWNER to postgres;