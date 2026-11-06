library(dplyr)
library(haven)
library(readr)

# Run from the repository root. Optionally pass a local Release 3a .dta file:
# Rscript _data/gss/gss-2024-more-cols-prep.R /path/to/gss7224_r3a.dta
args <- commandArgs(trailingOnly = TRUE)
output_file <- file.path("_data", "gss", "gss-2024-more-cols.csv")

local({
  if (length(args) > 0L) {
    source_dta <- args[[1]]
  } else {
    source_url <- "https://gss.norc.org/content/dam/gss/get-the-data/documents/stata/GSS_stata.zip"
    source_zip <- tempfile(fileext = ".zip")
    source_dir <- tempfile()
    on.exit(unlink(c(source_zip, source_dir), recursive = TRUE), add = TRUE)
    download.file(source_url, source_zip, mode = "wb")
    unzip(source_zip, files = "GSS_stata/gss7224_r3a.dta", exdir = source_dir)
    source_dta <- file.path(source_dir, "GSS_stata", "gss7224_r3a.dta")
  }

  gss_2024 <- read_dta(
    source_dta,
    col_select = c(
      year, marital, age, educ, childs, happy, health, wrkstat, partyid,
      natsci, polviews, consci, techesy, harmgood1, nextgen1
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
      health = stringr::str_to_sentence(
        as.character(as_factor(health, levels = "labels"))
      ),
      employment_status = stringr::str_to_sentence(
        as.character(as_factor(wrkstat, levels = "labels"))
      ),
      party_id = stringr::str_to_sentence(
        as.character(as_factor(partyid, levels = "labels"))
      ),
      natsci = stringr::str_to_sentence(
        as.character(as_factor(natsci, levels = "labels"))
      ),
      polviews = stringr::str_to_sentence(
        as.character(as_factor(polviews, levels = "labels"))
      ),
      consci = stringr::str_to_sentence(
        as.character(as_factor(consci, levels = "labels"))
      ),
      techesy = stringr::str_to_sentence(
        as.character(as_factor(techesy, levels = "labels"))
      ),
      harmgood1 = stringr::str_to_sentence(
        as.character(as_factor(harmgood1, levels = "labels"))
      ),
      nextgen1 = stringr::str_to_sentence(
        as.character(as_factor(nextgen1, levels = "labels"))
      )
    ) |>
    filter(
      year == 2024L,
      !(marital_status %in% c(
        "No answer", "Skipped on web", "Don't know", "Refused", "Not applicable"
      ))
    ) |>
    mutate(
      across(
        c(
          happiness, health, employment_status, party_id, natsci, polviews,
          consci, techesy, harmgood1, nextgen1
        ),
        ~ if_else(
          .x %in% c(
            "Don't know", "No answer", "Skipped on web", "Refused", "Not applicable",
            "Iap", "Dk, na, iap", "Uncodeable", "Not imputable",
            "Not available in this release", "Not available in this year",
            "See codebook", "Can't choose"
          ),
          NA_character_,
          .x
        )
      )
    )

  write_csv(gss_2024, output_file)
})
