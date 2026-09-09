# load packages ---------------------------------------------------------------

library(tidyverse)
library(jsonlite)
library(rvest)
library(PresElectionResults) # pak::pak("jaytimm/PresElectionResults")

# 2024 election results -------------------------------------------------------

# From PresElectionResults package: https://github.com/jaytimm/PresElectionResults

pres_24 <- as_tibble(PresElectionResults::pres_by_cd) |>
  rename(
    state_abb = state_abbrev,
    harris_24 = democrat,
    trump_24 = republican
  ) |>
  mutate(district = paste(state_abb, district_code, sep = "-")) |>
  select(state_abb, district, harris_24, trump_24)

write_csv(pres_24, file = "_data/gerrymander/pres-24.csv")

# 2020-2024 house election results --------------------------------------------

# From https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/IG0UN2

house_1976_2024 <- read_delim(
  "_data/gerrymander/1976-2024-house.tab",
  delim = ","
)

house_20_22_24 <- house_1976_2024 |>
  select(
    year,
    state,
    state_po,
    district,
    candidate,
    party,
    candidatevotes,
    totalvotes
  ) |>
  filter(
    year %in% c(2020, 2022, 2024),
    candidate != "EXHAUSTED BALLOT",
    state != "DISTRICT OF COLUMBIA"
  ) |>
  group_by(year, state, district) |>
  mutate(p_candidatevotes = candidatevotes / totalvotes) |>
  arrange(desc(p_candidatevotes)) |>
  slice_head(n = 1) |>
  ungroup() |>
  mutate(
    district = if_else(
      str_length(district) == 1,
      paste0(state_po, "-0", district),
      paste0(state_po, "-", district)
    )
  ) |>
  arrange(year, state_po, district) |>
  mutate(
    state = str_to_title(state),
    candidate = str_to_title(candidate),
    party = str_to_title(party)
  ) |>
  select(!c(p_candidatevotes, candidatevotes, totalvotes)) |>
  mutate(
    party = if_else(
      party == "Democratic-Farmer-Labor",
      "Democrat",
      party
    )
  )

write_csv(house_20_22_24, file = "_data/gerrymander/house-20-22-24.csv")

# State-level gerrymandering scores -------------------------------------------

# From https://nervous-noyce-f2ebc6.netlify.app/redistricting-report-card/
# Code by ChatGPT, 2029-09-08, GPT-5.6 Sol Extra High via Codex

# This section follows the state-page workflow directly. Each page has a
# "Scored Maps from the Redistricting Report Card" table containing the report
# name, the page's report date, and its `planId` link. The displayed report
# date can change when the site republishes a score (for example, California's
# 2021 congressional map is dated 2023 on the state page), so it does not
# reliably identify the election in which a map was used. We instead use the
# map year in the report name to identify:
#   1. the latest non-draft congressional map from 2022 or earlier;
#   2. the latest non-draft congressional map from 2024 or earlier; and
#   3. the most recent congressional report whose name includes "Enacted".
#
# The overall grade is then read from that plan's public JSON. The report-card
# app calls this field `finalReportCardGrade` (and also stores it as
# `overallGrade`).
state_page_base_url <- "https://nervous-noyce-f2ebc6.netlify.app/reforms/"
election_year_2022 <- 2022L
election_year_2024 <- 2024L

# The state-page links contain a plan ID. The app's public Gatsby catalog maps
# each plan ID to the JSON file containing the report-card grade.
report_card_catalog_url <- paste0(
  "https://nervous-noyce-f2ebc6.netlify.app",
  "/page-data/sq/d/4012683360.json"
)

read_public_json <- function(url) {
  json_file <- tempfile(fileext = ".json")
  on.exit(unlink(json_file), add = TRUE)
  download.file(url, json_file, mode = "wb", quiet = TRUE)
  jsonlite::read_json(json_file, simplifyVector = FALSE)
}

json_scalar <- function(x, name, default = NA) {
  value <- x[[name]]
  if (is.null(value) || length(value) == 0) {
    default
  } else {
    value[[1]]
  }
}

report_card_catalog <- read_public_json(report_card_catalog_url)

