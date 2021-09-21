library("RDSTK")
library("readr")
library("twitteR")
library("qdap")
library("syuzhet")
library("ggplot2")

## If you don't know what a package is, see below and use ctrl-return

??syuzhet
??qdap

## make sure that the following packages have loaded-- base, datasets, dplyr, ggplot2, graphics, grDevices, methods, plyr, qdap, qdapDictionaries, qdapRegex, qdapTools, RColorBrewer, RCurl, RDSTK, readr, rjson, stats, syuzhet, twitteR, utils
## in Rstudio double check package dplyr is checked in package tab on right

gandhi_speech = read_file("assets/gandhi_speech2.txt")
View(gandhi_speech)

## polarity and sentiment
g_scores = get_nrc_sentiment(gandhi_speech)
class(g_scores)
g_scores
g_polarity = g_scores[1,9:10]
g_sentiment = g_scores[1,1:8]

## visualize polarity
class(g_polarity)
g_polarity = data.matrix(g_polarity, rownames.force = TRUE)
barplot(g_polarity)

## visualize sentiment
class(g_sentiment)
g_sentiment = data.matrix(g_sentiment, rownames.force = TRUE)
barplot(g_sentiment)

## break it down by sentence
g_speech_sen = get_sentences(gandhi_speech)
g_speech_sen

sentiment_vector = get_sentiment(g_speech_sen, method = "syuzhet")
sentiment_vector
summary(sentiment_vector)
boxplot(sentiment_vector)

## what was the most positive sentence in the paragraph?
max(sentiment_vector)
sentence_sentiment = data.frame(g_speech_sen, sentiment_vector)
View(sentence_sentiment)
which.max(sentence_sentiment$sentiment_vector)

## we now have an index - what can we do with this?
most_positive = sentence_sentiment[which.max(sentence_sentiment$sentiment_vector),]
## don't forget the comma!

## Wordclouds
## look over to the right and see that these packages are checked
## if one is absent then go to the console below and type install.packages("MISSINGPACKAGE")
library("devtools")
library("RColorBrewer")
library("tm")
library("SnowballC")
library("wordcloud")

wordcloud(gandhi_speech,colors=c("blue","green"))

