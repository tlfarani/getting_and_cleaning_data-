################# Getting and Cleaning Data Course Project #############

library(data.table)
library(dplyr)
library(tidyr)

######################### General info ##################################
setwd("~/3. Getting and Cleaning Data/course_project/UCI HAR Dataset")

activity_labels <- fread("activity_labels.txt")     #activities labels

features <- fread("features.txt")                   #features names


########################## Test data set #######################
# by the Readme file, there are 9 volunteers taking 
# 6 activities each #

setwd("~/3. Getting and Cleaning Data/course_project/test")

### Load subject_test
subject_test <- fread("subject_test.txt")

# Find out how many unique values are there in subject_test
unique(subject_test)                          # we can see that this vector represents the volunteers in the test group
                                              # this retrieves the following volunteers: 2, 4, 9, 10, 12, 13, 18, 20, 24

# Find out how many observations per volunteer
subject_test_1 <- subject_test[, .N, by=V1]   # we can see the following distribution of observation per volunteer: 2=302; 4=317; 9=288; 10=294; 12=320; 13=327; 18=364; 20=354; 24=381

# Rename values on volunteers
subject_test$volunteer <- paste("volunteer", subject_test$V1, sep = ".")

### Load y_test
y_test <- fread("y_test.txt")

# Find out how many unique values there are in subject_test
unique(y_test)                                # we can see that this vector represents the 6 activities

# Find out how many observations per volunteer
y_test_1 <- y_test[, .N, by=V1]               # we can see the following distribution: 5=532; 4=491; 6=537; 1=496; 3=420; 2=471

# get readable names to activities
activity_labels <- tolower(activity_labels$V2)              # lower case
activity_labels <- gsub("_", ".", activity_labels)          # replace "_" by "."

# Create a new column "activity" based on activity_labels
y_test <- mutate(y_test, activity = recode(y_test$V1, 
                                           "1" = activity_labels[1],
                                           "2" = activity_labels[2],
                                           "3" = activity_labels[3],
                                           "4" = activity_labels[4],
                                           "5" = activity_labels[5],
                                           "6" = activity_labels[6]))

### x_test

# Load x_test represents the observations for the 561 features
x_test <- fread("X_test.txt")                

# get readable names to x_test variables
name_x <- tolower(features$V2)                  # get features names
name_x <- gsub("-", ".", name_x)                # replace "-" by "."
name_x <- gsub("\\(\\)", "", name_x)            # Replace all "()" by ""


#I`ve had a problem with invalid characters in the original column names. 
#Solved by forcing unique column names with valid characters, with make.names() .
valid_column_names <- make.names(name_x, unique=TRUE, allow_ = TRUE)
name_x <- valid_column_names


# rename x variables according to name_x vector
x_test <- rename_at(x_test, vars(names(x_test)), function(x) name_x)


## Merge x_test, subject_test and y_test
x_test <- cbind(volunteer = subject_test$volunteer, 
                activity = y_test$activity, 
                x_test)

## Insert column "test"group"
x_test$group <- "test"


## Select only features mean and std
x_test_final <- select(x_test, 
                       group,
                       volunteer, 
                       activity, 
                       matches("mean|std"))

## Remove intermediate data
rm(subject_test, x_test, x_test1, y_test)

############################ Training data set #########################
# 21 volunteers
setwd("~/3. Getting and Cleaning Data/course_project/train")

### Load subjetc_test
subject_train.txt <- fread("subject_train.txt")

# Find out how many unique values there are in subject_train
unique(subject_train)                           # we can see that this vector represents the volunteers in the test group
                                                # this retrieves the following volunteers: 1, 3, 5, 6, 7, 8, 11, 14, 15, 16, 17, 19, 21, 22, 23, 25, 26, 27, 28, 29, 30

# Find out how many observations per volunteer
subject_train_1 <- subject_train[, .N, by=V1]  

# Rename values on volunteers
subject_train$volunteer <- paste("volunteer", subject_train$V1, sep = ".")

### y_train
y_train <- fread("y_train.txt")

# Find out how many unique values are there in subject_train
unique(y_train)                                # we can see that this vector represents the 6 activities

# Find out how many observations per volunteer
y_train_1 <- y_train[, .N, by=V1]               

# Create a new column "activity" based on activity_labels
y_train <- mutate(y_train, activity = recode(y_train$V1, 
                                   "1" = "walking",
                                   "2" = "walking.upstairs",
                                   "3" = "walking.downstairs",
                                   "4" = "sitting",
                                   "5" = "standing",
                                   "6" = "laying"))

### x_train

# Load x_train
x_train <- fread("X_train.txt")                

# rename x variables according to name_x vector
x_train <- rename_at(x_train, vars(names(x_train)), function(x) name_x)

## Insert column group
x_train$group <- "trainning"


## Merge x_train, subject_train and y_train
x_train <- cbind(volunteer = subject_train$volunteer, 
                 activity = y_train$activity, 
                 x_train)


## Select only features mean and std
x_train_final <- select(x_train, 
                        group, 
                        volunteer, 
                        activity, 
                        matches("mean|std"))


## Remove intermediate data
rm(subject_train,subject_train1, x_train, x_train1, y_train, y_train_1)


#### Average Test and Trainning ####

# Merge x_train and x_test
x_complete <- rbind(x_test_final, x_train_final) 

## Group by volunteer and activity.
x_complete_group <- group_by(x_complete, volunteer, activity)

## Average

x_complete_average <- summarise_at(x_complete_group, y, mean, na.rm = TRUE)

write.table(x_complete_average, "tidy_data.txt", row.names = FALSE)
