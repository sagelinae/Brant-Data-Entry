###########################################
#Sage's attempt at making a shiny package we'll see how it goes lmao
###########################################

library(shiny)
library(shinyjs)
library(dplyr)
library(DT)
library(shinythemes)

#A *** indicates a section where the user must enter a file/directory or make some other choice

#***If this is the first entry of the season go ahead and make a .csv file if there isn't one already with the same headings as 
#   would normally go in the file and save it as whatever name you want (ex: nest2020). Then load these files in down below 
#   and when you run the app and start adding data it'll work! 

#***Change the working directory
setwd("C:\\Users\\sellis\\Desktop\\Brant-Data\\Brant-Data")

#Reads the date and time and formats it as mm-dd_%H-%M (month-day_hour-minute) to be used when saving backups
date_time <- paste0(substr(Sys.time(), 6,10), "_",sub(':', '-', strftime(Sys.time(), "%H:%M")))

#***Enter a directory to save your backups to!  
NestBackupdir <- "C:\\Users\\sellis\\Desktop\\Brant-Data\\Brant-Data\\Backups\\Nest\\"
BandBackupdir <- "C:\\Users\\sellis\\Desktop\\Brant-Data\\Brant-Data\\Backups\\Band\\"
EggBackupdir <- "C:\\Users\\sellis\\Desktop\\Brant-Data\\Brant-Data\\Backups\\Egg\\"

###
#Make a backup of the NEST file you'll be writing to
###

#***Add a location of the nest file you want to update in CSV format!! Make sure if it's not to convert it first
pathway <-"C:\\Users\\sellis\\Desktop\\Brant-Data\\Brant-Data\\Data\\NEST2020.csv" 
n_original <- read.csv(pathway)
n_original <- n_original %>% mutate_all(as.character)

filename <- sub(pattern = "(.*)\\..*$", replacement = "\\1", basename(pathway)) #Finds the file name minus the extension
bkupfile <- paste0(filename, "_",date_time, ".csv") #Creates the name of the backup

filePath <- file.path(NestBackupdir, bkupfile) #This creates the file path with the name we want to name the backup

#Writes the backup
write.csv(n_original, filePath, row.names = FALSE)

###
#Make a backup of the BAND file you'll be writing to
###

#***Add a location of the band file you want to update in .csv format
b_pathway <- "C:\\Users\\sellis\\Desktop\\Brant-Data\\Brant-Data\\Data\\BAND2020.csv" 
b_original <- read.csv(b_pathway)
b_original <- b_original %>% mutate_all(as.character)

b_filename <- sub(pattern = "(.*)\\..*$", replacement = "\\1", basename(b_pathway)) #Finds the file name minus the extension
b_bkupfile <- paste0(b_filename, "_",date_time, ".csv") #Creates the name of the backup
b_filePath <- file.path(BandBackupdir, b_bkupfile) #This creates the file path with the name we want to name the backup

#Writes the backup
write.csv(b_original, b_filePath, row.names = FALSE)

###
#Make a backup of the EGG file you'll be writing to
###

#***Enter the pathway to the egg file you want to add to in a csv format
e_pathway <- "C:\\Users\\sellis\\Desktop\\Brant-Data\\Brant-Data\\Data\\EGG2020.csv" 
e_original <- read.csv(e_pathway) 
e_original <- e_original %>% mutate_all(as.character)

e_filename <- sub(pattern = "(.*)\\..*$", replacement = "\\1", basename(e_pathway)) 
e_bkupfile <- paste0(e_filename, "_",date_time, ".csv")  #Creates the name of the backup
e_filePath <- file.path(EggBackupdir, e_bkupfile) #This creates the file path with the name we want to name the backup

#Writes the backup
write.csv(e_original, e_filePath, row.names = FALSE)

#Read nest file, then do something with band??

#Should I mutate everything as a character instead of a factor?

#Change no entries to NA

#Vector of all possible bands? Alerts user that this band isn't in our files anywhere
#also one of which birds got shot??? 

#A template file that has all the same colnames as the original nest file we'll be appending to
nesttemplate <- read.csv(paste0(getwd(),"/NestTemplate.csv"))
nesttemplate <- nesttemplate %>% mutate_all(as.character)

bandtemplate <- read.csv(paste0(getwd(), "/BandTemplate.csv"))
bandtemplate <- bandtemplate %>% mutate_all(as.character)

eggtemplate <- read.csv(paste0(getwd(), "/EggTemplate.csv"))
eggtemplate <- eggtemplate %>% mutate_all(as.character)

#A vector of fields that we want to take from the nest file to the band file.
bandfields <- c('YEAR','BAND', 'C1', 'MATE', 'C2', 'DATE', 'TIME', 'OBS', 'NEST', 'LOC', 'COMMENTS')


