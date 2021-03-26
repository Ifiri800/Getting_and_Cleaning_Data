# Getting_and_Cleaning_Data
This is Getting and Cleaning Data Final Assignment
CodeBook
Hereis the explanation of the variables used in the code.

train ... data table from X_train.txt
test ... data table from X_test.txt
train_label ... data table from y_train.txt
test_label ... data table from y_test.txt
activity_labels ... data table from activity_labels.txt
subject_train ... data table from subject_train.txt
subject_test ... data table from subject_test.txt
merged_data ... combined data table (X_train.txt and X_test.txt)
labeled_train ... combined train data with train's label data (y_train.txt)
labeled_test ... combined train data with test's label data (y_test.txt)
features ... data table from features.txt. Removed the first column and added "activity_labels" and "subject" as a first and second value on the code
subject_data ... combined data table (subject_train and subject_test from above)
all_dataset ... combined data table (labeled_train and labeled_test from above) first and then combine subject_data 
mean_and_std ... dataset that only include mean and standard deviation data from all_dataset and modified the column names to make them easy to read
consolidated_all_dataset ... grouped aggregated data table based on "activity_labels" and "subject" values from all_data with the average of each variable for each activity and each subject
