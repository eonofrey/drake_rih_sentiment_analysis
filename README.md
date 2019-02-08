# drake_rih_sentiment_analysis


The following is a sentiment analysis I performed on Drake and Rihanna's songs. The first step was to collect all of their songs through Spotify's API (shown in drak_rih_songs.R). There I first gathered all of the albums of each artist with the getAlbums() call. Once I have a clean vector of every album I loop through every album and grab the songs. The final part of the song collection is to add the year of each album manually. 

The next step is to get the lyrics for every song (found in drake_rih_lyrics.R) using Rap Genius's API. In this script I iterate through every song I've grabbed from Spotify's API and use the call scrape_lyrics_id(). With some general error handeling with the API and some cleaning and dataframe manipulation I end up with a dataframe that has all the lyrics of every song for each artists, with each row in the dataframe being a line of a song. 

Finally comes the visualization and analysis. 

### Overall Positivity / Negativity 

Here are histograms of the sentiments of Drake and Rihanna's songs. With the large number of lines analyzed, it makes sense that they would conform to a slightly normal distribution. Rihanna, however, had a much higher average sentiment at .211 whereas Drake's was .047

<img width="1300" alt="screen shot 2018-03-01 at 8 35 29 pm" src="https://user-images.githubusercontent.com/38504767/52453791-f4550c00-2b16-11e9-8ebe-779497dcaab2.png">

### Overall Sentiments

Here is a similar chart but rather numbers the lyrics are binned into the categories: Very Negative, Negative, Neutral, Positive, and Very Positive (Sarcastic was excluded for this analysis). Neutral is the dominant line type. 

<img width="1075" alt="screen shot 2018-03-01 at 6 19 04 pm" src="https://user-images.githubusercontent.com/38504767/52453833-26666e00-2b17-11e9-8ab5-0d4a5bf00685.png">

### Emotions
