# Libraries Used
library(dplyr)

# Read supporting Metadata
if(!file.exists("./data")) {dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/Dataset.zip", method = "curl")
unzip(zipfile = "./data/Dataset.zip", exdir = "./data")
path_rf<- file.path("./data" , "UCI HAR Dataset")
files <- list.files(path_rf, recursive = TRUE)

# Format training and test data sets
# Read training data
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", 
                           header = FALSE)
activityTrain <- read.table("UCI HAR Dataset/train/y_train.txt", 
                            header = FALSE)
featureTrain <- read.table("UCI HAR Dataset/train/x_train.txt", 
                           header = FALSE)

# Read test data
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", 
                          header = FALSE)
activityTest <- read.table("UCI HAR Dataset/test/y_test.txt",
                           header = FALSE)
featureTest <- read.table("UCI HAR Dataset/test/x_test.txt", 
                          header = FALSE)

# Part 1 - Merge the training and the test set to create one data set
# Concatenate the data tables by rows

subject <- rbind(subjectTrain, subjectTest)
activity <- rbind(activityTrain, activityTest)
features <- rbind(featureTrain, featureTest)



# Merge the data
colnames(activity) <- c("Activity")
colnames(subject) <- c("Subject")
completeData <- read.table(file.path(path_rf, "features.txt"), header = FALSE)
names(dataFeatures) <- dataFeaturesNames$v2
dataCombine <- cbind(subject, activity)
data <- cbind(features, dataCombine)

# Part 2 - Extracts only the measurements on the mean and standard deviation
# for each measurement

columnsWithMeanSTD <- completeData$v2[grep("mean\\(\\)|std\\(\\)", completeData$V2)]
requiredcolumns <- c(columnsWithMeanSTD, 562, 563)
extractedData <- completeData[, requiredcolumns]
 

# Subset the data frame by selected names of features

selectdNames <- c(as.character(columnsWithMeanSTD), "Activity", "Subject")
Data <- subset(completeData, select = selectdNames)
# Part 3 - Uses descriptive activity names to name the activities in the data set

extractedData <- read.table(file.path(path_rf, "activity_labels.txt"), header = 
                               FALSE)
