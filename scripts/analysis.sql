
-------------------------------------------------------------AEROSOL_PRE
-- CALCULATE MEAN OF AEROSOL_PRE INSIDE OF PARKS
-- convert raster to vector and create a new table
CREATE TABLE aerosol_pre_vector AS
SELECT val, geom -- selected val and geom from aerosol_pre_vector
FROM (
SELECT dp.*
FROM aerosol_pre_rast, LATERAL ST_DumpAsPolygons(rast) AS dp -- ST_DumpAsPolygons returns a table with val(band value) and geom (poly or multipoly. neighboring pixels of the same value are grouped into multipolygons)
) As foo;

-- calculate mean (optional) of intersection between aerosol and parks
SELECT percentile_cont(0.5) WITHIN GROUP (ORDER BY val) AS median_val
FROM aerosol_pre_vector
JOIN parks -- joining aerosol_pre_vector table with aerosol_pre_vector
ON ST_Intersects(aerosol_pre_vector.geom, parks.geom); -- where the geometries of aerosol_pre_vector and parks intersect

-- manually calculate average and convert NaN values to NULL
SELECT SUM(NULLIF(val, 'NaN')) / COUNT(val) AS average_val
FROM aerosol_pre_vector
JOIN parks
ON ST_Intersects(aerosol_pre_vector.geom, parks.geom);
-- 0.1631164499369558

-- CALCULATE MEAN OF AEROSOL OUTSIDE OF PARKS

SELECT SUM(NULLIF(val, 'NaN')) / COUNT(val) AS average_val
FROM aerosol_pre_vector
LEFT JOIN parks
ON ST_Difference(aerosol_pre_vector.geom, parks.geom) = aerosol_pre_vector.geom;
-- avg val: 0.03640181433373871

-------------------------------------------------------------AEROSOL_DURR
CREATE TABLE aerosol_durr_vector AS
SELECT val, geom
FROM (
SELECT dp.*
FROM aerosol_durr_rast, LATERAL ST_DumpAsPolygons(rast) AS dp
) As foo;

--- mean of entire aerosol

-- calculate mean (optional) of intersection between aerosol and parks
SELECT percentile_cont(0.5) WITHIN GROUP (ORDER BY val) AS median_val
FROM aerosol_durr_vector
JOIN parks
ON ST_Intersects(aerosol_durr_vector.geom, parks.geom);
-- 2.0675547122955322

-- manually calculate average and convert NaN values to NULL
SELECT SUM(NULLIF(val, 'NaN')) / COUNT(val) AS average_val
FROM aerosol_durr_vector
JOIN parks
ON ST_Intersects(aerosol_durr_vector.geom, parks.geom);
-- 2.062055047916361

-- CALCULATE MEAN OF AEROSOL OUTSIDE OF PARKS

SELECT SUM(NULLIF(val, 'NaN')) / COUNT(val) AS average_val
FROM aerosol_durr_vector
LEFT JOIN parks
ON ST_Difference(aerosol_durr_vector.geom, parks.geom) = aerosol_durr_vector.geom;
-- avg val: 1.9572445261879672


-------------------------------------------------------------AEROSOL_POST
CREATE TABLE aerosol_post_vector AS
SELECT val, geom
FROM (
SELECT dp.*
FROM aerosol_post_rast, LATERAL ST_DumpAsPolygons(rast) AS dp
) As foo;

--- mean of entire aerosol

-- calculate mean (optional) of intersection between aerosol and parks
SELECT percentile_cont(0.5) WITHIN GROUP (ORDER BY val) AS median_val
FROM aerosol_post_vector
JOIN parks
ON ST_Intersects(aerosol_post_vector.geom, parks.geom);
-- -0.1525564044713974

-- manually calculate average and convert NaN values to NULL
SELECT SUM(NULLIF(val, 'NaN')) / COUNT(val) AS average_val
FROM aerosol_post_vector
JOIN parks
ON ST_Intersects(aerosol_post_vector.geom, parks.geom);
-- -0.17051270673468436

-- CALCULATE MEAN OF AEROSOL OUTSIDE OF PARKS

SELECT SUM(NULLIF(val, 'NaN')) / COUNT(val) AS average_val
FROM aerosol_post_vector
LEFT JOIN parks
ON ST_Difference(aerosol_post_vector.geom, parks.geom) = aerosol_post_vector.geom;
-- avg val: -0.30599026363376086

------------------------------------ CO PRE

CREATE TABLE co_pre_vector AS
SELECT val, geom
FROM (
SELECT dp.*
FROM co_pre_rast, LATERAL ST_DumpAsPolygons(rast) AS dp
) As foo;

