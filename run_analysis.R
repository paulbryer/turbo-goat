#set working directory 

setwd("C:/Users/asus/Documents/R/Getting and Cleaning Data/UCI HAR Dataset")

## Read in feature names and manipulate to be used as headers for datasets
features <- read.table(file="features.txt")
#transpose (we want it horizontal, not vertical)
features <- t(features)
#subset second row (as this is where the names are)
features <- features[2,]

#read in activity data
testlabels <- read.table(file="./test/y_test.txt")
traininglabels <- read.table(file="./train/y_train.txt")
#compile and rename activities
all_actlabels <- rbind(testlabels,traininglabels)
colnames(all_actlabels) <- "Activity"
all_actlabels[all_actlabels == "1"] <- "STANDING" 
all_actlabels[all_actlabels == "2"] <- "WALKING_UPSTAIRS"
all_actlabels[all_actlabels == "3"] <- "WALKING_DOWNSTAIRS"
all_actlabels[all_actlabels == "4"] <- "SITTING"
all_actlabels[all_actlabels == "5"] <- "STANDING"
all_actlabels[all_actlabels == "6"] <- "LAYING"

## read in and compile subject IDs
test_subject <- read.table(file = "./test/subject_test.txt")
train_subject <- read.table(file = "./train/subject_train.txt")
all_subjects <- rbind(test_subject, train_subject)
colnames(all_subjects) <- "Subject_ID" 

##Read in test and train x data

testdata <- read.table(file="./test/X_test.txt")
traindata <- read.table(file="./train/X_train.txt")
#Combine test and trial data and apply headers to columns
completedata <- rbind(testdata,traindata)
#give descriptive names to columns
names(completedata) <- features

## subset columns that relate to mean and standard deviation
#use grep function to select on a general expression
meancols <- grep (pattern = "mean", features)
stdcols <- grep (pattern = "std()", features)

#combine to make a list of all coumns that contain mean or standard deviation measurements
desired_cols <- append (meancols, stdcols, after = length(stdcols))
#subset the full data set on these columns
desired_data <- completedata[,desired_cols] 

#add subect and activity data to desire data table
desired_data <- cbind(all_subjects,all_actlabels,desired_data)

#remove meanFreq columns
meanFreqcols <- grep (pattern = "meanFreq", names(desired_data))
desired_data <- desired_data[,-meanFreqcols]


##create tidy data set 

#install and load plyr package
install.packages(plyr)
library(plyr)


# Produce summary table with means for each Subject ID  Activity 
tidy_data <- ddply(desired_data, .(Subject_ID, Activity), function(x) colMeans(x[, 3:68]))

# write data to a file
write.table(tidy_data, "tidy_data.txt", row.name=FALSE)
