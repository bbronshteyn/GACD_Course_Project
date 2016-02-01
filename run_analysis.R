# Step 1 - Download file and unzip
if(!file.exists("./data")) {dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile = "./data/UCI_HAR_Dataset.zip",method = "curl")
unzip("./data/UCI_HAR_Dataset.zip", exdir = "./data/")

#Step 2 - Read in files
features <- read.table("./data/UCI HAR Dataset/features.txt")
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
subject_test  <- read.table("./data/UCI HAR Dataset/test/subject_test.txt") 
X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt") 
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt") 
X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt") 
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt") 

#Step 3 - Merge datasets
library(dplyr)
## combine two X data sets into one row-wise
combined_X <- rbind(X_test, X_train)
## use feature names from feature file to set names for combined set
feature_names <- as.character(features[[2]])
names(combined_X) <- feature_names
## extract all columns that have mean or std in the name
mean_and_std_cols <- grepl("mean|std", names(combined_X))
combined_X_shrunk <- combined_X[ , mean_and_std_cols]
## combine two Y data sets into one row-wise
combined_Y <- rbind(y_test, y_train)
## add proper name
names(combined_Y) <- c("activity_id")
## combine subject sets row-wise
combined_subj <- rbind(subject_test,subject_train)
## add proper name
names(combined_subj) <- c("subject_id")
## combine subject, activity, and data sets
combined_set <- cbind(combined_subj,combined_Y,combined_X_shrunk)
## replace activity ids with values
combined_set <- merge(activity_labels, combined_set, by.x = "V1", by.y = "activity_id")
combined_set <- rename(combined_set, activity = V2)
combined_set <- combined_set %>% select(-V1) %>% arrange(subject_id, activity)

#Step 4 - Create independent tidy data set with means
## group by activity and then subject_id (per instructions) and summarize each column using mean
tidy_set <- combined_set %>% group_by(activity, subject_id) %>% summarize_each(funs(mean))
## change column names to add MEAN
names(tidy_set)[3:81] <- paste("MEAN_",names(tidy_set)[3:81],sep = "")

#Step 5 - Write out the tidy data set
write.table(tidy_set, file = "./data/tidy_set.txt", row.name=FALSE)
