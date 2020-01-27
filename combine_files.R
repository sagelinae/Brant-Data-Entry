###########
#Script to Combine Data entered on multiple devices
###########

date_time <- paste0(substr(Sys.time(), 6,10), "_",sub(':', '-', strftime(Sys.time(), "%H:%M"))) #Figures out the date to add to backups

#***Set A Directory to save Backups to
NestBackupdir <- "C:\\Users\\sellis\\Desktop\\Brant-Data\\Backups\\Nest"
BandBackupdir <- "C:\\Users\\sellis\\Desktop\\Brant-Data\\Backups\\Band"
EggBackupdir <- "C:\\Users\\sellis\\Desktop\\Brant-Data\\Backups\\Egg"

#***Read in the files that you want to combine
bpathway <- "C:\\Users\\sellis\\Desktop\\Brant-Data\\Data\\BAND2020.csv"
b2pathway <- "C:\\Users\\sellis\\Desktop\\Brant-Data\\Data\\BAND2020 (2).csv"

npathway <- "C:\\Users\\sellis\\Desktop\\Brant-Data\\Data\\NEST2020.csv"
n2pathway <- "C:\\Users\\sellis\\Desktop\\Brant-Data\\Data\\NEST2020 (2).csv"

epathway <- "C:\\Users\\sellis\\Desktop\\Brant-Data\\Data\\EGG2020.csv"
e2pathway <- "C:\\Users\\sellis\\Desktop\\Brant-Data\\Data\\EGG2020 (2).csv"

###
#Band
###

file1 <- read.csv(bpathway)
file2 <- read.csv(b2pathway)

#combine files
combined <- merge(file1, file2, all = TRUE) 
combined[combined == ""] <- NA
combined <- unique(combined)
write.csv(combined, file.path(BandBackupdir, paste0("BAND2019_", date_time, ".csv")), row.names = FALSE) #Writes backup

#Overwrite both of them? hmm not sure how to exactly deal with this
#These both should be backuped already from app.r on their respective devices

write.csv(combined, bpathway, row.names = FALSE)
file.remove(b2pathway) 

###
#Nest
###
nfile1 <- read.csv(npathway)
nfile2 <- read.csv(n2pathway)

#combine files
ncombined <- merge(nfile1, nfile2, all = TRUE) 
ncombined[ncombined == ""] <- NA
write.csv(ncombined, file.path(NestBackupdir, paste0("NEST2019_", date_time, ".csv")), row.names = FALSE)

#Overwrite both of them? hmm not sure how to exactly deal with this
#These both should be backuped already from app.r on their respective devices
write.csv(ncombined, npathway, row.names = FALSE)
file.remove(n2pathway) 

###
#Egg
###
efile1 <- read.csv(epathway)
efile2 <- read.csv(e2pathway)

#combine files
ecombined <- merge(efile1, efile2, all = TRUE) 
ecombined[ecombined == ""] <- NA
write.csv(ecombined, file.path(EggBackupdir, paste0("EGG2019_", date_time, ".csv")), row.names = FALSE)

#Overwrite both of them? hmm not sure how to exactly deal with this
#These both should be backuped already from app.r on their respective devices
write.csv(ecombined, epathway, row.names = FALSE)
file.remove(e2pathway) 


