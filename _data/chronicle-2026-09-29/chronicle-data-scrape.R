# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)
library(polite)

# check that we can scrape data from the chronicle -----------------------------

bow("https://www.dukechronicle.com/section/opinion?page=1&per_page=500")

# scrape a single page ---------------------------------------------------------

scrape_chronicle_page <- function(page_number) {
  # read page --------------------------------------------------------------------
  # read from local copy of the site

  page <- read_html(
    str_glue(
      "https://www2.stat.duke.edu/~cr173/data/dukechronicle-opinion-paged/www.dukechronicle.com/section/opinion-page-{page_number}.html"
    )
  )

  # parse components -------------------------------------------------------------

  titles <- page |>
    html_elements("#__snw-main-content .text-xl") |>
    html_text()

  columns <- page |>
    html_elements(".space-y-4 .text-brand") |>
    html_text()

  authors_dates_times <- page |>
    html_elements(".space-y-4 .font-semibold") |>
    html_text2() |>
    str_remove("By ")

  urls <- page |>
    html_elements("#__snw-main-content .text-xl") |>
    html_attr(name = "href")

  # create a data frame ----------------------------------------------------------

  chronicle_raw <- tibble(
    # var name  = vector name
    title = titles,
    author_date_time = authors_dates_times,
    column = columns,
    url = urls
  )

  # clean up data ----------------------------------------------------------------

  chronicle_raw |>
    separate_wider_delim(
      author_date_time,
      delim = "\n|\n",
      names = c("author", "date_time"),
    ) |>
    separate_wider_delim(
      column,
      delim = " | ",
      names = c("column_1", "column_2"),
      too_few = "align_start"
    ) |>
    mutate(
      column = if_else(is.na(column_2), column_1, column_2),
      date_time = mdy_hm(date_time),
      month = month(date_time, label = TRUE),
      day = day(date_time),
      year = year(date_time),
      date = make_date(year, month, day),
      url = str_remove(url, ".."),
      url = paste0(
        "https://www2.stat.duke.edu/~cr173/data/dukechronicle-opinion-paged/www.dukechronicle.com",
        url
      )
    ) |>
    select(title, author, date_time, date, month, day, column, url) |>
    # scrape article paragraphs and combine them into one string per article
    mutate(
      article_text = map_chr(url, function(article_url) {
        read_html(article_url) |>
          html_elements(".article-content p") |>
          html_text2() |>
          str_c(collapse = "\n\n")
      })
    )
}

# scrape pages 1-25 and stack the data ------------------------------------------

chronicle <- map(1:25, scrape_chronicle_page) |>
  list_rbind()

chronicle |>
  relocate(article_text, .before = url) |>
  write_csv(
    "_data/chronicle-2026-09-29/chronicle-2026-09-29-with-article-text.csv"
  )

chronicle |>
  relocate(article_text, .before = url) |>
  write_csv(
    "slides/data/chronicle-2026-09-29-with-article-text.csv"
  )
