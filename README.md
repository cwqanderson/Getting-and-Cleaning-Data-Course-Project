# Final Project – Getting and Cleaning Data
## Files
* final.txt - contains the data set created for this project.
* run_analysis.R - R script called run_analysis.R that does the following. 1) Merges the training and the test sets to create one data set; 2) Extracts only the measurements on the mean and standard deviation for each measurement; 3) Uses descriptive activity names to name the activities in the data set; 4) Appropriately labels the data set with descriptive variable names; and 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
* codebook.md -  modifies and updates the original codebooks, “features_info.txt” and “activity_lablels.txt” (download from <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>),  and indicates all variables and summaries calculated, along with units, and other relevant information for creating the variables contained in “final.txt.”
* README.md

## 0. Read the data -- assuming that the "data is in your working directory" per the submission instructions.
```
activities <- read.table("activity_labels.txt" , col.names = c("code", "activity"))
features <- read.table("features.txt", col.names = c("row", "feature"), stringsAsFactors = FALSE)
test_d <- read.table("X_test.txt", col.names = features$feature)
test_s <- read.table("subject_test.txt", col.names = "subject")
test_a <- read.table("y_test.txt", col.names = "code")
train_d <- read.table("X_train.txt", col.names = features$feature)
train_s <- read.table("subject_train.txt", col.names = "subject")
train_a <- read.table("y_train.txt", col.names = "code")
```
* “activitiy_labels.txt” and “features.txt” were read using the ‘read.table’ function and column names were assigned based on a preliminary inspection of the files and consultation with “features_info.txt.” 
* A preliminary inspection of the data revealed that: the file “features.txt” contained the same number of rows as the number of columns in the files “X_test.txt” and “X_train.txt.”   For this reason, and after consulting “features_info.txt,” it was determined that “features.txt” described the column names for both ““X_test.txt” and “X_train.txt.” 
* Because both “y_train.txt” and “y_test.txt” contained the same unique set of values as the first column name in “activity_lables.txt”, column names  for all three of these files were assigned the same variable name, “code.”

## 1. Merges the training and the test sets to create one data set.
```
library(dplyr)
library(tidyr)

test_set <- test_s %>%
        bind_cols(test_a) %>%
        bind_cols(test_d)

train_set <- train_s %>%
        bind_cols(train_a) %>%
        bind_cols(train_d)
```
* Because the number of rows, 2,947, in ‘test_d,’ ‘test_s,’ and ‘test_a’ were all equal, the function ‘bind_cols’ was used to create a single “test” data set named ‘test_set.’  
* The same logic applied to all of the training data frames created in the step above and resulted in a new data frame ‘train_set.’
```
one_set <- test_set %>%
        bind_rows(train_set)
```
* Having the same number of columns, 563,  the data frames ‘test_set’ and ‘train_set’ were merged using the function ‘bind_rows’ to create a single data set, ‘one_set.’

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
```
sub_set <- one_set %>%
        select(1:2, contains("mean"), contains("std")) %>%
        select(-contains("angle"), -contains("Freq"))
```
* Creates a new data frame, ‘sub_set’ from the a) the first two columns, b) the columns whose labels contain the word “mean”, and c) columns whose labels contain the string “std” of the single merged data frame ‘one_set’ created in the step above using the function ‘select’ with the argument ‘contains.’ 
* Next, the function ‘select’ uses the argument ‘-contains’ is employed to remove columns containing the strings ‘angle’ and ‘Freq.’
* These sub-setting decision were made to exclude variables whose names included the strings “Mean,” or “mean” but were not directly measured during the data collecting process.  Instead such variables were derived from the values of the others. 

## 3. Uses descriptive activity names to name the activities in the data set.
```
tidy_set1 <- sub_set
tidy_set1$code <- activities[tidy_set1$code, "activity"]
```
* creates a new data frame ‘tidy_set1’ from the data frame ‘sub_set’ from the step above.
* Reassigns values of the variable “code” in in ‘tidy_set’ to the descriptive values found in the data frame ‘activities.’  This is accomplished by subletting ‘activities’ by the value of ‘code’ in each row of ‘tidy_1’ along with the value of the corresponding row in the ‘activity’ column from the data frame ‘activities.’
```
tidy_set1$code <- tolower(tidy_set1$code)
tidy_set1$code <- sub("_", "", tidy_set1$code)
tidy_set1$code <- as.factor(tidy_set1$code)
```
* These operations convert the text to lower case (using the function ‘tolower’), remove underscores (with the function ‘sub’), and convert the column to a factor (using the function ‘as.factor’) as suggested in the Week 4 video “Editing Text Variables.” 
## 4. Appropriately labels the data set with descriptive variable names.
```
tidy_set2 <- tidy_set1
names(tidy_set2) <- sub("code", "activity", names(tidy_set2))
names(tidy_set2) <- gsub("^t", "time", names(tidy_set2))
names(tidy_set2) <- gsub("^f", "frequency", names(tidy_set2))
names(tidy_set2) <- gsub("Acc", "accelerometer", names(tidy_set2))
names(tidy_set2) <- gsub("Gyro", "gyroscope", names(tidy_set2))
names(tidy_set2) <- gsub("BodyBody", "body", names(tidy_set2))
names(tidy_set2) <- gsub("Mag", "magnitude", names(tidy_set2))
names(tidy_set2) <- gsub("\\.", "", names(tidy_set2))
names(tidy_set2) <- tolower(names(tidy_set2))
```
* Creates a new data frame ‘tidy-2’ from ‘tidy_1’ above.
* Employs the function ‘sub’ to change the non-descriptive column name “code” to the descriptive column name “activity.”
* Uses the function ‘gsub’ to change non-descriptive strings to descriptive strings (e.g. “t” to “time”, “Acc” to “accelerometer,” etc,).
* Removes periods from column names with the function ‘gsub.’
* Converts any remaining capital letters to lowercase with the function ‘tolower.’
* These formatting decisions were made based on information contained in the Week 4 video “Editing Text Variables.” 

## 5.Create a second, independent tidy data set with the average of each variable for each activity and each subject.
```
final_set <- tidy_set2 %>%
        group_by(subject, activity) %>%
        summarize_all(funs(mean))
```
* Creates new data set, ‘final_set,’ from ‘tidy_set2’ from the step above.
* Creates two groups using the variables ‘subject’ and ‘activity’ using the function ‘group_by.’  These groups will be employed by the function ‘summarize_all’ below.ze_all’ below.
* The function ‘summarize all’ calculates averages for all the cross-tabbed groups created above using the function ‘mean’ as part of the argument ‘funs.’
```
write.table(final_set, "Final.txt", row.names = FALSE)
```
* The function ‘write.table’ creates a text file, “Final.txt,” from the data frame ‘final_set.’
* Requires the argument ‘header = TRUE’ if used with the function ‘read.table’ to assign column names. 
