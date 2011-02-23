Sync PostGIS for Drupal GeoField / OpenLayers

GeoField:   https://github.com/phayes/geofield
PostGIS:    http://postgis.refractions.net
OpenLayers: http://drupal.org/project/openlayers

This is for Drupal 7

This module syncronizes geofield data from drupal into postGIS so you can make spatial queries, or run GeoServer with it. Drupal / MySQL remains the "Database of Record", but data is replicated into postGIS so that it is more useful.

Installation
------------

1. Create a working postGIS database. 

Generally this involves installation postgres and postgis, creating a database, adding the plpgsql language to the database, adding the spatial-columns table to the database, adding finally spatial-reference tables to the database. Exact set-up varies from distro to distro. A good guide for ubuntu can be found here: 
http://blog.smartlogicsolutions.com/2010/03/04/installing-postgis-1-5-0-on-postgresql-8-4-on-ubuntu-9-10/

2. Run sync_postgis.postgres.sql against your postgis database. This adds our "node" table where we will be storing spatial data.

3. Create your postgres user and check permissions

4. Install module!


Use
---------------

So what the heck can you do now that you have your spatial data happily syncing to postgis?

Well, below is an example where we have two node types "region" and "post". Regions contain polygons and posts are points. Posts contain a field called field_post_region, which is a node-reference to a region (surprise!). Here we are using the postgis database to automatically assign posts to regions based on wether a post is spatially WITHIN a region. Cool!

<?php
function sby_node_presave($node) {
  if ($node->type == 'post') {
    $postgis_id = sby_get_postgis_id($node);
    
    // Get all regions that spatially contain this post
    // Since we are writing raw queries here, be wary of possible injection attack vulnerabilities
    $postgis_query = "
      SELECT regions.nid from 
        (select * from node WHERE type = 'post') as posts 
      INNER JOIN 
        (select * from node where type = 'region') as regions
        ON ST_Contains(regions.geom, posts.geom)
      WHERE posts.id = ".$postgis_id;
    $pgconn = sync_postgis_pgconn();
    $result = pg_query($pgconn,$postgis_query);
    
    // Clear the existing node-reference values and assign
    // TODO: language
    $node->field_post_region['en'] = array();
    while ($nid = pg_fetch_object($result)) {
      $node->field_post_region['en'][]['nid'] = $nid->nid;
    }
    
  }
}

function sby_get_postgis_id($node) {
  foreach ($node->sync_postgis as $id => $item) {
    if ($item['field'] == 'field_post_location') {
      return $id;
    }
  }
}

