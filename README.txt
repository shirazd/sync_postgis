Sync PostGIS for Drupal GeoField / OpenLayers

GeoField:   https://github.com/phayes/geofield
PostGIS:    http://postgis.refractions.net
OpenLayers: http://drupal.org/project/openlayers

This is for Drupal 7

This module syncronizes geofield data from drupal into postGIS so you can make spatial queries, or run GeoServer with it. Drupal / MySQL remains the "Database of Record", but data is replicated into postGIS so that it is more useful.

Installation:

1. Create a working postGIS database. 

Generally this involves installation postgres and postgis, creating a database, adding the plpgsql language to the database, adding the spatial-columns table to the database, adding finally spatial-reference tables to the database. Exact set-up varies from distro to distro. A good guide for ubuntu can be found here: 
http://blog.smartlogicsolutions.com/2010/03/04/installing-postgis-1-5-0-on-postgresql-8-4-on-ubuntu-9-10/

2. Run sync_postgis.postgres.sql against your postgis database. This adds our "node" table where we will be storing spatial data.

3. Create your postgres user and check permissions

4. Install module!
