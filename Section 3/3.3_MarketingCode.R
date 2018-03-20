library("googleAuthR")
library("googleAnalyticsR")
library("ggplot2")
library("scales")
library("reshape")


# authenticate, or use the RStudio Addin "Google API Auth" with analytics scopes set
ga_auth()

# get your accounts
account_list <- ga_account_list()
account_list$viewId
ga_id <- 154893193

# this tells you the segments that the user has access to
ga_segment_list()

# segmentation 1
ga_data <- google_analytics_4(ga_id, date_range = c("2017-08-28","2017-09-26"), dimensions=c("ga:campaign"), metrics = c("ga:users","ga:newUsers","ga:sessions","ga:bounceRate","ga:transactions"))



# Read in the CSV File
ga_data = read.csv("3.3-MarketingResults_ExampleFile.csv", sep=",", header=T)
# Modifications

# Calculationg New Users Pro
ga_data$NewUsersProp = ga_data$New.Users / ga_data$Users
# Making all levels consistent
ga_data$Campaign = factor(ga_data$Campaign, levels = ga_data$Campaign)
#ga_data$Bounce.Rate = percent(ga_data$Bounce.Rate)

# Color Scheme
MyColorPallet = c("#67001f","#b2182b","#d6604d","#f4a582","#fddbc7","#d1e5f0","#92c5de","#4393c3","#2166ac","#053061")


# plots : 
# which campaign is the best at getting new visitors? 

# 1. Total number
ga_data_filtered = ga_data[,c("Campaign", "Users", "New.Users", "Sessions")]
ga_data.melted = melt(ga_data_filtered, id="Campaign")

ggplot(ga_data.melted, aes(fill=variable, y=value, x=Campaign)) + geom_bar(position="dodge", stat="identity",color="black")+ coord_flip() + scale_fill_brewer(palette="Set1") + theme_minimal() + ylab("Counts") + xlab("Campaign Name") + labs(title="Visitor Report",  subtitle="By Campaign September 2017 - October 2017")

# 2. Proportion 
ggplot(ga_data, aes(x = Campaign, y = NewUsersProp, fill=Campaign)) + geom_bar(stat ="identity", color="black") + coord_flip() + scale_fill_manual(values = MyColorPallet) + theme_minimal() + ylab("Counts") + xlab("Campaign Name") + labs(title="New Visitor Propertion",  subtitle="By Campaign September 2017 - October 2017") 



# 3. which one with the highest bouncerate? 
ggplot(ga_data, aes(x = Campaign, y = Bounce.Rate, fill=Campaign)) + geom_bar(stat ="identity",color="black") + coord_flip() + scale_fill_manual(values = MyColorPallet) + theme_minimal() + ylab("Percentage") + xlab("Campaign Name")+ scale_y_continuous( limits=c(0,1)) + geom_text(aes(y = Bounce.Rate, label = percent(Bounce.Rate)),  hjust = -0.1) +  labs(title="Bounce Rate",  subtitle="By Campaign September 2017 - October 2017")



# 5. Tranaction
ggplot(ga_data, aes(x = Campaign, y = Transactions, fill=Campaign)) + geom_bar(stat ="identity",color="black") + coord_flip()+scale_fill_manual(values = MyColorPallet) + theme_minimal() + ylab("Counts") + xlab("Campaign Name") +  labs(title="Transactions",  subtitle="By Campaign September 2017 - October 2017")



# 6. Revenue
ggplot(ga_data, aes(x = Campaign, y = Revenue, fill=Campaign)) + geom_bar(stat ="identity",color="black") + coord_flip()+scale_fill_manual(values = MyColorPallet)+ scale_y_continuous( limits=c(0,100)) + theme_minimal() + ylab("Dollars") + xlab("Campaign Name") +  labs(title="Revenue",  subtitle="By Campaign September 2017 - October 2017")


