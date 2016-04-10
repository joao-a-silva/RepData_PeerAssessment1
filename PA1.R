## Loading and preprocessing the data
data <- read.csv("activity.csv")

## Mean total number of steps taken per day?
summarie <- aggregate(steps ~ date, data = data, FUN = sum)
barplot(summarie$steps, names.arg = summarie$date, xlab = "Date", ylab = "Number of steps", col=c("blue"))

mean_steps <- mean(summarie$sum[!is.na(summarie$sum)])
median_steps <- median(summarie$sum[!is.na(summarie$sum)])

#Make a time series plot 
summarie2 <- aggregate(steps ~ interval, data = data, FUN = mean)
plot(summarie2, type = "l", col="blue")

#Average across all the days in the dataset, with the maximum number of steps
max <- summarie2$interval[which.max(summarie2$steps)]

#Total number of missing values in the dataset (i.e. the total number of rows with NAs)
total_missing_values <- sum(is.na(data))

#Strategy for filling in all of the missing values in the dataset. 
#The strategy consists in fill the missing values with the mean
#between the minimum and maximum across all the days
min <- summarie2$interval[which.min(summarie2$steps)]
nas <- is.na(activity$steps)
datadata$steps[is.na(data$steps)] <- (min+max)/2                                                                         ".y"))

#Make a histogram of the total number of steps taken each day 
#and Calculate and report the mean and median total number of 
#steps taken per day






