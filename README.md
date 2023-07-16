# THE FIRST STEP APP

This is "The First Step" application, created in order to achive a better understanding on how the daily alcool consumption can impact on our life quality and health. 
Even if initially designed for a more complex purpouse, the application will acquire Heart Rate and Steps data of the user and compare them with the user alcoholic consumption. 
It will help the user to have a visual and very simple assessment of his/her behaviour, in the chosen day.

This app is designed to work on the previous day, with respect to the day of the access. But, of course this modality would be more suited for real time data. 

## Directories organization:

Inside the lib directory, which contains the useful code:
- [algorithms] : which contains the code to do csome computation on the data;
- [database] : which instead contains the subdirectories: 
    - [entities] : with the entities of the database;
    - [DAOs] : with the DAOs associated to each entity of the database;
- [Repository] : the repository of the database, containing the Provider in order to gain access to the data;
- [screens] : containing all the app pages/screens;
- [utils] : contains the classes useful for some applications in the various pages;
- [widgets]: contains some widget used for the implementation of the pages and their functions;

## Pages and Functionalities: 

Firstly, the user enters in the Login Page, in which he/she is required to insert his/her own credentials. If the credentials are correct, the code extracts the token from the server and saves them into the shared_preferences. 

Then, the navigator sends the user to the Home Page. There, first of all, the user is supposed to compile its own personal informations, by accessing the datasetting page throught the Drawer. 
Once completed the access, the user can return to the Home Page and press the elevated button in the body, in order to load the data regarding the Heart Rate data and the Steps. 

In addition, through the Drawer the user can access the alcoolPage, in which all the data regarding the alcool assumption (that can be add in the addAlcool page) are displayed. By tapping on the various insertions, the user is able to update or remove those specific elements.

## Important

We were not able to commit the build and ios directories that are part of the flutter project, because of issues related to the excessive size of some data (even if we try to upload them separatly). 

Finally, by accessing through the drawer the daily monitoring page we can visualize the charts displaying the informations about the trend of average HR and the mass amount of alcohol consumed during the day.
The above mentioned data are applied in order to gain a quantitative description of the behaviour of the user which is later evaluated by the application togheter with the user's number of steps acquired from the data server (related to the same day).
