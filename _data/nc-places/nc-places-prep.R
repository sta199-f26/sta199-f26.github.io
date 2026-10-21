library(tidyverse)

# CDC PLACES: Local Data for Better Health, County Data, 2025 release
# https://data.cdc.gov/resource/swc5-untb
# Retrieved 2026-10-19
source_url <- paste0(
  "https://data.cdc.gov/resource/swc5-untb.csv?",
  "%24limit=50000&",
  "%24where=stateabbr%3D%27NC%27%20AND%20",
  "datavaluetypeid%3D%27AgeAdjPrv%27"
)

places_raw <- read_csv(source_url, show_col_types = FALSE)

clean_measure_name <- function(x) {
  x |>
    str_to_lower() |>
    str_replace_all("[^a-z0-9]+", "_") |>
    str_remove("^_") |>
    str_remove("_$")
}

places_long <- places_raw |>
  mutate(
    variable = clean_measure_name(short_question_text),
    variable = recode(
      variable,
      current_cigarette_smoking = "smoking",
      frequent_mental_distress = "mental_distress",
      general_health = "fair_or_poor_health",
      health_insurance = "uninsured",
      lack_of_social_emotional_support = "lack_social_emotional_support",
      short_sleep_duration = "short_sleep",
      transportation_barriers = "transportation_barrier"
    )
  )

nc_places <- places_long |>
  transmute(
    county = locationname,
    county_fips = as.character(locationid),
    population = as.numeric(totalpopulation),
    variable,
    estimate = as.numeric(data_value)
  ) |>
  pivot_wider(names_from = variable, values_from = estimate) |>
  select(
    county,
    county_fips,
    population,
    loneliness,
    mental_distress,
    everything()
  ) |>
  arrange(county)

stopifnot(
  n_distinct(places_long$variable) == n_distinct(places_long$measureid),
  nrow(nc_places) == 100,
  ncol(nc_places) == 3 + n_distinct(places_long$measureid),
  !anyNA(nc_places),
  n_distinct(nc_places$county) == 100
)

write_csv(
  nc_places,
  here::here("_data", "nc-places", "nc-places.csv")
)

write_csv(
  nc_places,
  here::here("slides", "data", "nc-places.csv")
)

write_csv(
  nc_places,
  here::here("ae", "data", "nc-places.csv")
)
