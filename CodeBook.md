# Activity Tracker Tidy Data Set Code Book

This file outlines the contents of the tidy-data.txt file created by the run_analysis.R code.

## Variables
*subjectid*
* numeric code 1-30 indicating the person (subject) using the fitness tracker

*activity*
* laying
* sitting
* standing
* walking
* walking_downstairs
* walking_upstairs

*domain*
* indicates whether the measurement type was made in the time or frequency domain

*motioncomponent*
* indicates whether the motion component of the measurement type was body, bodybody, or gravity

*sensor*
* indicates whether the measurement comes from the accelerometer or gyroscope

*jerkmeasure*
* indicates (yes/no) if the "body linear acceleration and angular velocity were derived in time to obtain Jerk signals" 

*magnitudemeasure*
* indicates (yes/no) if the measurement refers to a magnitude of the three-dimensional signals (Euclidean norm)

*dimension*
* indicates if the measurement was in the x, y, or z dimension

*statistic*
* indicates whether the measurement is of the mean or standard deviation

*averagevalue*
* numeric value showing the average mean or average standard deviation

## Files in Repository
README.md

CodeBook.md

run_analysis.R

tidy-text.txt

## License
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

