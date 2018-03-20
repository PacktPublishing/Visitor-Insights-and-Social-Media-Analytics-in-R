library("googleAuthR")
library("googleAnalyticsR")
library("ggplot2")
#install.packages("scales")
library("scales")

## authenticate, or use the RStudio Addin "Google API Auth" with analytics scopes set
ga_auth()

## get your accounts
account_list <- ga_account_list()
account_list$viewId
ga_id <- 152486052

# downloading Google API
ga_data = google_analytics_4(ga_id, date_range = c("2017-04-18", "2017-06-18"), metrics=c("ga:pageviews", "ga:users"), dimensions=c("ga:sessionCount"))


# using example file
ga_data = read.csv("ExampleFile_1.4_FrequencyRecency.csv", sep=",", header=T)



ga_data.toPlot = data.frame(ga_data)
ga_data.toPlot$Pageviews = as.numeric(gsub(",","", ga_data.toPlot$Pageviews))

#ordering data
ga_data.toPlot$Count.of.Sessions =  factor(ga_data.toPlot$Count.of.Sessions, levels = ga_data.toPlot$Count.of.Sessions)

# Draw plot
ggplot(ga_data.toPlot, aes(x=Count.of.Sessions, y=Pageviews)) + geom_bar(stat="identity", width=0.8, fill="tomato3")