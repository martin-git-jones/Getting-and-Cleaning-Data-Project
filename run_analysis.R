##########################################################################################################

## Coursera Getting and Cleaning Data Course Project
#
# run_analysis.R   Martin Jones v.1.0  Jan 20th 2015
#
# See README.md for instructions on how to run this script.
# This script will perform the following steps on the UCI HAR Dataset downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip which should be unzipped into a subdirectory called data
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

##########################################################################################################

#  Read the training and the test data 
  x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
  y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
  subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
  x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
  y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
  subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)

#  Read activity labels
  activities <- read.table("./UCI HAR Dataset/activity_labels.txt")

#  Read features labels
  features <- read.table("./UCI HAR Dataset/features.txt")

#  Combine the training, test and subject data 
  x_combined <- rbind(x_train, x_test)
  y_combined <- rbind(y_train, y_test)
  s_combined <- rbind(subject_train, subject_test)

# Apply labels to columns
  names(features) <- c('feat_id', 'feat_name')

# Find the mean or standard deviation     
  data_mean_std <- grep("-mean\\(\\)|-std\\(\\)", features$feat_name) 
  x_combined <- x_combined[, data_mean_std] 

# Extracts only the measurements on the mean and standard deviation for each measurement.
  names(x_combined) <- gsub("\\(|\\)", "", (features[data_mean_std, 2]))

  names(activities) <- c('act_id', 'act_name')
  y_combined[, 1] = activities[y_combined[, 1], 2]

# Apply labels to columns of the combined data sets
  names(y_combined) <- "Activity"
  names(s_combined) <- "Subject"

# Create a single data set combining x,y and subject data
  all_combined <- cbind(s_combined, y_combined, x_combined)

#  Create a tidy data set with the average of each variable for each activity and each subject
  combinedAverages <- aggregate((all_combined[, 3:dim(all_combined)[2]]),list(all_combined$Subject, all_combined$Activity), mean)
  
#  Change column names to be more descriptive (see Codebook.md)
  names(combinedAverages)[1] <- "Subject"
  names(combinedAverages)[2] <- "Activity"
  names(combinedAverages) <- gsub("tBodyAcc", "Time.BodyAcc", names(combinedAverages))
  names(combinedAverages) <- gsub("tGravity", "Time.Gravity", names(combinedAverages))
  names(combinedAverages) <- gsub("fBody", "FFT.Body", names(combinedAverages))
  names(combinedAverages) <- gsub("fGravity", "FFT.Gravity", names(combinedAverages))
  names(combinedAverages) <- gsub("\\-mean\\(\\)\\-", ".Mean.", names(combinedAverages))
  names(combinedAverages) <- gsub("\\-std\\(\\)\\-", ".Std.", names(combinedAverages))
  names(combinedAverages) <- gsub("\\-mean\\(\\)", ".Mean", names(combinedAverages))
  names(combinedAverages) <- gsub("\\-std\\(\\)", ".Std", names(combinedAverages))

# Write tidy data set to a file called tidy.txt in the current directory
  write.table(combinedAverages, "./tidy.txt", row.names=FALSE)



