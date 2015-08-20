# The schript follows ten steps, described below:
#
# 1) INITIATE LIBRARIES
# this loads the plyr library which will be used in the script.
#
# 2) READ ALL DATA FILES
# this part read all the available data files and saves them into the workspace.
# features, activity_labels, Xtrain, Ytrain, Xtest, Ytest, subjectTrain, subjectTest
#
# 3) MERGE DATA
# This part merges the training and test sets into three variables:
# XFull, YFull, SubjectFull
#
# 4) LABEL X COL NAMES
# This piece of code takes the XFull data and labels the columns according to the 'features' data.
#
# 5) LABEL Y VALUES
# This piece of code takes the YFull data and makes a factor of it, with the levels as specified in 
# the activity_labels data
#
# 6) MERGE INTO 1 DATASET // LABEL COL NAME Y
# This piece of code merges the XFull, YFull and SubjectFull data into 1 dataset.
# Additionally, the Y column ('Activity') and Subject_ID column are named appropriately.
#
# 7) EXTRACT MEASURES ON MEANS AND SD
# This piece of code searches for the features that contain the string 'mean()' or 'std()'.
# It creates a dataset called Data_Final which only contains these columns, Subject_ID and Activity.
# In other words, Data_Final is a dataset with only the measures on the means and std's + the Y-labels ('Actitivy') and Subject_ID.
#
# 8) CALCULATE MEAN FOR EVERY COMBINATION OF SUBJECT AND ACTIVITY
# Here we create a list (called 'means') which contains the mean of each feature of Data_Final, 
# for every combination of subject and activity. 
# In total, there are 30 subjects and 6 Acitivy's. Thus, this list has 180 elements. 
#
# 9) RESTRUCTURE LIST INTO TIDY DATASET
# Here, we restructure the 'means' list into a tidy dataset, called 'New_data'.
# Each of the lists' elements represents 1 row. Thus, the dataset has 180 rows.
# We also make sure the columns and Activity values are labeled appropriately - just as in the Data_Full set.
#
# 10) WRITE DATA FILE
# Finally, we write the data into the file 'new_data.txt'
