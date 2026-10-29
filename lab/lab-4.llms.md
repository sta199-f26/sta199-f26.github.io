# Lab 4

JOINing the Olympic Gymnastics Committee

Lab

Due: End of lab on Thurs, Sep 24

> **IMPORTANT:**
>
> … and sit with them!

# Introduction

In honor of [National Gymnastics Day](https://usagym.org/ngd/) this past week, you will work with real gymnastics data from the 2024 Paris Olympics! You will first practice bringing two data frames together with join functions, then work through a small exercise on factors.

Make sure to upload your completed lab to Gradescope **by the end of your lab session** and commit and push your final version to GitHub.

## Learning objectives

By the end of this lab, you will:

- Combine two data frames with [`left_join()`](https://dplyr.tidyverse.org/reference/mutate-joins.html), [`right_join()`](https://dplyr.tidyverse.org/reference/mutate-joins.html), [`inner_join()`](https://dplyr.tidyverse.org/reference/mutate-joins.html), [`full_join()`](https://dplyr.tidyverse.org/reference/mutate-joins.html), and [`anti_join()`](https://dplyr.tidyverse.org/reference/filter-joins.html).
- Specify join keys with [`join_by()`](https://dplyr.tidyverse.org/reference/join_by.html) when the key columns have different names.
- Predict how many rows and columns a join will produce, and explain why.
- Convert a character variable to a factor and reorder its levels with [`fct_relevel()`](https://forcats.tidyverse.org/reference/fct_relevel.html).
- Distinguish between the underlying type and the class of a factor.

# Getting started

Clone your **lab-4** repository using the same process used in Lab 0. By now you should know the drill, so we won’t repeat it here again. If you have any trouble, please ask your TA for help.

We also won’t repeat the guidelines, but you can refer to a [previous lab](../lab/lab-3.llms.md#guidelines) to review them.

## Packages

In this lab we will work with the **tidyverse** package.

``` downlit
library(tidyverse)
```

Run the code cell to load the packages.

# Part 1

For Part 1 of this lab, you will work with two small data frames (`paris_scores` and `noc_codes`) and join them with various join functions.

- `paris_scores`: Team final balance beam and floor exercise scores for four gymnasts.

  ``` downlit
  paris_scores <- tribble(
    ~gymnast         , ~balance_beam , ~floor_exercise ,
    "Simone Biles"   , 14.40         , 14.70           ,
    "Sunisa Lee"     , 14.60         , 13.50           ,
    "Rebeca Andrade" , 14.10         , 14.20           ,
    "Jordan Chiles"  , 12.70         , 14.00
  )

  paris_scores
  ```

      # A tibble: 4 × 3
        gymnast        balance_beam floor_exercise
        <chr>                 <dbl>          <dbl>
      1 Simone Biles           14.4           14.7
      2 Sunisa Lee             14.6           13.5
      3 Rebeca Andrade         14.1           14.2
      4 Jordan Chiles          12.7           14  

  > **NOTE:**
  > The [`tribble()`](https://tibble.tidyverse.org/reference/tribble.html) function is helpful for creating small data frames (`tibble`s) with an easier to read row-by-row layout.

- `noc_codes`: 3-letter National Olympic Committee (NOC) code of the country each of four gymnasts competed for.

  ``` downlit
  noc_codes <- tribble(
    ~gymnast_name    , ~country_code ,
    "Simone Biles"   , "USA"         ,
    "Rebeca Andrade" , "BRA"         ,
    "Kaylia Nemour"  , "ALG"         ,
    "Qiyuan Qiu"     , "CHN"
  )

  noc_codes
  ```

      # A tibble: 4 × 2
        gymnast_name   country_code
        <chr>          <chr>       
      1 Simone Biles   USA         
      2 Rebeca Andrade BRA         
      3 Kaylia Nemour  ALG         
      4 Qiyuan Qiu     CHN         

## Question 1

1.  Your friend writes the following code to join the `paris_scores` and `noc_codes` data frames and gets an error message:

    ``` downlit
    paris_scores |>
      left_join(noc_codes)
    ```

        Error in `left_join()`:
        ! `by` must be supplied when `x` and `y` have no common variables.
        ℹ Use `cross_join()` to perform a cross-join.

    What does the error message mean and why does it occur? How would you fix the code?

2.  How many rows and columns does the resulting data frame from part (a) have? Explain why.

## Question 2

1.  Don’t write any code yet: Suppose you join the two data frames, `paris_scores` and `noc_codes`, with a [`right_join()`](https://dplyr.tidyverse.org/reference/mutate-joins.html), in that order. How many rows and columns would the resulting data frame have? Then, write the code to perform the join. If your guess wasn’t correct, discuss with your teammates before proceeding.

2.  Start with the code this time. Join the two data frames, `paris_scores` and `noc_codes`, with an [`inner_join()`](https://dplyr.tidyverse.org/reference/mutate-joins.html), in that order. How many rows and columns does the resulting data frame have? Explain why.

3.  Don’t write any code yet: Suppose you join the two data frames with an [`inner_join()`](https://dplyr.tidyverse.org/reference/mutate-joins.html) again, but in the reverse order (`noc_codes` first, then `paris_scores`). Would you expect the resulting data frame to have the same number of rows as the previous part or a different number of rows? Explain your reasoning. Then, write the code to perform the join. If your guess wasn’t correct, discuss with your teammates before proceeding.

4.  Don’t write any code yet: Suppose you join the two data frames, `paris_scores` and `noc_codes`, with an [`anti_join()`](https://dplyr.tidyverse.org/reference/filter-joins.html). Which gymnast(s) would be in the resulting data frame? Then, write the code to perform the join. If your guess wasn’t correct, discuss with your teammates before proceeding.

5.  Don’t write any code yet: Suppose you join the two data frames with an [`anti_join()`](https://dplyr.tidyverse.org/reference/filter-joins.html) again, but in the reverse order (`noc_codes` first, then `paris_scores`). Which gymnast(s) would be in the resulting data frame? Then, write the code to perform the join. If your guess wasn’t correct, discuss with your teammates before proceeding.

6.  Start with the code this time. Join the two data frames, `paris_scores` and `noc_codes`, with a [`full_join()`](https://dplyr.tidyverse.org/reference/mutate-joins.html), in that order. How many rows and columns does the resulting data frame have? Explain why.

7.  Your ultimate goal is to construct a dataset where you have all gymnasts who are in the `paris_scores` data frame along with their event scores and the country they competed for. In order to accomplish this, you will need to look up some gymnasts’ NOC codes in an alternate resource, since they’re not all in the `noc_codes` data frame. Which join function would you use to find out whose NOC codes you need to look up in an alternate resource? Write the code to perform the join to confirm your answer.

Preview, commit, and push your changes to GitHub with a meaningful commit message.

Make sure to commit and push all changed files so that your source control pane is empty afterward.

# Part 2

For Part 2 of this lab, you’ll work with a new dataset, `gymnastics`, which contains information about the routines performed by gymnasts in the women’s artistic gymnastics competition at the 2024 Paris Olympics. **Each row represents a single routine**, so a gymnast who competed on all four apparatus in qualification appears in at least four rows.

Read the data into R with:

``` downlit
gymnastics <- read_csv("data/gymnastics.csv")
```

``` downlit
glimpse(gymnastics)
```

    Rows: 561
    Columns: 10
    $ name         <chr> "Simone Biles", "Simone Biles", "Rebeca Andrade", "Rebeca…
    $ country      <chr> "United States", "United States", "Brazil", "Brazil", "Un…
    $ country_code <chr> "USA", "USA", "BRA", "BRA", "USA", "USA", "USA", "USA", "…
    $ event        <chr> "Vault", "Vault", "Vault", "Vault", "Vault", "Vault", "Va…
    $ competition  <chr> "Qualification", "Qualification", "Qualification", "Quali…
    $ d_score      <dbl> 6.4, 5.6, 5.6, 5.0, 5.6, 5.0, 5.0, 4.8, 5.4, 5.0, 5.0, 5.…
    $ e_score      <dbl> 9.400, 9.200, 9.400, 9.466, 9.166, 9.200, 9.333, 9.300, 9…
    $ penalty      <dbl> 0.0, 0.0, 0.1, 0.0, 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.…
    $ score        <dbl> 15.800, 14.800, 14.900, 14.466, 14.666, 14.200, 14.333, 1…
    $ rank         <dbl> 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10,…

The variables in this dataset are:

| Variable | Description |
|:---|:---|
| `name` | Gymnast’s name, in “Given Surname” order |
| `country` | Country name |
| `country_code` | 3-letter National Olympic Committee (NOC) code |
| `event` | Apparatus: Vault, Uneven Bars, Balance Beam, Floor Exercise |
| `competition` | Which round: Qualification, Team Final, All-Around Final, Event Final |
| `d_score` | Difficulty score (a number greater than zero, in increments of 0.1) |
| `e_score` | Execution score (a number between 0 and 10) |
| `penalty` | Neutral deduction |
| `score` | Routine total = `d_score` + `e_score` - `penalty` |
| `rank` | Placement for that row’s competition |

## Question 3

Olympic order is the specific order in which gymnasts compete the apparatus. Read about Olympic order in [this NBC Olympics explainer](https://www.nbcolympics.com/news/gymnastics-101-olympic-competition-format).

1.  Based on the article, provide the Olympic order of the events in women’s artistic gymnastics.

2.  Run the following code cell and analyze the result. Explain what the code does, and state why the events are listed in this order in the output.

``` downlit
gymnastics |>
  pull(event) |>
  as.factor() |>
  levels()
```

    [1] "Balance Beam"   "Floor Exercise" "Uneven Bars"    "Vault"         

3.  Write code to change the `event` variable so that its levels reflect Olympic order and save the new variable, with the same name, in the `gymnastics` data frame, i.e., overwrite the `gymnastics` data frame with the new version of the `event` variable. Then, write (or copy from above) code to display the new ordering.

4.  Before running any code, predict what each of the following two commands will return. Then run the code cell and check your predictions. Explain in a sentence or two why [`typeof()`](https://rdrr.io/r/base/typeof.html) and [`class()`](https://rdrr.io/r/base/class.html) return different things for a factor.

``` downlit
typeof(gymnastics$event)
class(gymnastics$event)
```

Preview, commit, and push your changes to GitHub with a meaningful commit message.

Make sure to commit and push all changed files so that your source control pane is empty afterward.

# Wrap-up

At this point, you should know the deal! If you don’t know how to submit your lab and how it will be graded, review a previous lab and/or ask your TA for help. And before then, make sure to run through the following checklist one last time.

> **IMPORTANT:**
>
> Make sure you have:
>
> - attempted every question;
> - previewed your Quarto document;
> - committed and pushed all final changes to GitHub, ending with no pending or staged changes in the Source Control pane; and
> - submitted your rendered PDF to Gradescope.
