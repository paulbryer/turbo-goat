### Description
Additional information about the processes applied in run_analysis.md

### Source Data
A full description of the data used in this project can be found at [The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

[The source data for this project can be found here.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

### Data Set Information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

### Measurements Information
For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

### Section 1. Merge the training and the test sets to create one data set.
After setting the correct working directory for the files, read in the data from these files using read.table(): 
- features.txt
- activity_labels.txt
- subject_train.txt
- x_train.txt
- y_train.txt
- subject_test.txt
- x_test.txt
- y_test.txt

The main sets of measurement data are contained in the x_train and _test files. 
These sets are row-binded, and the feature names used to name the columns.

## Section 2. Extract only the measurements on the mean and standard deviation for each measurement. 
This is achieved by use of the general expression function, grep(). 
It is used twice, once for mean and once or standard deviation, and the results clipped together to give a full list of columns to be extracted (desired_cols).
Some columns relating to meanFreq snuck through the general expression function. This required another general expression column selection, this time on the string "meanFreq", and a further subsetting of the data set to exclude these columns. 

## Section 3. Use descriptive activity names to name the activities in the data set
Replaced numbers with activity names as given in activity labels file.

## Section 4. Appropriately label the data set with descriptive activity names.
features.txt contains the descriptions of what the data columns are measurements of.
After reading it in, we transpose it and remove the first row.
This results in a character vector (features) which we use to name the columns of our data frame.


## Section 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
ddply() from the plyr package is used to easily produce a data table with the average of each measurement criteria for each activity and Subject_ID.
This data table is then written to a file.