report_card_plans <- map_dfr(
  report_card_catalog$data$allAirtableDashboard$group,
  function(plan_group) {
    map_dfr(plan_group$nodes, function(plan_node) {
      plan <- plan_node$data
      tibble(
        plan_id = plan_node$recordId,
        score_url = as.character(json_scalar(plan, "GeneratedScoreURL"))
      )
    })
  }
)

empty_state_reports <- function() {
  tibble(
    state_abbreviation = character(),
    state = character(),
    state_page_url = character(),
    plan_id = character(),
    plan_name = character(),
    report_status = character(),
    report_date_text = character(),
    report_date = as.Date(character())
  )
}

read_state_reports <- function(state_abbreviation, state_name) {
  state_page_url <- paste0(state_page_base_url, state_abbreviation)
  state_page_file <- tempfile(fileext = ".html")
  on.exit(unlink(state_page_file), add = TRUE)

  download.file(state_page_url, state_page_file, mode = "wb", quiet = TRUE)
  state_page <- read_html(state_page_file)
  report_links <- html_elements(
    state_page,
    "a[href*='/redistricting-report-card'][href*='planId=']"
  )

  if (length(report_links) == 0) {
    return(empty_state_reports())
  }

  map_dfr(report_links, function(report_link) {
    report_row <- html_element(report_link, xpath = "./ancestor::tr[1]")
    report_href <- html_attr(report_link, "href")
    report_date_text <- html_text2(html_element(report_row, "em"))

    tibble(
      state_abbreviation = state_abbreviation,
      state = state_name,
      state_page_url = state_page_url,
      plan_id = str_match(report_href, "planId=([^&]+)")[, 2],
      plan_name = html_text2(report_link),
      report_status = html_text2(html_element(report_row, "td:nth-child(2)")),
      report_date_text = report_date_text,
      report_date = as.Date(
        report_date_text,
        format = "%a %b %d %Y"
      )
    )
  })
}

state_pages <- tibble(
  state_abbreviation = state.abb,
  state = state.name
)

state_reports <- map2_dfr(
  state_pages$state_abbreviation,
  state_pages$state,
  read_state_reports
)

congressional_reports <- state_reports |>
  filter(str_detect(plan_name, regex("congressional", ignore_case = TRUE))) |>
  mutate(
    plan_year = as.integer(str_extract(plan_name, "\\b(?:19|20)\\d{2}\\b")),
    is_draft = str_detect(plan_name, regex("\\bdraft\\b", ignore_case = TRUE))
  )

# Use the plan year, not the mutable date displayed on the state page. A map
# can now be labeled "Superseded" or "Struck Down" and still be the historical
# map relevant to an earlier election, so only draft reports are excluded.
select_report_for_election <- function(election_year, prefix) {
  congressional_reports |>
    filter(
      report_status == "Graded",
      !is_draft,
      !is.na(plan_year),
      plan_year <= election_year
    ) |>
    arrange(state_abbreviation, desc(plan_year), desc(report_date)) |>
    distinct(state_abbreviation, .keep_all = TRUE) |>
    rename_with(~ paste0(prefix, .x), -state_abbreviation)
}

last_pre_2022_report <- select_report_for_election(
  election_year_2022,
  "pre2022_"
)

last_pre_2024_report <- select_report_for_election(
  election_year_2024,
  "pre2024_"
)

latest_enacted_report <- congressional_reports |>
  filter(str_detect(plan_name, regex("enacted", ignore_case = TRUE))) |>
  arrange(state_abbreviation, desc(plan_year), desc(report_date)) |>
  distinct(state_abbreviation, .keep_all = TRUE) |>
  rename_with(~ paste0("enacted_", .x), -state_abbreviation)

# The page links provide the plan IDs; the catalog above provides the public
# score-file URL for each ID. Use the report card's own overall grade.
plan_score_urls <- setNames(
  report_card_plans$score_url,
  report_card_plans$plan_id
)

get_overall_grade <- function(plan_id) {
  score_url <- unname(plan_score_urls[[plan_id]])

  if (length(score_url) == 0 || is.na(score_url) || score_url == "") {
    return(NA_character_)
  }

  score <- read_public_json(score_url)
  report_card <- score$report_card
  grade <- json_scalar(
    report_card,
    "finalReportCardGrade",
    default = NA_character_
  )

  if (is.na(grade)) {
    grade <- json_scalar(
      report_card,
      "overallGrade",
      default = NA_character_
    )
  }

  as.character(grade)
}

