######
# This R script is to get the average of the subject/activity as per the
# Samsung data set provided.
# we are in the working directory where train and test directories are.
######

## Load the requried libraries.
library(data.table)
library(reshape2)


## Merges the training and the test sets to create one data set
subject <- rbind(read.table("train/subject_train.txt"), read.table("test/subject_test.txt"))
X <- rbind(read.table("train/X_train.txt"), read.table("test/X_test.txt"))
Y <- rbind(read.table("train/y_train.txt"), read.table("test/y_test.txt"))

## add column names 
names(subject) <- "Subject.ID"
names(Y) <- "Activity"
names(X) <- read.table("features.txt")$V2

## determine which columns contain "mean" or "std"
## extract a minimal data set.
X <- X[, grepl("mean|std", names(X))]

## column combine files into one dataset
complete <- cbind(subject, Y, X)

## factorize on activity labels.
activity_labels <- read.table("activity_labels.txt")[,2]
complete$Activity <- factor(complete$Activity, labels = activity_labels)

## Compute mean on melted data set and store the output data frame.
complete.melt <- melt(complete, id=c("Subject.ID","Activity"))
output <- dcast(complete.melt, Subject.ID+Activity ~ variable, mean)
write.table(output, "output.txt", row.names=FALSE)

