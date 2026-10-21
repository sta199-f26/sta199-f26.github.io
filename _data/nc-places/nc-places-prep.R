library(tidyverse)

# CDC PLACES: Local Data for Better Health, County Data, 2025 release
# https://data.cdc.gov/resource/swc5-untb
# Retrieved 2026-10-21
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

# 2026 County Development Tier Designations, NC Department of Commerce
# https://www.commerce.nc.gov/grants-incentives/county-distress-rankings-tiers
development_tier_1 <- c(
  "Alexander", "Anson", "Bertie", "Bladen", "Burke", "Caldwell", "Caswell",
  "Cleveland", "Columbus", "Cumberland", "Edgecombe", "Greene", "Halifax",
  "Hertford", "Hoke", "Hyde", "Jones", "Lenoir", "Madison", "Martin",
  "McDowell", "Mitchell", "Nash", "Northampton", "Pasquotank", "Pitt",
  "Richmond", "Robeson", "Rockingham", "Rutherford", "Sampson", "Scotland",
  "Tyrrell", "Vance", "Warren", "Washington", "Wayne", "Wilkes", "Wilson",
  "Yancey"
)

development_tier_2 <- c(
  "Alamance", "Alleghany", "Ashe", "Avery", "Beaufort", "Buncombe",
  "Catawba", "Cherokee", "Chowan", "Clay", "Craven", "Dare", "Davidson",
  "Duplin", "Forsyth", "Franklin", "Gaston", "Gates", "Graham", "Granville",
  "Guilford", "Harnett", "Haywood", "Henderson", "Jackson", "Lee",
  "Montgomery", "Onslow", "Pamlico", "Perquimans", "Person", "Polk",
  "Randolph", "Rowan", "Stokes", "Surry", "Swain", "Transylvania",
  "Watauga", "Yadkin"
)

development_tier_3 <- c(
  "Brunswick", "Cabarrus", "Camden", "Carteret", "Chatham", "Currituck",
  "Davie", "Durham", "Iredell", "Johnston", "Lincoln", "Macon",
  "Mecklenburg", "Moore", "New Hanover", "Orange", "Pender", "Stanly",
  "Union", "Wake"
)

# Geographic regions, NC Office of State Archaeology
# https://archaeology.ncdcr.gov/programs/education/climatechange/risks
mountain_counties <- c(
  "Alleghany", "Ashe", "Avery", "Buncombe", "Burke", "Caldwell", "Cherokee",
  "Clay", "Graham", "Haywood", "Henderson", "Jackson", "Macon", "Madison",
  "McDowell", "Mitchell", "Polk", "Rutherford", "Swain", "Transylvania",
  "Watauga", "Wilkes", "Yancey"
)

piedmont_counties <- c(
  "Alamance", "Alexander", "Anson", "Cabarrus", "Caswell", "Catawba",
  "Chatham", "Cleveland", "Davidson", "Davie", "Durham", "Forsyth",
  "Franklin", "Gaston", "Granville", "Guilford", "Iredell", "Lee", "Lincoln",
  "Mecklenburg", "Montgomery", "Moore", "Orange", "Person", "Randolph",
  "Richmond", "Rockingham", "Rowan", "Stanly", "Stokes", "Surry", "Union",
  "Vance", "Wake", "Warren", "Yadkin"
)

# Appalachian counties, Appalachian Regional Commission
# https://www.arc.gov/appalachian-counties-served-by-arc/
appalachian_counties <- c(
  "Alexander", "Alleghany", "Ashe", "Avery", "Buncombe", "Burke", "Caldwell",
  "Catawba", "Cherokee", "Clay", "Cleveland", "Davie", "Forsyth", "Graham",
  "Haywood", "Henderson", "Jackson", "Macon", "Madison", "McDowell",
  "Mitchell", "Polk", "Rutherford", "Stokes", "Surry", "Swain",
  "Transylvania", "Watauga", "Wilkes", "Yadkin", "Yancey"
)

county_classifications <- places_long |>
  distinct(county = locationname) |>
  mutate(
    development_tier = case_when(
      county %in% development_tier_1 ~ "Tier 1",
      county %in% development_tier_2 ~ "Tier 2",
      county %in% development_tier_3 ~ "Tier 3"
    ),
    region = case_when(
      county %in% mountain_counties ~ "Mountains",
      county %in% piedmont_counties ~ "Piedmont",
      TRUE ~ "Coastal Plain"
    ),
    appalachian = if_else(
      county %in% appalachian_counties,
      "Yes",
      "No"
    )
  )

leading_variables <- c(
  "county",
  "county_fips",
  "development_tier",
  "region",
  "appalachian",
  "food_insecurity",
  "mental_distress",
  "dental_visit",
  "fair_or_poor_health"
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
  left_join(county_classifications, by = "county")

nc_places <- nc_places |>
  select(
    all_of(leading_variables),
    all_of(sort(setdiff(names(nc_places), leading_variables)))
  ) |>
  arrange(county)

stopifnot(
  n_distinct(places_long$variable) == n_distinct(places_long$measureid),
  nrow(nc_places) == 100,
  ncol(nc_places) == 6 + n_distinct(places_long$measureid),
  !anyNA(nc_places),
  n_distinct(nc_places$county) == 100,
  count(nc_places, development_tier)$n == c(40, 40, 20),
  count(nc_places, region)$n == c(41, 23, 36),
  count(nc_places, appalachian)$n == c(69, 31)
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
