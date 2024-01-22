# Year : 2023
# Title : Ecotourism Sites in Indonesia
# Author : Saraswati Sisriany
# Data Source : Google Places API

###1# Setting up the project#####
# Directory
setwd("D:/00_S3/ecotourism_map/map")
getwd()

### Packages 
## Googleway 
# Install
install.packages("googleway")
install.packages("gdata")

# Load Packages
library(googleway)
library(gdata)
library(readr)

###2# Connecting to Google Place API ####
# Add Google_API_key from text file
key=readLines("D:/00_S3/ecotourism_map/placesapi/apikey.txt",n=1)


###3# Setting Up Keywords Queries ####
# Read list data and change into a vector 
location <- read.csv("D:/00_S3/ecotourism_map/map/listprov.csv",
                     header = F)$V1
list_location <-as.character(location)
rm(location)
rm(list_location)

for(province in location){
# Type and modifies search strings here
keyword = paste0("Ekowisata ",province)

###4# Collecting Data from Google Place API ####
## Run each page one by one to avoid error on API Data Collection

# Page 1 
page1<-google_places(search_string = keyword , key = key)

Sys.sleep(time = 2)

# Page 2
   page2<-google_places(search_string = keyword , 
                       key = key, 
                       page_token = page1$next_page_token)

Sys.sleep(time=2)

# Page 3 
  page3<-google_places(search_string = keyword , 
                      key = key, page_token = page2$next_page_token)

# Check results number of list before proceed
# List pattern should be like 4-4-3 or 4-3 

###5# Extracting Results as Dataframe and Renames ####
# extract results from page 1 as dataframe
results1=page1[["results"]]
results2=page2[["results"]]
results3=page3[["results"]]

# Removes spaces on keywords 
name1a<-sub(' ','_',ignore.case = TRUE,province)
name2a<-sub(' ','_',ignore.case = TRUE,province)
name3a<-sub(' ','_',ignore.case = TRUE,province)

# Add number on each name 
name1b<-paste0(name1a,"1")
name2b<-paste0(name2a,"2")
name3b<-paste0(name3a,"3")

# Rename final results
mv(from = "results1", to=name1b)
mv(from = "results2", to=name2b)
mv(from = "results3", to=name3b)

# End of work, result can be copy or extract from data


###6# Cleaning up Environment before start a new search#####

# Removes old values for keyword search
rm(province)
rm(keyword)

# And then removes name with space
rm(name1a)
rm(name2a)
rm(name3a)

# And then removes name with number
rm(name1b)
rm(name2b)
rm(name3b)

# Removes old pages as results from prior Google Place search
rm(page1)
rm(page2)
rm(page3)


###############################End of Script####################
}

# Remove failed results

rm(results1)
rm(results2)
rm(results3)

## extract geolocation
p20_1_geo<-p20_1[["geometry"]]
p20_1_geo[["location"]]
p20_1_geoloc=p20_1[["geometry"]][["location"]] 

##coba-cobaaa
p20_1[,c("geometryl",c("location"))]
#gabung
lapply(unlist(p20_1, recursive = FALSE, ))

p20_1.df = ldply(p20_1, function(t) t$toDataFrame())

#export csv
write.csv(p20_a_df1,file = "p20a.csv",row.names = FALSE)

#keluarnya values
p20_all <- p20_1[["formatted_address"]]
          p20_1[["geometry"]][["location"]]
          p20_1[["name"]]
          
#only convert from list to dataframe
p20all<-as.data.frame(p20_1)         
p20all.df<-data.frame(p20_1)

#flatten all element
p20.new <- unlist(p20_1,recursive=FALSE)

#tidyverse package
install.packages("tidyverse")
library(tidyverse)


                 
#"geometry.location.lng","types","user_ratings_total","place_id","plus_code.compound_code")]

next_page_token

#excelexport
install.packages("writexl")
library(writexl)
write_xlsx(p20.new,"p20_new.xlsx")
print(Riau1)
