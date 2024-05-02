/*

-- Clio V Bate
-- Created 04/18/2024
-- Google Cloud Console 
-- Postgres 16

*/ 

-- Before starting......
-- Connect to database in SQL Shell
-- gcloud sql connect postgres --user=postgres --database=NYCAirQuality --quiet


-- a lot of the tables contain extraneous information, so to simplify things 
-- create new tables with only the desired columns and populate them from the originals
CREATE TABLE parks_clean (
    gid int PRIMARY KEY,
    acres numeric,
    address varchar(254),
    borough varchar(254),
    class varchar (254),
    geom GEOMETRY
);

INSERT INTO parks_clean(gid, acres, address, borough, class, geom)
SELECT gid, acres, address, borough, class, geom
FROM parks;
---------------------------------------------

CREATE TABLE boro_clean(
gid int PRIMARY KEY,
boro_name varchar(254),
shape_area numeric,
shape_length numeric,
geom GEOMETRY
);

INSERT INTO boro_clean(gid, boro_name, shape_area, shape_length, geom)
SELECT gid, boro_name, shape_area, shape_leng, geom
FROM buroughbounds;

------------------------------------------------------------
CREATE TABLE neighborhoods_clean(
gid int PRIMARY KEY,
boroname varchar(254),
countyfips varchar(254),
geom GEOMETRY
);

INSERT INTO neighborhoods_clean(gid, boroname, countyfips, geom)
SELECT gid, boroname, countyfips, geom
FROM neighborshoods;

------------------------------------------------------------

CREATE TABLE socialVul_clean(
gid int PRIMARY KEY,
ep_hburd numeric, -- cost burdened housing units
ep_limeng numeric, -- limited eng
epl_pov150 numeric, -- percent under poverty line
ep_minrty numeric,  --percent minority
epl_nohsdp numeric, -- persons over 25 with no hsd
rpl_theme1 numeric, -- percentile ranking of soc. econ. status
shape__are numeric,
shape__len numeric,
geom GEOMETRY    
);

INSERT INTO socialVul_clean(gid,ep_hburd, ep_limeng, epl_pov150, ep_minrty, epl_nohsdp, rpl_theme1, shape__are, shape__len, geom)
SELECT gid,ep_hburd, ep_limeng, epl_pov150, ep_minrty, epl_nohsdp, rpl_theme1, shape__are, shape__len, geom
FROM cdc_social_vuln_20_project;

-----------------------------------------
CREATE TABLE nycboundary_clean(

    
);