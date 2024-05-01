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
LIMIT 100; -- Sample 100 rows


SELECT *
FROM co_pre_vector
JOIN (
    SELECT * 
    FROM socialvul_clean 
    WHERE epl_pov150 <= 0.25
) AS pov150
ON ST_Intersects(co_pre_vector.geom, pov150.geom)
ORDER BY RANDOM()
LIMIT 100;