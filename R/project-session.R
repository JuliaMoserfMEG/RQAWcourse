#1. variable names
weight_kilo <- 10 # put value 10 to variable weight_kilo shortcut for <- Alt -
weight_kilo # to output variable (make variable names descriptive!)
# objects that contain data in R:
#Vectors: character (c("a", "b") - c: put these together in a vector)
# Numbers (c(1,2))
# Logic(c(TRUE, FALSE))

#data frame - series of vectors with headers
#iris: R example data
head(iris) # shows header'

colnames(iris)

str(iris) #structure of data frame

summary(iris)

# Exercise ----------------------------------------------------------------

# drop down menu: code - insert section
#Exersice: make code more readable, using styleguide (tidyverse - created by R-studio)
# Object names
DayOne # no lower and uper case naming of variables
day_one # better version "snake_case" writing - easier to read
T <- FALSE #avoid re-using names of comon functions and or variables
#also do not overwrite variable names (e.g. T translates to true)
c <- 9 # c usually used as function
#e.g. number_value <- 9
mean <- function(x) sum(x) #mean is common function
#better: mean_value <- function(x) sum(x)

# Spacing
x[, 1] # spacing always after ',' never before - readability!
x[ ,1]
x[ , 1]
mean (x, na.rm = TRUE) # no spaces between () or before (), only when using "if" clause
mean( x, na.rm = TRUE )
function (x) {}
function(x) {} #good
height <- feet * 12 + inches #surround operators by spaces
mean(x, na.rm = 10)
sqrt(x^2 + y^2) # don't surround ^ or $ or : by spaces
df$z # $ means take column z from data frame df
x <- 1:10

# Indenting
if (y < 0 && debug) {
  message("Y is negative")
  } #code blocks


# automatic fixing of style: highlight section and press
#Ctr + shift + A or "code - reformat code"

# Functions ---------------------------------------------------------------
# example of creating a basic function (fun {scripts} automatically
#creates structure to create function)
#this basic function adds the two input variables
# variable "added" is created and outputed with "return()"
add_two<- function(x, y) {
  #print(x) good addition, if I want to know, what's going on
  added <-  x + y
  return(added)
}

add_two(1, 2) #use of function


# loading packages --------------------------------------------------------


# if I want to use a package
library(tidyverse)
# if I want to use some packages frequently/generally,
#I create a "package-loading" script
source(here::here("R/package-loading.R"))
#here::here makes source go to project folder and look there for folder called R
#here:here makes code reproducible as it always goes to project folder,
#independent of actual location of folder


# save data ---------------------------------------------------------------

write_csv(iris, here::here("data/iris.csv"))
#write csv file from iris data that is part of some R package into data folder
imported_iris <-  read_csv(here::here("data/iris.csv"))
#read in csv file and pot it into object
glimpse(imported_iris)
# gives information about object
