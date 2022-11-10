
# 1 Merges the training and the test sets to create one data set.

#read data

X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")


#merge data

X_merged <- rbind(X_test, X_train)
y_merged <- rbind(y_test, y_train)
subject_merged <- rbind(subject_test, subject_train)


# 2 Extracts only the measurements on the mean and standard deviation 
#for each measurement. 

features_extracted <- grep("-(mean|str)\\(\\)", features[,2])

X_merged <- X_merged[,features_extracted]

names(X_merged) <- features[features_extracted,2]

# 3 Uses descriptive activity names to name the activities in the data set.

y_merged[,1] <- activity_labels[y_merged[,1],2]

names(y_merged) <- "activity"

# 4 Appropriately labels the data set with descriptive variable names. 

names(subject_merged) <- "subject"

data_all <- cbind(X_merged,y_merged, subject_merged)

# 5 From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.
install.packages('dplyr')
library(dplyr)

result_data <- data_all %>%  group_by(subject,activity)  %>%  summarise_each(funs(mean))

write.table(result_data, file="tided_dataset.txt")
                                                                          