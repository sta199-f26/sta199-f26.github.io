# AE 04: Sales taxes + data joining

Suggested answers

Application exercise

Answers

> **IMPORTANT:**
>
> These are suggested answers. This document should be used as a reference only; it’s not designed to be an exhaustive key.

# Getting started

## Packages

We’ll use the **tidyverse** package for this analysis.

``` downlit
library(tidyverse)
```

## Data

The data are available in the `data` folder.

``` downlit
sales_taxes <- read_csv("data/sales-taxes-26.csv")
us_regions <- read_csv("data/us-regions.csv")
```

And let’s take a look at the data.

``` downlit
glimpse(sales_taxes)
```

    Rows: 51
    Columns: 7
    $ state              <chr> "Alabama", "Alaska", "Arizona", "Arkansas", "Califo…
    $ state_tax_rate     <dbl> 4.000, 0.000, 5.600, 6.500, 7.250, 2.900, 6.350, 0.…
    $ state_tax_rank     <dbl> 40, 46, 28, 9, 1, 45, 12, 46, 17, 40, 40, 17, 13, 2…
    $ avg_local_tax_rate <dbl> 5.46, 1.82, 2.92, 2.96, 1.74, 4.99, 0.00, 0.00, 0.9…
    $ max_local          <dbl> 11.000, 7.850, 5.300, 6.125, 5.250, 9.100, 0.000, 0…
    $ combined_tax_rate  <dbl> 9.46, 1.82, 8.52, 9.46, 8.99, 7.89, 6.35, 0.00, 6.9…
    $ combined_rank      <dbl> 5, 46, 11, 4, 7, 16, 33, 47, 28, 18, 45, 37, 8, 24,…

``` downlit
glimpse(us_regions)
```

    Rows: 50
    Columns: 2
    $ state_name <chr> "Maine", "New Hampshire", "Vermont", "Massachusetts", "Rhod…
    $ region     <chr> "Northeast", "Northeast", "Northeast", "Northeast", "Northe…

# Joining

Join the sales tax data with region data and save the joined data frame as a new data frame, not overwriting either data frame that goes into the join.

``` downlit
sales_taxes_regions <- left_join(
  sales_taxes,
  us_regions,
  by = join_by(state == state_name)
)
```

Calculate the average sales tax of states in each region. What is surprising in the output?

``` downlit
sales_taxes_regions |>
  group_by(region) |>
  summarize(mean_state_tax = mean(state_tax_rate))
```

    # A tibble: 5 × 2
      region    mean_state_tax
      <chr>              <dbl>
    1 Midwest             5.69
    2 Northeast           5.30
    3 South               5.27
    4 West                4.16
    5 <NA>                6   

Identify the state with `NA` for region.

``` downlit
sales_taxes_regions |>
  filter(is.na(region)) |>
  select(state, region)
```

    # A tibble: 1 × 2
      state                region
      <chr>                <chr> 
    1 District of Columbia <NA>  

Suprised? You shouldn’t be… Read [here](https://en.wikipedia.org/wiki/No_taxation_without_representation#District_of_Columbia) for more information on why you shouldn’t be surprised.

Apply a fix for the `NA` in region, and calculate the mean sales taxes for regions again. Display the results in ascending order of mean sales tax.

``` downlit
sales_taxes_regions <- sales_taxes_regions |>
  mutate(
    region = if_else(state == "District of Columbia", "Northeast", region)
  )

sales_taxes_regions |>
  group_by(region) |>
  summarize(mean_state_tax = mean(state_tax_rate)) |>
  arrange(mean_state_tax)
```

    # A tibble: 4 × 2
      region    mean_state_tax
      <chr>              <dbl>
    1 West                4.16
    2 South               5.27
    3 Northeast           5.37
    4 Midwest             5.69

# Joining another way

Accomplish the same task using a different join this time.

``` downlit
sales_taxes_regions_2 <- right_join(
  us_regions,
  sales_taxes,
  by = join_by(state_name == state)
)

sales_taxes_regions_2 <- sales_taxes_regions_2 |>
  mutate(
    region = if_else(state_name == "District of Columbia", "Northeast", region)
  )

sales_taxes_regions_2 |>
  group_by(region) |>
  summarize(mean_state_tax = mean(state_tax_rate)) |>
  arrange(mean_state_tax)
```

    # A tibble: 4 × 2
      region    mean_state_tax
      <chr>              <dbl>
    1 West                4.16
    2 South               5.27
    3 Northeast           5.37
    4 Midwest             5.69
