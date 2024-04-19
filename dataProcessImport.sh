
'
-- Clio V Bate
-- Created 04/15/2024
-- Last updated 04/18/2024
-- Google Cloud Console 
-- Postgres 16
'

#Before starting......
#Connect to database in SQL Shell
'
CREATE DATABASE "NYCAirQuality";

\c NYCAirQuality;

CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS postgis_raster;'
------------------------------------------------------------------------

#---------------Step 1: use wsl from command prompt

#Convert shp to sql file using shp2pgsql. This data is stored "locally" in a cloned GitRepository in Cloud Console. In CloudShell/Terminal navigate to where data is stored
shp2pgsql -s 4326 -I buroughbounds.shp public.buroughbounds > buroughbounds.sql
shp2pgsql -s 4326 -I CDC_Social_Vuln_20_project.shp public.CDC_Social_Vuln_20_project > social_vuln.sql
shp2pgsql -s 4326 -I neighborshoods.shp public.neighborshoods > neighborshoods.sql
shp2pgsql -s 4326 -I parks.shp public.parks > parks.sql
shp2pgsql -s 4326 -I nycbound_proj.shp public.nycbound_proj > nycbound_proj.sql

#------------------------------------------------------------------------
#Raster/ One nyc bounds shp
#Transfer to "local" directory using gsutil UTI to connect to Cloud Storage
#nyc boundary vector
gsutil cp gs://gee_data_nyc/nycboundary/nycboundary.shp nycboundary.shp
#aerosol
gsutil cp gs://gee_data_nyc/aerosol_durr.tif aerosol_durr.tif
gsutil cp gs://gee_data_nyc/aerosol_post.tif aerosol_post.tif 
gsutil cp gs://gee_data_nyc/aerosol_pre.tif aerosol_pre.tif
#co
gsutil cp gs://gee_data_nyc/co_durr.tif co_durr.tif
gsutil cp gs://gee_data_nyc/co_post.tif co_post.tif
gsutil cp gs://gee_data_nyc/co_pre.tif co_pre.tif
#ndvi
gsutil cp gs://gee_data_nyc/evi_nyc.tif evi_nyc.tif

#potential issue with this?
'
Unable to open nycboundary.shx or nycboundary.SHX. Set SHAPE_RESTORE_SHX config option to YES to restore or create it.
nycboundary.shp: dbf file (.dbf) can not be opened
-- however, its in the dir(?)
'

#Convert .shp to .sql file using shp2pgsql
#vector file
shp2pgsql -s 4326 -I nycboundary.shp public.nycboundary > nycboundary.sql 

#Convert .tif to .sql file using raster2pgsql
#raster aerosol
raster2pgsql -s 4326 -I -C -M aerosol_durr.tif public.aerosol_durr_rast > aerosol_durr.sql
raster2pgsql -s 4326 -I -C -M aerosol_post.tif public.aerosol_post_rast > aerosol_post.sql
raster2pgsql -s 4326 -I -C -M aerosol_pre.tif public.aerosol_pre_rast > aerosol_pre.sql
#co
raster2pgsql -s 4326 -I -C -M co_durr.tif public.co_durr_rast > co_durr.sql
raster2pgsql -s 4326 -I -C -M co_post.tif public.co_post_rast > co_post.sql
raster2pgsql -s 4326 -I -C -M co_pre.tif public.co_pre_rast > co_pre.sql
#evi
raster2pgsql -s 4326 -I -C -M evi_nyc.tif public.evi_nyc_rast > evi_nyc.sql


#---------------Step 2: import sql files using command prompt

# connect to database 
gcloud sql connect postgres --user=postgres --database=NYCAirQuality --quiet 
``
#connect to database
\c NYCAirQuality

# set the path to your data
\cd /home/cvalentinebate/rast

# import your sql file
\i aerosol_durr.sql  
\i aerosol_post.sql  
\i aerosol_pre.sql  
\i co_durr.sql  
\i co_post.sql  
\i co_pre.sql  
\i evi_nyc.sql


# my shapefiles are stored in a differnt 
\cd /home/cvalentinebate/NYCAirQuality/DATA_REPROJECTED
\i parks.sql
\i neighborshoods.sql
\i buroughbounds.sql  
\i social_vuln.sql 
\i nycbound_proj.sql

# look at tables infomration like column names
\dt parks.sql