selected_plan_ids <- unique(c(
  last_pre_2022_report$pre2022_plan_id,
  last_pre_2024_report$pre2024_plan_id,
  latest_enacted_report$enacted_plan_id
))
selected_plan_ids <- selected_plan_ids[!is.na(selected_plan_ids)]

selected_grades <- tibble(
  plan_id = selected_plan_ids,
  overall_grade = map_chr(selected_plan_ids, get_overall_grade)
)

gerrymander_state_grade_sources <- state_pages |>
  left_join(last_pre_2022_report, by = "state_abbreviation") |>
  left_join(last_pre_2024_report, by = "state_abbreviation") |>
  left_join(latest_enacted_report, by = "state_abbreviation") |>
  left_join(
    selected_grades,
    by = c("pre2022_plan_id" = "plan_id")
  ) |>
  rename(pre2022_grade = overall_grade) |>
  left_join(
    selected_grades,
    by = c("pre2024_plan_id" = "plan_id")
  ) |>
  rename(pre2024_grade = overall_grade) |>
  left_join(
    selected_grades,
    by = c("enacted_plan_id" = "plan_id")
  ) |>
  rename(enacted_grade = overall_grade) |>
  mutate(
    # If the latest enacted map is from 2024 or earlier, there was no new map
    # for the 2026 cycle, so carry the 2024 grade forward.
    grade_2022 = pre2022_grade,
    grade_2024 = pre2024_grade,
    grade_2026 = if_else(
      is.na(enacted_plan_year) |
        enacted_plan_year <= election_year_2024,
      pre2024_grade,
      enacted_grade
    )
  )

# Requested result: exactly 50 rows and these four columns.
gerrymander_state_grades <- gerrymander_state_grade_sources |>
  select(state, grade_2022, grade_2024, grade_2026)

stopifnot(
  nrow(gerrymander_state_grades) == 50,
  identical(
    names(gerrymander_state_grades),
    c("state", "grade_2022", "grade_2024", "grade_2026")
  )
)

write_csv(
  gerrymander_state_grades,
  here::here("_data", "gerrymander", "gerrymander-22-24-26-state-grades.csv")
)

# put it altogether

gerrymander_22_24_26 <- read_csv(
  "_data/gerrymander/gerrymander-22-24-26-state-grades.csv"
) |>
  mutate(state_abb = state.abb[match(state, state.name)], .after = state) |>
  mutate(
    grade_2022 = if_else(grade_2022 == "Fail (racial)", "F", grade_2022),
    grade_2022 = if_else(grade_2022 == "F (racial)", "F", grade_2022),
    grade_2024 = if_else(state_abb == "AL", "B", grade_2024),
    grade_2024 = if_else(grade_2024 == "F (racial)", "F", grade_2024),
    grade_2026 = case_when(
      grade_2026 == "F (racial)" ~ "F",
      grade_2026 == "F (RACIAL)" ~ "F",
      grade_2026 == "C (racial)" ~ "C",
      .default = grade_2026
    )
  ) |>
  rename(
    gerry_22 = grade_2022,
    gerry_24 = grade_2024,
    gerry_26 = grade_2026
  )

house_20_22_24 <- read_csv("_data/gerrymander/house-20-22-24.csv") |>
  rename(state_abb = state_po)

pres_24 <- read_csv("_data/gerrymander/pres-24.csv") |>
  mutate(
    state = state.name[match(state_abb, state.abb)],
    .before = state_abb
  ) |>
  mutate(
    harris_24 = if_else(district == "NY-21", 39.4, harris_24),
    trump_24 = if_else(district == "NY-21", 60.1, trump_24)
  )

gerrymander <- house_20_22_24 |>
  left_join(pres_24, by = c("state", "state_abb", "district")) |>
  left_join(gerrymander_22_24_26, by = c("state", "state_abb")) |>
  select(
    year,
    state_abb,
    state,
    district,
    candidate,
    party,
    gerry_22,
    gerry_24,
    harris_24,
    trump_24,
    gerry_26
  ) |>
  arrange(year, state_abb, state, district)

write_csv(gerrymander, file = "_data/gerrymander/gerrymander.csv")