--- mean of entire aerosol

-- calculate mean (optional) of intersection between aerosol and parks
SELECT percentile_cont(0.5) WITHIN GROUP (ORDER BY val) AS median_val
FROM co_pre_vector
JOIN parks
ON ST_Intersects(co_pre_vector.geom, parks.geom);
-- 0.034890878945589066

-- manually calculate average and convert NaN values to NULL
SELECT SUM(NULLIF(val, 'NaN')) / COUNT(val) AS average_val
FROM co_pre_vector
JOIN parks
ON ST_Intersects(co_pre_vector.geom, parks.geom);
-- 0.03454449995197067



-- CALCULATE MEAN OF AEROSOL OUTSIDE OF PARKS
SELECT SUM(NULLIF(val, 'NaN')) / COUNT(val) AS average_val
FROM co_pre_vector
LEFT JOIN parks
ON ST_Difference(co_pre_vector.geom, parks.geom) = co_pre_vector.geom;
-- avg val: 


------------------------------------------------- CO DURR

CREATE TABLE co_durr_vector AS
SELECT val, geom
FROM (
SELECT dp.*
FROM co_durr_rast, LATERAL ST_DumpAsPolygons(rast) AS dp
) As foo;

--- mean of entire aerosol

-- calculate meaian (optional) of intersection between aerosol and parks
SELECT percentile_cont(0.5) WITHIN GROUP (ORDER BY val) AS median_val
FROM co_durr_vector
JOIN parks
ON ST_Intersects(co_durr_vector.geom, parks.geom);
-- 0.09017296880483627

-- manually calculate average and convert NaN values to NULL
SELECT SUM(NULLIF(val, 'NaN')) / COUNT(val) AS average_val
FROM co_durr_vector
JOIN parks
ON ST_Intersects(co_durr_vector.geom, parks.geom);
-- 0.09420179041088476

-- CALCULATE MEAN OF AEROSOL OUTSIDE OF PARKS
SELECT SUM(NULLIF(val, 'NaN')) / COUNT(val) AS average_val
FROM co_durr_vector
LEFT JOIN parks
ON ST_Difference(co_durr_vector.geom, parks.geom) = co_durr_vector.geom;
-- avg val: 0.08792659146550964

-------------------------------------------------- CO Post (NOT YET RUN)

CREATE TABLE co_post_vector AS
SELECT val, geom
FROM (
SELECT dp.*
FROM co_post_rast, LATERAL ST_DumpAsPolygons(rast) AS dp
) As foo;

--- mean of entire aerosol

-- calculate meaian (optional) of intersection between aerosol and parks
SELECT percentile_cont(0.5) WITHIN GROUP (ORDER BY val) AS median_val
FROM co_post_vector
JOIN parks
ON ST_Intersects(co_post_vector.geom, parks.geom);
-- 0.047788169234991074

-- manually calculate average and convert NaN values to NULL
SELECT SUM(NULLIF(val, 'NaN')) / COUNT(val) AS average_val
FROM co_post_vector
JOIN parks
ON ST_Intersects(co_post_vector.geom, parks.geom);
--  0.047632964930155015

-- CALCULATE MEAN OF AEROSOL OUTSIDE OF PARKS
SELECT SUM(NULLIF(val, 'NaN')) / COUNT(val) AS average_val
FROM co_post_vector
LEFT JOIN parks
ON ST_Difference(co_post_vector.geom, parks.geom) = co_post_vector.geom;
-- avg val: 0.04745639917202819



-- Use SQL to identify areas of income below a certain level and above a certain level
-- socialvul_clean
-- pl_pov150 -- percentage of block living below poverty line

-- mean of aerosol_pre >= .75
SELECT SUM(NULLIF(val, 'NaN')) / COUNT(val) AS average_val
FROM aerosol_pre_vector
JOIN (
    SELECT * 
    FROM socialvul_clean 
    WHERE epl_pov150  >= .75) AS pov150
ON ST_Intersects(aerosol_pre_vector.geom, pov150.geom);
-- 0.1847996763345447

-- mean of aerosol_pre <= .25
SELECT SUM(NULLIF(val, 'NaN')) / COUNT(val) AS average_val
FROM aerosol_pre_vector
JOIN (
    SELECT * 
    FROM socialvul_clean 
    WHERE epl_pov150  <= .25) AS pov150
ON ST_Intersects(aerosol_pre_vector.geom, pov150.geom);
-- 0.14817480306347067

