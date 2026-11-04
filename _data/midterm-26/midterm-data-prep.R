# Merge 2026 House seat projections onto the gerrymander data
# Inputs:  _data/gerrymander/gerrymander.csv
#          _data/midterm-26/house-seats-projections-<timestamp>.csv
# Output:  _data/midterm-26/midterm-<timestamp>.csv

# snapshot time ---------------------------------------------------------------

timestamp <- "2026-11-04-11-14"

# load packages ---------------------------------------------------------------

library(tidyverse)

# load data -------------------------------------------------------------------

gerrymander <- read_csv("_data/gerrymander/gerrymander.csv")

projections_26 <- read_csv(
  glue::glue("_data/midterm-26/house-seats-projections-{timestamp}.csv")
) |>
  mutate(
    # match gerrymander's at-large coding: "AK-AL" -> "AK-00"
    district = str_replace(district, "-AL$", "-00")
  ) |>
  select(-state_abb) |>
  rename(
    rating_26 = rating,
    leader_26 = leader,
    margin_26 = margin,
    called_26 = called
  )

# check districts that don't match --------------------------------------------

anti_join(gerrymander, projections_26, by = "district") |> select(district)
anti_join(projections_26, gerrymander, by = "district") |> select(district)

# merge -----------------------------------------------------------------------

midterm <- gerrymander |>
  left_join(projections_26, by = "district")

# write -----------------------------------------------------------------------

write_csv(midterm, glue::glue("_data/midterm-26/midterm-{timestamp}.csv"))
