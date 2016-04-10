# Reproducible Research: Peer Assessment 1


## Loading and preprocessing the data
     data <- read.csv("activity.csv")


## What is mean total number of steps taken per day?
1.Make a histogram of the total number of steps taken each day

     summarie <- aggregate(steps ~ date, data = data, FUN = sum)
     barplot(summarie$steps, names.arg = summarie$date, xlab = "Date", ylab = "Number of steps", col=c("blue"))
     
![ ](figures/mean_steps_day.jpeg)

2.Caculate and report the mean and median total number of steps taken per day

     mean(summarie$steps)
     [1] 10766
 
     median(summarie$steps)
     [1] 10765

## What is the average daily activity pattern?

1.Make a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis).

     summarie2 <- aggregate(steps ~ interval, data = data, FUN = mean)
     plot(summarie2, type = "l", col="blue")


![ ](figures/time_series1.jpeg)


2.Which 5-minute interval, on average across all the days in the dataset,contains the maximum number of steps?

     summarie2$interval[which.max(summarie2$steps)]
     [1] 835

## Imputing missing values
1.Calculate and report the total number of missing values in the dataset (i.e. the total number of rows with NAs).

     sum(is.na(data))
     [1] 2304

2.Devise a strategy for filling in all of the missing values in the dataset. The strategy does not need to be sophisticated. For example, you could use the mean/median for that day, or the mean for that 5-minute interval, etc. I will use the minimum for the 5-minute intevals across all the days.

     min <- summarie2$interval[which.min(summarie2$steps)]
     nas <- is.na(data$steps)
     
3.Create a new dataset that is equal to the original dataset but with the missing data filled in.
     
     data$steps[is.na(data$steps)] <- min

4.Make a histogram of the total number of steps taken each day and Calculate and report the mean and median total number of steps taken per day. Do these values differ from the estimates from the first part of the assignment? What is the impact of imputing missing data on the estimates of the total daily number of steps?

     summarie3 <- aggregate(steps ~ date, data = data, FUN = sum)
     barplot(summarie3$steps, names.arg = summarie3$date, xlab = "Date", ylab = "Number of Steps", col=c("blue"))

![ ](figures/mean_steps_day2.jpeg)

     mean(summarie3$steps)
     [1] 10766
     
     median(summarie3$steps)
     [1] 10765

*The filling of missing data does not impact the estimate of the total daily number of steps.*

## Are there differences in activity patterns between weekdays and weekends?

1.Create a new factor variable in the dataset with two levels - "weekday"
and "weekend" indicating whether a given date is a weekday or weekend
day.

     daytype <- function(date) {
          if (weekdays(as.Date(date)) %in% c("Saturday", "Sunday")) {
               "weekend"
          } else {
               "weekday"
          }
     }
     data$daytype <- as.factor(sapply(data$date, daytype))


2.Make a panel plot containing a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all weekday days or weekend days (y-axis). 


     par(mfrow = c(2, 1))
     steps<- aggregate(steps ~ interval, data = data, subset = data$daytype == "weekend", FUN = mean)
     plot(steps, type = "l", main = "Weekend", col="blue")

     steps<- aggregate(steps ~ interval, data = data, subset = data$daytype == "weekday", FUN = mean)
     plot(steps, type = "l", main = "Weekday", col="blue")

![ ](figures/panel.jpeg)

