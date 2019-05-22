source(here::here("R/package-loading.R"))


# Check column names
colnames(NHANES)

# Look at contents
str(NHANES)
glimpse(NHANES)

# See summary
summary(NHANES)

# Look over the dataset documentation
? NHANES

# Pipes -------------------------------------------------------------------

#the pipe makes operations on dataframes easier
NHANES %>%  #with pipe, always create new line; shortcut %>%  Ctr + Shift + M
  colnames() %>%
  length()

length(colnames(NHANES)) #same command as above

NHANES %>% #does not change the dataset as it is not assigned to a variable
  mutate(Height = Height / 100, #mutate is used to modify or add variables
         Testing = "yes",
         HighlyActive = if_else(
           PhysActiveDays >= 5,
           "yes",
           "no"
         ))

NHANES_updated <- NHANES %>%
  mutate(UrineVolAverage = (UrineVol1 + UrineVol2) / 2)

glimpse(NHANES_updated)



NHANES_modified <-  NHANES %>% # dataset
  mutate(
    # 1. Calculate average urine volume
    UrineVolAverage = ((UrineVol1 + UrineVol2) / 2),
    # 2. Modify Pulse variable
    Pulse = Pulse / 60,
    # 3. Create YoungChild variable using a condition
    YoungChild = if_else(Age < 6, TRUE, FALSE)
  )
glimpse(NHANES_modified)
head(NHANES_modified$YoungChild)

NHANES %>%
  select(Gender, BMI)
#select(-Gender) will remove gender

NHANES %>%
  select(-BMI)

NHANES %>%
  select(starts_with("Smoke"), #powerful tool to select variables
         contains("Vol"),
         matches("[123]")) #regular expression - pattern matching
# find every variable that contains 1, 2 or 3

NHANES %>%
  #new name = old name
  rename(
    NumberBabies = nBabies,
    Sex = Gender
    )

NHANES %>%
  filter(Gender == "female") # keep rows where gender equals female (== logical operator)
# filter(Gender != "female") # keep rows where gender does NOT equal female
 filter(BMI >= 25 & Gender == "female")
 #filter(BMI >= 25 | Gender == "female")

 NHANES %>%
   arrange(Age) %>%  #sorts in ascending order otherwise arrange(desc(Age))
   #arrange(Age, Gender)
   select(Age)


 #Exersice
 # To see values of categorical data
 summary(NHANES)

 # 1. BMI between 20 and 40 and who have diabetes
 NHANES %>%
   # format: variable >= number
   filter(BMI >= 20 & BMI <= 40 & Diabetes == "yes")

 # 2. Working or renting, and not diabetes
 NHANES %>%
   filter((Work == "Working" | HomeOwn == "Rent") & Diabetes == "no") %>%
   select(Age, Gender, Work, HomeOwn, Diabetes)
#brackets are needed for logic!
 # 3. How old is person with most number of children.
 NHANES %>%
   arrange(desc(nBabies)) %>%
   select(Age, nBabies)

#split, apply, combine
 NHANES %>%
   summarise(MaxAge = max(Age, na.rm = TRUE), #remove missing values
   MinBMI = min(BMI, na.rm = TRUE)
                          )

 NHANES %>%
   group_by(Gender) %>%
   summarize(MeanBMI = mean(BMI, na.rm =TRUE),
             MeanAge = mean(Age, na.rm =TRUE))


 #gather: convert data from wide to long format

 #example table
 table4b
 #gather takes at least 2 arguments.
 #1. the column name that takes variable,
 #2. name of column that takes up values
 #3. column that should be excluded from gathering (identifier)
 table4b %>%
  gather(year, population, -country)

 table4b %>% # doues exact same thing thean the one above
   gather(year, population, '1999', '2000')

 nhanes_simple <- NHANES %>%
   select(SurveyYr, Gender, Age, Weight, Height, BMI, BPSysAve)
 nhanes_simple

 #put dataset into long format
 nhanes_long <- nhanes_simple %>%
   gather(Measure, Value, -SurveyYr, -Gender)
 nhanes_long

nhanes_summary <-  nhanes_long %>%
  group_by(SurveyYr, Gender, Measure) %>%
  summarize(MeanValue = mean(Value, na.rm = TRUE))

# spread - from long to short
table2

 table2 %>%
   spread(type, count)

 nhanes_summary %>%
   spread(SurveyYr, MeanValue)

 #Exercise
 #1. select applicable values
 nhanes_exercise <- NHANES %>%
   select(SurveyYr, Gender, Age, BMI, BPDiaAve,
          BPSysAve, nBabies, Poverty, AlcoholDay,
          PhysActiveDays, DiabetesAge, TotChol)
 nhanes_exercise

 #2. create variables that are missing and rename other variables
 nhanes_renamed <- nhanes_exercise %>%
   mutate(MoreThan5DaysActive = PhysActiveDays > 5) %>%
   rename(AgeDiabetisDiagnisis = DiabetesAge,
          DrinksOfAlcoholInDay = AlcoholDay,
          NumberOfBabies = nBabies,
          TotalCholesterol = TotChol) %>%
   select(-PhysActiveDays) %>%
   filter(Age <= 75,  Age >= 18)
 nhanes_renamed

 #3. change to long format
nhanes_exercise_long <- nhanes_renamed %>%
  gather(Measure, Value, -Gender, -SurveyYr)
nhanes_exercise_long

#4. create summary to get mean values
nhanes_exercise_summary <-  nhanes_exercise_long %>%
  group_by(SurveyYr, Gender, Measure) %>%
  summarize(MeanValue = mean(Value, na.rm = TRUE))
nhanes_exercise_summary

#5. split those means by survey year
nhanes_exercise_year <- nhanes_exercise_summary %>%
  spread(SurveyYr, MeanValue)
nhanes_exercise_year

