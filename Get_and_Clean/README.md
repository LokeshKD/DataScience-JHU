## Get and Clean

### Description:
 This R script called run_analysis.R does the following. 

    * row bind all respective subject, X and Y data sets from train and test directories.
    * extract mean and sd columns of Y.
    * assign column names to all from the data descriptions files provided.
    * column bind all subject, X and Y, creating a single complete data set.
    * computes average on all columns "melted" with Subject.ID and ACtivity.
    * writes in a free form text format into output.txt file.
    
#### Links to Data
 
 A full description of data:
  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
  
 Actual Data:
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  