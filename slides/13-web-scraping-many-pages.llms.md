# Web scraping many pages (and coding with AI!)

Lecture 13

Author

Affiliation

Prof. Mine Çetinkaya-Rundel

Duke University\
STA 199 - Fall 2026

Published

October 14, 2026

# Warm-up

## While you wait: Participate 📱💻

The following code in `chronicle-scrape.R` extracts titles of an opinion article from The Chronicle website:

``` downlit
page <- read_html(
  "https://www2.stat.duke.edu/~cr173/data/dukechronicle-opinion/www.dukechronicle.com/section/opinionabc4.html"
)

titles <- page |>
  html_elements("#__snw-main-content .text-xl") |>
  html_text()
```

Which of the following needs to change to extract column titles instead?

- Change the URL in `read_html()`
- Change the function `html_elements()` to `html_element()`
- Change the CSS selector `#__snw-main-content .text-xl` to `.space-y-4 .text-brand`
- Change the function `html_text()` to `html_attr()`

[![QR code for Wooclap](images/13/wooclap-qr.png)](images/13/wooclap-qr.png)

Go to [wooclap.com](https://app.wooclap.com/OKZKXCY) and use the code OKZKXCY.

## Announcements

- (Optional) Midsemester course feedback form due tomorrow at 11:59pm

- Read Project milestone 3 instructions before lab tomorrow

- Peer eval 2 will be open tomorrow, due Monday

- Exam 1 grades are posted on Gradescope (with feedback) and on Canvas

  - See Gradescope for feedback on your exam
  - Exam questions posted on Canvas for review
  - If you want your specific paper (the one you wrote on), I *may* be able to put it together for you, but everything you need is already posted
  - Regrade requests: We will regrade your whole exam, points could go up or down or not change, usual regrade timeline (1 week from release date) applies

## Participate 📱💻

Put the following tasks in order to scrape data from a website:

- Use the SelectorGadget identify tags for elements you want to grab
- Use `read_html()` to read the page’s source code into R
- Use other functions from the **rvest** package to parse the elements you’re interested in
- Put the components together in a data frame (a tibble) and analyze it like you analyze any other data

[![QR code for Wooclap](images/13/wooclap-qr.png)](images/13/wooclap-qr.png)

Go to [wooclap.com](https://app.wooclap.com/OKZKXCY) and use the code OKZKXCY.

## A new R workflow

- When working in a Quarto document, your analysis is re-run each time you knit

- If web scraping in a Quarto document, you’d be re-scraping the data each time you knit, which is undesirable (and not *nice*)!

- An alternative workflow:

  - Use an R script to save your code
  - Saving interim data scraped using the code in the script as CSV or RDS files
  - Use the saved data in your analysis in your Quarto document

## Where we left off…

``` numberSource
# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)
library(polite)

# check that we can scrape data from the chronicle -----------------------------

bow("https://www.dukechronicle.com/section/opinion?page=1&per_page=500")

# read page --------------------------------------------------------------------
# read from local copy of the site

page <- read_html(
  "https://www2.stat.duke.edu/~cr173/data/dukechronicle-opinion/www.dukechronicle.com/section/opinionabc4.html"
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

chronicle <- chronicle_raw |>
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
      "https://www2.stat.duke.edu/~cr173/data/dukechronicle-opinion/www.dukechronicle.com",
      url
    )
  ) |>
  select(title, author, date_time, date, month, day, column, url)

# write data -------------------------------------------------------------------

write_csv(chronicle, file = "data/chronicle-2026-09-29.csv")
```

# Data cleaning review

## `chronicle_raw`

``` downlit
chronicle_raw
```

    # A tibble: 500 × 4
       title                                           author_date_time column url  
       <chr>                                           <chr>            <chr>  <chr>
     1 Find your tree                                  "Arnav Jain\n|\… Opini… ../a…
     2 ‘I hate Barack Obama’: Mitt Romney encourages … "Monday Monday\… Opini… ../a…
     3 Duke’s Roots of Faith                           "Luke A. Powery… Opini… ../a…
     4 Music’s connection to the self and the past     "Robert Wallace… Opini… ../a…
     5 Response to the DukeEngage Ghana Revelations    "Charles D. Pio… Opini… ../a…
     6 Sacrality of the University                     "Luke A. Powery… Opini… ../a…
     7 The Chronicle’s Board of Directors supports st… "Duke Student P… Opini… ../a…
     8 Do you                                          "Luke A. Powery… Opini… ../a…
     9 Community members share remembrances for Alex … "Remembrances\n… Opini… ../a…
    10 The Chronicle is accepting remembrances for Al… "Remembrances\n… Opini… ../a…
    # ℹ 490 more rows

## `author_date_time`

``` downlit
chronicle_raw |>
  select(author_date_time)
```

    # A tibble: 500 × 1
       author_date_time                                                 
       <chr>                                                            
     1 "Arnav Jain\n|\nSep 29, 2026, 12:00 PM"                          
     2 "Monday Monday\n|\nSep 28, 2026, 9:42 PM"                        
     3 "Luke A. Powery\n|\nSep 28, 2026, 2:36 PM"                       
     4 "Robert Wallace\n|\nSep 24, 2026, 10:00 AM"                      
     5 "Charles D. Piot\n|\nSep 23, 2026, 8:27 PM"                      
     6 "Luke A. Powery\n|\nSep 15, 2026, 2:19 AM"                       
     7 "Duke Student Publishing Company Board\n|\nSep 5, 2026, 12:37 AM"
     8 "Luke A. Powery\n|\nAug 31, 2026, 1:57 PM"                       
     9 "Remembrances\n|\nAug 30, 2026, 4:29 PM"                         
    10 "Remembrances\n|\nAug 28, 2026, 12:00 PM"                        
    # ℹ 490 more rows

## `author` and `date_time`

``` downlit
chronicle_1 <- chronicle_raw |>
  separate_wider_delim(
    author_date_time,
    delim = "\n|\n",
    names = c("author", "date_time"),
  ) |>
  relocate(author, date_time)

chronicle_1
```

    # A tibble: 500 × 5
       author                                date_time            title column url  
       <chr>                                 <chr>                <chr> <chr>  <chr>
     1 Arnav Jain                            Sep 29, 2026, 12:00… Find… Opini… ../a…
     2 Monday Monday                         Sep 28, 2026, 9:42 … ‘I h… Opini… ../a…
     3 Luke A. Powery                        Sep 28, 2026, 2:36 … Duke… Opini… ../a…
     4 Robert Wallace                        Sep 24, 2026, 10:00… Musi… Opini… ../a…
     5 Charles D. Piot                       Sep 23, 2026, 8:27 … Resp… Opini… ../a…
     6 Luke A. Powery                        Sep 15, 2026, 2:19 … Sacr… Opini… ../a…
     7 Duke Student Publishing Company Board Sep 5, 2026, 12:37 … The … Opini… ../a…
     8 Luke A. Powery                        Aug 31, 2026, 1:57 … Do y… Opini… ../a…
     9 Remembrances                          Aug 30, 2026, 4:29 … Comm… Opini… ../a…
    10 Remembrances                          Aug 28, 2026, 12:00… The … Opini… ../a…
    # ℹ 490 more rows

## `date_time`

``` downlit
chronicle_2 <- chronicle_1 |>
  mutate(date_time = mdy_hm(date_time)) |>
  relocate(date_time)

chronicle_2
```

    # A tibble: 500 × 5
       date_time           author                                title  column url  
       <dttm>              <chr>                                 <chr>  <chr>  <chr>
     1 2026-09-29 12:00:00 Arnav Jain                            Find … Opini… ../a…
     2 2026-09-28 21:42:00 Monday Monday                         ‘I ha… Opini… ../a…
     3 2026-09-28 14:36:00 Luke A. Powery                        Duke’… Opini… ../a…
     4 2026-09-24 10:00:00 Robert Wallace                        Music… Opini… ../a…
     5 2026-09-23 20:27:00 Charles D. Piot                       Respo… Opini… ../a…
     6 2026-09-15 02:19:00 Luke A. Powery                        Sacra… Opini… ../a…
     7 2026-09-05 00:37:00 Duke Student Publishing Company Board The C… Opini… ../a…
     8 2026-08-31 13:57:00 Luke A. Powery                        Do you Opini… ../a…
     9 2026-08-30 16:29:00 Remembrances                          Commu… Opini… ../a…
    10 2026-08-28 12:00:00 Remembrances                          The C… Opini… ../a…
    # ℹ 490 more rows

## Date and time columns

``` downlit
chronicle_3 <- chronicle_2 |>
  mutate(
    month = month(date_time, label = TRUE),
    day = day(date_time),
    year = year(date_time),
    date = make_date(year, month, day),
  ) |>
  relocate(month, day, year, date)

chronicle_3
```

    # A tibble: 500 × 9
       month   day  year date       date_time           author    title column url  
       <ord> <int> <dbl> <date>     <dttm>              <chr>     <chr> <chr>  <chr>
     1 Sep      29  2026 2026-09-29 2026-09-29 12:00:00 Arnav Ja… Find… Opini… ../a…
     2 Sep      28  2026 2026-09-28 2026-09-28 21:42:00 Monday M… ‘I h… Opini… ../a…
     3 Sep      28  2026 2026-09-28 2026-09-28 14:36:00 Luke A. … Duke… Opini… ../a…
     4 Sep      24  2026 2026-09-24 2026-09-24 10:00:00 Robert W… Musi… Opini… ../a…
     5 Sep      23  2026 2026-09-23 2026-09-23 20:27:00 Charles … Resp… Opini… ../a…
     6 Sep      15  2026 2026-09-15 2026-09-15 02:19:00 Luke A. … Sacr… Opini… ../a…
     7 Sep       5  2026 2026-09-05 2026-09-05 00:37:00 Duke Stu… The … Opini… ../a…
     8 Aug      31  2026 2026-08-31 2026-08-31 13:57:00 Luke A. … Do y… Opini… ../a…
     9 Aug      30  2026 2026-08-30 2026-08-30 16:29:00 Remembra… Comm… Opini… ../a…
    10 Aug      28  2026 2026-08-28 2026-08-28 12:00:00 Remembra… The … Opini… ../a…
    # ℹ 490 more rows

## `column`

``` downlit
chronicle_3 |>
  select(column)
```

    # A tibble: 500 × 1
       column                 
       <chr>                  
     1 Opinion                
     2 Opinion | Campus Voices
     3 Opinion | Campus Voices
     4 Opinion | Campus Voices
     5 Opinion                
     6 Opinion | Campus Voices
     7 Opinion                
     8 Opinion | Campus Voices
     9 Opinion | Campus Voices
    10 Opinion | Campus Voices
    # ℹ 490 more rows

## `column`

``` downlit
chronicle_4 <- chronicle_3 |>
  separate_wider_delim(
    column,
    delim = " | ",
    names = c("column_1", "column_2"),
    too_few = "align_start"
  ) |>
  relocate(column_1, column_2)

chronicle_4
```

    # A tibble: 500 × 10
       column_1 column_2     month   day  year date       date_time           author
       <chr>    <chr>        <ord> <int> <dbl> <date>     <dttm>              <chr> 
     1 Opinion  <NA>         Sep      29  2026 2026-09-29 2026-09-29 12:00:00 Arnav…
     2 Opinion  Campus Voic… Sep      28  2026 2026-09-28 2026-09-28 21:42:00 Monda…
     3 Opinion  Campus Voic… Sep      28  2026 2026-09-28 2026-09-28 14:36:00 Luke …
     4 Opinion  Campus Voic… Sep      24  2026 2026-09-24 2026-09-24 10:00:00 Rober…
     5 Opinion  <NA>         Sep      23  2026 2026-09-23 2026-09-23 20:27:00 Charl…
     6 Opinion  Campus Voic… Sep      15  2026 2026-09-15 2026-09-15 02:19:00 Luke …
     7 Opinion  <NA>         Sep       5  2026 2026-09-05 2026-09-05 00:37:00 Duke …
     8 Opinion  Campus Voic… Aug      31  2026 2026-08-31 2026-08-31 13:57:00 Luke …
     9 Opinion  Campus Voic… Aug      30  2026 2026-08-30 2026-08-30 16:29:00 Remem…
    10 Opinion  Campus Voic… Aug      28  2026 2026-08-28 2026-08-28 12:00:00 Remem…
    # ℹ 490 more rows
    # ℹ 2 more variables: title <chr>, url <chr>

## `column`

``` downlit
chronicle_5 <- chronicle_4 |>
  mutate(column = if_else(is.na(column_2), column_1, column_2)) |>
  relocate(starts_with("column"))

chronicle_5
```

    # A tibble: 500 × 11
       column_1 column_2     column month   day  year date       date_time          
       <chr>    <chr>        <chr>  <ord> <int> <dbl> <date>     <dttm>             
     1 Opinion  <NA>         Opini… Sep      29  2026 2026-09-29 2026-09-29 12:00:00
     2 Opinion  Campus Voic… Campu… Sep      28  2026 2026-09-28 2026-09-28 21:42:00
     3 Opinion  Campus Voic… Campu… Sep      28  2026 2026-09-28 2026-09-28 14:36:00
     4 Opinion  Campus Voic… Campu… Sep      24  2026 2026-09-24 2026-09-24 10:00:00
     5 Opinion  <NA>         Opini… Sep      23  2026 2026-09-23 2026-09-23 20:27:00
     6 Opinion  Campus Voic… Campu… Sep      15  2026 2026-09-15 2026-09-15 02:19:00
     7 Opinion  <NA>         Opini… Sep       5  2026 2026-09-05 2026-09-05 00:37:00
     8 Opinion  Campus Voic… Campu… Aug      31  2026 2026-08-31 2026-08-31 13:57:00
     9 Opinion  Campus Voic… Campu… Aug      30  2026 2026-08-30 2026-08-30 16:29:00
    10 Opinion  Campus Voic… Campu… Aug      28  2026 2026-08-28 2026-08-28 12:00:00
    # ℹ 490 more rows
    # ℹ 3 more variables: author <chr>, title <chr>, url <chr>

## `url`

``` downlit
chronicle_5 |>
  select(url)
```

    # A tibble: 500 × 1
       url                                                                
       <chr>                                                              
     1 ../article/find-your-tree-20260929.html                            
     2 ../article/20260928-mondaymonday-20260928.html                     
     3 ../article/20260928-lukepowery-20260928.html                       
     4 ../article/musics-connection-to-the-self-and-the-past-20260924.html
     5 ../article/response-dukeengage-ghana-20260923.html                 
     6 ../article/20260914-lukepowery-20260915.html                       
     7 ../article/20260409-dukestudentboard-20260905.html                 
     8 ../article/lukepowery-doyou-20260831.html                          
     9 ../article/20260830-alexdittarcommunity-20260830.html              
    10 ../article/20260827-remembrances-alex-dittmar-20260828.html        
    # ℹ 490 more rows

## `url`

``` downlit
chronicle_6 <- chronicle_5 |>
  mutate(
    url = str_replace(
      url,
      "..",
      "https://www2.stat.duke.edu/~cr173/data/dukechronicle-opinion/www.dukechronicle.com"
    )
  ) |>
  relocate(url)

chronicle_6
```

    # A tibble: 500 × 11
       url                     column_1 column_2 column month   day  year date      
       <chr>                   <chr>    <chr>    <chr>  <ord> <int> <dbl> <date>    
     1 https://www2.stat.duke… Opinion  <NA>     Opini… Sep      29  2026 2026-09-29
     2 https://www2.stat.duke… Opinion  Campus … Campu… Sep      28  2026 2026-09-28
     3 https://www2.stat.duke… Opinion  Campus … Campu… Sep      28  2026 2026-09-28
     4 https://www2.stat.duke… Opinion  Campus … Campu… Sep      24  2026 2026-09-24
     5 https://www2.stat.duke… Opinion  <NA>     Opini… Sep      23  2026 2026-09-23
     6 https://www2.stat.duke… Opinion  Campus … Campu… Sep      15  2026 2026-09-15
     7 https://www2.stat.duke… Opinion  <NA>     Opini… Sep       5  2026 2026-09-05
     8 https://www2.stat.duke… Opinion  Campus … Campu… Aug      31  2026 2026-08-31
     9 https://www2.stat.duke… Opinion  Campus … Campu… Aug      30  2026 2026-08-30
    10 https://www2.stat.duke… Opinion  Campus … Campu… Aug      28  2026 2026-08-28
    # ℹ 490 more rows
    # ℹ 3 more variables: date_time <dttm>, author <chr>, title <chr>

## Select relevant columns

``` downlit
chronicle <- chronicle_6 |>
  select(title, author, date_time, date, month, day, column, url)

chronicle
```

    # A tibble: 500 × 8
       title          author date_time           date       month   day column url  
       <chr>          <chr>  <dttm>              <date>     <ord> <int> <chr>  <chr>
     1 Find your tree Arnav… 2026-09-29 12:00:00 2026-09-29 Sep      29 Opini… http…
     2 ‘I hate Barac… Monda… 2026-09-28 21:42:00 2026-09-28 Sep      28 Campu… http…
     3 Duke’s Roots … Luke … 2026-09-28 14:36:00 2026-09-28 Sep      28 Campu… http…
     4 Music’s conne… Rober… 2026-09-24 10:00:00 2026-09-24 Sep      24 Campu… http…
     5 Response to t… Charl… 2026-09-23 20:27:00 2026-09-23 Sep      23 Opini… http…
     6 Sacrality of … Luke … 2026-09-15 02:19:00 2026-09-15 Sep      15 Campu… http…
     7 The Chronicle… Duke … 2026-09-05 00:37:00 2026-09-05 Sep       5 Opini… http…
     8 Do you         Luke … 2026-08-31 13:57:00 2026-08-31 Aug      31 Campu… http…
     9 Community mem… Remem… 2026-08-30 16:29:00 2026-08-30 Aug      30 Campu… http…
    10 The Chronicle… Remem… 2026-08-28 12:00:00 2026-08-28 Aug      28 Campu… http…
    # ℹ 490 more rows

Next step:\
Article text
============

## Plan

- Write a function that takes a URL and returns the article text on that page (then test it on a page)

- Run the function on each page in the `chronicle` data frame (but start by testing it on a few pages)

- Save the results in a new column in the `chronicle` data frame

## Demo

- Go to your ae project in Positron.

- If you haven’t yet done so, make sure all of your changes up to this point are committed and pushed, i.e., there’s nothing left in your source control pane.

- Pull to get today’s application exercise file: `ae-08-chronicle-scrape-II.R`.

- Then, close your laptop, and watch me demo the next few step.

# The 🐘 in the room

## Go for it

ask the question you want to ask!

\

If AI can do all of this, why do I need to learn how to do it myself?

## Another demo

Let’s try something simple…

- Create a scatterplot of miles per gallon vs. displacement in mtcars, and overlay the best fit line for predicting mpg from displacement.

- Now limit to cars with displacement below 200.

# Working with AI

## Codex as a coding collaborator

Codex can…

- Read the active file and related project files

- Use existing functions and coding conventions

- Edit files directly

- Run code and report results

- Revise its work after feedback

Codex can take actions, but **you** define success and decide what evidence is sufficient.

## Give it a concrete task

> Use the `scrape_article()` function in `ae-08-chronicle-scrape-II.R` and tidyverse to add a column to the `chronicle` data frame called article content with the content of the articles from each page.

. . .

Why is this a useful prompt?

- Names the file and existing function
- Names the preferred syntax
- Names the data frame
- Describes the desired output
- Provides enough context to inspect the project

## Inspect the generated code

``` downlit
chronicle <- chronicle |>
  mutate(article_content = map_chr(url, scrape_article))
```

. . .

`map_chr()` applies `scrape_article()` to every URL and requires the function to return one character value per row.

Is generating syntactically valid code enough?

## Writing code \\\neq\\ verifying code

> **Human:** Did you run this code to confirm it works?

> **Codex:** No. I only confirmed that the script parses without syntax errors.

. . .

**Parsing**

Is the syntax valid?

**Execution**

Does the code run?

**Validation**

Is the output correct?

## Test small before scaling up

> Try it with the first three rows of the data frame to test if it works.

``` downlit
chronicle_test <- chronicle |>
  slice_head(n = 3) |>
  mutate(
    article_content = map_chr(url, scrape_article)
  )
```

## Ask for evidence in the prompt

**Basic:**

> Add the article content column.

. . .

**Better:**

> Use `scrape_article()` and tidyverse to add an `article_content` column to `chronicle`. Test it on the first three rows before running it on the complete data. Confirm that the results are non-missing and non-empty. Do not overwrite the input data frame or the CSV during the test.

. . .

**Context + task + constraints + verification + reporting**

## The human remains responsible

You need enough knowledge to…

- Describe the intended computation
- Understand and inspect the generated code
- Design a meaningful test
- Recognize implausible output
- Diagnose failures
- Consider responsible scraping practices
- Decide when the evidence is strong enough to proceed

AI can produce code quickly. Statistical and computational knowledge lets you decide whether that code answers the right question – and whether it actually works.

## How does Codex know how to work?

### `AGENTS.md`

- Persistent instructions for a repository
- Describes project conventions, expectations, and checks
- Read by Codex before it begins working

**How to work in this project**

### Skills

- Reusable instructions for a particular kind of task
- Loaded when requested or when the task matches
- Can include scripts, references, and assets

**How to do this kind of task**

> **IMPORTANT:**
>
> Homework and lab repositories in this class, as well as the course project, use `AGENTS.md` files. Codex reads them – and you should too!

[`AGENTS.md` documentation](https://learn.chatgpt.com/docs/agent-configuration/agents-md) · [Skills documentation](https://learn.chatgpt.com/docs/build-skills)
