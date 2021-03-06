--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.4
-- Dumped by pg_dump version 9.6.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: projet-integrite-2018-VinSey1; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "projet-integrite-2018-VinSey1" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'French_France.1252' LC_CTYPE = 'French_France.1252';


ALTER DATABASE "projet-integrite-2018-VinSey1" OWNER TO postgres;

\connect -reuse-previous=on "dbname='projet-integrite-2018-VinSey1'"

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: journaliser(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION journaliser() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

DECLARE
	description text;  
    objetAvant text;
    objetApres text;
    operation text;
BEGIN
	objetAvant := '';
    objetApres := '';
    IF TG_OP = 'UPDATE' THEN
    	objetAvant := '[' || OLD.nom || ', ' || OLD.annee || ', ' || OLD.region || ']';
        objetApres := '[' || NEW.nom || ', ' || NEW.annee || ', ' || NEW.region || ']';
        operation := 'MODIFIER';
    END IF;
    IF TG_OP = 'DELETE' THEN
       	objetAvant := '[' || OLD.nom || ', ' || OLD.annee || ', ' || OLD.region || ']';
       	objetApres := '[ ]';
       	operation := 'SUPPRIMER';
    END IF;
    IF TG_OP = 'INSERT' THEN
    	objetAvant := '[ ]';
        objetApres := '[' || NEW.nom || ', ' || NEW.annee || ', ' || NEW.region || ']';
        operation := 'AJOUTER';
    END IF;

	description := objetAvant || ' -> ' || objetApres;
	INSERT INTO journal(moment, operation, objet, description) VALUES(NOW(), operation, '├ëquipe', description);
    RETURN NEW;
END;

$$;


ALTER FUNCTION public.journaliser() OWNER TO postgres;

--
-- Name: nettoyageequipes(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION nettoyageequipes() RETURNS void
    LANGUAGE sql
    AS $$

	TRUNCATE TABLE equipes RESTART IDENTITY CASCADE;

$$;


ALTER FUNCTION public.nettoyageequipes() OWNER TO postgres;

--
-- Name: nettoyagejoueur(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION nettoyagejoueur() RETURNS void
    LANGUAGE sql
    AS $$
	TRUNCATE TABLE joueur RESTART IDENTITY;
$$;


ALTER FUNCTION public.nettoyagejoueur() OWNER TO postgres;

--
-- Name: surveiller(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION surveiller() RETURNS void
    LANGUAGE plpgsql
    AS $$

DECLARE
	equipeCourante RECORD;
    nombre integer;
    moyenne integer;
    checksum text;
BEGIN
	FOR equipeCourante IN
		SELECT * FROM equipes
    LOOP
    	moyenne := AVG(naissance) FROM joueur WHERE equipe = equipeCourante.id;
        nombre := COUNT(*) FROM joueur WHERE equipe = equipeCourante.id;
        checksum := md5(string_agg(joueur.nationalite::text, '' ORDER BY id)) FROM joueur WHERE equipe = equipeCourante.id;
    	INSERT INTO "surveillanceJoueurParEquipe"(moment, "nombreJoueurs", "moyenneNaissance", "checksumNationalite") VALUES(NOW(), nombre, moyenne, checksum);
    END LOOP;
    
    moyenne := AVG(annee) FROM equipes;
    nombre := COUNT(*) FROM equipes;
    checksum := md5(string_agg(equipes.region::text, '' ORDER BY id)) FROM equipes;
    INSERT INTO "surveillanceEquipe"(moment, "nombreEquipes", "moyenneAnnee", "checksumRegion") VALUES(NOW(), nombre, moyenne, checksum);
    
	moyenne := AVG(naissance) FROM joueur;
    nombre := COUNT(*) FROM joueur;
    checksum := md5(string_agg(joueur.nationalite::text, '' ORDER BY id)) FROM joueur;
    INSERT INTO "surveillanceJoueur"(moment, "nombreJoueurs", "moyenneNaissance", "checksumNationalite") VALUES(NOW(), nombre, moyenne, checksum);
END

$$;


ALTER FUNCTION public.surveiller() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: equipes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE equipes (
    id integer NOT NULL,
    nom text,
    region text,
    annee integer
);


ALTER TABLE equipes OWNER TO postgres;

--
-- Name: equipes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE equipes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE equipes_id_seq OWNER TO postgres;

--
-- Name: equipes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE equipes_id_seq OWNED BY equipes.id;


--
-- Name: joueur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE joueur (
    id integer NOT NULL,
    nom text,
    nationalite text,
    equipe integer,
    naissance integer
);


ALTER TABLE joueur OWNER TO postgres;

--
-- Name: joueur_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE joueur_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE joueur_id_seq OWNER TO postgres;

--
-- Name: joueur_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE joueur_id_seq OWNED BY joueur.id;


--
-- Name: journal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE journal (
    id integer NOT NULL,
    moment timestamp with time zone NOT NULL,
    operation text NOT NULL,
    description text,
    objet text NOT NULL
);


ALTER TABLE journal OWNER TO postgres;

--
-- Name: journal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE journal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE journal_id_seq OWNER TO postgres;

--
-- Name: journal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE journal_id_seq OWNED BY journal.id;


--
-- Name: surveillanceEquipe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "surveillanceEquipe" (
    id integer NOT NULL,
    moment time with time zone NOT NULL,
    "nombreEquipes" integer,
    "moyenneAnnee" integer,
    "checksumRegion" text
);


ALTER TABLE "surveillanceEquipe" OWNER TO postgres;

--
-- Name: surveillanceEquipe_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "surveillanceEquipe_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "surveillanceEquipe_id_seq" OWNER TO postgres;

--
-- Name: surveillanceEquipe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "surveillanceEquipe_id_seq" OWNED BY "surveillanceEquipe".id;


--
-- Name: surveillanceJoueur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "surveillanceJoueur" (
    id integer NOT NULL,
    moment time with time zone NOT NULL,
    "nombreJoueurs" integer,
    "moyenneNaissance" integer,
    "checksumNationalite" text
);


ALTER TABLE "surveillanceJoueur" OWNER TO postgres;

--
-- Name: surveillanceJoueurParEquipe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "surveillanceJoueurParEquipe" (
    id integer NOT NULL,
    moment time with time zone NOT NULL,
    "nombreJoueurs" integer,
    "moyenneNaissance" integer,
    "checksumNationalite" text
);


ALTER TABLE "surveillanceJoueurParEquipe" OWNER TO postgres;

--
-- Name: surveillanceJoueurParEquipe_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "surveillanceJoueurParEquipe_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "surveillanceJoueurParEquipe_id_seq" OWNER TO postgres;

--
-- Name: surveillanceJoueurParEquipe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "surveillanceJoueurParEquipe_id_seq" OWNED BY "surveillanceJoueurParEquipe".id;


--
-- Name: surveillanceJoueur_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "surveillanceJoueur_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "surveillanceJoueur_id_seq" OWNER TO postgres;

--
-- Name: surveillanceJoueur_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "surveillanceJoueur_id_seq" OWNED BY "surveillanceJoueur".id;


--
-- Name: equipes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY equipes ALTER COLUMN id SET DEFAULT nextval('equipes_id_seq'::regclass);


--
-- Name: joueur id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY joueur ALTER COLUMN id SET DEFAULT nextval('joueur_id_seq'::regclass);


--
-- Name: journal id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY journal ALTER COLUMN id SET DEFAULT nextval('journal_id_seq'::regclass);


--
-- Name: surveillanceEquipe id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "surveillanceEquipe" ALTER COLUMN id SET DEFAULT nextval('"surveillanceEquipe_id_seq"'::regclass);


--
-- Name: surveillanceJoueur id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "surveillanceJoueur" ALTER COLUMN id SET DEFAULT nextval('"surveillanceJoueur_id_seq"'::regclass);


--
-- Name: surveillanceJoueurParEquipe id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "surveillanceJoueurParEquipe" ALTER COLUMN id SET DEFAULT nextval('"surveillanceJoueurParEquipe_id_seq"'::regclass);


--
-- Data for Name: equipes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO equipes VALUES (1, 'Fnatic', 'Europe', 2009);
INSERT INTO equipes VALUES (13, 'KT Rolsterz', 'Cor├®e', 2005);
INSERT INTO equipes VALUES (3, 'SKT', 'Cor├®e', 2010);
INSERT INTO equipes VALUES (14, 'Test', 'France', 2018);
INSERT INTO equipes VALUES (2, 'Gambit', 'Europe', 2009);
INSERT INTO equipes VALUES (15, 'Cloud 9', '├ëtats-Unis', 2008);
INSERT INTO equipes VALUES (16, 'TestNadine2', 'Qu├®bec', 2018);


--
-- Name: equipes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('equipes_id_seq', 16, true);


--
-- Data for Name: joueur; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO joueur VALUES (4, 'Flo', 'France', 2, 1998);
INSERT INTO joueur VALUES (3, 'Valentin', 'France', 1, 1995);
INSERT INTO joueur VALUES (6, 'John', 'Russie', 2, 1998);
INSERT INTO joueur VALUES (5, 'Micha├½l', 'Canada', 2, 1998);
INSERT INTO joueur VALUES (8, 'Shen', 'Cor├®e', 3, 1998);
INSERT INTO joueur VALUES (7, 'Mike', 'Cor├®e', 3, 1998);
INSERT INTO joueur VALUES (9, 'Neo', 'Cor├®e', 3, 1998);
INSERT INTO joueur VALUES (20, 'Test', 'France', 3, 2001);
INSERT INTO joueur VALUES (21, 'Test1', 'France', 13, 2008);
INSERT INTO joueur VALUES (22, 'Test2', 'Cor├®e', 13, 6523);
INSERT INTO joueur VALUES (2, 'Elliott', 'France', 1, 2000);
INSERT INTO joueur VALUES (1, 'Vincent', 'France', 1, 1998);
INSERT INTO joueur VALUES (23, 'Nadine', 'Qu├®bec', 16, 2017);


--
-- Name: joueur_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('joueur_id_seq', 23, true);


--
-- Data for Name: journal; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO journal VALUES (1, '2018-10-02 23:23:20.862427-04', 'AJOUTER', '[ ] -> [KT Rolster, 2010, Cor├®e]', '├ëquipe');
INSERT INTO journal VALUES (2, '2018-10-02 23:33:33.411174-04', 'MODIFIER', '[KT Rolster, 2010, Cor├®e] -> [KT Rolsterz, 2010, Cor├®e]', '├ëquipe');
INSERT INTO journal VALUES (3, '2018-10-02 23:34:22.281661-04', 'SUPPRIMER', '[KT Rolsterz, 2010, Cor├®e] -> [ ]', '├ëquipe');
INSERT INTO journal VALUES (4, '2018-10-03 01:42:53.283298-04', 'MODIFIER', '[KT Rolsterz, 2010, Cor├®e] -> [KT Rolsterz, 2010, Cor├®e]', '├ëquipe');
INSERT INTO journal VALUES (5, '2018-10-03 01:51:25.290718-04', 'MODIFIER', '[Gambit, 2009, Europe] -> [Gambit, 2009, Europe]', '├ëquipe');
INSERT INTO journal VALUES (6, '2018-10-03 01:51:27.541445-04', 'MODIFIER', '[KT Rolsterz, 2010, Cor├®e] -> [KT Rolsterz, 2010, Cor├®e]', '├ëquipe');
INSERT INTO journal VALUES (7, '2018-10-03 02:01:53.341149-04', 'MODIFIER', '[SKT, 2009, Cor├®e] -> [SKT, 2010, Cor├®e]', '├ëquipe');
INSERT INTO journal VALUES (8, '2018-10-03 02:02:42.887988-04', 'MODIFIER', '[Fnatic, 2000, Europe] -> [Fnatic, 2000, Europe]', '├ëquipe');
INSERT INTO journal VALUES (9, '2018-10-03 02:05:04.205421-04', 'AJOUTER', '[ ] -> [Test, 2018, France]', '├ëquipe');
INSERT INTO journal VALUES (10, '2018-10-03 02:07:54.080975-04', 'MODIFIER', '[Gambit, 2009, Europe] -> [Gambit, 2009, Europe]', '├ëquipe');
INSERT INTO journal VALUES (11, '2018-10-03 02:07:57.698943-04', 'MODIFIER', '[Test, 2018, France] -> [Test, 2018, France]', '├ëquipe');
INSERT INTO journal VALUES (12, '2018-10-03 02:09:17.326483-04', 'MODIFIER', '[KT Rolsterz, 2010, Cor├®e] -> [KT Rolsterz, 2010, Cor├®e]', '├ëquipe');
INSERT INTO journal VALUES (13, '2018-10-03 02:09:22.797138-04', 'MODIFIER', '[Fnatic, 2000, Europe] -> [Fnatic, 2000, Europe]', '├ëquipe');
INSERT INTO journal VALUES (14, '2018-10-03 03:12:49.110779-04', 'MODIFIER', NULL, '├ëquipe');
INSERT INTO journal VALUES (15, '2018-10-03 03:12:49.110779-04', 'MODIFIER', NULL, '├ëquipe');
INSERT INTO journal VALUES (16, '2018-10-03 03:12:49.110779-04', 'MODIFIER', NULL, '├ëquipe');
INSERT INTO journal VALUES (17, '2018-10-03 03:12:49.110779-04', 'MODIFIER', NULL, '├ëquipe');
INSERT INTO journal VALUES (18, '2018-10-03 03:12:49.110779-04', 'MODIFIER', NULL, '├ëquipe');
INSERT INTO journal VALUES (19, '2018-10-03 03:14:09.035555-04', 'MODIFIER', '[Gambit, 2009, Europe] -> [Gambit, 2009, Europe]', '├ëquipe');
INSERT INTO journal VALUES (20, '2018-10-03 03:14:27.516545-04', 'AJOUTER', '[ ] -> [Cloud 9, 2008, ├ëtats-Unis]', '├ëquipe');
INSERT INTO journal VALUES (21, '2018-10-04 12:38:41.531111-04', 'AJOUTER', '[ ] -> [TestNadine, 2018, Qu├®bec]', '├ëquipe');
INSERT INTO journal VALUES (22, '2018-10-04 12:38:49.229709-04', 'MODIFIER', '[TestNadine, 2018, Qu├®bec] -> [TestNadine2, 2018, Qu├®bec]', '├ëquipe');


--
-- Name: journal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('journal_id_seq', 22, true);


--
-- Data for Name: surveillanceEquipe; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "surveillanceEquipe" VALUES (6, '03:35:14.890852-04', 6, 2010, 'c6bbf5fabbbeb091bed6fb81f872a089');
INSERT INTO "surveillanceEquipe" VALUES (7, '03:50:41.526254-04', 6, 2010, 'c6bbf5fabbbeb091bed6fb81f872a089');


--
-- Name: surveillanceEquipe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"surveillanceEquipe_id_seq"', 7, true);


--
-- Data for Name: surveillanceJoueur; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "surveillanceJoueur" VALUES (4, '03:35:14.890852-04', 12, 2376, 'c8ab70d963cecfca428967fd8d3013f8');
INSERT INTO "surveillanceJoueur" VALUES (5, '03:50:41.526254-04', 12, 2376, 'c8ab70d963cecfca428967fd8d3013f8');


--
-- Data for Name: surveillanceJoueurParEquipe; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "surveillanceJoueurParEquipe" VALUES (45, '03:35:14.890852-04', 3, 1998, 'e64905055661cb5561e8493a1484c563');
INSERT INTO "surveillanceJoueurParEquipe" VALUES (46, '03:35:14.890852-04', 2, 4266, '68ccb0f747f65a45a0a344d6de47ae04');
INSERT INTO "surveillanceJoueurParEquipe" VALUES (47, '03:35:14.890852-04', 4, 1999, '57b1ff6f8eaa902ae39492669228e837');
INSERT INTO "surveillanceJoueurParEquipe" VALUES (48, '03:35:14.890852-04', 0, NULL, NULL);
INSERT INTO "surveillanceJoueurParEquipe" VALUES (49, '03:35:14.890852-04', 3, 1998, '43f8fc94ea56ebb8e59704878f94768b');
INSERT INTO "surveillanceJoueurParEquipe" VALUES (50, '03:35:14.890852-04', 0, NULL, NULL);
INSERT INTO "surveillanceJoueurParEquipe" VALUES (51, '03:50:41.526254-04', 3, 1998, 'e64905055661cb5561e8493a1484c563');
INSERT INTO "surveillanceJoueurParEquipe" VALUES (52, '03:50:41.526254-04', 2, 4266, '68ccb0f747f65a45a0a344d6de47ae04');
INSERT INTO "surveillanceJoueurParEquipe" VALUES (53, '03:50:41.526254-04', 4, 1999, '57b1ff6f8eaa902ae39492669228e837');
INSERT INTO "surveillanceJoueurParEquipe" VALUES (54, '03:50:41.526254-04', 0, NULL, NULL);
INSERT INTO "surveillanceJoueurParEquipe" VALUES (55, '03:50:41.526254-04', 3, 1998, '43f8fc94ea56ebb8e59704878f94768b');
INSERT INTO "surveillanceJoueurParEquipe" VALUES (56, '03:50:41.526254-04', 0, NULL, NULL);


--
-- Name: surveillanceJoueurParEquipe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"surveillanceJoueurParEquipe_id_seq"', 56, true);


--
-- Name: surveillanceJoueur_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"surveillanceJoueur_id_seq"', 5, true);


--
-- Name: equipes equipes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY equipes
    ADD CONSTRAINT equipes_pkey PRIMARY KEY (id);


--
-- Name: joueur joueur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY joueur
    ADD CONSTRAINT joueur_pkey PRIMARY KEY (id);


--
-- Name: journal journal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY journal
    ADD CONSTRAINT journal_pkey PRIMARY KEY (id);


--
-- Name: surveillanceEquipe surveillanceEquipe_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "surveillanceEquipe"
    ADD CONSTRAINT "surveillanceEquipe_pkey" PRIMARY KEY (id);


--
-- Name: surveillanceJoueurParEquipe surveillanceJoueurParEquipe_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "surveillanceJoueurParEquipe"
    ADD CONSTRAINT "surveillanceJoueurParEquipe_pkey" PRIMARY KEY (id);


--
-- Name: surveillanceJoueur surveillanceJoueur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "surveillanceJoueur"
    ADD CONSTRAINT "surveillanceJoueur_pkey" PRIMARY KEY (id);


--
-- Name: fki_one_equipe_to_many_joueurs; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_one_equipe_to_many_joueurs ON joueur USING btree (equipe);


--
-- Name: equipes evenementajouterequipe; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER evenementajouterequipe BEFORE INSERT ON equipes FOR EACH ROW EXECUTE PROCEDURE journaliser();


--
-- Name: equipes evenementmodifierequipe; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER evenementmodifierequipe BEFORE UPDATE ON equipes FOR EACH ROW EXECUTE PROCEDURE journaliser();


--
-- Name: equipes evenementsupprimerequipe; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER evenementsupprimerequipe BEFORE DELETE ON equipes FOR EACH ROW EXECUTE PROCEDURE journaliser();


--
-- Name: joueur one_equipe_to_many_joueurs; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY joueur
    ADD CONSTRAINT one_equipe_to_many_joueurs FOREIGN KEY (equipe) REFERENCES equipes(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

