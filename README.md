# NYCAirQuality

## Setup
I wil be using Google Cloud Console for this project. There is a free trial available with $300 in free credits. You must create an account and connect your git repository. I followed the instructions from [this page to connect to my repository using Cloud Build](https://cloud.google.com/build/docs/automating-builds/github/connect-repo-github). Follow the link to see more detailed instructions for setup for steps 3-X!
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
    [Click here to read about Build Config file schema](https://cloud.google.com/build/docs/build-config-file-schema)  
    [Click here to read about how to create a basic config file. ](https://cloud.google.com/build/docs/configuring-builds/create-basic-configuration)

1. Here we will follow the steps under ["Connecting to a GitHub host"](https://cloud.google.com/build/docs/automating-builds/github/connect-repo-github?generation=2nd-gen#connecting_a_github_host)
    Complete steps 1-7 under "Connecting a GitHub host"  
    ![Alt text](Imgs/ConnectingToGitHubHost.png)
1. Here we will follow the steps under ["Connecting a GitHub repository"](https://cloud.google.com/build/docs/automating-builds/github/connect-repo-github?generation=2nd-gen#connecting_a_github_repository_2)
    Complete steps 1-5 under "Connecting a GitHub repository"  
    ![Alt text](Imgs/ConnectingToGitHubRepo.png)
1. After these steps you will have to configure your global username and email associated with your github account. Run the following code in the terminal of your project dashboard to finalize the configuration of your github repository:
    `
    git init # you will be told to configure your username and email
    git config --global user.name <gitusername>
    git config --global user.email <email> 
    `

Now you should be all set up and ready to make commits to your GitHub repository!!
When you make commits from VSCode Cloushell Editor 'Source Control' you will press "Commit" and then "Sync Changes" and then you will be redirected to GitHub, enter the code given to you and sign into your account.  
![Alt text](Imgs/sourcecontrol.png)