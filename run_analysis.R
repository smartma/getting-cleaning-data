run_analysis <- function(){
  
  # Set the working directory
  setwd("C:/Users/Mike/Desktop/r/project")
  dataUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
  
  # Create a data folder if not already created
  # Assumes that if the directory exists then the data is present & unzipped
  
  if(!file.exists("data")){
    dir.create("data")
    
    # Download the data and unzip
    download.file(dataUrl, destfile="./data/Dataset.zip")
    unzip(zipfile="./data/Dataset.zip", exdir="./data")
  }
  
  #Read the subject files
  sub_tst <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
  sub_trn <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
  
  #Read the activity files
  act_tst <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header = FALSE)
  act_trn <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header = FALSE)
  
  #Read the data files
  dat_tst <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header = FALSE)
  dat_trn <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header = FALSE)
  
  #Read the features file, this is used as the column headers for the data files
  ftr <- read.table("./data/UCI HAR Dataset/features.txt", header = FALSE)
  
  # Combine the rows of the Subject Data & give it the name 'Subject'
  sub_data <- rbind(sub_tst, sub_trn)
  names(sub_data) <- c("Subject")
  
  # Combine the rows of the Activty Data & give it the name 'Subject'
  act_data <- rbind(act_tst, act_trn)
  names(act_data) <- c("Activity")
  
  # Add the feature names to the dat_tst object.
  names(dat_tst) <- ftr$V2
  names(dat_trn) <- ftr$V2
  
  # Subset the data objects by the column name which MUST include the string 'mean()' or 'std()'
  dat_tst <- dat_tst[,grepl("mean\\(\\)|std\\(\\)", names(dat_tst))]
  dat_trn <- dat_trn[,grepl("mean\\(\\)|std\\(\\)", names(dat_trn))]
  
  # Combine the row data for out data objects
  full_data <- rbind(dat_tst, dat_trn)
  # Combine all the columns for our full data set
  full_data <- cbind(sub_data, act_data, full_data)

  # Update the Activity data from numerics to Text Descriptions
  act_nms <- read.table("./data/UCI HAR Dataset/activity_labels.txt", header = FALSE)
  full_data$Activity <- sapply(full_data$Activity, function(x){act_nms[x,2]})
  
  # Update the names to more meaningful descriptions
  names(full_data)<-gsub("std\\(\\)", "SD", names(full_data))
  names(full_data)<-gsub("mean\\(\\)", "MEAN", names(full_data))
  names(full_data)<-gsub("^t", "time", names(full_data))
  names(full_data)<-gsub("^f", "frequency", names(full_data))
  names(full_data)<-gsub("Acc", "Accelerometer", names(full_data))
  names(full_data)<-gsub("Gyro", "Gyroscope", names(full_data))
  names(full_data)<-gsub("Mag", "Magnitude", names(full_data))
  names(full_data)<-gsub("BodyBody", "Body", names(full_data))
  names(full_data)<-gsub("\\-", "\\_", names(full_data))
  
  # Write to file
  write.csv(full_data, file = 'full_tidy_data.csv', row.names = FALSE)
  
  # Creates a second, independent data set with the average of each variable for each activity and each subject.
  full_data_melt <- melt(full_data, id = c("Subject", "Activity"))
  aggdata <- summarise(group_by(full_data_melt, Subject, Activity, variable), mean(value))
  
  write.csv(aggdata, file = 'average_variable_values.csv', row.names = FALSE)
  
  print("Complete")

}



