## Loading and preprocessing the data
data <- read.csv("activity.csv")

## Mean total number of steps taken per day?
summarie <- aggregate(steps ~ date, data = data, FUN = sum)
barplot(summarie$steps, names.arg = summarie$date, xlab = "Date", ylab = "Number of steps", col=c("blue"))

mean(summarie$steps)
median(summarie$steps)

#Make a time series plot 
summarie2 <- aggregate(steps ~ interval, data = data, FUN = mean)
plot(summarie2, type = "l", col="blue")

#Average across all the days in the dataset, with the maximum number of steps
summarie2$interval[which.max(summarie2$steps)]

#Total number of missing values in the dataset (i.e. the total number of rows with NAs)
sum(is.na(data))

#Strategy for filling in all of the missing values in the dataset. 
#The strategy consists in fill the missing values with the minimum across all the days
min <- summarie2$interval[which.min(summarie2$steps)]
nas <- is.na(data$steps)
data$steps[is.na(data$steps)] <- min

#Make a histogram of the total number of steps taken each day 
#and Calculate and report the mean and median total number of 
#steps taken per day
summarie3 <- aggregate(steps ~ date, data = data, FUN = sum)
barplot(summarie3$steps, names.arg = summarie3$date, xlab = "Date", ylab = "Number of Steps", col=c("blue"))


mean(summarie3$steps)
median(summarie3$steps)

#A new factor variable in the dataset with two levels ??? ???weekday???
#and ???weekend??? indicating whether a given date is a weekday or weekend
#day.

daytype <- function(date) {
     if (weekdays(as.Date(date)) %in% c("Saturday", "Sunday")) {
          "weekend"
     } else {
          "weekday"
     }
}
data$daytype <- as.factor(sapply(data$date, daytype))

#A panel plot containing a time series plot (i.e. type = "l") of the
#minute interval (x-axis) and the average number of steps taken, averaged
#across all weekday days or weekend days (y-axis). 

par(mfrow = c(2, 1))
steps<- aggregate(steps ~ interval, data = data, subset = data$daytype == "weekend", FUN = mean)
plot(steps, type = "l", main = "Weekend", col="blue")

steps<- aggregate(steps ~ interval, data = data, subset = data$daytype == "weekday", FUN = mean)
plot(steps, type = "l", main = "Weekday", col="blue")



