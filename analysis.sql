CREATE TABLE aerosol_pre_vector AS
SELECT val, geom
FROM (
SELECT dp.*
FROM aerosol_pre_rast, LATERAL ST_DumpAsPolygons(rast) AS dp
) As foo;

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