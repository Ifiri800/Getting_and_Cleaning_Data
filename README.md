The script consists of 5 steps based on the given instruction.

Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
The detailed operations for each step are below.

Read all the datasets and assign them to variables
train <- read.table("C:\\projects\\github\\R-projects\\1_gettingData\\UCI HAR Dataset\\train\\X_train.txt")
test <- read.table("C:\\projects\\github\\R-projects\\1_gettingData\\UCI HAR Dataset\\test\\X_test.txt")

train_label <- read.table("C:\\projects\\github\\R-projects\\1_gettingData\\UCI HAR Dataset\\train\\y_train.txt")
test_label <- read.table("C:\\projects\\github\\R-projects\\1_gettingData\\UCI HAR Dataset\\test\\y_test.txt")

activity_labels <- read.table("C:\\projects\\github\\R-projects\\1_gettingData\\UCI HAR Dataset\\activity_labels.txt")

subject_train <- read.table("C:\\projects\\github\\R-projects\\1_gettingData\\UCI HAR Dataset\\train\\subject_train.txt")
subject_test <- read.table("C:\\projects\\github\\R-projects\\1_gettingData\\UCI HAR Dataset\\test\\subject_test.txt")
1. Merges the training and the test sets to create one data set.
merged_data <- rbind(train, test)
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
Create a blank matrix to store mean
mean <- matrix(data=NA, nrow=1, ncol=ncol(merged_data))
Fill each cell per column with mean
for (i in 1:ncol(merged_data)) {
  mean[1, i] <- mean(merged_data[, i])
}
Create a blank matrix to store standard deviation
std <- matrix(data=NA, nrow=1, ncol=ncol(merged_data))
Fill each cell per column with standard deviation
# Fill each cell per column with standard deviation
for (i in 1:ncol(merged_data)) {
  std[1, i] <- sd(merged_data[, i])
  
}
Combine train dataset with the label
labeled_train <- cbind(train_label, train)
Combine test dataset with the label
labeled_test <- cbind(test_label, test)
Extract the names of the features
features <- read.table("C:\\projects\\github\\R-projects\\1_gettingData\\UCI HAR Dataset\\features.txt")
features <- features[,2]
Name the features column "activity_labels" (Replace the numbers with the actual names later)
features <- append("activity_labels", features)
Add column names on labeled_train dataset corresponding to the names of the features
colnames(labeled_train) <- features
Add column names on labeled_test dataset corresponding to the names of the features
colnames(labeled_test) <- features
Combine labeled_train dataset and labeled_test dataset
all_dataset <- rbind(labeled_train, labeled_test)
Replace the numbers in activity_labels with the actual value on activity_labels table
for (i in 1:nrow(all_dataset)) {
  if (all_dataset[i, 1] == 1) {
    all_dataset[i,1] <- activity_labels[, 2][1]
  } else if (all_dataset[i, 1] == 2) {
    all_dataset[i, 1] <- activity_labels[, 2][2]
  } else if (all_dataset[i, 1] == 3) {
    all_dataset[i, 1] <- activity_labels[, 2][3]
  } else if (all_dataset[i, 1] == 4) {
    all_dataset[i, 1] <- activity_labels[, 2][4]
  } else if (all_dataset[i, 1] == 5) {
    all_dataset[i, 1] <- activity_labels[, 2][5]
  } else if (all_dataset[i, 1] == 6) {
    all_dataset[i, 1] <- activity_labels[, 2][6]
  }
}
Consolidating subject data with all_dataset
subject_data <- rbind(subject_train, subject_test)
all_dataset <- cbind(subject_data, all_dataset)
Replace the numbers on subject_data with
features <- append("subject", features)
colnames(all_dataset) <- features
Extract only the measurements on the mean and standard deviation for each measurement.
mean_and_std <-all_dataset %>%
  select(subject, activity_labels, contains("mean"), contains("std"))
4. Appropriately labels the data set with descriptive variable names.
names(mean_and_std) <- tolower(names(mean_and_std))
names(mean_and_std) <- gsub("[.]", "", names(mean_and_std))
names(mean_and_std) <- gsub("acc", "_accelerometer_", names(mean_and_std))
names(mean_and_std) <- gsub("freq", "_frequency_", names(mean_and_std))
names(mean_and_std) <- gsub("^t", "_time_", names(mean_and_std))
names(mean_and_std) <- gsub("^f", "_frequency_", names(mean_and_std))
names(mean_and_std) <- gsub("gyro", "_gyroscope_", names(mean_and_std))
names(mean_and_std) <- gsub("mag", "_magnitude_", names(mean_and_std))
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
consolidated_all_dataset <- aggregate(mean_and_std, by=list(all_dataset[, 1], all_dataset[, 2]), FUN=mean, na.rm=TRUE)
consolidated_all_dataset <- consolidated_all_dataset[, c(-3, -4)]
colnames(consolidated_all_dataset) <- features
names(consolidated_all_dataset) <- gsub("Group.1", "subject", names(mean_and_std))
names(consolidated_all_dataset) <- gsub("Group.2", "activity_labels", names(mean_and_std))
Set the output location and export the data table to this text file : run_analysis_result.txt
setwd("C:\\projects\\github\\W4_Getting_and_Cleaning_Data_Course_Project")
write.table(consolidated_all_dataset, file="run_analysis_result.txt", row.name=FALSE)
© 2021 GitHub, Inc.
