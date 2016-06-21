# Code Book

This code book sumarises the data and analysis used to create ```'full_tidy_data.csv'```, the main tidy data file. It also generates ```'average_variable_values.csv'```

## Requirements

1. Merge the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Design (matched to requiremnts)

The following data files are used for this project:

1. UCI HAR Dataset/test/subject_test.txt
2. UCI HAR Dataset/train/subject_train.txt
3. UCI HAR Dataset/test/y_test.txt
4. UCI HAR Dataset/train/y_train.txt
5. UCI HAR Dataset/test/X_test.txt
6. UCI HAR Dataset/train/X_train.txt
7. UCI HAR Dataset/features.txt
8. UCI HAR Dataset/activity_labels.txt

Firstly, the full data set is downloaded and extracted. The above 7 files are read into R objects. The subject files (```subject_test.txt``` and ```subject_train.txt```) are combined by row and given the column name 'Subject'. The activity files (```y_test.txt``` & ```y_train.txt```) are combined by row and given the column name 'Activity'. The main data files (```X_test.txt``` & ```X_train.txt```) are given the column headings/names as given in the ```features.txt``` file. This R object (containing the main data) is then subset to only contain the measurements for mean() and std(). **This satisfies requirement 2**.

The activity, subject and main measurement data is this combined by column. **This satisifies requirement 1**

The ```activity_labels.txt``` file is read into R and are used to replace the numeric activity data with the labels (i.e. 1 becomes WALKING, 2 becomes WALKING_UPSTAIRS etc). **This satisifes requirement 3**

The column names in the main data object are then updated to be more descriptive. A breakdown of the updates are as follows:

* std() becomes SD
* mean() becomes MEAN
* measurements starting 't' have the 't' replaced with 'time'
* measurements starting 'f' have the 'f' replaced with 'frequency'
* 'Acc' becomes 'Accelerometer'
* 'Gyro' becomes 'Gyroscope'
* 'Mag' becomes 'Magnitude'
* 'BodyBody' becomes 'Body'
* All hyphens become underscores

**This satisfies requirement 4**

Finally the main data object is melted to take the measurements in columns to data rows. This object is then aggregated/summarised to generate the average/mean value for each subject for each activity for each measurement. **This satisfies requirement 5**

### Identifiers

1. ```Subject``` - A unique integer assigned for each subject/person
2. ```Activity``` - The type of activity/movement being measured, these are:
    1. WALKING
    2. WALKING_UPSTAIRS
    3. WALKING_DOWNSTAIRS
    4. SITTING
    5. STANDING
    6. LAYING

### Measurements

