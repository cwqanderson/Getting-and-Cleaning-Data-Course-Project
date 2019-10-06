# 0. Read the data -- assuming that the "data is in your working directory" per the submission instructions.

activities <- read.table("activity_labels.txt" , col.names = c("code", "activity"))
features <- read.table("features.txt", col.names = c("row", "feature"), stringsAsFactors = FALSE)
test_d <- read.table("X_test.txt", col.names = features$feature)
test_s <- read.table("subject_test.txt", col.names = "subject")
test_a <- read.table("y_test.txt", col.names = "code")
train_d <- read.table("X_train.txt", col.names = features$feature)
train_s <- read.table("subject_train.txt", col.names = "subject")
train_a <- read.table("y_train.txt", col.names = "code")

# 1. Merges the training and the test sets to create one data set.

library(dplyr)
library(tidyr)

test_set <- test_s %>%
        bind_cols(test_a) %>%
        bind_cols(test_d)

train_set <- train_s %>%
        bind_cols(train_a) %>%
        bind_cols(train_d)

one_set <- test_set %>%
        bind_rows(train_set)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

sub_set <- one_set %>%
        select(1:2, contains("mean"), contains("std")) %>%
        select(-contains("angle"), -contains("Freq"))

# 3. Uses descriptive activity names to name the activities in the data set.

tidy_set1 <- sub_set
tidy_set1$code <- activities[tidy_set1$code, "activity"]
tidy_set1$code <- tolower(tidy_set1$code)
tidy_set1$code <- sub("_", "", tidy_set1$code)
tidy_set1$code <- as.factor(tidy_set1$code)

# 4. Appropriately labels the data set with descriptive variable names.
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

# 5.Create a second, independent tidy data set with the average of each variable for each activity and each subject.

final_set <- tidy_set2 %>%
        group_by(subject, activity) %>%
        summarize_all(funs(mean))

write.table(final_set, "Final.txt", row.names = FALSE)
