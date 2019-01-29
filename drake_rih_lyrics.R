
# Load Package
library(geniusr)

# Rap Genius Credentials
client_id = "_AXQLV_eKSiCgXSy24FsXQZuGPK5OAYYzj1pNpF4O4u8qZUlMx2g8V2THZxDJlQx"
client_secret = "l8aM2qmyr_kwCEoWdxWGcNVJ91Ya3dlyrSNB0VLf6rcIpcG9_8tt8ubALVg0kfRPoa5NfEw-uRH0YydZNbnfVQ"
GENIUS_API_TOKEN = "n5TPUYeh9XP81ipo_Km9JsX4cLCT97zjxyh0xGB_iwqiNgmEP41c_dLLMFH8D2Xq"

# Rap Genius Token Input
Sys.setenv(GENIUS_API_TOKEN = "n5TPUYeh9XP81ipo_Km9JsX4cLCT97zjxyh0xGB_iwqiNgmEP41c_dLLMFH8D2Xq")
genius_token()

###################### Grabbing All Drake Lyrics #############################

# Create Empty Containers
lyrics_container = c()
song_container = c()

# Loop 
for (i in 1:length(all_drake_songs_and_albums$song)) {
  
  # Skip 66 (it causes errors)
  if (i == 66) {
    i = i + 1
  }
  
  # Find Song
  search <- search_song(search_term = all_drake_songs_and_albums$song[i])
  search = search[search$artist_name == "Drake" | search$artist_name == "Drake & Future" | search$artist_name == "Future",]
  
  # API Exceptions. For all songs grab the first result except 35 and 112
  if (i == 35) {
    lyrics <- scrape_lyrics_id(search$song_id[2])$line
  } else if (i == 112) {
    lyrics <- scrape_lyrics_id(search$song_id[2])$line
  } else {
    lyrics <- scrape_lyrics_id(search$song_id[1])$line
  }
  
  # Add Lyrics to the Container
  lyrics_container = c(lyrics_container, lyrics)
  
  # Move Onto the Next Song 
  song = all_drake_songs_and_albums$song[i]
  songs = rep(song,length(lyrics))
  song_container = c(song_container, songs)
  
  # Print Statments for Status Updates on the Loop
  print(length(lyrics))
  print(length(songs))
  print(i)
}

# Create Dataframe
all_drake_lyrics = data.frame(line = lyrics_container, song = song_container)

# Merge the Two Dataframes 
drake_combined <- merge(all_drake_songs_and_albums, all_drake_lyrics, by="song")

# Write to csv
write.csv(drake_combined, file = "drake_combined.csv")

###################### Grabbing all Rihana Lyrics #############################

# Create Empty Containers 
lyrics_container = c()
song_container = c()

# Handle Exceptions (29,30,42,52,53,67,72,73,74,80,82,85,86,87,88,89,90-106 doesn't show up)
for (i in 1:length(all_rihanna_songs_and_albums$song)) {
  
  if (i %in% c(29,30,42,52,53,67,72,73,74,80,82,85:106)) {
    next
  }
  
  # Find Song In Rap Genius's API
  search <- search_song(search_term = paste(all_rihanna_songs_and_albums$song[i], 'rihanna', sep=' '))
  search = search[search$artist_name == "Rihanna",]
  
  # Grab first item in the List 
  lyrics <- scrape_lyrics_id(search$song_id[1])$line
  
  # Add to Lyrics Container 
  lyrics_container = c(lyrics_container, lyrics)
  
  # Move onto Next Song
  song = all_rihanna_songs_and_albums$song[i]
  songs = as.character(rep(song,length(lyrics)))
  song_container = c(song_container, songs)
  
  # Print Statement to Check Progress of Loop
  print(i)
}

# Create dataframe
all_rihanna_lyrics = data.frame(line = lyrics_container, song = song_container)

# Merge the two dataframes 
rihanna_combined <- merge(all_rihanna_songs_and_albums, all_rihanna_lyrics, by="song")

# Write to csv
write.csv(rihanna_combined, file = "rihanna_combined.csv")

