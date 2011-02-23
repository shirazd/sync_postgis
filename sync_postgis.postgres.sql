--
-- PostGIS for Sync PostGIS
-- PLEASE NOTE: This file assumes you have a basic postGIS database created using a postGIS template file. 
-- This 'basic postGIS' can be created on an empty database by running:
-- createdb my_db
-- createlang plpgsql my_db
-- psql -d my_db -f /usr/share/postgresql/8.4/contrib/postgis-1.5/postgis.sql
-- psql -d my_db -f /usr/share/postgresql/8.4/contrib/postgis-1.5/spatial_ref_sys.sql
-- psql -d my_db -f /usr/share/postgresql/8.4/contrib/postgis_comments.sql
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = true;

--
-- Data for Name: geometry_columns; Type: TABLE DATA; Schema: public; Owner: fnfn
--

COPY geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) FROM stdin;
	public	node	geom	2	4326	GEOMETRY
	public	node	geom_albers	2	3005	GEOMETRY
\.

SET default_with_oids = false;

--
-- Name: node; Type: TABLE; Schema: public; Owner: fnfn; Tablespace: 
--

CREATE TABLE node (
    nid integer,
    type text,
    geom geometry,
    geom_albers geometry,
    title text,
    CONSTRAINT enforce_dims_geom CHECK ((st_ndims(geom) = 2)),
    CONSTRAINT enforce_dims_geom_albers CHECK ((st_ndims(geom_albers) = 2)),
    CONSTRAINT enforce_srid_geom CHECK ((st_srid(geom) = 4326)),
    CONSTRAINT enforce_srid_geom_albers CHECK ((st_srid(geom_albers) = 3005))
);

--
-- Name: node_spatial_index_geom; Type: INDEX; Schema: public; Owner: fnfn; Tablespace: 
--

CREATE INDEX node_spatial_index_geom ON node USING gist (geom);


--
-- Name: node_spatial_index_geom_albers; Type: INDEX; Schema: public; Owner: fnfn; Tablespace: 
--

CREATE INDEX node_spatial_index_geom_albers ON node USING gist (geom_albers);



--
-- PostgreSQL database dump complete
--

