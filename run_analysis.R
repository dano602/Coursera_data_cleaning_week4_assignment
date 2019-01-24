## read libraries
library(data.table)

## download files
vector<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(vector,"Dataset.zip",mode = "wb") ## wb mode reads binary data of the dataset
unzip(zipfile="Dataset.zip",exdir="./data")
path<-file.path("./data","UCI HAR Dataset")
files<-list.files(path,recursive = TRUE) ## you get list of all files present

##read train data
trainx = read.table(file.path(path, "train", "X_train.txt"),header = FALSE)
trainy = read.table(file.path(path, "train", "y_train.txt"),header = FALSE)
train_subject<-read.table(file.path(path,"train", "subject_train.txt"),header=FALSE)

## read test data
testx<-read.table(file.path(path,"test","X_test.txt"),header=FALSE)
testy<-read.table(file.path(path,"test","y_test.txt"),header=FALSE)
test_subject<-read.table(file.path(path,"test","subject_test.txt"),header=FALSE)

## read features
features = read.table(file.path(path, "features.txt"),header = FALSE)

## read labels
activityLabels = read.table(file.path(path, "activity_labels.txt"),header = FALSE)

## name columns of train files
colnames(trainx)<-features[,2]
colnames(trainy) = "activityId"
colnames(train_subject) = "subjectId"
## name columns of test files
colnames(testx) = features[,2]
colnames(testy) = "activityId"
colnames(test_subject) = "subjectId"
## name columns of activity labels
colnames(activityLabels) <- c('activityId','activityType')
## train set merging merging
train_merge<-cbind(trainy, train_subject, trainx)
## test set merging merging
test_merge<-cbind(testy, test_subject, testx)
## merged all together
merged_together<-rbind(train_merge,test_merge)
## save column names from merged data as variable and then look for info you are interested in
columnnames<-colnames(merged_together)
mean_std <- (grepl("activityId" , columnnames) | grepl("subjectId" , columnnames) | 
               grepl("mean.." , columnnames) | grepl("std.." , columnnames))
##subsets only columns containing activity id, subject id, mean and std in column name 
## from merged dataset
mean_std_subset <- merged_together[ , mean_std == TRUE]
## adds descriptive activity names to name the activities
mean_std_subset_wtlabels<-merge(mean_std_subset, activityLabels, by='activityId', 
                                all.x=TRUE)
## creates tidy dataset
tidyset <- aggregate(. ~subjectId + activityId + activityType, mean_std_subset_wtlabels, mean)
tidyset <- tidyset[order(tidyset$subjectId, tidyset$activityId),]
## writes output to text file 
write.table(tidyset, "tidyset.txt", row.name=FALSE)
