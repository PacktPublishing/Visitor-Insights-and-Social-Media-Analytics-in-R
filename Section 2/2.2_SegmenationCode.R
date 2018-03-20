
library("googleAuthR")
library("googleAnalyticsR")
library("ggplot2")
library("scales")
library("gridExtra")
library("reshape")
library("xtable")

# authenticate, or use the RStudio Addin "Google API Auth" with analytics scopes set
ga_auth()

# get your accounts
account_list <- ga_account_list()
account_list$viewId
ga_id <- 154893193

# this tells you the segments that the user has access to
ga_segment_list()

# Query List
# segmentation 1
ga_data <- google_analytics_4(ga_id, date_range = c("2017-08-28","2017-09-26"), dimensions=c("ga:productName"), metrics = c("ga:itemRevenue", "ga:uniquePurchases", "ga:itemQuantity"))

ga_data <- google_analytics_4(ga_id, date_range = c("2017-08-28","2017-09-26"), dimensions=c("date"), metrics = c("ga:itemRevenue"))

ga_data <- google_analytics_4(ga_id, date_range = c("2017-08-28","2017-09-26"), dimensions=c("ga:productName"), metrics = c("ga:productDetailViews","ga:productAddsToCart","ga:productCheckouts","ga:uniquePurchases"))

#
ga_data = read.csv("RevenuePerWeek_2016-2017.csv", sep=",", header=T)

# format the date correctly
ga_data$Date = as.Date(ga_data$Date, "%m/%d/%y")
bp <- ggplot(ga_data, aes(x=Date, y=Product.Revenue))+ geom_line() + scale_y_continuous( limits=c(0,35000))
bp + ylab("Weekly Revenue") + labs(title="Weekly Revenue Plot", 
       subtitle="September 2016 - August 2017")

# 2. Table of "problem weeks"
 ga_data$Product.Revenue <- dollar_format()(as.numeric(ga_data$Product.Revenue))
 
 # Date Product.Revenue
 # 2017-03-26        20257.98
 # 2017-04-02         8179.00
 # 2017-04-09         7289.00
 # 2017-04-16         8898.00
 # 2017-04-23        10124.00
 
 head(ga_data)
 ga_data_filtered = ga_data[which(ga_data$Date %in% as.Date(c("2017-03-26", "2017-04-02", "2017-04-09", "2017-04-16", "2017-04-23"))),]
 
 grid.table(ga_data_filtered)

 
ga_data = read.csv("2.3_ProductDetailView_20170326.csv")

# processing data
ga_data$Product = factor(ga_data$Product, levels=ga_data$Product)
ga_data.melted = melt(ga_data, id.vars = c("Product"))

ggplot() + geom_line(data = ga_data.melted, aes(x = variable, y = value, group = Product, color = Product)) +  scale_color_manual(values=c("#9e0142","#d53e4f","#f46d43","#fdae61","#fee08b","#e6f598","#abdda4","#66c2a5","#3288bd","#5e4fa2")) + ylab("Counts") + xlab("Sales Performance") + labs(title="Product Performance", subtitle="2017-03-26")
