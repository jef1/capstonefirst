# int
library <- c("tm", "dplyr", "RTextTools")
lapply(library, require, character.only = TRUE)

# set options
options(stringsAsFactors = FALSE)

# set parameters - attempted to upload strait into a data frame using the generateTDM function bellow
platform <- c("blogs", "twitter", "news")
pathway <- "~/Documents/sentiment_text"

# clean text - works
cleanCorpus <- function(corpus) {
  corpus.tmp <- tm_map(corpus, content_tranfer(removePuncuation))
  corpus.tmp <- tm_map(corpus.tmp, content_transfer(stripWhitespace))
  corpus.tmp <- tm_map(corpus.tmp, content_transformer(tolower))
  corpus.tmp <- tm_map(corpus.tmp, content_tranfer(removeWords), stopwords(kind = "english"))
  return(corpus.tmp)
}

# build tdm - does not work

generateTDM <- function(plat, path) {
  s.dir <- sprintf("%s/%s.txt", pathway, platform)
  s.cor <- VCorpus(DirSource(directory = s.dir), readerControl = list(reader = readLines))
  s.cor.cl <- cleanCorpus(s.cor)
  s.tdm <- TermDocumentMatrix(s.cor.cl)
  
  s.tdm <- removerSparseTerms(s.tdm, 0.7)
  result <- list(name = platform, tdm = s.tdm)
}

tdm <- lapply(platform, generateTDM, path = pathway)

# attach source name



# stack

# hold out sample

# model



# to enter data - could not get the source/directory to work
blogs <- readLines("~/Documents/sentiment_text/blogs.txt", encoding = "UTF-8", skipNul = T)
twitter <- readLines("~/Documents/sentiment_text/twitter.txt", encoding = "UTF-8", skipNul = T)
news <- readLines("~/Documents/sentiment_text/news.txt", encoding = "UTF-8", skipNul = T)
