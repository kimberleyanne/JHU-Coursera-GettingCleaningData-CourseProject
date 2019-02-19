# JHU-Coursera-GettingCleaningData-CourseProject
## Task Objectives:
This script contains code that accomplishes the following five tasks:
1. Merges the training and test data sets into a single data set.
2. Extracts all measurements of a mean or standard deviation (std). 
3. Adds descriptive activity names to the data set.
4. Adds descriptive variable names to the data set.
5. Creates a second tidy data set wiht the average of each mean and standard deviation measurement across each activity and subject.

## Process:
This script accomplishes these tasks in the following way:
1. Read in all training and test data sets including measurement (X_test.txt; X_train.txt) and label (y_test.txt; y_train.txt) files.
2. Read in activity lables (activity_labels.txt) and features (features.txt).
3. Merge all the labels for the training and test data sets into a single data frame with bind_rows.
4. Using a left join, replace the numeric labels with their respective activity names.
5. Merge the training and test data sets using bind_rows.
6. Replace the column names (V1, V2,...) with the descriptive names in the features.txt file.
7. Add the activity lables to the data frame containing all the measurements and rearrange the data frame so that the activity name variable is the first column.
8. Subset the data frame to only contain the activity name column and any column containing mean or standard deviation variables.
9. Clean the resulting data set by gathering the data into long format, separating the subject labels (features.txt) so that each column contains one variable (time_frequency, subject, statistic, and dimension), and standardizing naming conventions (e.g., tolower()).
10. Create a new data set with the average mean and standard deviation for each activity and subject (time_frequency-subject-dimention) using group_by and summarise.
11. Write the resulting data frame to a .txt file in the working directory (remove row names).
