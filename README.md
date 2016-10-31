run_analysis.R
==========
	by: UKemiktarak
==========
	R script for extraction and aggregation of "Human Activity Recognition Using Smartphones Dataset". This script merges the training and the test sets to create one data set. It then extracts only the measurements on the mean and standard deviation for each measurement and creates a second, independent tidy data set with the average of each variable for each activity and each subject. The generated dataset is then written into txt file with the name "run_analysis.txt". 

	Script should be placed under the same folder as the  main dataset folder (UCI HAR Dataset). 
	
	Run main() from R command after sourcing (source("run_analysis.R")) the script. Working directory must be the same as the main dataset folder (setwd("<FOLDER_PATH>/UCI HAR Dataset")) 
	
ALGORITHM
==========
	1- Merge test and train data sets
	2- Add activity column from activity_labels file
	3- Replace variable names of the merged data set with descriptive ones from features.txt
	4- Extract mean and standard deviation columns for each subject and activity label
	5- Calculate the average of each variable for each  activity and each subject and create a tidy data set
	6- Write the new dataset to a file

FUNCTIONS
==========
	1- mergeFiles:  
	Function reads X_train.txt, y_train.txt, subject_train.txt under train folder and  X_test.txt, y_test.txt, subject_test.txt  under test folder and merges all 6 files.   Returns the newly created dataframe.
	Parameters: String (pathDir)
	
	2- extractMnStdColumns: 
	Function returns a data frame that has only the std and mean columns.
	Parameters: Dataframe (df) 
	
	3- addActivityNames:
	Function adds the activity names as a new column to the dataset
	Parameters: String (pathDir), Dataframe (dFrame)
	
	4- replaceVarNames:
	Function replaces the column generic column names of the data set with the ones read from activity_labels.txt file
	Parameters: String (pathDir), Dataframe (dFrame)
	
	5- getAverageByActSubj
	Function returns a new data set of averages for each variable grouped by each activity and each subject 
	Parameters: Dataframe (dFrame)
	
	6- writeToFile:
	Function writes contents of a dataframe to a file with the name run_analysis.txt
	Parameters: Dataframe (df))
	
	7- main:
	Function should be called from the command to run the script.
	Parameters: N/A
	
CODE BOOK  (run_analysis.txt)
==========
	The variables in the generated data file:
	1- subject: subject number
	2- activity: activity label
	3- variable: variable/column name from the original dataset
	4- average: average value of  each variable for each activity and each subject