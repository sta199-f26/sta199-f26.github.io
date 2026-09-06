library(tidycensus)
library(tidyverse)
library(tigris)
library(sf)
library(readxl)

# census data via tidycensus ----

# retrieved on 2025-09-07
us_county_raw <- get_decennial(
  geography = "county",
  variables = "P1_001N",
  year = 2020,
  geometry = TRUE,
  keep_geo_vars = TRUE
)

us_county <- us_county_raw |>
  mutate(
    land_area_mi2 = ALAND / 2589988.11, # m2 ÷ 2,589,988.11 = mi2
    pop_dens_2020 = value / land_area_mi2
  ) |>
  rename(
    county = NAME.x,
    state_abb = STUSPS,
    state_name = STATE_NAME,
    land_area_m2 = ALAND,
    pop_2020 = value
  ) |>
  select(
    county,
    state_abb,
    state_name,
    land_area_m2,
    land_area_mi2,
    pop_2020,
    pop_dens_2020
  ) |>
  st_drop_geometry()

nc_county_1 <- us_county |>
  filter(state_abb == "NC") |>
  select(-state_abb, -state_name) |>
  arrange(county)

# other county data via muFutureNC ----

# retrieved from https://dashboard.myfuturenc.org/county-data-and-resources/ on 2026-09-05
nc_county_2 <- read_excel(
  here::here(
    "_data",
    "nc-county/2026_MFNC_Attainment_Profile_Data_Summary.xlsx"
  ),
  sheet = "County",
  skip = 5
) |>
  slice(-1) |>
  select(
    county = NAME,
    county_type,
    median_hh_income = medhhinc,
    p_foreign_born = p_foreignborn,
    p_child_poverty = childpov,
    p_single_parent_hh = p_sphh,
    p_broadband = broadband,
    p_home_ownership = home_owners,
    p_family_sustaining_wage = famwage,
    p_edu_lths = p_lths,
    p_edu_hsged = p_hsged,
    p_edu_scnd = p_scnd,
    p_edu_ndc = p_ndc,
    p_edu_assoc = p_assoc,
    p_edu_ba = p_ba,
    p_edu_mapl = p_mapl,
    p_edu_hs_grad_rate = hsgrad_rate,
    p_edu_chronic_absent_rate = absenteeism_rate
  ) |>
  mutate(county = str_remove(county, " County"))

# join data ----

nc_county <- left_join(nc_county_1, nc_county_2, by = "county")

# write data ----

write_csv(nc_county, file = here::here("_data", "nc-county/nc-county.csv"))
