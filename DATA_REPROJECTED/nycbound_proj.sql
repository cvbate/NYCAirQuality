SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
BEGIN;
CREATE TABLE "public"."nycbound_proj" (gid serial,
"name" varchar(40),
"muni_type" varchar(4),
"munitycode" int4,
"county" varchar(50),
"gnis_id" varchar(9),
"fips_code" varchar(10),
"swis" varchar(6),
"pop1990" float8,
"pop2000" float8,
"pop2010" float8,
"pop2020" float8,
"dos_ll" varchar(7),
"dosll_date" date,
"map_symbol" varchar(1),
"calc_sq_mi" numeric,
"datemod" date);
ALTER TABLE "public"."nycbound_proj" ADD PRIMARY KEY (gid);
INSERT INTO "public"."nycbound_proj" ("name","muni_type","munitycode","county","gnis_id","fips_code","swis","pop1990","pop2000","pop2010","pop2020","dos_ll","dosll_date","map_symbol","calc_sq_mi","datemod") VALUES ('New York','city','1','New York, Bronx, Kings, Richmond, Queens','2395220','3608151000','650000','7322564','8008278','8175133','8804190',NULL,'18991230','3','4.70316754336e+02','20191004');
COMMIT;
ANALYZE "public"."nycbound_proj";
