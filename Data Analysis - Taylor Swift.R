# Install devtools package from GitHub
devtools::install_github('charlie86/spotifyr')

# Import required libraries
library(devtools)
library(dplyr)
library(spotifyr)
library(tidyverse)
library(knitr)
library(ggridges)
library(ggplot2)

# Access to Spotify API
access_token <- get_spotify_access_token(client_id = Sys.getenv('xxxxxxxxxxxxxxxxxxxxx'), client_secret = Sys.getenv('xxxxxxxxxxxxxxxxxxxxx'))

# Get artist data from Spotify
taylor_swift = get_artist_audio_features('taylor swift' , authorization = access_token)

# Which are Taylor's top 13 most used chords?
taylor_swift %>%
  count(key_mode, sort = TRUE) %>%
  head(13) %>%
  kable()

# Which are Taylor's top 13 songs with highest valence?
# Valence is a measure of happiness by Spotify
taylor_swift %>%
  arrange(-valence) %>%
  distinct(track_name, valence) %>%
  head(13) %>%
  kable()

# Let's take a look at valence of all the albums together
ggplot(taylor_swift, aes(x = valence, y = album_name, fill = stat(x))) + 
 geom_density_ridges_gradient(scale = 0.8) +
  scale_fill_viridis_c(name = "Valence", option = "C") +
  theme_ridges()


