# if working in PGAdmin/ on local computer....
# I will be testing my sql workflow locally before running in cloud console due to data crediting concerns.

# make sure you are in the directory/folder where the .sql files live
"c:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d NYCAirQuality -f buroughbounds.sql
"c:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d NYCAirQuality -f social_vuln.sql
"c:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d NYCAirQuality -f neighborshoods.sql
"c:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d NYCAirQuality -f parks.sql
"c:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d NYCAirQuality -f nycbound_proj.sql

#------------------------------------------------

#rasters import but the column is emptyy....... this is okay, there is still data 
"c:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d NYCAirQuality -f aerosol_pre.sql
"c:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d NYCAirQuality -f aerosol_durr.sql
"c:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d NYCAirQuality -f aerosol_post.sql
"c:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d NYCAirQuality -f co_durr.sql
"c:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d NYCAirQuality -f co_post.sql 
"c:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d NYCAirQuality -f co_pre.sql
"c:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d NYCAirQuality -f evi_nyc.sql

"c:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -d NYCAirQuality -f co_pre.sql
