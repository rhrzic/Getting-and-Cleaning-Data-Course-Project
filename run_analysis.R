##All the data is found locally within the "UCI HAR Dataset" folder
##The data is found split within 2 folders, test and train
##In addition it is fragmented within 3 files: subject label, data itself and activity label
##Thus the first step is to load all the data

X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("UCI HAR Dataset/train/y_train.txt.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

