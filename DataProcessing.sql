-- Connect to database in SQL Shell
CREATE DATABASE "NYCAirQuality";

\c NYCAirQuality;

CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS postgis_raster;
------------------------------------------------------------------------
-- Google Cloud Console 

-- Vector
-- In CloudShell/Terminal
-- navigate to where data is stored
cd NYCAirQuality/DATA_REPROJECTED

shp2pgsql -s 4326 -I buroughbounds.shp public.buroughbounds > buroughbounds.sql

-- Raster
-- for connecting to cloud storage to convert files to .sql
-- first navigate to the folder you want to hold your data!
-- cvalentinebate@cloudshell:~/rast (nycairquality)$ 

-- Transfer to "local" directory

-- aerosol
gsutil cp gs://gee_data_nyc/aerosol_durr.tif aerosol_durr.tif
gsutil cp gs://gee_data_nyc/aerosol_post.tif aerosol_post.tif 
gsutil cp gs://gee_data_nyc/aerosol_pre.tif aerosol_pre.tif
-- co
gsutil cp gs://gee_data_nyc/co_durr.tif co_durr.tif
gsutil cp gs://gee_data_nyc/co_post.tif co_post.tif
gsutil cp gs://gee_data_nyc/co_pre.tif co_pre.tif
-- ndvi
gsutil cp gs://gee_data_nyc/evi_nyc.tif evi_nyc.tif
/* --example output:

Copying gs://gee_data_nyc/aerosol_durr.tif...
 / [1 files][  1.9 MiB/  1.9 MiB]   
 
 */
 

raster2pgsql -s 4326 -I -C -M aerosol_durr.tif public.aerosol_durr_rast > aerosol_durr.sql
-- Processing 1/1: aerosol_durr.tif

