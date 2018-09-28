--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.4
-- Dumped by pg_dump version 9.6.4

-- Started on 2018-09-28 18:11:52

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
-- TOC entry 2158 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 192 (class 1255 OID 24727)
-- Name: nettoyageequipes(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION nettoyageequipes() RETURNS void
    LANGUAGE sql
    AS $$

	TRUNCATE TABLE equipes RESTART IDENTITY CASCADE;

$$;


ALTER FUNCTION public.nettoyageequipes() OWNER TO postgres;

--
-- TOC entry 191 (class 1255 OID 24728)
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
    annee text,
    region text
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
-- TOC entry 2159 (class 0 OID 0)
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
    naissance text,
    equipe integer
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
-- TOC entry 2160 (class 0 OID 0)
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
-- TOC entry 2161 (class 0 OID 0)
-- Dependencies: 189
-- Name: journal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE journal_id_seq OWNED BY journal.id;


--
-- TOC entry 2018 (class 2604 OID 24604)
-- Name: equipes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY equipes ALTER COLUMN id SET DEFAULT nextval('equipes_id_seq'::regclass);


--
-- TOC entry 2019 (class 2604 OID 24615)
-- Name: joueur id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY joueur ALTER COLUMN id SET DEFAULT nextval('joueur_id_seq'::regclass);


--
-- TOC entry 2020 (class 2604 OID 24803)
-- Name: journal id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY journal ALTER COLUMN id SET DEFAULT nextval('journal_id_seq'::regclass);


--
-- TOC entry 2147 (class 0 OID 24601)
-- Dependencies: 186
-- Data for Name: equipes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY equipes (id, nom, annee, region) FROM stdin;
2	Gambit	2009	Europe
1	Fnatic	2009	Europe
3	SKT	2009	Corée
\.


--
-- TOC entry 2162 (class 0 OID 0)
-- Dependencies: 185
-- Name: equipes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('equipes_id_seq', 3, true);


--
-- TOC entry 2149 (class 0 OID 24612)
-- Dependencies: 188
-- Data for Name: joueur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY joueur (id, nom, nationalite, naissance, equipe) FROM stdin;
2	Eliott	France	05/11/1998	1
3	Valentin	France	05/11/1998	1
4	Youssef	France	05/11/1998	2
5	Michaël	Canada	05/11/1998	2
6	John	Russie	05/11/1998	2
7	Mike	Corée	05/11/1998	3
8	Shen	Corée	05/11/1998	3
9	Neo	Corée	05/11/1998	3
1	Vincent	France	05/11/1998	1
14	Faker	Corée	11/09/1995	3
15	Youssef2	Corée	ouais	2
\.


--
-- TOC entry 2163 (class 0 OID 0)
-- Dependencies: 187
-- Name: joueur_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('joueur_id_seq', 15, true);


--
-- TOC entry 2151 (class 0 OID 24800)
-- Dependencies: 190
-- Data for Name: journal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY journal (id, moment, operation, description, objet) FROM stdin;
\.


--
-- TOC entry 2164 (class 0 OID 0)
-- Dependencies: 189
-- Name: journal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('journal_id_seq', 1, false);


--
-- TOC entry 2022 (class 2606 OID 24609)
-- Name: equipes equipes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY equipes
    ADD CONSTRAINT equipes_pkey PRIMARY KEY (id);


--
-- TOC entry 2025 (class 2606 OID 24620)
-- Name: joueur joueur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY joueur
    ADD CONSTRAINT joueur_pkey PRIMARY KEY (id);


--
-- TOC entry 2027 (class 2606 OID 24808)
-- Name: journal journal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY journal
    ADD CONSTRAINT journal_pkey PRIMARY KEY (id);


--
-- TOC entry 2023 (class 1259 OID 24626)
-- Name: fki_one_equipe_to_many_joueurs; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_one_equipe_to_many_joueurs ON joueur USING btree (equipe);


--
-- TOC entry 2028 (class 2606 OID 24793)
-- Name: joueur one_equipe_to_many_joueurs; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY joueur
    ADD CONSTRAINT one_equipe_to_many_joueurs FOREIGN KEY (equipe) REFERENCES equipes(id) ON DELETE CASCADE;


-- Completed on 2018-09-28 18:11:52

--
-- PostgreSQL database dump complete
--

