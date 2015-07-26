run_analysis <- function() {
  
## Some notes:
##
## This script assumes the original data has been decompressed in the current folder, hence there is a "UCI HAR Dataset"
## folder with the data inside.

  
if (!dir.exists("./UCI HAR Dataset")) { stop("Data directory does not exist.") }
  
## If you want fo have a look at all the temporarily dataframes, you should comment (##) the lines 1 and 117 like this:
## run_analysis <- function() {
## }

## Ensure both dplyr and tidyr libraries are loaded.
library(dplyr)
library(tidyr)

## General information on the test source files.
##
### - File X_test.txt contains the 561 variables for the test records.
### - File y_test.txt contains the activity label codes record code for the test, 
###   as defined in the file activity_labels.txt.
### - File subject_test.txt contains the id of the subject (volunteer) 
###   who performed the test record. These ids are between 1 to 30.

## Read data files into dataframes.
x_test_set <- read.delim("UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = "")
y_test_set <- read.delim("UCI HAR Dataset/test/y_test.txt", header = FALSE, sep = "")
subject_test_set <- read.delim("UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = "")

## General information on the train source files.
##
### - File X_train.txt contains the 561 variables for the train records.
### - File y_train.txt contains the activity label codes record code for the train, 
###  as defined in the file activity_labels.txt
### - File subject_train.txt contains the id of the subject (volunteer) 
###   who performed the train record. These ids are between 1 to 30.

x_train_set <- read.delim("UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = "")
y_train_set <- read.delim("UCI HAR Dataset/train/y_train.txt", header = FALSE, sep = "")
subject_train_set <- read.delim("UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep = "")

## Read the features.txt file with the 561 variable names.
features <- read.delim("UCI HAR Dataset/features.txt", header = FALSE, sep = "", stringsAsFactors = FALSE)

## Read the activity_labels.txt file with the 6 types of exercise, we'll use it latter.
activity_labels <- read.delim("UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = "", stringsAsFactors = FALSE)


## Course Project DELIVERABLE 1
### This will satisfy request (1) fo the Course Project:
### 1. Merges the training and the test sets to create one data set.

## First, bind the test and train original dataframes.
full_x <- rbind(x_test_set, x_train_set)
full_y <- rbind(y_test_set, y_train_set)
full_subject <- rbind(subject_test_set, subject_train_set)

## Then, we'll label all the previously created full_x, and the simpler full_y and full_subject dataframes.
names(full_x) <- features[,2]
names(full_y)[1] <- c("Activity")
names(full_subject)[1] <- c("Subject")

## Prior to make the single dataframe, let's replace the coded activity with the actual description in full_y.
### This will satisfy Course Project DELIVERABLE 3
full_y <- mutate(full_y, Activity = activity_labels[Activity,2])

## Create the full single dataframe.
full_set <- cbind(full_y, full_subject, full_x)


### Course Project DELIVERABLE 2
### This will satisfy request (2) fo the Course Project:
### 2. Extracts only the measurements on the mean and standard deviation for each measurement.

## Select the variable names from full_x containing mean(), std(), and stdFreq()
## Please note we couldn't use select() from {dplyr} since there are repeated columns in the features.txt file.
x_col_filter <- grepl("Activity|Subject|mean\\(\\)|std", names(full_x))
x_filtered <- subset(full_x, select = x_col_filter)

## If required, we create a single dataframe with the filtered columns. 
full_filtered_set <- cbind(full_y, full_subject, x_filtered)


### Course Project DELIVERABLE 3
### This will satisfy request (3) fo the Course Project:
### 3. Uses descriptive activity names to name the activities in the data set. 
## This was acomplished before in line 55, prior to the creation of the single files (full_set and full_filtered_set).


### Course Project DELIVERABLE 4
### This will satisfy request (4) fo the Course Project:
### 4. Appropriately labels the data set with descriptive variable names. 
## This was acomplished before in line 49. Previous single files (full_set and full_filtered_set) already have 
## the activity name.


### Course Project DELIVERABLE 5
### This will satisfy request (5) fo the Course Project:
### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
### for each activity and each subject. 
by_activity_subject <- group_by(full_filtered_set, Activity, Subject)
summ_by_activity_subject <- summarise_each(by_activity_subject, funs(mean))

## Create a txt file with summ_by_activity_subject
write.table(summ_by_activity_subject, "summ_by_activity_subject.txt", row.names = FALSE)

}
