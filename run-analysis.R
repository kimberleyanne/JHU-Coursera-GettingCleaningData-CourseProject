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


## Load necessary packages
    library(tidyverse)

    
## Read in available data sets
    # Raw measurement data - test set
    testdataset <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
    # Activity labels (numeric code) by row - test set
    testlabels <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
    # Subject IDs by row - test set
    testsubject <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
    
    # Raw measurement data - training set
    traindataset <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
    # Activity labels (numeric code) by row - training set
    trainlabels <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
    # Subject IDs by row - train set
    trainsubject <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
    
    # Matching activity level numeric code with descriptive name
    activitylabels <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
    
    # Matching feature column number with descriptive name
    features <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt")


## Merge and label data
    # Merge the activity labels for the test and training sets
    allactivitylabels <- bind_rows(testlabels, trainlabels) %>%
      left_join(activitylabels, by = "V1") %>%
      select(activity = V2)
    
    # Merge the subject labels for the test and training sets
    allsubjects <- bind_rows(testsubject, trainsubject) %>%
      rename(subjectid = V1)
    
    # Merge the test and training sets
    allmeasurements <- bind_rows(testdataset, traindataset)
    
    # Rename the column names in allmeasurements with the descriptive names in features
    names(allmeasurements) <- features[,2]
    
    # Merge the subject and activity labels in with all the measurements
    measurementslabelled <- bind_cols(allsubjects, allactivitylabels, allmeasurements)
    
    # Create a data frame from measurementslabelled containing only mean and sd measurements
    measurements_meansd <- measurementslabelled %>%
      select(subjectid, activity, contains("mean()"), contains("std()"))

    
## Clean the final data set
    cleandata <- measurements_meansd %>%
      gather(key = "signal", value = "measurement", `tBodyAcc-mean()-X`:`fBodyBodyGyroJerkMag-std()`) %>%
      separate(signal, into = c("tf_type", "statistic", "dimension"), sep = "-") %>% # generates warnings for subjects without dimension
      mutate(domain = substr(tf_type, 1, 1), # extract the first character (t | f)
             domain = gsub("^t$", "time", domain), # change any t to time
             domain = gsub("^f$", "frequency", domain), # change any f to frequency
             statistic = gsub("\\(\\)", "", statistic), # remove the parentheses from mean() and std() - need to escape parens
             signal = substr(tf_type, 2, nchar(tf_type)), # extract remainder of subject name
             activity = tolower(activity), # make all characters lower case
             dimension = tolower(dimension), # make all characters lower case
             motioncomponent = tolower(gsub("Acc.*|Gyro.*", "", signal)), # remove sensor, jerk, mag data from motion component (Body, BodyBody, Gravity)
             sensor = gsub(".*Acc.*", "accelerometer", signal), # create sensor variable indicating accelerometer
             sensor = gsub(".*Gyro.*", "gyroscope", sensor), # add to sensor variable indication for gyroscope
             jerkmeasure = ifelse(grepl("Jerk", signal), "yes", "no"), # flag for if measurement is for jerk (body linear acceleration & ancular velocity)
             magnitudemeasure = ifelse(grepl("Mag", signal), "yes", "no")) %>% # flag for if measurement is the magnitude
      select(subjectid, activity, 
             domain, motioncomponent, sensor, jerkmeasure, magnitudemeasure, dimension, 
             statistic, 
             measurement)

    
## Create a new data set with the average of the mean and standard deviation measurements for each subject and activity
    groupaverages <- cleandata %>%
      group_by(subjectid, activity, 
               domain, motioncomponent, sensor, jerkmeasure, magnitudemeasure, dimension, 
               statistic) %>%
      summarise(averagevalue = mean(measurement))

    # Write new data set to a text file in the working directory
    write.table(groupaverages, "tidy-data.txt", row.names = FALSE)