-- mean of aerosol_durr >= .75
SELECT SUM(NULLIF(val, 'NaN')) / COUNT(val) AS average_val
FROM aerosol_durr_vector
JOIN (
    SELECT * 
    FROM socialvul_clean 
    WHERE epl_pov150  >= .75) AS pov150
ON ST_Intersects(aerosol_durr_vector.geom, pov150.geom);
-- 2.1261042325867843

-- mean of aerosol_durr <= .25
SELECT SUM(NULLIF(val, 'NaN')) / COUNT(val) AS average_val
FROM aerosol_durr_vector
JOIN (
    SELECT * 
    FROM socialvul_clean 
    WHERE epl_pov150  <= .25) AS pov150
ON ST_Intersects(aerosol_durr_vector.geom, pov150.geom);
-- 1.9966970343047508

-- mean of aerosol_post >= .75
SELECT SUM(NULLIF(val, 'NaN')) / COUNT(val) AS average_val
FROM aerosol_post_vector
JOIN (
    SELECT * 
    FROM socialvul_clean 
    WHERE epl_pov150  >= .75) AS pov150
ON ST_Intersects(aerosol_post_vector.geom, pov150.geom);
-- -0.09579695084130638

-- mean of aerosol_post <= .25
SELECT SUM(NULLIF(val, 'NaN')) / COUNT(val) AS average_val
FROM aerosol_post_vector
JOIN (
    SELECT * 
    FROM socialvul_clean 
    WHERE epl_pov150  <= .25) AS pov150
ON ST_Intersects(aerosol_post_vector.geom, pov150.geom);
-- -0.2176500171382611

-- median of aerosol_durr >= .5
SELECT percentile_cont(0.5) WITHIN GROUP (ORDER BY val) AS median_val
FROM aerosol_durr_vector
JOIN (
    SELECT * 
    FROM socialvul_clean 
    WHERE epl_pov150  >= .50) AS pov150
ON ST_Intersects(aerosol_durr_vector.geom, pov150.geom);
-- 2.131716728210449


-------------------- co_durr vs social vulnerability
-- mean of co_pre >= .75
SELECT SUM(NULLIF(val, 'NaN')) / COUNT(val) AS average_val
FROM co_pre_vector
JOIN (
    SELECT * 
    FROM socialvul_clean 
    WHERE epl_pov150  >= .75) AS pov150
ON ST_Intersects(co_pre_vector.geom, pov150.geom);
-- 0.03457263646324386

-- mean of co_pre <= .75
SELECT SUM(NULLIF(val, 'NaN')) / COUNT(val) AS average_val
FROM co_pre_vector
JOIN (
    SELECT * 
    FROM socialvul_clean 
    WHERE epl_pov150  <= .25) AS pov150
ON ST_Intersects(co_pre_vector.geom, pov150.geom);
-- 0.03416090318846414


-- mean of co_durr >= .75
SELECT SUM(NULLIF(val, 'NaN')) / COUNT(val) AS average_val
FROM co_durr_vector
JOIN (
    SELECT * 
    FROM socialvul_clean 
    WHERE epl_pov150  >= .75) AS pov150
ON ST_Intersects(co_durr_vector.geom, pov150.geom);
-- 0.0956476101881646

-- mean of co_durr <= .75
SELECT SUM(NULLIF(val, 'NaN')) / COUNT(val) AS average_val
FROM co_durr_vector
JOIN (
    SELECT * 
    FROM socialvul_clean 
    WHERE epl_pov150  <= .25) AS pov150
ON ST_Intersects(co_durr_vector.geom, pov150.geom);
-- 0.08910578930923216

-- mean of co_post >= .75
SELECT SUM(NULLIF(val, 'NaN')) / COUNT(val) AS average_val
FROM co_post_vector
JOIN (
    SELECT * 
    FROM socialvul_clean 
    WHERE epl_pov150  >= .75) AS pov150
ON ST_Intersects(co_post_vector.geom, pov150.geom);
-- 0.04787728055152151

-- mean of co_post <= .25
SELECT SUM(NULLIF(val, 'NaN')) / COUNT(val) AS average_val
FROM co_post_vector
JOIN (
    SELECT * 
    FROM socialvul_clean 
    WHERE epl_pov150  <= .25) AS pov150
ON ST_Intersects(co_post_vector.geom, pov150.geom);
-- 


-- median of co durr >= .50 
SELECT percentile_cont(0.5) WITHIN GROUP (ORDER BY val) AS median_val
FROM co_durr_vector
JOIN (
    SELECT * 
    FROM socialvul_clean 
    WHERE epl_pov150  >= .50) AS pov150
