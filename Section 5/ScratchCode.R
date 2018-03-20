
library("ggplot2")
library("reshape")
library("scales")
library("ggsci")


# Read in the CSV File
ga_data = read.csv("4.4_ExampleFile.csv", sep=",", header=T)

# Making all levels consistent
ga_data$campaign = factor(ga_data$campaign, levels = ga_data$campaign)

# 1. Total number
ga_data_filtered = ga_data[,c("campaign", "users", "newUsers", "sessions", "bounces")]
ga_data.melted = melt(ga_data_filtered, id="campaign")

# this is the plot for 
# Grouped
ggplot(ga_data.melted, aes(fill=campaign, y=value, x=variable)) + 
  geom_bar(position="dodge", stat="identity", colour="black") + theme_bw() + scale_fill_locuszoom() 

# now for the goal conversions
# campaign A
ga_data.campaignA = ga_data[2,]
ga_data.campaignA = melt(ga_data.campaignA, id="campaign")
ggplot(ga_data.campaignA, aes(x=variable, y=value)) + 
  geom_bar(stat="identity", width=.5, fill="#DC0000B2", colour="black") 

ga_data.campaignB = ga_data[3,]
ga_data.campaignB = melt(ga_data.campaignB, id="campaign")
ggplot(ga_data.campaignB, aes(x=variable, y=value)) + 
  geom_bar(stat="identity", width=.5, fill="#3C5488B2", colour="black") 


ga_data.campaignC = ga_data[4,]
ga_data.campaignC = melt(ga_data.campaignC, id="campaign")
ggplot(ga_data.campaignC, aes(x=variable, y=value)) + 
  geom_bar(stat="identity", width=.5, fill="#00A087B2", colour="black") 



#### How are they actually doing? #####
# stacked
ga_data.toCompare = ga_data[c(2,3,4),c("campaign", "newUsers", "goal1Completions", "goal2Completions")]
ga_data.toCompare = melt(ga_data.toCompare, id.vars = "campaign")

ggplot(ga_data.toCompare, aes(x = campaign, y =value ,fill = variable)) +  geom_bar(stat = "identity", position = "stack", colour="black")  +  scale_fill_startrek()

