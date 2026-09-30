# fmt: skip

# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)
library(polite)

# check that we can scrape data from the chronicle -----------------------------

bow("https://www.dukechronicle.com/section/opinion?page=1&per_page=500")

# read page --------------------------------------------------------------------
# read from local copy of the site

page <- read_html(
  "https://www2.stat.duke.edu/~cr173/data/dukechronicle-opinion-paged/www.dukechronicle.com/section/opinion-page-1.html"
)

# parse components -------------------------------------------------------------

titles <- page |>
  html_elements("_______") |> # replace blank with selector
  html_text()

columns
# add code to grab elements corresponding to column names
# add code to retrieve text from those elements

# add code here to parse authors_dates_times

# add code to parse urls

# create a data frame ----------------------------------------------------------

chronicle_raw <- tibble(
  # var name  = vector name
  # add code here
)

# clean up data ----------------------------------------------------------------

chronicle <- chronicle_raw |>
  # separate author and date_time into two columns
  ___ |>
  # separate column_1 and column_2 into two columns
  ___ |>
  mutate(
    # make column be column_2 if it exists, otherwise column_1
    column = ___,
    # parse date_time into a date-time object
    date_time = ___,
    # extract month and day from date_time
    month = ___,
    day = ___,
    # create full url
    url = ___
  ) |>
  # select only relevant columns
  select(title, author, date_time, month, day, column, url)

# write data -------------------------------------------------------------------

# add code to write data to data folder
