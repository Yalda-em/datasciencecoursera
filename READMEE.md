
Download and unzip 

I have Downloaded all file and I have unzipped them in a folder called UCIDataset.

It is necessary to set the working directory to the path where all the zippede folder exist
setwd("C:/UCIDataset")



The project is divided to the following sections

1. Merges the training and the test sets to create one data set. For doing this the function cbind and r bind have been used

2. Extracts only the measurements on the mean and standard deviation for each measurement. 
need to install   install.packages("gdata")


3. Uses descriptive activity names to name the activities in the data set , all the activities were labeled from 1-6 and now, after that the real activies nmae would appear in the data set.


4. Appropriately labels the data set with descriptive activity names. 
the names which were shorten now will be replaced by complete name.

5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

additional information about the variables, data and transformations are all in the CodeBook.MD file.
