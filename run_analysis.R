#Cleaning Analysis

#We first import the files, the subject file, the attributes file and then the labels file

subject_test <- read.table("F:/Coursera/Data Science Specialization/Course 3 - Getting and Cleaning Data/Week 4/Project/UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="")
X_test <- read.table("F:/Coursera/Data Science Specialization/Course 3 - Getting and Cleaning Data/Week 4/Project/UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char = "")
 y_test <- read.table("F:/Coursera/Data Science Specialization/Course 3 - Getting and Cleaning Data/Week 4/Project/UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char="")
                
#Assigning appropriate colnames and binding them into one dataset, colnames are found in the feature.md file
 
features <- read.table("F:/Coursera/Data Science Specialization/Course 3 - Getting and Cleaning Data/Week 4/Project/UCI HAR Dataset/features.txt", quote="\"", comment.char="")
 
 attrnames <- as.character(features[,2])
 colnames(X_test) <- attrnames
 colnames(y_test) <- c("Activity Label")
 colnames(subject_test) <- c("Subject")
 testset <- cbind(subject_test,y_test, X_test) #Merging into one test data set
 
#Similarly for the training data
 
 subject_train <- read.table("F:/Coursera/Data Science Specialization/Course 3 - Getting and Cleaning Data/Week 4/Project/UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="")
 X_train <- read.table("F:/Coursera/Data Science Specialization/Course 3 - Getting and Cleaning Data/Week 4/Project/UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="")
 y_train <- read.table("F:/Coursera/Data Science Specialization/Course 3 - Getting and Cleaning Data/Week 4/Project/UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="")
 
 attrnamest <- as.character(features[,2])
 colnames(X_train) <- attrnamest
 colnames(y_train) <- c("Activity Label")
 colnames(subject_train) <- c("Subject")
 trainset <- cbind(subject_train,y_train, X_train)
 
 ##Merge test and train data
 
 mega <- rbind(testset,trainset)
 
 
 ##We need to compress the data set with 'mean' and 'std' variables only
 
 #We load the stringr package for this
 
 library(stringr)
 
 a <- str_detect(attrnames, pattern = "mean")
 b <- which(a == TRUE)
 c <- str_detect(attrnames, pattern = "std")
 d <- which(c == TRUE)
 
 ind <- c(c(1,2),sort(c(b,d)+2)) #We need the first two columns and the rest are indices with the desired strings in the variable names
 compress <- mega[,ind] #Final desired dataset, extracted meticulously :)
 
 
 ##Second dataset with average for ech activity and then the subject, we use reshape
 
 library(reshape)
 
 melted <-  melt(compress, id = c("Subject", "Activity Label"))
 Final <- dcast(melted, Subject + 'Activity Label' ~ variable, mean)
 
 
 
 
 
 