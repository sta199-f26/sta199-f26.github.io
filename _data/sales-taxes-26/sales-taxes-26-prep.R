library(tidyverse)
library(readxl)

# Read the table, skipping the title above the column headings.
sales_taxes_raw <- read_excel(
  here::here("_data", "sales-taxes-26", "2026-Sales-Tax-Data.xlsx"),
  sheet = "Table",
  skip = 1
)

sales_taxes <- sales_taxes_raw |>
  select(
    state = State,
    state_tax_rate = `State Tax Rate`,
    state_tax_rank = `State Tax Rank`,
    avg_local_tax_rate = `Avg. Local Tax Rate`,
    max_local = `Max Local`,
    combined_tax_rate = `Combined Tax Rate`,
    combined_rank = `Combined Rank`
  ) |>
  # Remove blank rows and source notes, retaining zero-tax states and D.C.
  filter(!is.na(state_tax_rate)) |>
  mutate(
    state = str_remove(state, "\\s+\\([a-z]\\)$"),
    # Convert fractions to percentage units, matching the 2025 CSV precision.
    across(c(state_tax_rate, max_local), ~ round(.x * 100, 3)),
    across(c(avg_local_tax_rate, combined_tax_rate), ~ round(.x * 100, 2))
  )

write_csv(
  sales_taxes,
  here::here("_data", "sales-taxes-26", "sales-taxes-26.csv"),
  na = "NA"
)

write_csv(
  sales_taxes,
  here::here("slides/data", "sales-taxes-26.csv"),
  na = "NA"
)

write_csv(
  sales_taxes,
  here::here("ae/data", "sales-taxes-26.csv"),
  na = "NA"
)
