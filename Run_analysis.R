

setwd("C:/UCIDataset") # set to your own working directory


 x_test = read.table("test/X_test.txt")# reading the x test file 
 y_test = read.table("test/y_test.txt")# reading y test file
 subject_test = read.table("test/subject_test.txt")# reading subject file which includes number of participant
 temp=cbind(x_test,y_test) # combine x,y test 
 test_data=cbind(temp,subject_test)# comnine subject 

 x_train = read.table("train/X_train.txt")# doing the same as x
 y_train = read.table("train/y_train.txt")
 subject_train = read.table("train/subject_train.txt")
 temp=cbind(x_train,y_train)
 train_data=cbind(temp,subject_train)
 
 all_data= rbind(test_data,train_data)
 
 
  all_data= rbind(test_data,train_data)
  features = read.table("features.txt")
  features_name<-features[,2] #  getting only the lable / names of activities
 
 names(all_data)<-features_name

 colnames(all_data)[562] <- "Activity" # calling activity
  colnames(all_data)[563] <- "subject" # calling subject
  
  install.packages("gdata")
  
  require(gdata) # needed to use matchcols
 
  mean_std_measures=matchcols(all_data,with = c( ".*-mean\\(.*" ,    ".*-std\\(.*" ), method=c("or")   )
  mean_std_measures1=unlist(mean_std_measures) # getting only the column with the mean and std 
  
selectedNames<-c((mean_std_measures1),  colnames(all_data[562]), colnames(all_data[563]) )# adding activity and subject columns to the selected columns with mean and std 
  
  columns_with_measures= subset(all_data,select=selectedNames) # subsetting the data
  

  activity_labels = read.table("activity_labels.txt")# reading activity_label file

  for(i in 1:nrow(activity_labels) )
  {
    
  columns_with_measures$Activity[columns_with_measures$Activity==activity_labels[i,1]]<-as.character(activity_labels[i,2])
  
  # instead of 1-6 which were representin the activitie substitude them with the real name
  
  }
  
  
  colnames(columns_with_measures)<- gsub("Mag","Magnitude",colnames(columns_with_measures)) #replacing Mag with Magnitude
  colnames(columns_with_measures)<- gsub("Acc","Accelerometer",colnames(columns_with_measures)) #replacing Acc with Accelerometer
  colnames(columns_with_measures)<- gsub("Gyro","Gyroscope",colnames(columns_with_measures)) #replacing Gyro with Gyroscope
  colnames(columns_with_measures)<- gsub("BodyBody","Body",colnames(columns_with_measures)) #replacing BodyBody with Body
  colnames(columns_with_measures)<- gsub("mean()","Mean",colnames(columns_with_measures)) #replacing mean() with Mean
  colnames(columns_with_measures)<- gsub("std()","StdDev",colnames(columns_with_measures)) #replacing std() with StdDev
  colnames(columns_with_measures)<- gsub("[()]","",colnames(columns_with_measures)) #removing ()
  
  data <-aggregate(columns_with_measures, by=list(columns_with_measures$Activity,columns_with_measures$subject), FUN=mean, na.rm=TRUE)
  TidyDataset <- data[,-(69:70)]             # vector
  colnames(TidyDataset)[1]<-"Activity"
  colnames(TidyDataset)[2]<-"subject"
  
  
 
  write.table(TidyDataset, "TidyDataSet.txt", sep=" ", row.names=FALSE)
  
  
