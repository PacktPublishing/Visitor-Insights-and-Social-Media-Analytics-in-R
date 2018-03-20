library("googleAuthR")
library("googleAnalyticsR")
library("ggplot2")
library("reshape")
library("ggsci")
library("waffle")

## authenticate, or use the RStudio Addin "Google API Auth" with analytics scopes set
ga_auth()

## get your accounts
account_list <- ga_account_list()
account_list$viewId
ga_id <- 162301128

# First way is going to be the traffic sources
temp_ga_data = google_analytics_4(ga_id, date_range = c("2017-10-01", "2017-11-20"), dimensions = c("ga:socialNetwork"), metrics = c("ga:users", "ga:newUsers","ga:sessions", "ga:bounces","ga:goal1Completions","ga:goal2Completions","ga:avgTimeOnPage","ga:entranceRate", "ga:pageviewsPerSession","ga:avgSessionDuration" ))

# code for each of the dashboard components. 
ga_data = read.table("5.2_ExampleFile.csv", sep=",", header=T)

# cleaning up data
ga_data$socialNetwork = factor(ga_data$socialNetwork, levels = ga_data$socialNetwork)


# pie chart
ggplot(ga_data, aes(x="", y=sessions, fill=socialNetwork)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", start=0)


# Sessions by Social Network
vals <- ga_data$sessions
val_names <- sprintf("%s (%s)", ga_data$socialNetwork, scales::percent(round(ga_data$sessions/sum(ga_data$sessions), 2)))
names(vals) <- val_names

waffle(vals/50, rows= 10, legend_pos = "bottom")

waffle(vals/20, rows = 10, legend_pos = "bottom", title="Visitors by Social Network", xlab="1 square = 20 visitors")






