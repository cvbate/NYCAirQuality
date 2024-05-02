
----------------------------------------------------------------------- AEROSOL PRE
SELECT *
FROM aerosol_pre_vector
JOIN (
    SELECT * 
    FROM socialvul_clean 
    WHERE epl_pov150 >= 0.75
) AS pov150
ON ST_Intersects(aerosol_pre_vector.geom, pov150.geom)
ORDER BY RANDOM()
LIMIT 750; -- Sample 750 rows

SELECT *
FROM aerosol_pre_vector
JOIN (
    SELECT * 
    FROM socialvul_clean 
    WHERE epl_pov150 <= 0.25
) AS pov150
ON ST_Intersects(aerosol_pre_vector.geom, pov150.geom)
ORDER BY RANDOM()
LIMIT 750; -- Sample 750 rows




----------------------------------------------------------------------- AEROSOL DUR

SELECT *
FROM aerosol_durr_vector
JOIN (
    SELECT * 
    FROM socialvul_clean 
    WHERE epl_pov150 >= 0.75
) AS pov150
ON ST_Intersects(aerosol_durr_vector.geom, pov150.geom)
ORDER BY RANDOM()
LIMIT 750; -- Sample 750 rows

SELECT *
FROM aerosol_durr_vector
JOIN (
    SELECT * 
    FROM socialvul_clean 
    WHERE epl_pov150 <= 0.25
) AS pov150
ON ST_Intersects(aerosol_durr_vector.geom, pov150.geom)
ORDER BY RANDOM()
LIMIT 750; -- Sample 750 rows

----------------------------------------------------------------------- AEROSOL POST

SELECT *
FROM aerosol_post_vector
JOIN (
    SELECT * 
    FROM socialvul_clean 
    WHERE epl_pov150 >= 0.75
) AS pov150
ON ST_Intersects(aerosol_post_vector.geom, pov150.geom)
ORDER BY RANDOM()
LIMIT 750; -- Sample 750 rows

SELECT *
FROM aerosol_post_vector
JOIN (
    SELECT * 
    FROM socialvul_clean 
    WHERE epl_pov150 <= 0.25
) AS pov150
ON ST_Intersects(aerosol_post_vector.geom, pov150.geom)
ORDER BY RANDOM()
LIMIT 750; -- Sample 750 rows

----------------------------------------------------------------------- 
--------------------------------------CO
----------------------------------------------------------------------- CO PRE
-- Sample a specific number of rows
SELECT *
FROM co_pre_vector
JOIN (
    SELECT * 
    FROM socialvul_clean 
    WHERE epl_pov150 >= 0.75
) AS pov150
ON ST_Intersects(co_pre_vector.geom, pov150.geom)
ORDER BY RANDOM()
LIMIT 750; -- Sample 750 rows


SELECT *
FROM co_pre_vector
JOIN (
    SELECT * 
    FROM socialvul_clean 
    WHERE epl_pov150 <= 0.25
) AS pov150
ON ST_Intersects(co_pre_vector.geom, pov150.geom)
ORDER BY RANDOM()
LIMIT 750;

----------------------------------------------------------------------- CO DUR

SELECT *
FROM co_durr_vector
JOIN (
    SELECT * 
    FROM socialvul_clean 
    WHERE epl_pov150 >= 0.75
) AS pov150
ON ST_Intersects(co_durr_vector.geom, pov150.geom)
ORDER BY RANDOM()
LIMIT 750; -- Sample 100 rows

SELECT *
FROM co_durr_vector
JOIN (
    SELECT * 
    FROM socialvul_clean 
    WHERE epl_pov150 >= 0.25
) AS pov150
ON ST_Intersects(co_durr_vector.geom, pov150.geom)
ORDER BY RANDOM()
LIMIT 750; -- Sample 100 rows

----------------------------------------------------------------------- CO POST
SELECT *
FROM co_post_vector
JOIN (
    SELECT * 
    FROM socialvul_clean 
    WHERE epl_pov150 >= 0.75
) AS pov150
ON ST_Intersects(co_post_vector.geom, pov150.geom)
ORDER BY RANDOM()
LIMIT 750; -- Sample 100 rows

SELECT *
FROM co_post_vector
JOIN (
    SELECT * 
    FROM socialvul_clean 
    WHERE epl_pov150 >= 0.25
) AS pov150
ON ST_Intersects(co_post_vector.geom, pov150.geom)
ORDER BY RANDOM()
LIMIT 750; -- Sample 100 rows