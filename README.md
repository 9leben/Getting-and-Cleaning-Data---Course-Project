This is the README file for the "Getting and Cleaning Data" Course Project.

The run_analysis.R script reads the test and train datasets from the original files (those that came from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ) and performs the following tasks:

1) Read the test and train dataset files separately. Each original dataset has 3 components: x, y and subject. 
2) Also reads the features and activity_labels files. This will be used to name the columns, and replace the activity code for the activity name.
3) Merges the 2 components (test and train) to create a single dataframe for x, y and subject.
4) Label (add names) the x, y, and subject dataframes.
5) Replaces the activity codes in the y dataframe with the actual Activity (character).
6) Merges the x, y and subject into a single dataframe (named full_set).
7) Creates a second dataframe filtering only the columns (variables) that represent a mean or and standard deviation ("mean" or "std").
8) Group the previous "reduced" dataframe based in the Activity and Subject, and calculates the average (mean) for the columns.
9) Writes this new dataframe to a text file: "summ_by_activity_subject.txt" per summary by activity and subject.

Note:
The script was written as a function to clean all the dataframes after running, but such dataframes can be preserved for analysis if the first and last lines of the script are commented out.  