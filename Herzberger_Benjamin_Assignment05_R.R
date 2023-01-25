#Assignment 5 DSPM Benjamin Herzberger


# Task 5: Getting to know the API
#The default quota is 5000 API calls per day and rate limitation of 5 requests per second.

# Task 6: Reading API key
setwd("C:/Users/benny/OneDrive/Studium/Tübingen/M. Sc. Data Science in Business and Economics/1. Semester WS22-23/Data Science Project Management/Assignments/Assignment 5")
api_key <- read.delim("API_key.txt")
api_key <- api_key[1,1]

# Task 7: