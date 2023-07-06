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

-- Table: Application.employees

-- DROP TABLE IF EXISTS "Application".employees;

CREATE TABLE IF NOT EXISTS "Application".employees
(
    employee_id integer NOT NULL,
    first_name character varying COLLATE pg_catalog."default" NOT NULL,
    last_name character varying COLLATE pg_catalog."default" NOT NULL,
    hire_date date NOT NULL,
    hourly_salary numeric(7,5) NOT NULL,
    title_id integer NOT NULL,
    manager_id integer,
    team integer,
    CONSTRAINT employees_pkey PRIMARY KEY (employee_id),
    CONSTRAINT manager_id FOREIGN KEY (manager_id)
        REFERENCES "Application".employees (employee_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID,
    CONSTRAINT team FOREIGN KEY (team)
        REFERENCES "Application".teams (team_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID,
    CONSTRAINT title_id FOREIGN KEY (title_id)
        REFERENCES "Application".titles (title_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "Application".employees
    OWNER to postgres;

-- Table: Application.teams

-- DROP TABLE IF EXISTS "Application".teams;

CREATE TABLE IF NOT EXISTS "Application".teams
(
    team_id integer NOT NULL,
    team_name character varying COLLATE pg_catalog."default" NOT NULL,
    location character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT teams_pkey PRIMARY KEY (team_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "Application".teams
    OWNER to postgres;