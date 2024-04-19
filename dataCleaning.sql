/*

-- Clio V Bate
-- Created 04/18/2024
-- Google Cloud Console 
-- Postgres 16

*/ 

-- Before starting......
-- Connect to database in SQL Shell
-- gcloud sql connect postgres --user=postgres --quiet


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

CREATE TABLE cencustracts_clean(

    
);

CREATE TABLE nycboundary_clean(

    
);