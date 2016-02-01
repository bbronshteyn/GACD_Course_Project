Code Book
=========================
The data set "./data/tidy_set.txt" was derived from multiple data produced as part of Human Activity Recognition Using Smartphones Data Set project (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

Tidy Data Set description
=========================
Tidy data set contains was produced by combining test and train data, removing unnecessary columns, grouping observations by activity and subject and calculating means of each column for each group. The following steps were taken.

Step 1 - Download file and unzip
Since files were locate on a remote server, I downloaded files into ./data directory and unzipped them

Step 2 - Read in files
I then read in the following files:
./data/UCI HAR Dataset/features.txt
./data/UCI HAR Dataset/activity_labels.txt
./data/UCI HAR Dataset/train/subject_train.txt
./data/UCI HAR Dataset/test/subject_test.txt 
./data/UCI HAR Dataset/test/X_test.txt
./data/UCI HAR Dataset/test/y_test.txt
./data/UCI HAR Dataset/train/X_train.txt 
./data/UCI HAR Dataset/train/y_train.txt

Step 3 - Merge datasets
I used combination of core R features and dplyr library to merge datasets. The following actions were taking to compete this step:
1. combine two X data sets into one row-wise
2. use feature names from feature file to set names for combined set
3. extract all columns that have mean or std in the name
4. combine two Y data sets into one row-wise
5. add proper name to combined Y set
6. combine subject sets row-wise
7. add proper name to subjects set
8. combine subject, activity, and data sets column-wise
9. replace activity ids with values and sort set by subject_id and activity_id

Step 4 - Create independent tidy data set with means
I performed the following activities to achieve the result
1. group by activity and then subject_id (per instructions) and summarize each column using mean
2. change column names to add MEAN to differentiate them from original column names

Step 5 - Write out the tidy data set

Field Description
=========================
The resulting file consists of 81 variables and 180 observations. The variables are:
"activity" - contains description of the activity which was measured
"subject_id" - contains unique identified for each subject in the study
Columns 3 - 81 are average values of columns which contain mean or std in the name and extracted from files prodcued as the result of Human Activity Recognition Using Smartphones Data Set experiment. Detailed descriptions can be found in ./data/UCI HAR Dataset/features_info.txt file. 
