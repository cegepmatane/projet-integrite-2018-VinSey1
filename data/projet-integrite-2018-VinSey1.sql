--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.4
-- Dumped by pg_dump version 9.6.4

-- Started on 2018-10-03 03:19:15

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12387)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2199 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 212 (class 1255 OID 24871)
-- Name: enregistrer(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION enregistrer() RETURNS void
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
        checksum := 'ne marche pas';
    	INSERT INTO "surveillanceJoueurParEquipe"(moment, "nombreJoueurs", "moyenneNaissance", "checksumNationalite") VALUES(NOW(), nombre, moyenne, checksum);
    END LOOP;
    
    moyenne := AVG(annee) FROM equipes;
    nombre := COUNT(*) FROM equipes;
    checksum := 'ne marche pas';
    INSERT INTO "surveillanceEquipe"(moment, "nombreEquipes", "moyenneAnnee", "checksumRegion") VALUES(NOW(), nombre, moyenne, checksum);
    
	moyenne := AVG(naissance) FROM joueur;
    nombre := COUNT(*) FROM joueur;
    checksum := 'ne marche pas';
    INSERT INTO "surveillanceJoueur"(moment, "nombreJoueurs", "moyenneNaissance", "checksumNationalite") VALUES(NOW(), nombre, moyenne, checksum);
END

$$;


ALTER FUNCTION public.enregistrer() OWNER TO postgres;

--
-- TOC entry 211 (class 1255 OID 24878)
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
	INSERT INTO journal(moment, operation, objet, description) VALUES(NOW(), operation, 'Équipe', description);
    RETURN NEW;
END;

$$;


ALTER FUNCTION public.journaliser() OWNER TO postgres;

--
-- TOC entry 198 (class 1255 OID 24727)
-- Name: nettoyageequipes(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION nettoyageequipes() RETURNS void
    LANGUAGE sql
    AS $$

	TRUNCATE TABLE equipes RESTART IDENTITY CASCADE;

$$;


ALTER FUNCTION public.nettoyageequipes() OWNER TO postgres;

--
-- TOC entry 197 (class 1255 OID 24728)
-- Name: nettoyagejoueur(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION nettoyagejoueur() RETURNS void
    LANGUAGE sql
    AS $$
	TRUNCATE TABLE joueur RESTART IDENTITY;
$$;


ALTER FUNCTION public.nettoyagejoueur() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 186 (class 1259 OID 24601)
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
-- TOC entry 185 (class 1259 OID 24599)
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
-- TOC entry 2200 (class 0 OID 0)
-- Dependencies: 185
-- Name: equipes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE equipes_id_seq OWNED BY equipes.id;


--
-- TOC entry 188 (class 1259 OID 24612)
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
-- TOC entry 187 (class 1259 OID 24610)
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
-- TOC entry 2201 (class 0 OID 0)
-- Dependencies: 187
-- Name: joueur_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE joueur_id_seq OWNED BY joueur.id;


--
-- TOC entry 190 (class 1259 OID 24800)
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
-- TOC entry 189 (class 1259 OID 24798)
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
-- TOC entry 2202 (class 0 OID 0)
-- Dependencies: 189
-- Name: journal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE journal_id_seq OWNED BY journal.id;


--
-- TOC entry 196 (class 1259 OID 24858)
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
-- TOC entry 195 (class 1259 OID 24856)
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
-- TOC entry 2203 (class 0 OID 0)
-- Dependencies: 195
-- Name: surveillanceEquipe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "surveillanceEquipe_id_seq" OWNED BY "surveillanceEquipe".id;


--
-- TOC entry 194 (class 1259 OID 24850)
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
-- TOC entry 192 (class 1259 OID 24817)
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
-- TOC entry 191 (class 1259 OID 24815)
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
-- TOC entry 2204 (class 0 OID 0)
-- Dependencies: 191
-- Name: surveillanceJoueurParEquipe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "surveillanceJoueurParEquipe_id_seq" OWNED BY "surveillanceJoueurParEquipe".id;


--
-- TOC entry 193 (class 1259 OID 24848)
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
-- TOC entry 2205 (class 0 OID 0)
-- Dependencies: 193
-- Name: surveillanceJoueur_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "surveillanceJoueur_id_seq" OWNED BY "surveillanceJoueur".id;


--
-- TOC entry 2041 (class 2604 OID 24604)
-- Name: equipes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY equipes ALTER COLUMN id SET DEFAULT nextval('equipes_id_seq'::regclass);


--
-- TOC entry 2042 (class 2604 OID 24615)
-- Name: joueur id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY joueur ALTER COLUMN id SET DEFAULT nextval('joueur_id_seq'::regclass);


--
-- TOC entry 2043 (class 2604 OID 24803)
-- Name: journal id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY journal ALTER COLUMN id SET DEFAULT nextval('journal_id_seq'::regclass);


--
-- TOC entry 2046 (class 2604 OID 24861)
-- Name: surveillanceEquipe id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "surveillanceEquipe" ALTER COLUMN id SET DEFAULT nextval('"surveillanceEquipe_id_seq"'::regclass);


--
-- TOC entry 2045 (class 2604 OID 24853)
-- Name: surveillanceJoueur id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "surveillanceJoueur" ALTER COLUMN id SET DEFAULT nextval('"surveillanceJoueur_id_seq"'::regclass);


--
-- TOC entry 2044 (class 2604 OID 24820)
-- Name: surveillanceJoueurParEquipe id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "surveillanceJoueurParEquipe" ALTER COLUMN id SET DEFAULT nextval('"surveillanceJoueurParEquipe_id_seq"'::regclass);


--
-- TOC entry 2182 (class 0 OID 24601)
-- Dependencies: 186
-- Data for Name: equipes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY equipes (id, nom, region, annee) FROM stdin;
1	Fnatic	Europe	2009
13	KT Rolsterz	Corée	2005
3	SKT	Corée	2010
14	Test	France	2018
2	Gambit	Europe	2009
15	Cloud 9	États-Unis	2008
\.


--
-- TOC entry 2206 (class 0 OID 0)
-- Dependencies: 185
-- Name: equipes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('equipes_id_seq', 15, true);


--
-- TOC entry 2184 (class 0 OID 24612)
-- Dependencies: 188
-- Data for Name: joueur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY joueur (id, nom, nationalite, equipe, naissance) FROM stdin;
4	Flo	France	2	1998
3	Valentin	France	1	1995
6	John	Russie	2	1998
5	Michaël	Canada	2	1998
8	Shen	Corée	3	1998
7	Mike	Corée	3	1998
9	Neo	Corée	3	1998
20	Test	France	3	2001
21	Test1	France	13	2008
22	Test2	Corée	13	6523
2	Elliott	France	1	2000
1	Vincent	France	1	1998
\.


--
-- TOC entry 2207 (class 0 OID 0)
-- Dependencies: 187
-- Name: joueur_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('joueur_id_seq', 22, true);


--
-- TOC entry 2186 (class 0 OID 24800)
-- Dependencies: 190
-- Data for Name: journal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY journal (id, moment, operation, description, objet) FROM stdin;
1	2018-10-02 23:23:20.862427-04	AJOUTER	[ ] -> [KT Rolster, 2010, Corée]	Équipe
2	2018-10-02 23:33:33.411174-04	MODIFIER	[KT Rolster, 2010, Corée] -> [KT Rolsterz, 2010, Corée]	Équipe
3	2018-10-02 23:34:22.281661-04	SUPPRIMER	[KT Rolsterz, 2010, Corée] -> [ ]	Équipe
4	2018-10-03 01:42:53.283298-04	MODIFIER	[KT Rolsterz, 2010, Corée] -> [KT Rolsterz, 2010, Corée]	Équipe
5	2018-10-03 01:51:25.290718-04	MODIFIER	[Gambit, 2009, Europe] -> [Gambit, 2009, Europe]	Équipe
6	2018-10-03 01:51:27.541445-04	MODIFIER	[KT Rolsterz, 2010, Corée] -> [KT Rolsterz, 2010, Corée]	Équipe
7	2018-10-03 02:01:53.341149-04	MODIFIER	[SKT, 2009, Corée] -> [SKT, 2010, Corée]	Équipe
8	2018-10-03 02:02:42.887988-04	MODIFIER	[Fnatic, 2000, Europe] -> [Fnatic, 2000, Europe]	Équipe
9	2018-10-03 02:05:04.205421-04	AJOUTER	[ ] -> [Test, 2018, France]	Équipe
10	2018-10-03 02:07:54.080975-04	MODIFIER	[Gambit, 2009, Europe] -> [Gambit, 2009, Europe]	Équipe
11	2018-10-03 02:07:57.698943-04	MODIFIER	[Test, 2018, France] -> [Test, 2018, France]	Équipe
12	2018-10-03 02:09:17.326483-04	MODIFIER	[KT Rolsterz, 2010, Corée] -> [KT Rolsterz, 2010, Corée]	Équipe
13	2018-10-03 02:09:22.797138-04	MODIFIER	[Fnatic, 2000, Europe] -> [Fnatic, 2000, Europe]	Équipe
14	2018-10-03 03:12:49.110779-04	MODIFIER	\N	Équipe
15	2018-10-03 03:12:49.110779-04	MODIFIER	\N	Équipe
16	2018-10-03 03:12:49.110779-04	MODIFIER	\N	Équipe
17	2018-10-03 03:12:49.110779-04	MODIFIER	\N	Équipe
18	2018-10-03 03:12:49.110779-04	MODIFIER	\N	Équipe
19	2018-10-03 03:14:09.035555-04	MODIFIER	[Gambit, 2009, Europe] -> [Gambit, 2009, Europe]	Équipe
20	2018-10-03 03:14:27.516545-04	AJOUTER	[ ] -> [Cloud 9, 2008, États-Unis]	Équipe
\.


--
-- TOC entry 2208 (class 0 OID 0)
-- Dependencies: 189
-- Name: journal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('journal_id_seq', 20, true);


--
-- TOC entry 2192 (class 0 OID 24858)
-- Dependencies: 196
-- Data for Name: surveillanceEquipe; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "surveillanceEquipe" (id, moment, "nombreEquipes", "moyenneAnnee", "checksumRegion") FROM stdin;
3	03:17:59.295314-04	6	2010	ne marche pas
\.


--
-- TOC entry 2209 (class 0 OID 0)
-- Dependencies: 195
-- Name: surveillanceEquipe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"surveillanceEquipe_id_seq"', 3, true);


--
-- TOC entry 2190 (class 0 OID 24850)
-- Dependencies: 194
-- Data for Name: surveillanceJoueur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "surveillanceJoueur" (id, moment, "nombreJoueurs", "moyenneNaissance", "checksumNationalite") FROM stdin;
1	03:17:59.295314-04	12	2376	ne marche pas
\.


--
-- TOC entry 2188 (class 0 OID 24817)
-- Dependencies: 192
-- Data for Name: surveillanceJoueurParEquipe; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "surveillanceJoueurParEquipe" (id, moment, "nombreJoueurs", "moyenneNaissance", "checksumNationalite") FROM stdin;
27	03:17:59.295314-04	3	1998	ne marche pas
28	03:17:59.295314-04	2	4266	ne marche pas
29	03:17:59.295314-04	4	1999	ne marche pas
30	03:17:59.295314-04	0	\N	ne marche pas
31	03:17:59.295314-04	3	1998	ne marche pas
32	03:17:59.295314-04	0	\N	ne marche pas
\.


--
-- TOC entry 2210 (class 0 OID 0)
-- Dependencies: 191
-- Name: surveillanceJoueurParEquipe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"surveillanceJoueurParEquipe_id_seq"', 32, true);


--
-- TOC entry 2211 (class 0 OID 0)
-- Dependencies: 193
-- Name: surveillanceJoueur_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"surveillanceJoueur_id_seq"', 1, true);


--
-- TOC entry 2048 (class 2606 OID 24609)
-- Name: equipes equipes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY equipes
    ADD CONSTRAINT equipes_pkey PRIMARY KEY (id);


--
-- TOC entry 2051 (class 2606 OID 24620)
-- Name: joueur joueur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY joueur
    ADD CONSTRAINT joueur_pkey PRIMARY KEY (id);


--
-- TOC entry 2053 (class 2606 OID 24808)
-- Name: journal journal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY journal
    ADD CONSTRAINT journal_pkey PRIMARY KEY (id);


--
-- TOC entry 2059 (class 2606 OID 24866)
-- Name: surveillanceEquipe surveillanceEquipe_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "surveillanceEquipe"
    ADD CONSTRAINT "surveillanceEquipe_pkey" PRIMARY KEY (id);


--
-- TOC entry 2055 (class 2606 OID 24825)
-- Name: surveillanceJoueurParEquipe surveillanceJoueurParEquipe_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "surveillanceJoueurParEquipe"
    ADD CONSTRAINT "surveillanceJoueurParEquipe_pkey" PRIMARY KEY (id);


--
-- TOC entry 2057 (class 2606 OID 24855)
-- Name: surveillanceJoueur surveillanceJoueur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "surveillanceJoueur"
    ADD CONSTRAINT "surveillanceJoueur_pkey" PRIMARY KEY (id);


--
-- TOC entry 2049 (class 1259 OID 24626)
-- Name: fki_one_equipe_to_many_joueurs; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_one_equipe_to_many_joueurs ON joueur USING btree (equipe);


--
-- TOC entry 2061 (class 2620 OID 24881)
-- Name: equipes evenementajouterequipe; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER evenementajouterequipe BEFORE INSERT ON equipes FOR EACH ROW EXECUTE PROCEDURE journaliser();


--
-- TOC entry 2062 (class 2620 OID 24882)
-- Name: equipes evenementmodifierequipe; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER evenementmodifierequipe BEFORE UPDATE ON equipes FOR EACH ROW EXECUTE PROCEDURE journaliser();


--
-- TOC entry 2063 (class 2620 OID 24883)
-- Name: equipes evenementsupprimerequipe; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER evenementsupprimerequipe BEFORE DELETE ON equipes FOR EACH ROW EXECUTE PROCEDURE journaliser();


--
-- TOC entry 2060 (class 2606 OID 24793)
-- Name: joueur one_equipe_to_many_joueurs; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY joueur
    ADD CONSTRAINT one_equipe_to_many_joueurs FOREIGN KEY (equipe) REFERENCES equipes(id) ON DELETE CASCADE;


-- Completed on 2018-10-03 03:19:15

--
-- PostgreSQL database dump complete
--

