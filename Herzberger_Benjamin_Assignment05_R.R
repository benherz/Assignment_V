#Assignment 5 DSPM Benjamin Herzberger
library(tidyverse)
library(jsonlite)
library(httr)
library(rlist)

# Task 5: Getting to know the API
#The default quota is 5000 API calls per day and rate limitation of 5 requests per second.

# Task 6: Reading API key
setwd("C:/Users/benny/OneDrive/Studium/Tübingen/M. Sc. Data Science in Business and Economics/1. Semester WS22-23/Data Science Project Management/Assignments/Assignment 5")
api_key <- read.delim("API_key.txt")
api_key <- api_key[1,1]

api_key <- "7elxdku9GGG5k8j0Xm8KWdANDgecHMV0"

# Task 7: Basic API interaction
response <- GET("https://app.ticketmaster.com/discovery/v2/events/",
                query = list(apikey = api_key,
                             countryCode = "DE")
                )


temp <- content(response)
