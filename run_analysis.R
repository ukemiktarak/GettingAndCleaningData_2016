# run_analysis.r
#  1- Merges the training and the test sets to create one data set.
#  2- Extracts only the measurements on the mean and standard deviation for each measurement.
#  3- Uses descriptive activity names to name the activities in the data set
#  4- Appropriately labels the data set with descriptive variable names.
#  5- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(dplyr)

# mergeFiles
#  1- Merges the training and the test sets to create one data set.
mergeFiles <- function(pathDir){
    # read measurement ("X" files) and activity ("Y" files) files
    trnX <- read.table(paste(pathDir, "/train/X_train.txt", sep=""), header=FALSE, stringsAsFactors = FALSE)
    trnY <- read.table(paste(pathDir, "/train/Y_train.txt", sep=""), header=FALSE, stringsAsFactors = FALSE)
    trnSubj <- read.table(paste(pathDir, "/train/subject_train.txt", sep=""), header=FALSE, stringsAsFactors = FALSE)
    
    tstX <- read.table(paste(pathDir, "/test/X_test.txt", sep=""), header=FALSE, stringsAsFactors = FALSE)
    tstY <- read.table(paste(pathDir, "/test/Y_test.txt", sep=""), header=FALSE, stringsAsFactors = FALSE)
    tstSubj <- read.table(paste(pathDir, "/test/subject_test.txt", sep=""), header=FALSE, stringsAsFactors = FALSE)
    
    # add activity columns to measurement columns
    trn <- cbind(trnX, trnY, trnSubj)
    tst <- cbind(tstX, tstY, tstSubj)
    
    # merge measurement frames trn and tst by row
    trnTst <- rbind(trn, tst)
    
    # rename activity and subject columns
    names(trnTst)[562] <- "activity_code"
    names(trnTst)[563] <- "subject_code"
    
    # return merged frame 
    trnTst
}

# extractMnStdColumns
#  2- Extracts only the measurements on the mean and standard deviation for each measurement.
extractMnStdColumns <- function(df){
    ## get the column numbers that have mean and std values
    colsToExtract <- grep("subject_code|activity|mean|std", colnames(df))
    ## extract columns
    retDf <- df[,colsToExtract]
    
    retDf
}

# addActivityNames
#  3- Uses descriptive activity names to name the activities in the data set
addActivityNames <- function(pathDir, dFrame){
    # read activity names
    aNames <- read.table(paste(pathDir, "/activity_labels.txt", sep=""), stringsAsFactors = FALSE)
    # add a new column with the name "activity"
    dFrameWithActivity <- mutate(dFrame, activity = aNames[dFrame$activity_code,"V2"])
    # return the new frame
    dFrameWithActivity
}

# replaceVarNames
#  4- Appropriately labels the data set with descriptive variable names.
replaceVarNames <- function(pathDir, dFrame){
    # read column names from features file
    cNames <- read.table(paste(pathDir, "/features.txt", sep=""), stringsAsFactors = FALSE) 
    cNames <- append(cNames[, 2], c("activity_code", "subject_code", "activity"))
    # replace variable (column) names with the ones in cNames frame (column 2) for the first 561 of them
    colnames(dFrame) <- cNames
    # return updated data frame
    dFrame
}
# getAverageByActSubj
#  5- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
getAverageByActSubj <- function(dFrame){
    meansFrame <- dFrame %>%
        group_by(subject_code, activity) %>%
        summarise_each(funs(mean))
    meansFrame
}

# writeToFile: writes contents of a dataframe to a file with the name run_analysis.txt
writeToFile <- function(df){
    fileName <-"run_analysis.txt"
    write.table(df, file=fileName, quote=FALSE, row.names =FALSE)
}

main <- function(){
    pathDir <- "UCI HAR Dataset"
    # 1- Merge files
    trnTst <- mergeFiles(pathDir)
    # 3- Add a decriptive activity column
    trnTst <- addActivityNames(pathDir, trnTst)
    # 4- Replace variable (column) names with appropriate ones
    trnTst <- replaceVarNames(pathDir, trnTst)
    # 2- Extract only the mean and standard deviation measurements (plus activity)
    trnTst <- extractMnStdColumns(trnTst)
    # 5- Average of all measurements by subject and activity
    meansFrame <- getAverageByActSubj(trnTst)
    # write to file
    writeToFile(meansFrame)
}