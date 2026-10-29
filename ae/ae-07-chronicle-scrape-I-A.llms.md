# AE 07: 500 recent opinion articles in The Chronicle

Suggested answers

Application exercise

Answers

> **IMPORTANT:**
>
> These are suggested answers. This document should be used as reference only, it’s not designed to be an exhaustive key.

## Part 1 - Data scraping

See [`ae-07-chronicle-scrape-I-A.R`](_ae-07-chronicle-scrape-I-A.R) for suggested scraping code.

## Part 2 - Data analysis

Let’s start by loading the packages we will need:

``` downlit
library(tidyverse)
```

- Load the data you saved into the `data` folder and name it `chronicle`.

``` downlit
chronicle <- read_csv("data/chronicle-2026-09-29.csv")
```

- How many opinion articles were published in The Chronicle since the beginning of the semester?

``` downlit
chronicle |>
  filter(date >= ymd("2026-08-24")) |>
  nrow()
```

    [1] 10

- Who are the top 10 most prolific authors among the 500 most recent opinion articles and how many articles have they each published?

``` downlit
chronicle |>
  count(author, sort = TRUE)
```

    # A tibble: 201 × 2
       author             n
       <chr>          <int>
     1 Luke A. Powery    32
     2 Anna Garziera     24
     3 Monday Monday     22
     4 Leo Goldberg      19
     5 Remembrances      19
     6 Aaron Siegle      14
     7 Robert Wallace    12
     8 Wendy House        9
     9 Adam Levin         8
    10 Alex Berkman       8
    # ℹ 191 more rows

- Display the date, title, and author of any article(s) that mention AI in their title.

``` downlit
chronicle |>
  filter(str_detect(title, "AI")) |>
  select(date, title, author)
```

    # A tibble: 7 × 3
      date       title                                                     author   
      <date>     <chr>                                                     <chr>    
    1 2026-06-19 Scott Dyreng’s AI classroom: Actually, we liked it.       The Stud…
    2 2026-04-09 AI for medical diagnosis: Where does Duke stand?          Anagha G…
    3 2026-03-26 Faculty oversight is a necessity for AI at Duke           Robin Ki…
    4 2026-03-25 Dear professors, stop force feeding us AI                 Wendy Ho…
    5 2026-03-04 No, actually: ‘AI in the humanities’ is not our advantage Anna Sor…
    6 2025-09-24 The unfed mind devours itself: Duke has an AI problem     Wendy Ho…
    7 2025-02-27 My losing battle against AI cheating                      Orin Sta…

- Come up with another question and try to answer it using the data.

``` downlit
# add code here
```
