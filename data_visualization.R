
# Import Libraries 
library(ggplot2)
library(gridExtra)
library(dplyr)

# Load Data
drake_data = read.csv("drake_combo_sentiments 2.csv")
rih_data = read.csv("rihanna_combo_sentiments 2.csv")

# Check Data
head(drake_data)
head(rih_data)


# Plot Drake Sentiments 
drake_data$drake_sentiments.sentiment <- factor(drake_data$drake_sentiments.sentiment, levels = c("Very Negative", "Negative", "Neutral", "Positive", "Very Positive"))
drake_sent <- ggplot(drake_data, aes(drake_sentiments.sentiment)) +
     geom_bar(fill = "navyblue") +
     xlab("Sentiments") +
     ylab("Count") +
     theme_classic() +
     ggtitle("Drake Sentiments") 
drake_sent

# Plot Rihanna Sentiments 
rih_data$rihanna_sentiments <- factor(rih_data$rihanna_sentiments, levels = c("Very Negative", "Negative", "Neutral", "Positive", "Very Positive"))
rih_sent <- ggplot(rih_data, aes(rihanna_sentiments)) +
  geom_bar(fill = "firebrick4") +
  xlab("Sentiments") +
  ylab("Count") +
  theme_classic() +
  ggtitle("Rihanna Sentiments") 
rih_sent

grid.arrange(drake_sent, rih_sent, ncol=2)

# Plot Drake Sentiment Scores 
drake_score_no99 <- drake_data[drake_data$drake_scores != 99,]
drake_score <- ggplot(drake_score_no99, aes(drake_scores)) +
  geom_bar(fill = "navyblue") +
  xlab("Scores") +
  ylab("Count") +
  theme_classic() +
  ggtitle("Drake Scores") +
  geom_vline(xintercept = sum(drake_score_no99$drake_scores)/length(drake_score_no99$drake_scores))
drake_score

# Plot Rihanna Sentiment Scores
rih_score_no99 <- rih_data[rih_data$rihanna_scores != 99, ]
rih_score <- ggplot(rih_score_no99, aes(rihanna_scores)) +
  geom_bar(fill = "firebrick4") +
  xlab("Scores") +
  ylab("Count") +
  theme_classic() +
  ggtitle("Rihanna Scores") +
  geom_vline(xintercept = sum(rih_score_no99$rihanna_scores)/length(rih_score_no99$rihanna_scores))
rih_score

grid.arrange(drake_score, rih_score, ncol=2)



# Structure Data Further
drake_counts=data.frame(value=apply(drake_data[,c(8:17)],2,sum))
drake_counts$key=rownames(drake_counts)
drake_counts = drake_counts[order(drake_counts$value),]

# Plot Drake Emotions 
drake_emotions <- ggplot(drake_counts, aes(x = reorder(key, -value), y=value)) +
  geom_bar(fill="navyblue", stat="identity") +
  xlab("Emotions") +
  ylab("Count") +
  ggtitle("Drake Emotions") +
  theme_classic() 
drake_emotions

# Structure Data Further
rih_counts=data.frame(value=apply(rih_data[,c(8:17)],2,sum))
rih_counts$key=rownames(rih_counts)
rih_counts = rih_counts[order(rih_counts$value),]

# Plot Rihannah Emotions 
rih_emotions <- ggplot(rih_counts, aes(x = reorder(key, -value), y=value)) +
  geom_bar(fill="firebrick4", stat="identity") +
  xlab("Emotions") +
  ylab("Count") +
  ggtitle("Rihanna Emotions") +
  theme_classic() 
rih_emotions

grid.arrange(drake_emotions, rih_emotions, ncol=2)


# Further Data Manipulation 
drake_years = drake_score_no99 %>%
  group_by(year) %>%
  dplyr::summarize(Mean = mean(drake_scores, na.rm=TRUE))

rih_years = rih_score_no99 %>%
  group_by(year) %>%
  dplyr::summarize(Mean = mean(rihanna_scores, na.rm=TRUE))

# Plot Drake Sentiment by Year 
drake_sent_year <- ggplot(drake_years, aes(x=as.factor(year), y=Mean)) +
  xlab("Years") +
  ylab("Mean Sentiment") +
  ggtitle("Drake Sentiment by Year") +
  theme_classic() +
  geom_point() +
  geom_line(aes(group=1), color='navyblue', size=2) 
drake_sent_year

# Plot Rihanna Sentiment by Year 
rih_sent_year <- ggplot(rih_years, aes(x=as.factor(year), y=Mean)) +
  xlab("Years") +
  ylab("Mean Sentiment") +
  ggtitle("Rihanna Sentiment by Year") +
  theme_classic() +
  geom_point() +
  geom_line(aes(group=1), color='firebrick4', size=2) 
rih_sent_year
grid.arrange(drake_sent_year, rih_sent_year, ncol=2)
