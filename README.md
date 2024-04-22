
# NYCAirQuality

# Table of contents

1. [Introduction](#introduction)

1. [Setup](#setup)
    1. [Google Cloud Console: Creating a Project & Connecting to Github](#setup1)
    1. [Triggers - Cloud Build](#setup2)
    1. [Buckets for Google Cloud Storage](#setup3)
    1. [Setting Up Instances](#setup4)
1. [Data](#data)
    1. [Vector](#vector-data)
    1. [Raster](#raster-data)
1. [Methodology](#methodology)
    1. [Data Aquisition](#data-aquisition)
    1. [GEE Scripts](#scripts)
    1. [Data Prep](#data-prep)
        - [Access Cloud Storage & Convert files to .sql](#tosql)
            -  gsutil URI
            - raster2pgsql
            - shp2pgsql
        - [Export data to postgres instance](#exportdata)
        - [Data cleaning](#clean)
        - [Normalization](#normalization)
    1. [Analysis](#analysis)
1. [Troubleshooting](#troubleshooing)

## Introduction <a name="introduction"></a>

-- what is the project about and why
-- what are the goals

## Setup

This project uses Google Cloud Console so if you are new to this platform. Cloud Console essentually creates a Virtual Linux bash sytem in which you can use to interact with the rest of console. Bash commands work the same as on your local machine, with a few extra commands, with VSCode Shell as the GUI interface. If you are familiar with Bash and VSCode(steep learning curve), it should make things easier.
For Cloud Console however, there is a learning curve with quite a few steps required to get started including:
1. Setting up your account(simple and intuative)
1. Creating a project
1. Connecting to GitHub
    - Setting up triggers (allow for git pull)
1. Setting up buckets to store exported data from GEE (optional)
1. Creating a postgres instance
    - creating a database

I belive I included all the APIs necesary in the instructions, however if not, google console should tell you if you dont have a required API enabled, and will direct you to the page where it can be enabled.  

APIs Used in this project:  
![Alt text](Imgs/Apis.png)

### Creating a Project and Connecting to GitHub <a name="introduction"></a>

I wil be using Google Cloud Console for this project. There is a free trial available with $300 in free credits. First, you must create an account and connect your git repository. I followed the instructions from [this page to connect to my repository using Cloud Build](https://cloud.google.com/build/docs/automating-builds/github/connect-repo-github). I will also walk you through the process below:

1. Create a Google Console account.
    I named it the same as my github repository, although I am not sure that is necessary.

1. Creating a project in Cloud Console. I named it the same as this repository. 

1. Enable required APIs:
    Enable cloud API
    Enable sectret manager API

1. Use the terminal in your project dashboard to create a file called config.yaml  
    ` touch cloudbuild.yaml `  
    ` edit cloudbuild.yaml `  
    You wil need to set up a basic congig file that tells Cloud Build how to build/host your repository. There are a couple of differnt builds available through Cloud Builder. I chose to use Docker because I have some prior experience. The only required argument in the build file is the `name` argument. Here is a basic config.yaml file(but there are many arguments available):  
    ![Alt text](Imgs/cloudbuild.png)    
    [Read about Build Config file schema.](https://cloud.google.com/build/docs/build-config-file-schema)  
    [Read about how to create a basic config file.](https://cloud.google.com/build/docs/configuring-builds/create-basic-configuration)  
    [Read an overview of Cloud Build](https://cloud.google.com/build/docs/overview#:~:text=Cloud%20Build%20can%20import%20source,protect%20your%20software%20supply%20chain.)

1. Here we will follow the steps under ["Connecting to a GitHub host"](https://cloud.google.com/build/docs/automating-builds/github/connect-repo-github?generation=2nd-gen#connecting_a_github_host)
    Complete steps 1-7 under "Connecting a GitHub host"  
    ![Alt text](Imgs/ConnectingToGitHubHost.png)  
    After the previous steps, your repo page should look something like this:  
    ![Alt text](Imgs/repo_ex_1.png)

1. Here we will follow the steps under ["Connecting a GitHub repository"](https://cloud.google.com/build/docs/automating-builds/github/connect-repo-github?generation=2nd-gen#connecting_a_github_repository_2)
    Complete steps 1-5 under "Connecting a GitHub repository"  
    ![Alt text](Imgs/ConnectingToGitHubRepo.png)  
    After the previous steps, your repo page should now look something like this:  
    ![Alt text](Imgs/repo_ex.png)  
1. After these steps you will have to configure your global username and email associated with your github account. Run the following code in cloud shell to finalize the configuration of your github repository:  

```console
git init # you will be told to configure your username and email
git config --global user.name <gitusername>
git config --global user.email <email> 
```

Now you should be all set up and ready to make commits to your GitHub repository!!
You wil make commits from VSCode Cloushell Editor 'Source Control'. Press "Commit" and then "Sync Changes", copy the code that will pop up, then you will be redirected to GitHub. Enter the code given to you and sign into your account.  
![Alt text](Imgs/sourcecontrol.png)  

If you use ` git push ` in command line you will be asked for user and password authentication which was disabled by GitHub in 2021.
------------------------------------------------  

#### Triggers - Cloud Build <a name="setup2"></a>

In order to pull from your GitHub repository you will need to set up a trigger request. I will be uploading my vector datafiles stored locally on my computer to the cloned GitHub repository and then pushing it to GitHub so I can pull it in Cloud Shell.  

[Click here to look at the Cloud Build instructions](https://cloud.google.com/build/docs/automating-builds/github/build-repos-from-github?generation=2nd-gen)

Once you have created the trigger
![Alt text](Imgs/gitpullrequest.png)  

------------------------------------------------

### Buckets for Google Cloud Storage (Exporting Data from GEE to Cloud Storage) <a name="setup3"></a>

Setting up a Bucket is important if you are exporting raster data from GEE. If you will not be using GEE this step is optional. Buckets are basic containers that hold your data in Cloud Storage.

[To set up your bucket follow these instructions.](https://cloud.google.com/storage/docs/discover-object-storage-console)

![Alt text](Imgs/bucket.png)  

------------------------------------------------

### CloudSQL/PostgresSQL Instances <a name="setup4"></a>

 [How to create instances](https://cloud.google.com/sql/docs/postgres/create-instance#console)  
1. Enable Cloud SQL Admin API and Compute Engine API 
 `gcloud init`

1. Create a PostgreSQL instance... Follow the steps from the link above!

1. In terminal run the following code:  
    `sudo apt-get update`  
    `sudo apt-get install postgresql`

Go to your instances and click on the name of your instance to open the configuation panel. I named mine postgres. Scroll down to "Connect to this instance" and click on OPEN CLOUD SHELL.  
![Alt text](Imgs/opencloudshell.png)  

Upon clicking OPEN CLOUD SHELL something similar to this code will be automatically pasted into your terminal. Press enter to execute the code:  
    `gcloud sql connect postgres --user=postgres --quiet`  
    or to connect direclty to your database add the --database="name of database"  
    `gcloud sql connect postgres --user=postgres --database=NYCAirQuality --quiet`  
  
This is the code that you will run everytime you want to access your Database in GC's SQLShell

The tutorial I looked at also said to then do this code which will allow you to access postgres just by typing psql in the Cloud Terminal, however when I tired to run it, it timed out before asking me for my password. It seems like this is uncessary and the previous code will also work fine.

`psql -h <publicIPAddress> -U postgres`

Next, install postGIS in the bin of postgresql -- see [Troublshooting](#troubleshooing) for recurring issues accessing postGIS

```console
<email>>@cloudshell:/usr/lib/postgresql/16/bin (nycairquality)$ sudo apt install postgis
```

## Data

### Vector Data

1. [City boundaries](https://data.gis.ny.gov/datasets/sharegisny::nys-civil-boundaries/explore?layer=4&location=40.695449%2C-73.623530%2C9.29)  
![Alt text](Imgs/boundary_gee.png)  
  
1. [Parks](https://data.cityofnewyork.us/Recreation/Parks-Properties/enfh-gkve/about_data)  
![Alt text](Imgs/parks.png)  
  
1. [2020 US census data](https://data.cityofnewyork.us/City-Government/2020-Census-Tracts-Tabular/63ge-mke6/about_data)  
![Alt text](Imgs/census.png)

1. [2020 Neighborhood Data](https://data.cityofnewyork.us/City-Government/2020-Neighborhood-Tabulation-Areas-NTAs-Tabular/9nt8-h7nd/about_data)  
![Alt text](Imgs/neighborhoods.png)  

1. [Borough boundaries](https://data.cityofnewyork.us/City-Government/Borough-Boundaries/tqmj-j8zm)  
![buroghs](Imgs/buroghbounds.png)

### Raster Data

1. [Sentinel-5P NRTI AER AI: Near Real-Time UV Aerosol Index ](https://developers.google.com/earth-engine/datasets/catalog/COPERNICUS_S5P_NRTI_L3_AER_AI)  
Sentinel 5 Data.  

"This dataset provides near real-time high-resolution imagery of the UV Aerosol Index (UVAI), also called the Absorbing Aerosol Index (AAI).

The AAI is based on wavelength-dependent changes in Rayleigh scattering in the UV spectral range for a pair of wavelengths. The difference between observed and modelled reflectance results in the AAI. When the AAI is positive, it indicates the presence of UV-absorbing aerosols like dust and smoke. It is useful for tracking the evolution of episodic aerosol plumes from dust outbreaks, volcanic ash, and biomass burning.

The wavelengths used have very low ozone absorption, so unlike aerosol optical thickness measurements, AAI can be calculated in the presence of clouds. Daily global coverage is therefore possible.

For this L3 AER_AI product, the absorbing_aerosol_index is calculated with a pair of measurements at the 354 nm and 388 nm wavelengths."

- Above text from GEE catalog page.
  
Pre(one year prior):  
![pre](Imgs/Aerosol_pre.png)  
  
Durring:  
![durr](Imgs/Aerosol_durr.png)  
  
Post (one month after):  
![post](Imgs/Aerosol_post.png)

1. [Sentinel-5P NRTI CO: Near Real-Time Carbon Monoxide](https://developers.google.com/earth-engine/datasets/catalog/COPERNICUS_S5P_NRTI_L3_CO)
" This dataset provides near real-time high-resolution imagery of CO concentrations.

Carbon monoxide (CO) is an important atmospheric trace gas for understanding tropospheric chemistry. In certain urban areas, it is a major atmospheric pollutant. Main sources of CO are combustion of fossil fuels, biomass burning, and atmospheric oxidation of methane and other hydrocarbons. Whereas fossil fuel combustion is the main source of CO at northern mid-latitudes, the oxidation of isoprene and biomass burning play an important role in the tropics. TROPOMI on the Sentinel 5 Precursor (S5P) satellite observes the CO global abundance exploiting clear-sky and cloudy-sky Earth radiance measurements in the 2.3 μm spectral range of the shortwave infrared (SWIR) part of the solar spectrum. TROPOMI clear sky observations provide CO total columns with sensitivity to the tropospheric boundary layer. For cloudy atmospheres, the column sensitivity changes according to the light path. More information."

- Above text from GEE catalog page.

Pre(one year prior):  
![pre - one year before](Imgs/co_pre.png)
  
Durring(June 5th- June 8th):  
![durring](Imgs/co_durr.png)
  
Post(one month after):  
![post 1 month later](Imgs/co_post.png)


1. EVI (GEE)
    - Written by Clio Bate, adapted from a thread of [Stack Exchange](https://gis.stackexchange.com/questions/370978/time-series-chart-of-evi-landsat-8-for-a-single-pixel-in-gee
with the help of Chat GPT to make visualizations)  

![Alt text](Imgs/evi_gee.png)

1. [Elevation 1ft DEM](https://data.cityofnewyork.us/City-Government/1-foot-Digital-Elevation-Model-DEM-Integer-Raster/7kuu-zah7/about_data)  
![Alt text](Imgs/evlevation.png)

## Methodology

### Data Aquisition

1. Download vector data from [NYC Open Data](https://opendata.cityofnewyork.us/) and save locally on computer.
1. Reproject all the data to ensure its in a Geospatial Cordinate Sytesm EPSG:4326 and then upload to GitHub repository. All vector data (exept for NYCBoundary) is located in Data_Reprojected.
1. The NYC Boundary Data  was loaded into GEE, only the NYC bounary was selected to be use as a boundary for my raster data and saved as a new variable. Then it was exported to Cloud storage from GEE using the following code:
1. Aquire Raster
    - Elevation data from NYC Open Data Enable
    - Aquire Aresol, EVI, and CO Data from GEE 
        - See x and x file for source code.
        - Enable the Google Earth Engine API in Console.
    - Export Data from GEE to Cloud Storage

    ```js
    // Export the image to Cloud Storage. 
    Export.image.toCloudStorage({
        image: evi_exp, // name of your feature/image
        description: 'evi_export',
        bucket: 'gee_data_nyc',
        fileNamePrefix: 'evi_nyc',
        crs: 'EPSG:4326',
        scale: 30,
        region: geometryrec //rectangualar geometry that defines the region to export
    });

    // Export a SHP file to Cloud Storage.
    Export.table.toCloudStorage({
        collection: nycBoundary,
        description:'nycboundary_shapefile',
        bucket: 'gee_data_nyc',
        fileNamePrefix: 'nycboundary',
        fileFormat: 'SHP'
    });
    ```

After exporting each of the images, from GEE. The bucket should look something like this. I moved all the Boundary SHP into a single folder.  
![Alt text](Imgs/bucket_exported.png)

#### Scripts

[Link to GEE Aerosol Script](https://code.earthengine.google.com/fbd7677c9c8c354ae38f88c99c6c70fc)  
[Link to GEE CO Script](https://code.earthengine.google.com/087b036e06b996e1cc49e5329ae9cbd2)  
[Link to GEE EVI Script](https://code.earthengine.google.com/e3d6c85ddccae6000194cbaa98dc0eee)  

### Data Prep

#### Import data from buckets to "local" cloud shell directory <a name="tosql"></a>

1. Make a new directory, and navigate to that dir.
1. Transfer file from cloud storage, to local dir using the following code:

```console
<email>>@cloudshell:~/rast (nycairquality)$ gsutil cp <gsuil URI> <filename>`
```

1. use shp2pgsql/rast2pgsql to convert files from .tiff/.shp to .sql

examples for raster and vector files  

```console
raster2pgsql -s 4326 -I -C -M aerosol_durr.tif public.aerosol_durr_rast > aerosol_durr.sql
```

example output:  

```console
Copying gs://gee_data_nyc/aerosol_durr.tif...
 / [1 files][  1.9 MiB/  1.9 MiB]   
```  

```console
shp2pgsql -s 4326 -I buroughbounds.shp public.buroughbounds > buroughbounds.sql
```
  
example output:  

```console
Processing 1/1: aerosol_durr.tif
```

#### For Data stored "locally" in CloudShell linux system

1. navigate to the dir with the data
1. Use raster2pgsql or shp2pgsql to convert data to a .sql file. See code example in the previous section.


1. After donwloading the data, convert vectors and Rasters to SQL see [Access Cloud Storage & Convert files to .sql](#setup5) for more information on the steps.

#### Export data to your postgres instance database <a name="exportdata"></a>
1. Import the data into your database
    - Connect to postgres instance and database

    ```console
    gcloud sql connect postgres --user=postgres --database NYCAirQuality --quiet`  
    ```

    - Paste the path to your data

    ```console
    \cd /home/cvalentinebate/rast
    ```

    - Import sql file

    ```console
    \i <filename.sql>
    ```

#### Clean the tables by populating new tables with relevent columns <a name="clean"></a>

**examples from script**

 Because many of my tables have extraneous columns now relevant to my project, to make my data more straightforward, I will create new tables and populate them with only the columns necesary. It is important not to just drop the columns from the orignal table because you never know if a column will become relevant to your analysis at a later time, and its best to practice to keep a copy of the unalterned, orignal data.

#### Normalization

Luckily for me, none of my data needs to be normalized. I aquired it from NYC Open Data, and from the census bureou wich are managed by city/ the federal government and have good database management practices in place. All of my vector tables 
- buroughbounds
- CDC_Social_Vuln_20_project
- neighborshoods
- parks
are already in 4NF because:

- 1NF Each cell contians **atomic values** aka there is only one value stored in a single cell of the table(no multiple values).
- 2NF Satisfies 1NF and there are **no partial dependencies** (there are no partial primary keys/ the data doesn't depend on mutiple keys for unique identification. In the case for all of my talbes, there is a gid that serves as the unique primary key)
- 3NF: Satisfies 2NF and there are **no transitive dependencies** among non-prime attributes, each non-key attribute is directly dependent on the primary key (gid).
- 4NF: Satisfies 3NF and there are **no multi-valued dependencies**. This means that there are no columsn that are unrelated but both depend on the same primary key.

parks_cleaned:  
![Alt text](Imgs/parks_cleaned.png)  

neighborhood_cleaned:  
![Alt text](Imgs/neighbhor_cleaned.png)  

social_vuln_cleaned:  
![Alt text](Imgs/socialvuln_cleaned.png)  

borobounds_cleadned:  
![Alt text](Imgs/borobounds_cleaned.png)  

nycboundary:  
![Alt text](image.png)

### Analysis

Goal for today 04/22 create an outline of what I want to do/ write the the script outline


### Next Steps


#### Troubleshooing

1. GEE to Cloud Storage
Trying to export my raster data from GEE to Cloud Storage. The code was running fine and a file was being exported. However, when I downloaded the file and opened in in ArcPro(to check that there was in fact data), there were only two values.
I had to go back into GEE and change the code from: 

```js
//check projection/crs
var projection = evi_exp.projection().getInfo();
print(projection);

Export.image.toCloudStorage({
  image: evi_exp,
  description: 'evi_export',
  bucket: 'gee_data_nyc',
  fileNamePrefix: 'evi_nyc', 
  crs: projection.transform
  region: nycboundary
  })
```

to:  

```js
// Create a geometry representing an export region.
var geometryrec = ee.Geometry.Rectangle(-74.25884568811979, 40.476585245386836, -73.70023628178262, 40.917637783354124);
Map.addLayer(geometryrec); // check validity of geom

Export.image.toCloudStorage({
  image: evi_exp,
  description: 'evi_export',
  bucket: 'gee_data_nyc',
  fileNamePrefix: 'evi_nyc', 
  crs: 'EPSG:4326',
  scale: 30,
  region: geometryrec
});
```  
  
1. shp2pgsql command not recognized
After I creating the instance for PostgreSQL and creating the database, I tried to create an extension for POSTGIS and rastergis in my database. It did not return an error however, when I tried to run the shp2pgsql I got an error saying it was an unknown command. This was because PostGIS was not actually installed. I had to navigate to the bin where postgres was installed and install the extension.  

```console
<email>>@cloudshell:/usr/lib/postgresql/16/bin (nycairquality)$ sudo apt install postgis
```

Note: later on I when I had to go back and convert a differnt shapefile cause there was an issue with the original data, I had to reinstall postgis AGAIN because I was getting the same error.

1. Importing .sql files into my NYCAirQuality postgres database

When trying to import data into the postgres, I orignally tried this command: however it failed.

```console
psql -h <public ip address for instance> -U postgres NYCAirQuality < evi_nyc.sql
psql: error: connection to server at <public ip address for instance>, port 5432 failed: Connection timed out
        Is the server running on that host and accepting TCP/IP connections?
```

I checked to see the status of the instance:  

```console
service postgresql status
16/main (port 5432): down
```

It was down, so I restarted it and tried again:

```console
sudo service postgresql restart
Restarting PostgreSQL 16 database server: main.
```

I rechecked the status and now it says its online, but I am still getting the same psql error.

To check the IP address of cloud shell session run the following code:

```console
curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//'
```

or for a simpler command....

```console
curl ifconfig.co
```

None of this worked.... however what did was was:

```console
gcloud sql connect postgres --user=postgres --database=nycairquality --quiet` 

# set the path to your data - note nothing will happen
\cd /home/cvalentinebate/rast

# import your sql file
\i aerosol_durr.sql  
```

------------------------------------------------

##### For Assignment 1 Due 04/12/24 5pm EST

1. Find and Process Geospatial Data (10 Points)

    - Data Acquisition (5 Points): Successfully obtained and processed the necessary data to address their proposed queries.
    - Data Processing (5 Points): Shared steps on GitHub that includes additional software needs and detailed descriptions of their data attributes and sources.

##### For Assignment 2 Due 04/XX/24 5pm EST - Import Spatial Data & Normalize Tables 

1. Import your data into PostgreSQL tables/schema created in Assignment 1. 

1. Normalize your tables (1NF up to possibly 4NF, depending on your data) and explain the logic in your README.

    - Even if normalization is not required, explain why in your README. 

##### For Assignment 3 Due 04/25/24 5pm EST - Spatial Analyssi!

- SELECT the CO and Aerosol Index over the parks/vegetated areas and calculate the average concentration/ intensity over these areas. Do the same for Each neighborhood – see how those areas compare to pre/during/post values 
- Use SQL to identify areas of income below a certain level and above a certain level
- Identify neighborhoods that have with languages other than English spoken at home over 25% (this number may change)
- See if there is a correlation between race, income, ethnicity, languages and concentrations of CO or aerosol

**Final Pushes to Github Due May3rd 5pm!!!**
