##All the data is found locally within the "UCI HAR Dataset" folder
##The data is found split within 2 folders, test and train
##In addition it is fragmented within 3 files: subject label, data itself and activity label

##Thus the first step is to load all the data

X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

##Then we merge set-wise

train_set <- cbind(subject_train, Y_train, X_train)
test_set <- cbind(subject_test, Y_test, X_test)

##And finally create the complete dataset

complete_set <- rbind(train_set, test_set)

##We also load the files that contain data labels and create label name vectors

main_labels <- read.table("UCI HAR Dataset/features.txt")
main_labels <- as.character(main_labels[,2])

##Then we add the remaining two labels for subjects and activity
complete_labels <- c("subject", "activity", main_labels)

##Then we apply the labels to data
names(complete_set) <- complete_labels

##We locate the labels that include mean and std and store it into a filter variable (don't forget the subject and activity) and use it to subset the set

filter <- grep("mean\\(\\)|std\\(\\)",names(complete_set))
filter <- c(1,2,filter)

subset_set <- complete_set[,filter]

##Next we use the activity_labels.txt file to add some sensible labels to our activities in column 2

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
recode_instr <- setNames(as.character(activity_labels[,2]), activity_labels[,1])

##Then we apply them to our dataset using plyr's revalue

library(plyr)
subset_set[,2] <- revalue(as.factor(subset_set[,2]), recode_instr)

##Now for the last task, we create a new tidy dataset using the aggregate function
tidy_dataset <- with(subset_set, aggregate(subset_set, by=list(subject,activity), FUN=mean, na.rm=TRUE))

##The result is a dataset that displays the mean for all combinations of activity and subject (180 observations)
##Thenw we rename the newly created GROUP variables and delete the old ones (cols 3 and 4), since they're no longer useful

tidy_dataset$subject <- NULL
tidy_dataset$activity <- NULL
names(tidy_dataset)[1:2] <- c("subject", "activity")

##And finally we export the newly created tidy_dataset

write.table(tidy_dataset, "tidy_dataset.txt", sep=" ", row.name=FALSE)
