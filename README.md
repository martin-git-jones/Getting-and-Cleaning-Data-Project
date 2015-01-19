# Getting and Cleaning Data

Martin Jones

## Course Project

An R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## Steps to use this program

1. Place run_analysis.R in a working directory.

2. From the same directory where you placed run_analysis.R run the following commands to download the source data in to a data subdirectory and unzip it:

	  dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
	  download.file(dataUrl,destfile="./Dataset.zip",method="curl")
	  unzip(zipfile="./Dataset.zip",exdir="./data")

3. Run run_analysis.R  to generate a new file tidy.txt in your working directory.


## run_analysis.R steps explained

* Read the contents of all the test, training, subject, activity and features files:
	X_train.txt
	y_train.txt
	subject_train.txt
	y_test.txt
	X_test.txt
	activity_labels.txt
	features.txt

* Combine the files to a data frame called all_combined.

* Apply the features and activity labels

* Extract the mean and standard deviation data in to a new data frame called combinedAverages

* Change the column labels to make them more descriptive.

* Write the new tidy set into a text file called tidy.txt in the current working directory

### Additional Information
The tidy.txt data set can be read back in to R with the following command:
	 data <- read.table("tidy.txt", header = TRUE)

You can find additional information about the variables, data and transformations in the CodeBook.MD file.

