# Load Sentiment Analysis Libraries and ggplot2
library(RSentiment)
library(syuzhet)
library(ggplot2)

########################### Get Lyric Sentiments for Drake ##################################

# Get Scores, Split into Two to Avoid Heap Overflow
drake_scores_first_half = calculate_score(drake_combined$line[1:5294])
drake_scores_second_half = calculate_score(drake_combined$line[5295:length(drake_combined$line)])
drake_scores = c(drake_scores_first_half, drake_scores_second_half)

# Do the Same for Getting Sentiments 
drake_sentiments_first_half = calculate_sentiment(drake_combined$line[1:5294])
drake_sentiments_second_half = calculate_sentiment(drake_combined$line[5295:length(drake_combined$line)])
drake_sentiments = c(drake_sentiments_first_half, drake_sentiments_second_half)

# Syuzhet Library Sentiments 
drake_syuzhet_sentiments = get_nrc_sentiment(as.character(drake_combined$line))

# Concat onto Dataframe
drake_total = cbind(drake_combined, drake_scores, drake_sentiments$sentiment, drake_syuzhet_sentiments)

# Datacheck 
head(drake_sentiments)

# Output the File
write.csv(drake_total, file = "drake_combo_sentiments.csv")

# Plot Data 
barplot(table(drake_total$`drake_sentiments$sentiment`))
barplot(table(drake_total$drake_scores))

barplot(
  sort(colSums(prop.table(drake_syuzhet_sentiments))), 
  horiz = TRUE, 
  cex.names = 0.7, 
  las = 1, 
  main = "Drake Emotions in Songs", xlab="Percentage"
)

########################### Get Lyric Sentiments for Rihanna ##################################

# Get Scores, Split into Two to Avoid Heap Overflow
rihanna_scores_first_half = calculate_score(rihanna_combined$line[1:2107])
rihanna_scores_second_half = calculate_score(rihanna_combined$line[2108:length(rihanna_combined$line)])
rihanna_scores = c(rihanna_scores_first_half, rihanna_scores_second_half)
length(rihanna_scores)

# Do the Same for Getting Sentiments 
rihanna_sentiments_first_half = calculate_sentiment(rihanna_combined$line[1:2107])
rihanna_sentiments_second_half = calculate_sentiment(rihanna_combined$line[2108:length(rihanna_combined$line)])
rihanna_sentiments = c(as.character(rihanna_sentiments_first_half$sentiment), as.character(rihanna_sentiments_second_half$sentiment))

# Syuzhet Library Sentiments 
rihanna_syuzhet_sentiments = get_nrc_sentiment(as.character(rihanna_combined$line))
length(rihanna_combined$line)

# Concat onto Dataframe
rihanna_total = cbind(rihanna_combined, rihanna_scores, rihanna_sentiments, rihanna_syuzhet_sentiments)

# Data Check
head(rihanna_total)

# Output File
write.csv(rihanna_total, file = "rihanna_combo_sentiments.csv")

# Plot Data
barplot(table(rihanna_total$rihanna_sentiments))
barplot(table(rihanna_total$rihanna_scores))

par(mfrow=c(1,1))
barplot(
  sort(colSums(prop.table(rihanna_syuzhet_sentiments))), 
  horiz = TRUE, 
  cex.names = 0.7, 
  las = 1, 
  main = "Rihanna Emotions in Songs", xlab="Percentage"
)

