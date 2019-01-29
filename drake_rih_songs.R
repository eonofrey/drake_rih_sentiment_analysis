# Imports for API Access
library(devtools)
install_github("tiagomendesdantas/Rspotify")
library(Rspotify)

# Credentials Store
app_id = "oidd215d2"
client_id = "8ff660c8ac2c429e8e6405e532de4bd4"
client_secret = "48d42dd6044f4db0b453a87d274cceb7"

# Input Credentials 
keys <- spotifyOAuth(app_id,client_id,client_secret)
spotify.playlists = getPlaylist("onofamspotify", token=keys)
head(spotify.playlists)

# Check to See if Connection Works
us.playlist <- getPlaylistSongs("onofamspotify","0PxcV87c8T1zL9dVfAAUhi",token=keys)
us.playlist

# Custom Function to Search Exact Artist by Name
search_exact_artist <- function(exact_name) {
  a = searchArtist(exact_name, token = keys)
  a = a[a$display_name == exact_name, ]
  a = a[a$popularity == max(a$popularity), ]
  return (a)
}

# Proof of Concept: Grabbing Songs from Drake's "Views" album 
drake_artist = search_exact_artist("Drake")
drake_views = getAlbums(drake_artist$id[1], token = keys)[3,]
drake_views_songs = getAlbum(drake_views$id, token = keys)


###################### Grabbing all Songs for Drake #############################
# Grab Artist and Albums
drake_artist = search_exact_artist("Drake")
drake_albums = getAlbums(drake_artist$id[1], token = keys)

# Dedup 
drake_albums = drake_albums[!duplicated(drake_albums$name),] #get rid of duplicates

# Create Containers for Songs and Albums 
song_container = c()
album_container = c()

# Loop Through API to get Songs
for (i in 1:length(drake_albums$name)) {
  songs = unlist(getAlbum(drake_albums$id[i], token = keys)$name)
  album_name = drake_albums$name[i]
  albums = rep(album_name,length(songs))
  
  song_container = c(song_container, songs)
  album_container = c(album_container, albums)
}

# Throw Songs and Albums into a Dataframe
all_drake_songs_and_albums = data.frame(song=song_container, album=album_container)

# A Little Bit of Cleaning 
all_drake_songs_and_albums$song = gsub("- Album Version \\(Edited\\)", "", all_drake_songs_and_albums$song)
all_drake_songs_and_albums$album = gsub("- Album Version \\(Edited\\)", "", all_drake_songs_and_albums$album)

# Add Years of Albums (Manually) 
all_drake_songs_and_albums$year[all_drake_songs_and_albums$album == "More Life"] <- 2017
all_drake_songs_and_albums$year[all_drake_songs_and_albums$album == "Views"] <- 2016
all_drake_songs_and_albums$year[all_drake_songs_and_albums$album == "What A Time To Be Alive"] <- 2015
all_drake_songs_and_albums$year[all_drake_songs_and_albums$album == "If You're Reading This It's Too Late"] <- 2015
all_drake_songs_and_albums$year[all_drake_songs_and_albums$album == "Nothing Was The Same"] <- 2013
all_drake_songs_and_albums$year[all_drake_songs_and_albums$album == "Nothing Was The Same (Deluxe)"] <- 2013
all_drake_songs_and_albums$year[all_drake_songs_and_albums$album == "Take Care (Deluxe)"] <- 2011
all_drake_songs_and_albums$year[all_drake_songs_and_albums$album == "Thank Me Later"] <- 2010
all_drake_songs_and_albums$year[all_drake_songs_and_albums$album == "So Far Gone"] <- 2008

# Data Check 
head(all_drake_songs_and_albums)

###################### Grabbing all Rihanna Songs #############################
# Grab Artist Albums 
rihanna_artist = search_exact_artist("Rihanna")
rihanna_albums = getAlbums(rihanna_artist$id[1], token = keys)

# Clean Albums 
rihanna_albums = rihanna_albums[!duplicated(rihanna_albums$name),] #get rid of duplicates
rihanna_albums = rihanna_albums[c(1,3,5,6,8,10,11,12),]

# Create Empty Containers
rihanna_song_container = c()
rihanna_album_container = c()

# Loop Through API to get Songs
for (i in 1:length(rihanna_albums$name)) {
  songs = unlist(getAlbum(rihanna_albums$id[i], token = keys)$name)
  album_name = rihanna_albums$name[i]
  albums = rep(album_name,length(songs))
  
  rihanna_song_container = c(rihanna_song_container, songs)
  rihanna_album_container = c(rihanna_album_container, albums)
}

# Put into a Data Frame
all_rihanna_songs_and_albums = data.frame(song=rihanna_song_container, album=rihanna_album_container)

# Add Years of Albums (Manually) 
all_rihanna_songs_and_albums$year[all_rihanna_songs_and_albums$album == "ANTI"] <- 2016
all_rihanna_songs_and_albums$year[all_rihanna_songs_and_albums$album == "Unapologetic (Deluxe)"] <- 2012
all_rihanna_songs_and_albums$year[all_rihanna_songs_and_albums$album == "Talk That Talk"] <- 2011
all_rihanna_songs_and_albums$year[all_rihanna_songs_and_albums$album == "Loud"] <- 2010
all_rihanna_songs_and_albums$year[all_rihanna_songs_and_albums$album == "Rated R"] <- 2009
all_rihanna_songs_and_albums$year[all_rihanna_songs_and_albums$album == "Good Girl Gone Bad: Reloaded"] <- 2008
all_rihanna_songs_and_albums$year[all_rihanna_songs_and_albums$album == "A Girl Like Me"] <- 2006
all_rihanna_songs_and_albums$year[all_rihanna_songs_and_albums$album == "Music Of The Sun"] <- 2005

