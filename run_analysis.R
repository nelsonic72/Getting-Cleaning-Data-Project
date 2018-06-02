#Getting and Cleaning Data Course Project

# Download data collected from the accelerometers from the Samsung Galaxy S smartphone and create a tidy dataset
# Input:  UCI HAR Dataset.zip
# OUtput: UCI_HAR_Tidy.txt

#Steps
# 1 Merges the training and the test sets to create one data set.
# 2 Extracts only the measurements on the mean and standard deviation for each measurement.
# 3 Uses descriptive activity names to name the activities in the data set
# 4 Appropriately labels the data set with descriptive variable names.
# 5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Preliminary
library(dplyr)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file <- "UCI HAR Dataset.zip"

if(!file.exists(file)) {
      download.file(url, file, mode="wb")
}

path <- "UCI HAR Dataset"
if(!file.exists(path)) {
      unzip(file)
}

trainLabels <- read.table(file.path(path, "train", "Y_train.txt"))
trainData <- read.table(file.path(path, "train", "X_train.txt"))
trainSubjects <- read.table(file.path(path, "train", "subject_train.txt"))

testLabels <- read.table(file.path(path, "test", "Y_test.txt"))
testData <- read.table(file.path(path, "test", "X_test.txt"))
testSubjects <- read.table(file.path(path, "test", "subject_test.txt"))

#Step 1 - Merges the training and the test sets to create one data set.
allData <- rbind(cbind(trainSubjects, trainLabels, trainData), cbind(testSubjects, testLabels, testData))
features <- read.table(file.path(path, "features.txt"), as.is=TRUE)
featureList <- features[,2]
colnames(allData) <- c("subject", "activity", featureList)

#Step 2 - Extracts only the measurements on the mean and standard deviation for each measurement.
colMask <- grepl("subject|activity|mean|std", colnames(allData))
subData <- allData[ ,colMask]

#Step 3 - Uses descriptive activity names to name the activities in the data set
activities <- read.table(file.path(path, "activity_labels.txt"))
colnames(activities) <- c("actID", "actLabel")
subData$activity <- factor(subData$activity, levels=activities$actID, labels=activities$actLabel)

#Step4 - Appropriately label the data set with descriptive variable names.
allCols <- colnames(subData)
allCols <- gsub("^f", "frequency", allCols)
allCols <- gsub("^t", "time", allCols)
allCols <- gsub("[\\(\\)-]", "", allCols)
allCols <- gsub("BodyBody", "Body", allCols)
allCols <- gsub("[Aa]cc", "Accelerometer", allCols)
allCols <- gsub("[Mm]ean", "Mean", allCols)
allCols <- gsub("[Gg]yro", "Gyroscope", allCols)
allCols <- gsub("[Ss]td", "StandardDeviation", allCols)
allCols <- gsub("Freq", "Frequency", allCols)
allCols <- gsub("Mag", "Magnitude", allCols)
colnames(subData) <- allCols

#step 5 - From the data set in step 4, creates a second, independent tidy data set with the 
#average of each variable for each activity and each subject.

dataMeans <- subData %>%
      group_by(subject, activity) %>%
      summarise_all(funs(mean))

write.table(dataMeans, "UCI HAR Tidy.txt", row.name=FALSE, quote=FALSE)


