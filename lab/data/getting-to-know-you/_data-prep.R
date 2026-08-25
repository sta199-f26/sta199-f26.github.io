library(tidyverse)

getting_to_know_you_raw <- read_csv(here::here(
  "lab",
  "data",
  "getting-to-know-you",
  "Getting to know you Survey Student Analysis Report.csv"
)) |>
  janitor::clean_names() |>
  select(
    section,
    x367964_have_you_taken_any_statistics_courses_before,
    x367965_how_much_experience_do_you_have_with_programming,
    x367967_how_do_you_learn_best_select_all_that_apply,
    x367977_what_types_of_data_interest_you_select_all_that_apply
  )

names(getting_to_know_you_raw) <- c(
  "section",
  "stats_exp",
  "prog_exp",
  "learn_best",
  "data_interest"
)

set.seed(1234)
getting_to_know_you <- getting_to_know_you_raw |>
  mutate(
    section = str_remove(section, "STA 199CCL.001.Fa26"),
    section = str_remove(section, ", "),
    section = str_trim(section),
    section = str_remove(section, "STA 199CCL."),
    section = str_remove(section, ".Fa26")
  ) |>
  # create separate learn_best columns that are binary for each element in learn_best separated by commas
  # note: options contain commas inside parentheses, so match on patterns instead of splitting
  mutate(
    learn_best_reading = str_detect(
      learn_best,
      fixed("Reading the textbook or written materials")
    ),
    learn_best_videos = str_detect(
      learn_best,
      fixed("Watching videos or lectures")
    ),
    learn_best_hands_on = str_detect(
      learn_best,
      fixed("Hands-on practice/exercises")
    ),
    learn_best_practice_problems = str_detect(
      learn_best,
      fixed("Working through practice problems on my own")
    ),
    learn_best_groups = str_detect(
      learn_best,
      fixed("Working in groups / discussing with classmates")
    ),
    learn_best_asking_questions = str_detect(
      learn_best,
      fixed("Asking questions and getting immediate feedback")
    ),
    learn_best_teaching = str_detect(
      learn_best,
      fixed("Explaining concepts to someone else / teaching others")
    )
  ) |>
  # same treatment for data_interest
  mutate(
    data_interest_crime = str_detect(data_interest, fixed("Crime")),
    data_interest_econ_business = str_detect(
      data_interest,
      fixed("Economics/Business")
    ),
    data_interest_entertainment = str_detect(
      data_interest,
      fixed("Entertainment")
    ),
    data_interest_environment = str_detect(
      data_interest,
      fixed("Environment/Climate")
    ),
    data_interest_health = str_detect(data_interest, fixed("Health")),
    data_interest_politics = str_detect(data_interest, fixed("Politics")),
    data_interest_sports = str_detect(data_interest, fixed("Sports")),
    # combine technology, education, no preference, and other into a single other column
    data_interest_other = str_detect(
      data_interest,
      "Technology|Education|No preference|Other"
    )
  ) |>
  select(!c(learn_best, data_interest)) |>
  sample_n(nrow(getting_to_know_you_raw)) |>
  mutate(anonymous_id = row_number(), .before = section)

write_csv(
  getting_to_know_you,
  here::here(
    "lab",
    "data",
    "getting-to-know-you",
    "getting-to-know-you.csv"
  )
)