ui <- fluidPage(theme = shinytheme("flatly"),
                shinyjs::useShinyjs(),
                
                titlePanel("Brant Data Entry App"),
                sidebarLayout(
                  sidebarPanel(id = "form",
                               width = 3,
                               h4("Don't give up"),
                               textInput("NEST", "Nest", width = "45%"),
                               textInput("OBS", "Observer", width = "45%"),
                               textInput("DATE", "Date", width = "45%"),
                               br(),
                               
                               checkboxInput("prevobs", "See previous observations of nest")
                  ),
                  
                  mainPanel(
                    id = 'main', 
                    tabsetPanel(id = "tabs", type = "tabs",
                                tabPanel("Nest",
                                         br(),
                                         br(),
                                         column(12,
                                                fluidRow(
                                                  splitLayout(
                                                    textInput("TIME", "TIME"),
                                                    textInput("S", "S"),
                                                    textInput("BAND", "BAND"),
                                                    textInput("C1", "C1"),
                                                    textInput("MATE", "MATE"),
                                                    textInput("C2", "C2"),
                                                    textInput("LOC", "LOC"),
                                                    textInput("A", "A"),
                                                    textInput("B", "B"),
                                                    textInput("C", "C"),
                                                    textInput("D", "D"),
                                                    textInput("E", "E"),
                                                    textInput("F", "F")))),
                                         br(),
                                         br(),
                                         column(12,
                                                fluidRow(
                                                  splitLayout(
                                                    textInput("G", "G"),
                                                    textInput("H", "H"),
                                                    textInput("I", "I"),
                                                    textInput("J", "J"),
                                                    textInput("K", "K"),
                                                    textInput("L", "L"),
                                                    textInput("M", "M"),
                                                    textInput("N", "N"),
                                                    textInput("O", "O"),
                                                    textInput("P", "P"),
                                                    textInput("COMMENTS", "COMMENTS")))),
                                         br(),
                                         br(),
                                         actionButton("submit", "Submit", class = "btn-primary"), 
                                         actionButton("save", "Save", class = "btn-primary"),
                                         br(),
                                         br(),
                                         column(12,fluidRow(DT::dataTableOutput("responses"))),
                                         fluidRow(shinyjs::hidden(div(
                                           id = "thankyou_msg",
                                           h3("Thanks, your response was saved successfully!")
                                         )))
                                ),
                                tabPanel("Egg",
                                         br(),
                                         br(),
                                         column(12,
                                                fluidRow(
                                                  splitLayout(
                                                    textInput("EGGA", "EGGA"),
                                                    textInput("LENGTH", "LENGTH"),
                                                    textInput("WIDTH", "WIDTH"),
                                                    textInput("EGGB", "EGGB"),
                                                    textInput("TAG", "TAG"),
                                                    textInput("STATE", "STATE"),
                                                    textInput("BAND2", "BAND"),
                                                    textInput("COMMENTS2", "COMMENTS")))),
                                         br(),
                                         br(),
                                         actionButton("submit2", "Submit", class = "btn-primary"), 
                                         actionButton("save2", "Save", class = "btn-primary"),
                                         br(),
                                         br(),
                                         column(12,fluidRow(DT::dataTableOutput("egg_inputs"))),
                                         fluidRow(shinyjs::hidden(div(
                                           id = "egg_msg",
                                           h3("Thanks, your response was saved successfully!")
                                         )))
                                ),
                                tabPanel("Prev Nest Obs", value = "prevtab",
                                         br(),
                                         br(),
                                         column(12,fluidRow(DT::dataTableOutput("prev_obs"))))
                    )
                  )
                )
)