ON ST_Intersects(co_durr_vector.geom, pov150.geom);
-- >= .50 == 0.0895862802863121 

-- median of co durr >= .75
SELECT percentile_cont(0.5) WITHIN GROUP (ORDER BY val) AS median_val
FROM co_durr_vector
JOIN (
    SELECT * 
    FROM socialvul_clean 
    WHERE epl_pov150  >= .75) AS pov150
ON ST_Intersects(co_durr_vector.geom, pov150.geom);
-- >= .75 == 0.09054359793663025

-------- everything above this line has been successful 

-- Identify neighborhoods that have with languages other than English spoken at home over 25% (this number may change)










------------------------------------------------------------------
---------- WHAT KUNAL TRIED

SELECT val, ST_ASTEXT(geom)
FROM aerosol_pre_vector;

SELECT ST_ASTEXT(geom)
FROM parks;

SELECT AVG(val) AS mean_val
FROM aerosol_pre_vector
JOIN parks
ON ST_Intersects(aerosol_pre_vector.geom, parks.geom);

WITH dumped AS (
    SELECT (ST_Dump(geom)).geom
    FROM parks
)
SELECT AVG(val) AS mean_val
FROM aerosol_pre_vector
JOIN dumped
ON ST_Intersects(aerosol_pre_vector.geom, dumped.geom);

SELECT a.id
FROM dumped a
JOIN dumped b ON ST_Intersects(a.geom, b.geom)
WHERE b.id = 999 AND a.id != b.id

-- he would like to be try to find intersection between the geom and the raster
SELECT rast,(st_summarystats(st_clip(aerosol_pre_rast.rast, parks.geom))).*
FROM aerosol_pre_rast, parks
WHERE st_intersects(aerosol_pre_rast.rast,parks.geom);

/*
ERROR:  out of memory
DETAIL:  Failed on request of size 217554865 in memory context "printtup".
*/
-- I NEED TO CHOOSE A POINT IN A POLYGON AND FIND THE DISTANCE OF ALL THE OTHER POLYGONS FROM THAT POINT
---------------------------



-- convert NDVI to geometry ST_Polygon(maybe)

-- something about elevation, selected vegetation that is a above a certain elevation for canopy(?)

-- converts rast to points and saves it as a new table in POSTGIS format
CREATE TABLE apre_points AS
SELECT ST_SetSRID(ST_MakePoint(x, y), 4326) AS geom, val
FROM (SELECT (ST_PixelAsPoints(rast, 1)).* FROM aerosol_pre_rast) apre;

-- intersect/ join apre and parks and get the mean value from the val column of the points
SELECT AVG(val) AS mean_val
FROM apre_points
JOIN parks
ON ST_Intersects(apre_points.geom, parks.geom);
------

CREATE TABLE evi_points AS
SELECT ST_SetSRID(ST_MakePoint(x, y), 4326) AS geom, val
FROM (SELECT (ST_PixelAsPoints(rast, 1)).* FROM evi_nyc_rast) evi;

-- intersect/ join apre and parks and get the mean value from the val column of the points
SELECT AVG(val) AS mean_val
FROM apre_points
JOIN parks
ON ST_Intersects(apre_points.geom, parks.geom);

--------------


--- combination of above.
SELECT ST_Quantile(ST_Intersects(apre.geom, parks.geom))
FROM (SELECT (ST_PixelAsPoints(rast, 1)).* AS geom FROM aerosol_pre_rast) apre, parks;

SELECT ST_Quantile(ST_Union(apre.geom))
FROM (SELECT (ST_PixelAsPoints(rast, 1)).* AS geom FROM aerosol_pre_rast) apre
JOIN parks
ON ST_Intersects(apre.geom, parks.geom);



-- Select the CO Index over the parks/vegetated areas
-- clip co index rast to the parks veg areas
-- calculate the mean over that area

-- Select the aerosol index over the parks/vegetated areas
-- clip aerosol index rast to the parks veg areas
-- calculate the mean over that area



----------
-- do the inverse, so get average for non- veg areas

-- Select the CO Index over the NON parks/vegetated areas
-- clip co index rast to the non parks veg areas
-- calculate the mean over that area

-- Select the aerosol index over the non parks/vegetated areas will this require converting raster to vector?
-- clip aerosol index rast to the non parks veg areas
-- calculate the mean over that area



-- find the average income for each neighborhood (social vuln and )

--Do the same for Each neighborhood – see how those areas compare to pre/during/post values 



-- some sort of raster subtraction to ID areas of highest recovery/ most difference (ie. post - durring, pre- durring etc )