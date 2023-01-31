#Assignment 5 DSPM Benjamin Herzberger
library(tidyverse)
library(jsonlite)
library(httr)
library(rlist)

# Task 1: Registered on github.com
# Task 2: Public repository initialized
# Task 3: Stuck to the standard Git workflow
# Task 4: Including hyperlink in HTML file 

# Task 5: Getting to know the API
#The default quota is 5000 API calls per day and rate limitation of 5 requests per second.

# Task 6: Reading API key
setwd("C:/Users/benny/OneDrive/Studium/Tübingen/M. Sc. Data Science in Business and Economics/1. Semester WS22-23/Data Science Project Management/Assignments/Assignment 5")
api_key <- read.delim("API_key.txt", header = FALSE)
api_key <- api_key[1,1]


# Task 7: Basic API interaction
response <- GET("https://app.ticketmaster.com/discovery/v2/events/",
                query = list(apikey = api_key,
                             countryCode = "DE")
                )

temp <- content(response)
#This returns a list of 20 events for which you can buy tickets via ticketmaster
#Each event element also contains additional data e.g. images, a classification and the start-/end time of ticket sales

# Task 8: Extracting certain information into a dataframe

#number of event -> links -> embedded -> 
temp[[1]][[1]][[1]][[1]]

df <- data.frame(
  name = character(20),
  city = character(20),
  postalCode = character(20),
  address = character(20),
  url = character(20),
  longitude = character(20),
  latitude = character(20))
  

#Really ugly solution
#Event name
for(i in 1:20){
  df[i, 1] <- temp[[1]][[1]][[i]][[1]]
}

#City name
for(i in 1:20){
  df[i, 2] <- temp[["_embedded"]][["events"]][[i]][["_embedded"]][["venues"]][[1]][["city"]][["name"]]
}

#Postal Code
for(i in 1:20){
  df[i,3] <- temp[["_embedded"]][["events"]][[i]][["_embedded"]][["venues"]][[1]][["postalCode"]]
}

#Address
for(i in 1:20){
  df[i,4] <- temp[["_embedded"]][["events"]][[i]][["_embedded"]][["venues"]][[1]][["address"]][["line1"]]
}

#URL
for(i in 1:20){
  df[i,5] <- temp[["_embedded"]][["events"]][[i]][["_embedded"]][["venues"]][[1]][["url"]]
}

#Longitude
for(i in 1:20){
  df[i,6] <- temp[["_embedded"]][["events"]][[i]][["_embedded"]][["venues"]][[1]][["location"]][["longitude"]]
}

#Latitude
for(i in 1:20){
  df[i,7] <- temp[["_embedded"]][["events"]][[i]][["_embedded"]][["venues"]][[1]][["location"]][["latitude"]]
}

str(df) #as instructed


# Task 9: Advanced API interaction
#number of results is 1410
n_pages <- 1410/20
temp2 <- list()
for(i in 1:71){
  Sys.sleep(.5)
  venues <- GET("https://app.ticketmaster.com/discovery/v2/events/",
                    query = list(apikey = api_key,
                                 countryCode = "DE",
                                 page   = i))

#Extract the items
temp2[i] <- content(venues)
}


#Setting up an empty df with specified dimensions
n_results <- 1410

df2 <- data.frame(
  name = character(n_results),
  city = character(n_results),
  postalCode = character(n_results),
  address = character(n_results),
  url = character(n_results),
  longitude = character(n_results),
  latitude = character(n_results))
 
#Filling the df as above
#Event name
for(i in 1:20){
  df2[i, 1] <- temp2[[i]][["events"]][[i]][["name"]]
}

##I am very sorry, but an assignment in another module took up all my time.
##I planned on uploading what I have so far, but now  RMarkdown cannot format 
##the file somehow, even if I only try to Knit the standard RMarkdown default page.
##Nevertheless I wanted to upload what I had so far, hoping it might be worth like half a point or something.

# Github repository:
#  
