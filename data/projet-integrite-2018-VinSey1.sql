--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.4
-- Dumped by pg_dump version 9.6.4

-- Started on 2018-09-13 16:27:51

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
-- TOC entry 2144 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

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
-- TOC entry 2145 (class 0 OID 0)
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
-- TOC entry 2146 (class 0 OID 0)
-- Dependencies: 187
-- Name: joueur_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE joueur_id_seq OWNED BY joueur.id;


--
-- TOC entry 2009 (class 2604 OID 24604)
-- Name: equipes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY equipes ALTER COLUMN id SET DEFAULT nextval('equipes_id_seq'::regclass);


--
-- TOC entry 2010 (class 2604 OID 24615)
-- Name: joueur id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY joueur ALTER COLUMN id SET DEFAULT nextval('joueur_id_seq'::regclass);


--
-- TOC entry 2135 (class 0 OID 24601)
-- Dependencies: 186
-- Data for Name: equipes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY equipes (id, nom, annee, region) FROM stdin;
5			
6			
7			
8			
3	SKT	2009	Corée
9	Test	Oui	OUAIS
4			
2	Gambit	2011	Europe
1	Fnatic	2011	Europe
\.


--
-- TOC entry 2147 (class 0 OID 0)
-- Dependencies: 185
-- Name: equipes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('equipes_id_seq', 9, true);


--
-- TOC entry 2137 (class 0 OID 24612)
-- Dependencies: 188
-- Data for Name: joueur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY joueur (id, nom, nationalite, naissance, equipe) FROM stdin;
2	Vincent	France	05/11/1998\n	1
1	Valentin	France	04/11/1994	1
3	Youssef	France	?/?/1998	2
\.


--
-- TOC entry 2148 (class 0 OID 0)
-- Dependencies: 187
-- Name: joueur_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('joueur_id_seq', 1, false);


--
-- TOC entry 2012 (class 2606 OID 24609)
-- Name: equipes equipes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY equipes
    ADD CONSTRAINT equipes_pkey PRIMARY KEY (id);


--
-- TOC entry 2015 (class 2606 OID 24620)
-- Name: joueur joueur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY joueur
    ADD CONSTRAINT joueur_pkey PRIMARY KEY (id);


--
-- TOC entry 2013 (class 1259 OID 24626)
-- Name: fki_one_equipe_to_many_joueurs; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_one_equipe_to_many_joueurs ON joueur USING btree (equipe);


--
-- TOC entry 2016 (class 2606 OID 24621)
-- Name: joueur one_equipe_to_many_joueurs; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY joueur
    ADD CONSTRAINT one_equipe_to_many_joueurs FOREIGN KEY (equipe) REFERENCES equipes(id);


-- Completed on 2018-09-13 16:27:51

--
-- PostgreSQL database dump complete
--

