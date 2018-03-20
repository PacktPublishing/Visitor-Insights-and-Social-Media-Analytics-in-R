library("googleAuthR")
library("googleAnalyticsR")
library("ggplot2")
## authenticate, or use the RStudio Addin "Google API Auth" with analytics scopes set
ga_auth()

## get your accounts
account_list <- ga_account_list()
account_list$viewId
ga_id <- 162301128

temp_ga_data = google_analytics_4(ga_id, date_range = c("2017-10-01", "2017-11-07"), metrics = c("ga:users", "ga:newUsers","ga:sessions", "ga:bounces","ga:goal1Completions","ga:goal2Completions"),dimensions = c("ga:campaign"))