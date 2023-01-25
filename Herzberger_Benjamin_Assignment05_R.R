#Assignment 5 DSPM Benjamin Herzberger
library(tidyverse)
library(jsonlite)
library(httr)
library(rlist)

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

# Task 8:

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
for(i in 1:20){
  df[i, 1] <- temp[[1]][[1]][[i]][[1]]
}

for(i in 1:20){
  df[i, 2] <- temp[["_embedded"]][["events"]][[i]][["_embedded"]][["venues"]][[1]][["city"]][["name"]]
}

for(i in 1:20){
  df[i,3] <- temp[["_embedded"]][["events"]][[i]][["_embedded"]][["venues"]][[1]][["postalCode"]]
}

for(i in 1:20){
  df[i,4] <- temp[["_embedded"]][["events"]][[i]][["_embedded"]][["venues"]][[1]][["address"]][["line1"]]
}

for(i in 1:20){
  df[i,5] <- temp[["_embedded"]][["events"]][[i]][["_embedded"]][["venues"]][[1]][["url"]]
}

for(i in 1:20){
  df[i,6] <- temp[["_embedded"]][["events"]][[i]][["_embedded"]][["venues"]][[1]][["location"]][["longitude"]]
}

for(i in 1:20){
  df[i,7] <- temp[["_embedded"]][["events"]][[i]][["_embedded"]][["venues"]][[1]][["location"]][["latitude"]]
}

