# Parse 2026 House seat projections from copied web page text into a CSV
# Inputs:  _data/midterm-26/house-seats-projections-<timestamp>.md
#          _data/midterm-26/house-seats-uncalled-<timestamp>.md (if it exists)
# Output:  _data/midterm-26/house-seats-projections-<timestamp>.csv

# snapshot time ---------------------------------------------------------------

timestamp <- "2026-11-04-11-14"

# load packages ---------------------------------------------------------------

library(tidyverse)

# parser ----------------------------------------------------------------------

# The copied text has category headers ("Races expected to be toss-ups", ...)
# followed by district / margin pairs, e.g. "CO-03" then "R +0.4".
parse_races <- function(path) {
  lines <- read_lines(path) |>
    str_trim()
  lines <- lines[lines != ""]

  out <- list()
  category_current <- NA
  i <- 1
  while (i <= length(lines)) {
    line <- lines[i]
    if (str_detect(line, "^Races|^Other races")) {
      category_current <- line
      i <- i + 1
      next
    }
    out[[length(out) + 1]] <- tibble(
      district = line,
      category = category_current,
      raw = lines[i + 1]
    )
    i <- i + 2
  }

  bind_rows(out)
}

# projections -----------------------------------------------------------------

projections <- parse_races(
  glue::glue("_data/midterm-26/house-seats-projections-{timestamp}.md")
) |>
  mutate(
    state_abb = str_sub(district, 1, 2),
    rating = case_when(
      str_detect(category, "toss-ups") ~ "Toss-up",
      str_detect(category, "leaning toward Democrats") ~ "Lean D",
      str_detect(category, "leaning toward Republicans") ~ "Lean R",
      str_detect(category, "likely to go to Democrats") ~ "Likely D",
      str_detect(category, "likely to go to Republicans") ~ "Likely R",
      str_detect(category, "safe for Democrats") ~ "Safe D",
      str_detect(category, "safe for Republicans") ~ "Safe R",
      .default = "Other"
    ),
    leader = case_when(
      str_starts(raw, "D") ~ "Democrat",
      str_starts(raw, "R") ~ "Republican"
    ),
    # "<0.1" recorded as 0.05; "—" (no margin reported) recorded as NA
    margin = parse_number(str_replace(raw, "<0.1", "0.05"), na = "—")
  ) |>
  # drop DC's non-voting delegate to keep the 435 voting seats
  filter(district != "DC-AL")

# called / uncalled -----------------------------------------------------------

uncalled_path <- glue::glue(
  "_data/midterm-26/house-seats-uncalled-{timestamp}.md"
)

if (file.exists(uncalled_path)) {
  uncalled <- parse_races(uncalled_path)
  projections <- projections |>
    mutate(
      called = if_else(district %in% uncalled$district, "uncalled", "called")
    )
} else {
  projections <- projections |>
    mutate(called = NA_character_)
}

# write -----------------------------------------------------------------------

projections |>
  select(district, state_abb, rating, leader, margin, called) |>
  write_csv(
    glue::glue("_data/midterm-26/house-seats-projections-{timestamp}.csv")
  )
