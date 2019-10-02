###########
#Script to Combine Data entered on multiple devices
###########

date_time <- paste0(substr(Sys.time(), 6,10), "_",sub(':', '-', strftime(Sys.time(), "%H:%M"))) #Figures out the date to add to backups

#***Set A Directory to save Backups to
NestBackupdir <- "X:\\Public\\Data_proofing_scripts\\Sage\\Shiny\\Brant-Data\\Backups\\Nest"
BandBackupdir <- "X:\\Public\\Data_proofing_scripts\\Sage\\Shiny\\Brant-Data\\Backups\\Band"
EggBackupdir <- "X:\\Public\\Data_proofing_scripts\\Sage\\Shiny\\Brant-Data\\Backups\\Egg"

###
#Band
###

#***Read in the files that you want to combine
file1 <- read.csv("X:\\Public\\Data_proofing_scripts\\Sage\\Shiny\\Brant-Data\\Data\\BAND2019.csv")
file2 <- read.csv("X:\\Public\\Data_proofing_scripts\\Sage\\Shiny\\Brant-Data\\Data\\BAND2019 (2).csv")

#combine files
combined <- merge(file1, file2, all = TRUE) 
combined[combined == ""] <- NA
combined <- unique(combined)
write.csv(combined, file.path(BandBackupdir, paste0("BAND2019_", date_time, ".csv")), row.names = FALSE) #Writes backup

#Overwrite both of them? hmm not sure how to exactly deal with this
#These both should be backuped already from app.r on their respective devices
write.csv(combined, "X:\\Public\\Data_proofing_scripts\\Sage\\Shiny\\Brant-Data\\Data\\BAND2019.csv", row.names = FALSE)
file.remove("X:\\Public\\Data_proofing_scripts\\Sage\\Shiny\\Brant-Data\\Data\\BAND2019 (2).csv") 

###
#Nest
###
nfile1 <- read.csv("X:\\Public\\Data_proofing_scripts\\Sage\\Shiny\\Brant-Data\\Data\\NEST2019.csv")
nfile2 <- read.csv("X:\\Public\\Data_proofing_scripts\\Sage\\Shiny\\Brant-Data\\Data\\NEST2019 (2).csv")

#combine files
ncombined <- merge(nfile1, nfile2, all = TRUE) 
ncombined[ncombined == ""] <- NA
write.csv(ncombined, file.path(NestBackupdir, paste0("NEST2019_", date_time, ".csv")), row.names = FALSE)

#Overwrite both of them? hmm not sure how to exactly deal with this
#These both should be backuped already from app.r on their respective devices
write.csv(ncombined, "X:\\Public\\Data_proofing_scripts\\Sage\\Shiny\\Brant-Data\\Data\\NEST2019.csv", row.names = FALSE)
file.remove("X:\\Public\\Data_proofing_scripts\\Sage\\Shiny\\Brant-Data\\Data\\NEST2019 (2).csv") 

###
#Egg
###
efile1 <- read.csv("X:\\Public\\Data_proofing_scripts\\Sage\\Shiny\\Brant-Data\\Data\\EGG2019.csv")
efile2 <- read.csv("X:\\Public\\Data_proofing_scripts\\Sage\\Shiny\\Brant-Data\\Data\\EGG2019 (2).csv")

#combine files
ecombined <- merge(efile1, efile2, all = TRUE) 
ecombined[ecombined == ""] <- NA
write.csv(ecombined, file.path(EggBackupdir, paste0("EGG2019_", date_time, ".csv")), row.names = FALSE)

#Overwrite both of them? hmm not sure how to exactly deal with this
#These both should be backuped already from app.r on their respective devices
write.csv(ecombined, "X:\\Public\\Data_proofing_scripts\\Sage\\Shiny\\Brant-Data\\Data\\EGG2019.csv", row.names = FALSE)
file.remove("X:\\Public\\Data_proofing_scripts\\Sage\\Shiny\\Brant-Data\\Data\\EGG2019 (2).csv") 


