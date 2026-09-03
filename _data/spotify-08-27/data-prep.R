library(tidyverse)

chart <- read_csv(here::here(
  "_data/spotify-08-27",
  "spotify-global-weekly-2026-08-27-raw.csv"
))

genre <- read_csv(here::here(
  "_data/spotify-08-27",
  "spotify-artist-genres.csv"
))

spotify <- chart |>
  left_join(genre, by = "artist") |>
  rename(genre = artist_genre)

spotify |>
  count(genre, sort = TRUE)

spotify <- spotify |>
  mutate(
    genre = case_when(
      artist == "Anuv Jain" ~ "Indie",
      artist == "Banjaare" ~ "Pop",
      genre == "Indonesian pop" ~ "Pop",
      genre == "Indonesian pop" ~ "Pop",
      .default = genre
    )
  )

spotify |>
  count(genre, sort = TRUE)

write_csv(
  spotify,
  here::here(
    "_data/spotify-08-27",
    "spotify-global-weekly-2026-08-27.csv"
  )
)
