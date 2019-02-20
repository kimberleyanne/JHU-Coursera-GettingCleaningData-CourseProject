# JHU-Coursera-GettingCleaningData-CourseProject
## Context
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data (Reyes-Ortiz *et al.*, 2012).

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain (Reyes-Ortiz *et al.*, 2012).

## Task Objectives
The script run_analysis.R contains code that accomplishes the following five tasks:
1. Merges the training and test data sets into a single data set.
2. Extracts all measurements of a mean or standard deviation (std). 
3. Adds descriptive activity names to the data set.
4. Adds descriptive variable names to the data set.
5. Creates a second tidy data set wiht the average of each mean and standard deviation measurement across each activity and subject.

## Process
This script accomplishes these tasks in the following way:
1. Read in all training and test data sets including measurement (X_test.txt; X_train.txt), label (y_test.txt; y_train.txt), and subject id (subject_test.txt; subject_train.txt) files.
2. Read in activity lables (activity_labels.txt) and features (features.txt).
3. Merge all the labels for the training and test data sets into a single data frame with bind_rows.
4. Using a left join, replace the numeric labels with their respective activity names.
5. Merge the training and test subject id data sets using bind_rows.
6. Merge the training and test data sets using bind_rows.
7. Replace the column names (V1, V2,...) with the descriptive names in the features.txt file.
8. Add the subject id's and activity lables to the data frame containing all the measurements with bind_cols.
9. Subset the data frame to only contain the subject id, activity name, and any column containing mean or standard deviation variables.
10. Clean the resulting data set by gathering the data into long format, separating the subject labels (features.txt) so that each column contains one variable (domain, motioncomponent, sensor, jerkmeasure, magnitudemeasure, dimension, and statistic), and standardizing naming conventions (e.g., tolower()).
11. Create a new data set with the average mean and standard deviation for each activity and subject using group_by and summarise.
12. Write the resulting data frame to a .txt file in the working directory (remove row names).

## References
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
