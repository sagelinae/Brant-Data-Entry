# Brant-Data-Entry
An app that runs locally to enter Brant Data along w/ necessary details and shortcuts to run it. 

This has only been tested on a Windows so far, I know you may have a problem on Macs/other systems when trying to work shortcuts so you're on your own for now with that. But the app itself will still run and work! You'll just have to go into the app.R and run it every time.

**How To Work Brant Entry App.docx:** gives step by step instructions on how to work this app. 

**Combine_files.R:** A script to combine files if data was entered on multiple computers

**BrantEntry.bat:** A batch file so we can run the code as a desktop shortcut without opening R

**Brant Data Entry.vbs:** A visual basic processing script that will just run the batch file but without opening up the window's command line so it's more visually appealing to the user by calling the batch file. 

# How to work Brant-Entry Shiny App

### Steps To Do Once at Start of Season
Do these steps on each device you will want to enter data on!
1.	Download R onto laptop/tablet if it is not on the device already – **_requires internet connection_** <br>
    a.	Run these lines of code, what it does is check if packages are installed, and if they aren’t it installs them

```  
ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
  install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, library, character.only = TRUE)
}

packages <- c("shiny", "shinyjs", "shinythemes", "dplyr", "DT")
ipak(packages)
```  

2.	Install a browser if you don’t have one already – **_requires internet connection_** <br>
3.	Go to https://github.com/sagelinae/Brant-Data-Entry and click the green button that says “Clone or Download” – **_requires internet connection_** <br>
*Not sure if this is where we’ll keep it forever but this is where it is for now* <br>
    a.	Then click “Download ZIP” <br>
    b.	Go into your downloads and right click the folder you downloaded called “Brant-Data-Entry-master” and select Extract All <br>
    c.	This brings up a popup for the destination, click browse and extract this folder to wherever you want to keep the data (desktop, under documents, ect) <br>


    Files that you should see: <br>
    •	Folder called Data with three subfiles BAND/EGG/NEST2019.csv <br>
    •	app.R <br>
    •	combine_files.R <br>
    •	Three template files called Band/Egg/NestTemplate.csv <br>
    •	One Windows Batch File script called BrantEntry <br>
    •	One VBScript file called Brant Data Entry <br>
    •   A word document titled: How To Work Brant Entry App <br>
    •	A copy of this same MD file <br>

4. Open up the How to Work Brant Entry word doc and continue on step 4 there <br>
* *I don't know markdown well enough yet and can't format the lists or insert pictures so we'll keep to basic word for now!*

Please feel free to reach out with any questions and/or bugs while trying to use the app!
Email: sage.linae.ellis@gmail.com

