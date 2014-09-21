run_analysis.R
==============

### -= Getting and Cleaning Data Course Project =-

This repo contains R script which can process this source data:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Source data description:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

You can find information about the data in `CodeBook.md`.

The R script `run_analysis.R` can download and process the required data.
It produces two text files:
- `all_data.txt` : contains training and test data sets;
- `tidy_data.txt` : contains data set with the average of each variable for each activity and each subject.

Main process steps of `run_analysis.R` script are:

1. Downloads the training and test data sets.
2. Loads the data sets.
3. Merges the training and the test sets to create one data set.
4. Extracts only the measurements on the mean and standard deviation for each measurement.
5. Uses descriptive activity names to name the activities in the data set.
6. Appropriately labels the data set with descriptive activity names.
7. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.





