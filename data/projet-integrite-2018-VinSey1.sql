--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.4
-- Dumped by pg_dump version 9.6.4

-- Started on 2018-09-12 19:19:23

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
-- TOC entry 2130 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 186 (class 1259 OID 24590)
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
-- TOC entry 185 (class 1259 OID 24588)
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
-- TOC entry 2131 (class 0 OID 0)
-- Dependencies: 185
-- Name: equipes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE equipes_id_seq OWNED BY equipes.id;


--
-- TOC entry 2002 (class 2604 OID 24593)
-- Name: equipes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY equipes ALTER COLUMN id SET DEFAULT nextval('equipes_id_seq'::regclass);


--
-- TOC entry 2123 (class 0 OID 24590)
-- Dependencies: 186
-- Data for Name: equipes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY equipes (id, nom, annee, region) FROM stdin;
2	Fnatic	2011	Europe
1	Gambit	2011	Europe
3	SKT	2013	Corée
\.


--
-- TOC entry 2132 (class 0 OID 0)
-- Dependencies: 185
-- Name: equipes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('equipes_id_seq', 1, false);


--
-- TOC entry 2004 (class 2606 OID 24598)
-- Name: equipes equipes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY equipes
    ADD CONSTRAINT equipes_pkey PRIMARY KEY (id);


-- Completed on 2018-09-12 19:19:23

--
-- PostgreSQL database dump complete
--

