### Create one R script called run_analysis.R that does the following ###
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive activity names. 
#5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Prepare 
# Required packages
if (!require("data.table")) {install.packages("data.table") 
                             require("data.table")}
if (!require("reshape2")) {install.packages("reshape2")
                           require("reshape2")}

### Download file and unzip it
dataFile <- "getdata-projectfiles-UCI HAR Dataset.zip"
dataDir  <- "UCI HAR Dataset"
if (!file.exists(dataFile)){  
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, dataFile, method="curl")
    
    # Read all required .txt files and label the datasets
    if (!file.exists(dataDir)){ 
        unzip(dataFile)}
}

# Load datasets
test_Subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
test_X <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_Y <- read.table("./UCI HAR Dataset/test/Y_test.txt")

train_Subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
train_X <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_Y <- read.table("./UCI HAR Dataset/train/Y_train.txt")

features <- read.table("./UCI HAR Dataset/features.txt")
activity_Labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# Merge the test and train subject datasets
subject <- rbind(test_Subject, train_Subject)
colnames(subject) <- "subject"

# Merge the test and train labels with textual labels
label <- rbind(test_Y, train_Y)
label <- merge(label, activity_Labels, by=1)[,2]

# Merge the test and train main dataset with textual headings
all_data <- rbind(test_X, train_X)
colnames(all_data) <- features[, 2]

# Merge all previous datasets
all_data <- cbind(subject, label, all_data)

# Save to file
write.table(all_data, file="all_data.txt")

# Create a smaller dataset containing only the mean and std variables
search <- grep("-mean|-std", colnames(all_data))
dataMeanStd <- all_data[,c(1,2,search)]

# Compute the means, grouped by subject and label
melted = melt(dataMeanStd, id.var = c("Subject", "Activity"))
tidyData = dcast(melted , subject + label ~ variable, mean)

# Save result dataset to file
write.table(tidyData, file="tidy_data.txt", row.name=FALSE)

