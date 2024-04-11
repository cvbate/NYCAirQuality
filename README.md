# NYCAirQuality

## Introduction

## Setup

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
    [Click here to read about Build Config file schema.](https://cloud.google.com/build/docs/build-config-file-schema)  
    [Click here to read about how to create a basic config file.](https://cloud.google.com/build/docs/configuring-builds/create-basic-configuration)
    [Click here to read an overview of Cloud Build](https://cloud.google.com/build/docs/overview#:~:text=Cloud%20Build%20can%20import%20source,protect%20your%20software%20supply%20chain.)

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
1. After these steps you will have to configure your global username and email associated with your github account. Run the following code in the terminal of your project dashboard to finalize the configuration of your github repository:  

    ` git init # you will be told to configure your username and email `  
    ` git config --global user.name <gitusername> `  
    ` git config --global user.email <email> `  

Now you should be all set up and ready to make commits to your GitHub repository!!
You wil make commits from VSCode Cloushell Editor 'Source Control'. Press "Commit" and then "Sync Changes", copy the code that will pop up, then you will be redirected to GitHub. Enter the code given to you and sign into your account.  
![Alt text](Imgs/sourcecontrol.png)

### Triggers - Cloud Build

In order to pull from your GitHub repository you will need to set up a trigger request. I will be uploading my vector datafiles on my computer and then pushing it to GitHub so I can pull it here.
[Click here to look at the Cloud Build instructions](https://cloud.google.com/build/docs/automating-builds/github/build-repos-from-github?generation=2nd-gen)

Once you have created the trigger
![Alt text](Imgs/gitpullrequest.png)


### CloudSQL/PostgresSQL Instance

 [How to create instances](https://cloud.google.com/sql/docs/postgres/create-instance#console)
 Enable Cloud SQL Admin API
 
 `gcloud init`

Create an Instance
 
 
 Make sure Compute Engine API is activated in your poeject

 A Create a PostgreSQL instance

 In terminal run the following code: 
    `sudo apt-get update`
    `sudo apt-get install postgresql`

Go to your instances and click on the name of your instance to open the configuation panel. I named mine postgres. Scroll down to "Connect to this instance" and click on OPEN CLOUD SHELL. 
![Alt text](image.png)  

Upon clicking OPEN CLOUD SHELL 
Something similar to this code will be automatically pasted into your terminal. Press enter to execute the code:  
`gcloud sql connect postgres --user=postgres --quiet`  
This is the code that you will run everytime you want to access your Database.


## Data

**Vector Data**

1. City boundaries 

1. [Parks](https://data.cityofnewyork.us/Recreation/Parks-Properties/enfh-gkve/about_data) [X]

1. [2020 US census data](https://data.cityofnewyork.us/City-Government/2020-Census-Tracts-Tabular/63ge-mke6/about_data) [X]

1. [2020 Neighborhood Data](https://data.cityofnewyork.us/City-Government/2020-Neighborhood-Tabulation-Areas-NTAs-Tabular/9nt8-h7nd/about_data) [X]

1. [Borough boundaries](https://data.cityofnewyork.us/City-Government/Borough-Boundaries/tqmj-j8zm) [x]

**Raster Data**

1. UV Aerosol Index (GEE) 

1. CO Concentrations(GEE) 

1. NDVI- or other vegetation index of nyc (to get street trees(?))- I have scripts from a previous class I could adapt. 

1. [Elevation 1ft DEM](https://data.cityofnewyork.us/City-Government/1-foot-Digital-Elevation-Model-DEM-Integer-Raster/7kuu-zah7/about_data) [X]

## Methodology

### Data Aquisition

1. Download vector data from (NYC Open Data)[https://opendata.cityofnewyork.us/]
1. Aquire Raster
    - Elevation data from NYC Open Data
    - Aquire Data from GEE 

### Data Prep

1. Rasters to SQL



------------------------------------------------
##### For Assignment 1 Due 04/12/24 5pm EST

1. Find and Process Geospatial Data (10 Points)

    - Data Acquisition (5 Points): Successfully obtained and processed the necessary data to address their proposed queries.
    - Data Processing (5 Points): Shared steps on GitHub that includes additional software needs and detailed descriptions of their data attributes and sources.


##### For Assignment 2 Due 04/XX/24 5pm EST - Import Spatial Data & Normalize Tables 

1. Import your data into PostgreSQL tables/schema created in Assignment 1. 

1. Normalize your tables (1NF up to possibly 4NF, depending on your data) and explain the logic in your README. 

    - Even if normalization is not required, explain why in your README. 

#####  For Assignment 3 Due 04/25/24 5pm EST - Spatial Analyssi!

- SELECT the CO and Aerosol Index over the parks/vegetated areas and calculate the average concentration/ intensity over these areas. Do the same for Each neighborhood – see how those areas compare to pre/during/post values 
- Use SQL to identify areas of income below a certain level and above a certain level 
- Identify neighborhoods that have with languages other than English spoken at home over 25% (this number may change) 
- See if there is a correlation between race, income, ethnicity, languages and concentrations of CO or aerosol 

**Final Pushes to Github Due May3rd 5pm!!!**