library(dplyr)

# read training and test data
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")
sub_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
sub_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# read variable data for X 
features <- read.table("./UCI HAR Dataset/features.txt")

# read labels for Y
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# merges training & test data
X_total <- rbind(X_train, X_test)
Y_total <- rbind(Y_train, Y_test)
sub_total <- rbind(sub_train, sub_test)

# extracts mean & std data to clean X & give column name
selected_var <- features[grep("mean|std",features[,2]),]
X_total <- X_total[,selected_var[,1]]
colnames(X_total) <- features[selected_var[,1],2]

# uses descriptive activity names to substitute activity number in Y
colnames(Y_total) <- "activity"
Y_total$activitylabel <- factor(Y_total$activity, labels = as.character(activity_labels[,2])) #from factor to character
activitylabel <- Y_total[,-1]

# merge to get total 
colnames(sub_total) <- "subject"
total <- cbind(X_total, activitylabel, sub_total)

# id label array
id_labels = c("subject", "activitylabel")
# reshape data using melt function
melt_data = melt(total, id = id_labels)
# use mean function using dcast function
tidy_data = dcast(melt_data, subject + activitylabel ~ variable, mean)

#write table to file
write.table(tidy_data, file = "./UCI HAR Dataset/tidy_data.txt", row.names = FALSE, col.names = TRUE)
