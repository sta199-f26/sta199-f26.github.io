library(dplyr)
library(haven)
library(readr)

source_url <- "https://gss.norc.org/content/dam/gss/get-the-data/documents/stata/GSS_stata.zip"
source_zip <- tempfile(fileext = ".zip")
source_dir <- tempfile()
source_dta <- file.path(source_dir, "GSS_stata", "gss7224_r3a.dta")
output_file <- file.path("slides", "data", "gss-2024.csv")

download.file(source_url, source_zip, mode = "wb")
unzip(source_zip, files = "GSS_stata/gss7224_r3a.dta", exdir = source_dir)
on.exit(unlink(c(source_zip, source_dir), recursive = TRUE), add = TRUE)

gss_2024 <- read_dta(
  source_dta,
  col_select = c(
    year, marital, age, educ, childs, happy, wrkstat, partyid, wtssnrps
  )
) |>
  transmute(
    year = as.integer(year),
    marital_status = stringr::str_to_sentence(
      as.character(as_factor(marital, levels = "labels"))
    ),
    age = as.numeric(age),
    education_years = as.numeric(educ),
    children = as.numeric(childs),
    happiness = stringr::str_to_sentence(
      as.character(as_factor(happy, levels = "labels"))
    ),
    employment_status = stringr::str_to_sentence(
      as.character(as_factor(wrkstat, levels = "labels"))
    ),
    party_id = stringr::str_to_sentence(
      as.character(as_factor(partyid, levels = "labels"))
    ),
    weight = as.numeric(wtssnrps)
  ) |>
  filter(
    year == 2024L,
    !(marital_status %in% c(
      "No answer", "Skipped on web", "Don't know", "Refused", "Not applicable"
    )),
    !is.na(weight)
  ) |>
  mutate(
    across(
      c(happiness, employment_status, party_id),
      ~ if_else(
        .x %in% c(
          "Don't know", "No answer", "Skipped on web", "Refused", "Not applicable",
          "Iap", "Dk, na, iap", "Uncodeable"
        ),
        NA_character(),
        .x
      )
    )
  )

write_csv(gss_2024, output_file)
