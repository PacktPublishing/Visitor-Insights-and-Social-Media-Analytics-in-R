# install.packages("googleAuthR")
# install.packages("googleAnalyticsR")
# install.packages("ggplot2")

library("googleAuthR")
library("googleAnalyticsR")
library("ggplot2")
## authenticate, or use the RStudio Addin "Google API Auth" with analytics scopes set
ga_auth()

## get your accounts
account_list <- ga_account_list()
account_list$viewId
ga_id <- 162301128

temp_ga_data = google_analytics_4(ga_id, 
                   date_range = c("2017-10-22", "2017-11-06"), metrics = c("ga:users", "ga:newUsers","ga:sessions", "ga:bounces", "ga:bounceRate","ga:goal1Completions","ga:goal2Completions", "ga:goalCompletionsAll"),dimensions = c("ga:campaign", "ga:browser"))
temp_ga_data


# /ordercompleted.html
# /registersuccess.html



# Goal Completion Location	Goal Completions	% Goal Completions
# /ordercompleted.html
# /registersuccess.html
# /basket.html
# /home
# /yourinfo.html
# /google+redesign/nest/nest-usa



