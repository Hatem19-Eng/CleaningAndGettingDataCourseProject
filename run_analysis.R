#In order to merge data:
  x_data <- rbind(X_train, X_test)
  y_data <- rbind(y_train, y_test)
  s_data <- rbind(subject_train,subject_test)
  
# extracting features and calculating mean and standard division:
    label <- activity_labels
  label[,2] <- as.character(label[,2]) 
  selectedCols <- grep("-(mean|std).*", as.character(feature[,2]))
  selectedColNames <- feature[selectedCols, 2]
  selectedColNames <- gsub("-mean", "Mean", selectedColNames)
  selectedColNames <- gsub("-std", "Std", selectedColNames)
  selectedColNames <- gsub("[-()]", "", selectedColNames)
  
  # Merging all data: 
    x_data <- x_data[selectedCols]
  allData <- cbind(s_data, y_data, x_data)
  colnames(allData) <- c("Subject", "Activity", selectedColNames)
  
  # tidyData:
    meltedData <- melt(allData, id = c("Subject", "Activity"))
  tidyData <- dcast(meltedData, Subject + Activity ~ variable, mean)
  write.table(tidyData, "./tidy_dataset.csv", row.names = FALSE, quote = FALSE)