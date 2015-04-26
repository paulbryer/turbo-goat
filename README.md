
Getting and Cleaning Data Course Project

How the run_analysis.R script works:

The script assumes that we have already downloaded and unzipped the .zip file, into the folder "C:/Users/asus/Documents/R/Getting and Cleaning Data/UCI HAR Dataset"

If this is not where you have unzipped it too, you will only need change this filepath once: All other file paths are relative to the initial working directory set in line 5 of run_analysis.R

We start by reading the relevant files into R:

features.txt contains the descriptions of what the data columns are measurements of.
After reading it in, we transpose it and remove the first row.
This results in a character vector (features) which we will later use to name the columns of our data frame, and to decide which columns to extract from the full data set.

Subject IDs are in the subject_test and subject_train files. They tell us which human subject the measurements were taken from. The two sets are then combined into one object (all_subjects) using the cbind command.

The activity data is given in the y_train and y_test files. These contain numbers 1 to 6, which corresponds to the activity being performed (as outlined in the activity_labels file). The two sets of data are column-binded, and the numbers replaced by meaningful labels. 

The main sets of measurement data are contained in the x_train and _test files. These sets are row-binded, and the feature names used to name the columns.

The assignment calls for just the columns relating to mean and standard deviation. This is achieved by use of the general expression function, grep(). 
It is used twice, once for mean and once or standard deviation, and the results clipped together to give a full list of columns to be extracted (desired_cols).

These columns are then subsetted into a new object, desired_data

The Subject ID and Activity are then col-binded to the front of desired_data.

At this point I realised there were columns relating to meanFreq which had snuck through the general expression function. This required another general expression column selection, this time on the string "meanFreq", and a further subsetting of the data set to exclude these columns. 

At this point, desired_data is now our cleaned up data set.

The next step is to create a tidy data set from desired_data and write it to a file.
To do that the function ddply() from the plyr package was used to create a summary table for each Subject_ID & Activity.

Et voila! C'est fin.
