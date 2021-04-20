--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 13.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: retailstores; Type: SCHEMA; Schema: -; Owner: briandunn
--

CREATE SCHEMA retailstores;


ALTER SCHEMA retailstores OWNER TO briandunn;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: sales; Type: TABLE; Schema: retailstores; Owner: briandunn
--

CREATE TABLE retailstores.sales (
    storeid smallint NOT NULL,
    dept character varying(2),
    salesdate date,
    weeklysales money
);


ALTER TABLE retailstores.sales OWNER TO briandunn;

--
-- Name: stores; Type: TABLE; Schema: retailstores; Owner: briandunn
--

CREATE TABLE retailstores.stores (
    storeid integer NOT NULL,
    storetype character varying(2) NOT NULL,
    storesize integer NOT NULL
);


ALTER TABLE retailstores.stores OWNER TO briandunn;

--
-- Name: avgsalesbystoretype; Type: VIEW; Schema: retailstores; Owner: briandunn
--

CREATE VIEW retailstores.avgsalesbystoretype AS
 SELECT st.storetype,
    avg((sa.weeklysales)::numeric) AS averageweeklysales
   FROM (retailstores.stores st
     JOIN retailstores.sales sa ON ((st.storeid = sa.storeid)))
  GROUP BY st.storetype;


ALTER TABLE retailstores.avgsalesbystoretype OWNER TO briandunn;

--
-- Name: features; Type: TABLE; Schema: retailstores; Owner: briandunn
--

CREATE TABLE retailstores.features (
    storeid smallint NOT NULL,
    featuredate date,
    temperature numeric,
    fuelprice numeric,
    cpi numeric,
    unemployment numeric,
    isholiday boolean
);


ALTER TABLE retailstores.features OWNER TO briandunn;

--
-- Name: storesclone; Type: TABLE; Schema: retailstores; Owner: briandunn
--

CREATE TABLE retailstores.storesclone (
    storeid integer,
    storetype character varying(2),
    storesize integer
);


ALTER TABLE retailstores.storesclone OWNER TO briandunn;

--
-- Name: stores stores_pkey; Type: CONSTRAINT; Schema: retailstores; Owner: briandunn
--

ALTER TABLE ONLY retailstores.stores
    ADD CONSTRAINT stores_pkey PRIMARY KEY (storeid);


--
-- Name: features featuresfk; Type: FK CONSTRAINT; Schema: retailstores; Owner: briandunn
--

ALTER TABLE ONLY retailstores.features
    ADD CONSTRAINT featuresfk FOREIGN KEY (storeid) REFERENCES retailstores.stores(storeid);


--
-- Name: sales salesfk; Type: FK CONSTRAINT; Schema: retailstores; Owner: briandunn
--

ALTER TABLE ONLY retailstores.sales
    ADD CONSTRAINT salesfk FOREIGN KEY (storeid) REFERENCES retailstores.stores(storeid);


--
-- PostgreSQL database dump complete
--

