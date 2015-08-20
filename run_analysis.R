## 1) INITIATE LIBRARIES
library(plyr)

## 2) READ ALL DATA FILES
features <- read.table('./UCI HAR Dataset/features.txt')
activityLabels <- read.table('./UCI HAR Dataset/activity_labels.txt')
XTrain <- read.table('./UCI HAR Dataset/train/X_train.txt')
YTrain <- read.table('./UCI HAR Dataset/train/y_train.txt')
subjectTrain <- read.table('./UCI HAR Dataset/train/subject_train.txt')
XTest <- read.table('./UCI HAR Dataset/test/X_test.txt')
YTest <- read.table('./UCI HAR Dataset/test/y_test.txt')
subjectTest <- read.table('./UCI HAR Dataset/test/subject_test.txt')

## 3) MERGE DATA
XFull <- rbind(XTrain,XTest)
YFull <- rbind(YTrain, YTest)
SubjectFull <- rbind(subjectTrain, subjectTest)

# 4) LABEL X COL NAMES
colnames(XFull) <- features[,2]

# 5) LABEL Y VALUES
YFull = unlist(YFull)
YFull = as.factor(YFull)
levels(YFull) <- activityLabels[,2]

## 6) MERGE 1 DATASET // LABEL COL NAME Y
Data_Full <- cbind(SubjectFull, XFull, YFull)
colnames(Data_Full)[colnames(Data_Full)=="YFull"] <- "Activity"
colnames(Data_Full)[colnames(Data_Full)=="V1"] <- "Subject_ID"

## 7) EXTRACT MEASURES ON MEANS AND SD
means <- grep("mean()", features[,2], fixed = TRUE)
stds <- grep("std()", features[,2], fixed = TRUE)
meansAndStds <- sort(c(means, stds))
X_MeansStds <- XFull[,meansAndStds]
Data_Final <- cbind(SubjectFull, X_MeansStds, YFull)
colnames(Data_Final)[colnames(Data_Final)=="YFull"] <- "Activity"
colnames(Data_Final)[colnames(Data_Final)=="V1"] <- "Subject_ID"

## 8) CALCULATE MEAN FOR EVERY COMBINATION OF SUBJECT AND ACTIVITY
indexlist <- interaction(Data_Final$Subject_ID, Data_Final$Activity)
Datasplit <- split(Data_Final[,2:67], indexlist)
means <- lapply(Datasplit, colMeans, na.rm=TRUE)

## 9) RESTRUCTURE LIST INTO TIDY DATASET
New_data <- matrix(unlist(means), ncol = 66, byrow = TRUE)
colnames(New_data) <- features[meansAndStds,2]
Subject_IDs <- rep(c(1:30), times=6)
Activity <- rep(c(1:6), each=30)
New_data <- cbind(Subject_IDs, Activity, New_data)
New_data[,'Activity'] <- mapvalues(New_data[,'Activity'], c(1,2,3,4,5,6), as.vector(activityLabels[,2]))

## 10) WRITE DATA FILE
write.table(New_data, file = "new_data.txt", row.names = FALSE)
