library(devtools)
install_github("tiagomendesdantas/Rspotify")
library(Rspotify)

app_id = "oidd215d2"
client_id = "8ff660c8ac2c429e8e6405e532de4bd4"
client_secret = "48d42dd6044f4db0b453a87d274cceb7"

keys <- spotifyOAuth(app_id,client_id,client_secret)

spotify.playlists = getPlaylist("onofamspotify",token=keys)
head(spotify.playlists)

us.playlist <- getPlaylistSongs("onofamspotify","0PxcV87c8T1zL9dVfAAUhi",token=keys)
us.playlist

#####Function to serach exact artist 
search_exact_artist <- function(exact_name) {
  a = searchArtist(exact_name, token = keys)
  a = a[a$display_name == exact_name, ]
  a = a[a$popularity == max(a$popularity), ]
  return (a)
}

##example of grabbing the songs off of Drake's Views album 
drake_artist = search_exact_artist("Drake")
drake_views = getAlbums(drake_artist$id[1], token = keys)[3,]
drake_views_songs = getAlbum(drake_views$id, token = keys)


###################### Grabbing all songs for Drake Example #############################
drake_artist = search_exact_artist("Drake")
drake_albums = getAlbums(drake_artist$id[1], token = keys)
drake_albums = drake_albums[!duplicated(drake_albums$name),] #get rid of duplicates

#get all songs and albums
song_container = c()
album_container = c()

for (i in 1:length(drake_albums$name)) {
  songs = unlist(getAlbum(drake_albums$id[i], token = keys)$name)
  album_name = drake_albums$name[i]
  albums = rep(album_name,length(songs))
  
  song_container = c(song_container, songs)
  album_container = c(album_container, albums)
}

#little bit of cleaning
all_drake_songs_and_albums = data.frame(song=song_container, album=album_container)
all_drake_songs_and_albums$song = gsub("- Album Version \\(Edited\\)", "", all_drake_songs_and_albums$song)
all_drake_songs_and_albums$album = gsub("- Album Version \\(Edited\\)", "", all_drake_songs_and_albums$album)

#add years
all_drake_songs_and_albums$year[all_drake_songs_and_albums$album == "More Life"] <- 2017
all_drake_songs_and_albums$year[all_drake_songs_and_albums$album == "Views"] <- 2016
all_drake_songs_and_albums$year[all_drake_songs_and_albums$album == "What A Time To Be Alive"] <- 2015
all_drake_songs_and_albums$year[all_drake_songs_and_albums$album == "If You're Reading This It's Too Late"] <- 2015
all_drake_songs_and_albums$year[all_drake_songs_and_albums$album == "Nothing Was The Same"] <- 2013
all_drake_songs_and_albums$year[all_drake_songs_and_albums$album == "Nothing Was The Same (Deluxe)"] <- 2013
all_drake_songs_and_albums$year[all_drake_songs_and_albums$album == "Take Care (Deluxe)"] <- 2011
all_drake_songs_and_albums$year[all_drake_songs_and_albums$album == "Thank Me Later"] <- 2010
all_drake_songs_and_albums$year[all_drake_songs_and_albums$album == "So Far Gone"] <- 2008


head(all_drake_songs_and_albums)
###################### Grabbing all songs for Drake Example #############################

