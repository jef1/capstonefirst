library(stringi)
library(tm)
library(RWeka)
library(wordcloud)
install.packages(stringr)
library(stringi)
library(stringr)
library(tidyr)
library(dplyr)

# Import data
blogs <- readLines("~/Documents/sentiment_text/en_US.blogs.txt", encoding = "UTF-8", skipNul = T)
twitter <- readLines("~/Documents/sentiment_text/en_US.twitter.txt", encoding = "UTF-8", skipNul = T)
news <- readLines("~/Documents/sentiment_text/en_US.news.txt", encoding = "UTF-8", skipNul = T)

# borrowed code
Blogs <- stri_stats_general(blogs) 
Twitter = stri_stats_general(twitter) 
News <- stri_stats_general(news)
(df <- data.frame(Blogs, Twitter, News))

# data cleaning
twitter <- str_to_lower(twitter)
blogs <- str_to_lower(blogs)
news <- str_to_lower(news)


# create platform
twitter3 <- transform(twitter, platform = "twitter")
blogs3 <- transform(blogs, platform = "blogs")
news3 <- transform(news, platform = "news")

#bind data
complete <- bind_rows(blogs3, news3, twitter3)

# Clean data - remove punctuation etc
complete$X_data <- str_replace_all(complete$X_data, pattern = "[[:punct:]]", "")

complete$X_data <- tm_map(complete$X_data, removeWords, stopwords)



#excess 
twit2 <- as.list(twitter)
blog2 <- as.list(blogs)
new2 <- as.list(news)



twitter2 <- data.frame(twit2)
blogs2 <- data.frame(blog2)
news2 <- data.frame(new2)

twitter3 <- mutate(twit2, platform = "twitter")
blogs2 <- mutate(blog2, platform = "blogs")
news3 <- mutate(new2, platform = "news")

# mock up random samples
bg <- blogs[sample(1:length(blogs),1000)]
tw <- twitter[sample(1:length(twitter),4000)]
nw <- news[sample(1:length(news),1000)]

# Code for matching patterns in strings
stri_count(blogs[26], pattern = "you", regex = T)


# Create test and train

# Create swear word indicator
swear <- c("fuck", "shit", "holy shit", "hell", "ass","asshole","arse","motherfucker", "shitass", "basterd","bitch","bollocks","cunt")
