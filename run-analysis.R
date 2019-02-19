# Outcome: 
#   1. Tidy data set
#   2. Github repo with scripts
#   3. Code book
#   4. README
# 
# Script contains:
#   1. Merge training and test sets into one data set
#   2. Extract mean and sd for each measurement
#   3. Add descriptive activity names
#   4. Add descriptive variable names
#   5. Create second tidy data set with the average of each variable for each activity and each subject
# 

library(tidyverse)

## Read in available data sets
# Raw measurement data - test set
testdataset <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
# Activity labels (numeric code) by row - test set
testlabels <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")

# Raw measurement data - training set
traindataset <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
# Activity labels (numeric code) by row - training set
trainlabels <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")

# Matching activity level numeric code with descriptive name
activitylabels <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")

# Match feature column number with descriptive name
features <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt")



## Merge the activity labels for the test and training sets
alllabels <- bind_rows(testlabels, trainlabels) %>%
  left_join(activitylabels, by = "V1") %>%
  select(activity = V2)

## Merge the test and training sets
allmeasurements <- bind_rows(testdataset, traindataset)

## Rename the column names in allmeasurements with the descriptive names in features
names(allmeasurements) <- features[,2]

## Merge the activity labels in the allmeasurements data frame
measurementslabelled <- bind_cols(allmeasurements, alllabels) %>%
  select(activity, 1:561) # reorder columns so the activity labels appear in the first column

## Create a data frame from measurementslabelled containing only mean and sd measurements
measurements_meansd <- measurementslabelled %>%
  select(activity, contains("mean()"), contains("std()"))

cleandata <- measurements_meansd %>%
  gather(key = "fullsubject", value = "measurement", `tBodyAcc-mean()-X`:`fBodyBodyGyroJerkMag-std()`) %>%
  separate(fullsubject, into = c("tf_subject", "statistic", "dimension"), sep = "-") %>% # generates warnings for subjects without dimension
  mutate(time_frequency = substr(tf_subject, 1, 1), # extract the first character (t | f)
         time_frequency = gsub("^t$", "time", time_frequency), # change any t to time
         time_frequency = gsub("^f$", "frequency", time_frequency), # change any f to frequency
         statistic = gsub("\\(\\)", "", statistic), # remove the parentheses from mean() and std() - need to escape parens
         subject = substr(tf_subject, 2, nchar(tf_subject)), # extract remainder of subject name
         activity = tolower(activity), # make all characters lower case
         dimension = tolower(dimension)) %>% # make all characters lower case
  select(activity, subject, time_frequency, dimension, statistic, measurement)

groupaverages <- cleandata %>%
  group_by(activity, subject, time_frequency, dimension, statistic) %>%
  summarise(averagevalue = mean(measurement))

write.table(groupaverages, "tidy-data-activity-tracker.txt", row.names = FALSE)