###Create server
#This builds and will rebuild based off of user interaction
server <- function(input, output, session){
  
  #Hides the previous observations tab until clicked
  observe({
    toggle(condition = input$prevobs, selector = "#tabs li a[data-value=prevtab]")
  })
  
  nest <- reactiveValues(df = NULL)
  nest$df <- nesttemplate
  
  band <- reactiveValues(df = NULL)
  band$df <- bandtemplate
  
  egg <- reactiveValues(df = NULL)
  egg$df <- eggtemplate
  
  prevobs <- reactiveValues(df = NULL)
  prevobs$df <- n_original
  
  # Whenever a field is filled, aggregate all form data
  #***Hardcode the year to whatever year it is you're doing this in!
  formData <- reactive({
    #this is ghastly i'm sorry i couldn't figure out how to make it more efficient i'm not a professional lol
    data.frame("YEAR" = "2020","NEST" = toupper(input$NEST), "OBS" = toupper(input$OBS), "DATE" = input$DATE, 
               "TIME" = input$TIME, "S" = toupper(input$S), "BAND" = toupper(input$BAND), "C1" = toupper(input$C1),
               "MATE" = toupper(input$MATE), "C2" = toupper(input$C2), "LOC" = toupper(input$LOC),
               "A" = input$A, "B" = input$B, "C" = input$C, "D" = input$D, "E" = input$E, "F" = toupper(input$F),
               "G" = input$G, "H" = input$H, "I" = input$I, "J" = input$J, "K" = input$K, "L" = toupper(input$L),
               "M" = toupper(input$M), "N" = toupper(input$N), "O" = toupper(input$O), "P" = input$P, 
               "COMMENTS" = toupper(input$COMMENTS), stringsAsFactors = FALSE)
  })
  
  egginputs <- reactive({
    data.frame("YEAR" = "2020","NEST" = toupper(input$NEST), "OBS" = toupper(input$OBS), "DATE" = input$DATE, 
               "EGGA" = toupper(input$EGGA), "LENGTH" = input$LENGTH, "WIDTH" = input$WIDTH, 
               "EGGB" = toupper(input$EGGB),"TAG" = toupper(input$TAG), "STATE" = toupper(input$STATE), 
               "BAND" = toupper(input$BAND2), "COMMENTS" = toupper(input$COMMENTS2),
               stringsAsFactors = FALSE)
  })
  
  #When the Submit button is clicked, save the form to our template
  observeEvent(input$submit, {
    tryCatch({
      shinyjs::hide("thankyou_msg")
      shinyjs::reset('main')
    })
    isolate(nest$df <- rbind(as.matrix(nest$df), formData()))
  })
  
  observeEvent(input$submit2, {
    #write to egg template
    tryCatch({
      shinyjs::hide("egg_msg")
      shinyjs::reset('main')
    })
    isolate(egg$df <- rbind(as.matrix(egg$df),egginputs()))
  })
  
  #When the user clicks save:
  observeEvent(input$save, {
    
    #Take all the entries and pull out the rows we need for the band file
    isolate(band$df <- rbind(band$df, nest$df[which(colnames(nest$df) %in% bandfields)] ))
    band$df <- unique(band$df)
    band$df <- rename(band$df, C = C1)
    #Bind rows will throw warnigs, but we decided that it changing into a character is fine since it does what we want.
    allband <- bind_rows(b_original, band$df)
    allband <- unique(allband)
    
    write.csv(allband, file = b_pathway, row.names = FALSE)
    band$df <- rename(band$df, C1 = C)
    
    nest$df <- unique(nest$df)
    allnest <- bind_rows(n_original, nest$df) #Add the new entries to the original nest file
    allnest <- unique(allnest)
    
    #This will overwrite your original file! That's why we make a backup!
    write.csv(allnest, pathway, row.names = FALSE)
    
    shinyjs::show("thankyou_msg") 
  })
  
  observeEvent(input$save2, {
    #e_original <- read.csv(e_pathway)
    #e_original <- e_original %>% mutate_all(as.factor)
    
    egg$df <- unique(egg$df)
    allegg <- bind_rows(e_original, egg$df)
    allegg <- unique(allegg)
    
    
    write.csv(allegg, file = e_pathway, row.names = FALSE)
    
    shinyjs::show("egg_msg") 
  })
  
  output$responses <- DT::renderDataTable({
    
    #Checks to make sure our requirements are met. May need tweaking on where it should go and when (i'd prefer it
    #to throw and error if you hit submit and it's wrong but idk how to do that yet lol)
    validate(
      need(nchar(input$NEST) == 6, "Please enter a valid Nest name (must be 6 chars)"),
      need(nchar(input$OBS) == 3, "Please enter a valid Observer name (must be 3 chars)")
    )
    #input$submit #???
    nest$df
  },
  options = list(scrollX = TRUE)) #Adds a scrollbar onto our table
  
  output$egg_inputs <- DT::renderDataTable({
    #input$submit #???
    egg$df
  },
  options = list(scrollX = TRUE)) #Adds a scrollbar onto our table
  
  output$prev_obs <- DT::renderDataTable({
    n_original <- read.csv(pathway)
    n_original[which(n_original$NEST == input$NEST),]
  },
  options = list(scrollX = TRUE))
  
  session$onSessionEnded(stopApp) #Stops the app if the user closes the browser
  
}

#Saves another backup after you're done entering data and close the app
onStop(function(){
  date_time <- paste0(substr(Sys.time(), 6,10), "_",sub(':', '-', strftime(Sys.time(), "%H:%M")))

  file.copy(pathway, NestBackupdir)
  file.rename(paste0(NestBackupdir, basename(pathway)), paste0(NestBackupdir, filename, "_", date_time, ".csv"))

  file.copy(b_pathway, BandBackupdir)
  file.rename(paste0(BandBackupdir, basename(b_pathway)), paste0(BandBackupdir, b_filename, "_", date_time, ".csv"))

  file.copy(e_pathway, EggBackupdir)
  file.rename(paste0(EggBackupdir, basename(e_pathway)), paste0(EggBackupdir, e_filename, "_", date_time, ".csv"))
})



shinyApp(ui = ui, server = server)







