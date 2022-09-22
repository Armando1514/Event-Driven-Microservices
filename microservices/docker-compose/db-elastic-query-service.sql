-- START IMPORT FOR ELASTIC-QUERY-SERVICE




DROP TABLE IF EXISTS public.users CASCADE;

CREATE TABLE public.users
(
    id uuid NOT NULL,
    username character varying COLLATE pg_catalog."default",
    firstname character varying COLLATE pg_catalog."default",
    lastname character varying COLLATE pg_catalog."default",
    CONSTRAINT users_pkey PRIMARY KEY (id)
)

    TABLESPACE pg_default;

ALTER TABLE public.users
    OWNER to postgres;

DROP TABLE IF EXISTS public.documents CASCADE;

CREATE TABLE public.documents
(
    id uuid NOT NULL,
    document_id character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT documents_pkey PRIMARY KEY (id)
)

    TABLESPACE pg_default;

ALTER TABLE public.documents
    OWNER to postgres;

DROP TABLE IF EXISTS public.user_permissions CASCADE;

CREATE TABLE public.user_permissions
(
    user_id uuid NOT NULL,
    document_id uuid NOT NULL,
    user_permission_id uuid NOT NULL,
    permission_type character varying COLLATE pg_catalog."default",
    CONSTRAINT document_fk FOREIGN KEY (document_id)
        REFERENCES public.documents (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT user_fk FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

    TABLESPACE pg_default;

ALTER TABLE public.user_permissions
    OWNER to postgres;

CREATE INDEX "fki_USER_FK"
    ON public.user_permissions USING btree
    (user_id ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX fki_document_fk
    ON public.user_permissions USING btree
    (document_id ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";


INSERT INTO public.users(
    id, username, firstname, lastname)
VALUES ('edd8fe96-cf80-4bcf-b39e-7428d83ca4c8', 'app_user', 'Standard', 'User');
INSERT INTO public.users(
    id, username, firstname, lastname)
VALUES ('e41bd033-77df-4e07-8d38-eb5498998873', 'app_admin', 'Admin', 'User');
INSERT INTO public.users(
    id, username, firstname, lastname)
VALUES ('388258cb-1542-4104-920d-87e04a0381d5', 'app_super_user', 'Super', 'User');


insert into documents(id, document_id)
values ('c1df7d01-4bd7-40b6-86da-7e2ffabf37f7', 1);
insert into documents(id, document_id)
values ('f2b2d644-3a08-4acb-ae07-20569f6f2a01', 2);
insert into documents(id, document_id)
values ('90573d2b-9a5d-409e-bbb6-b94189709a19', 3);

insert into user_permissions(user_permission_id, user_id, document_id, permission_type)
values (uuid_generate_v4(),'edd8fe96-cf80-4bcf-b39e-7428d83ca4c8', 'c1df7d01-4bd7-40b6-86da-7e2ffabf37f7', 'READ');

insert into user_permissions(user_permission_id, user_id, document_id, permission_type)
values (uuid_generate_v4(),'e41bd033-77df-4e07-8d38-eb5498998873', 'c1df7d01-4bd7-40b6-86da-7e2ffabf37f7', 'READ');

insert into user_permissions(user_permission_id, user_id, document_id, permission_type)
values (uuid_generate_v4(),'e41bd033-77df-4e07-8d38-eb5498998873', 'f2b2d644-3a08-4acb-ae07-20569f6f2a01', 'READ');

insert into user_permissions(user_permission_id, user_id, document_id, permission_type)
values (uuid_generate_v4(), 'e41bd033-77df-4e07-8d38-eb5498998873', '90573d2b-9a5d-409e-bbb6-b94189709a19', 'READ');

insert into user_permissions(user_permission_id, user_id, document_id, permission_type)
values (uuid_generate_v4(), '388258cb-1542-4104-920d-87e04a0381d5', 'c1df7d01-4bd7-40b6-86da-7e2ffabf37f7', 'READ');




-- END IMPORT FOR ELASTIC-QUERY-SERVICE

-- START IMPORT FOR ANALYTICS SERVICE
CREATE SCHEMA analytics;


ALTER SCHEMA analytics OWNER TO postgres;

CREATE TABLE analytics.twitter_analytics (
                                             id uuid NOT NULL,
                                             word character varying NOT NULL,
                                             word_count bigint NOT NULL,
                                             record_date time with time zone NOT NULL
);



ALTER TABLE analytics.twitter_analytics OWNER TO postgres;

CREATE INDEX "INDEX_WORD_BY_DATE"
    ON analytics.twitter_analytics USING btree
    (word COLLATE pg_catalog."default" ASC NULLS LAST, record_date DESC NULLS LAST)



-- END IMPORT FOR ANALYTICS SERVICE