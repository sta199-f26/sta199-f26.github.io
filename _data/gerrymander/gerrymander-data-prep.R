# load packages ----

library(tidyverse)
library(rvest)
library(PresElectionResults) # pak::pak("jaytimm/PresElectionResults")

# 2024 election results ----

pres_24 <- as_tibble(PresElectionResults::pres_by_cd) |>
  rename(
    state_abb = state_abbrev,
    harris24 = democrat,
    trump24 = republican
  ) |>
  mutate(district = paste(state_abb, district_code, sep = "-")) |>
  select(state_abb, district, harris24, trump24)

write_csv(pres_24, file = "_data/gerrymander/pres-24.csv")

# 2020-2024 results ----

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

# State-level overall grades from the state pages ----------------------------
#
# This section follows the state-page workflow directly. Each page has a
# "Scored Maps from the Redistricting Report Card" table containing the report
# name, the page's report date, and its `planId` link. We use those links to
# identify:
#   1. the last congressional report dated before the 2024 election; and
#   2. the most recent congressional report whose name includes "Enacted".
#
# The overall grade is then read from that plan's public JSON. The report-card
# app calls this field `finalReportCardGrade` (and also stores it as
# `overallGrade`).
state_page_base_url <- "https://nervous-noyce-f2ebc6.netlify.app/reforms/"
election_day_2024 <- as.Date("2024-11-05")

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
  filter(str_detect(plan_name, regex("congressional", ignore_case = TRUE)))

# Use the last report date before election day. Restricting this to rows marked
# "Graded" ensures that `grade_2024` comes from a report with an overall grade,
# rather than a page that only reports calculated metrics.
last_pre_election_report <- congressional_reports |>
  filter(
    report_date < election_day_2024,
    report_status == "Graded"
  ) |>
  arrange(state_abbreviation, desc(report_date)) |>
  distinct(state_abbreviation, .keep_all = TRUE) |>
  rename_with(~ paste0("pre_", .x), -state_abbreviation)

latest_enacted_report <- congressional_reports |>
  filter(str_detect(plan_name, regex("enacted", ignore_case = TRUE))) |>
  arrange(state_abbreviation, desc(report_date)) |>
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
  last_pre_election_report$pre_plan_id,
  latest_enacted_report$enacted_plan_id
))
selected_plan_ids <- selected_plan_ids[!is.na(selected_plan_ids)]

selected_grades <- tibble(
  plan_id = selected_plan_ids,
  overall_grade = map_chr(selected_plan_ids, get_overall_grade)
)

gerrymander_state_grade_sources <- state_pages |>
  left_join(last_pre_election_report, by = "state_abbreviation") |>
  left_join(latest_enacted_report, by = "state_abbreviation") |>
  left_join(
    selected_grades,
    by = c("pre_plan_id" = "plan_id")
  ) |>
  rename(pre_grade = overall_grade) |>
  left_join(
    selected_grades,
    by = c("enacted_plan_id" = "plan_id")
  ) |>
  rename(enacted_grade = overall_grade) |>
  mutate(
    # If the latest enacted report predates the 2024 election, there was no
    # post-election enacted update, so carry the pre-election grade forward.
    grade_2024 = pre_grade,
    grade_2026 = if_else(
      is.na(enacted_report_date) |
        enacted_report_date < election_day_2024,
      pre_grade,
      enacted_grade
    )
  )

# Requested result: exactly 50 rows and these three columns.
gerrymander_state_grades <- gerrymander_state_grade_sources |>
  select(state, grade_2024, grade_2026)

stopifnot(
  nrow(gerrymander_state_grades) == 50,
  identical(
    names(gerrymander_state_grades),
    c("state", "grade_2024", "grade_2026")
  )
)

write_csv(
  gerrymander_state_grades,
  here::here("_data", "gerrymander", "gerrymander24-state-grades.csv")
)
