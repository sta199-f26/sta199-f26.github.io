# AE 13: Houses in Duke Forest

In this application exercise, we will use bootstrapping to construct confidence intervals.

## Packages

We will use **tidyverse** and **tidymodels** for data exploration and modeling, respectively, and the **openintro** package for the data, and the **knitr** package for formatting tables.

``` downlit
library(tidyverse)
library(tidymodels)
library(openintro)
library(knitr)
```

## Data

The data are on houses that were sold in the Duke Forest neighborhood of Durham, NC around November 2020. It was originally scraped from Zillow, and can be found in the `duke_forest` data set in the **openintro** R package.

Take a [`glimpse()`](https://pillar.r-lib.org/reference/glimpse.html) at the data to see what variables are available.

``` downlit
glimpse(duke_forest)
```

    Rows: 98
    Columns: 13
    $ address    <chr> "1 Learned Pl, Durham, NC 27705", "1616 Pinecrest Rd, Durha…
    $ price      <dbl> 1520000, 1030000, 420000, 680000, 428500, 456000, 1270000, …
    $ bed        <dbl> 3, 5, 2, 4, 4, 3, 5, 4, 4, 3, 4, 4, 3, 5, 4, 5, 3, 4, 4, 3,…
    $ bath       <dbl> 4.0, 4.0, 3.0, 3.0, 3.0, 3.0, 5.0, 3.0, 5.0, 2.0, 3.0, 3.0,…
    $ area       <dbl> 6040, 4475, 1745, 2091, 1772, 1950, 3909, 2841, 3924, 2173,…
    $ type       <chr> "Single Family", "Single Family", "Single Family", "Single …
    $ year_built <dbl> 1972, 1969, 1959, 1961, 2020, 2014, 1968, 1973, 1972, 1964,…
    $ heating    <chr> "Other, Gas", "Forced air, Gas", "Forced air, Gas", "Heat p…
    $ cooling    <fct> central, central, central, central, central, central, centr…
    $ parking    <chr> "0 spaces", "Carport, Covered", "Garage - Attached, Covered…
    $ lot        <dbl> 0.97, 1.38, 0.51, 0.84, 0.16, 0.45, 0.94, 0.79, 0.53, 0.73,…
    $ hoa        <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
    $ url        <chr> "https://www.zillow.com/homedetails/1-Learned-Pl-Durham-NC-…

## Model

Fit a linear model predicting `price` from `area`, and display the model output in a neatly formatted table.

``` downlit
df_fit <- linear_reg() |>
  set_engine("lm") |>
  fit(price ~ area, data = duke_forest)

tidy(df_fit) |>
  kable(digits = 2)
```

| term        |  estimate | std.error | statistic | p.value |
|:------------|----------:|----------:|----------:|--------:|
| (Intercept) | 116652.33 |  53302.46 |      2.19 |    0.03 |
| area        |    159.48 |     18.17 |      8.78 |    0.00 |

## Bootstrap confidence interval

### 1. Calculate the observed fit (slope)

Using functions from the **infer** package, calculate the observed fit from the original sample. The slope from this fit is the point estimate we’ll build our confidence intervals around.

``` downlit
observed_fit <- duke_forest |>
  specify(price ~ area) |>
  fit()

observed_fit
```

    # A tibble: 2 × 2
      term      estimate
      <chr>        <dbl>
    1 intercept  116652.
    2 area          159.

### 2. Take *n* bootstrap samples and fit models to each one.

Fill in the code, then set `eval: true` .

``` r
n <- 1000
set.seed(20261123)

boot_fits <- ______ |>
  specify(______) |>
  generate(reps = ____, type = "bootstrap") |>
  fit()

boot_fits
```

- Make a histogram of the bootstrap samples to visualize the bootstrap distribution.

``` downlit
# add code here
```

- A handy shortcut to visualize the bootstrap distribution is to use the `visualize()` function from the **infer** package. Use it to visualize the bootstrap distribution.

``` downlit
# add code here
```

### Compute the 95% confidence interval

#### 3a. Percentile method

The percentile method constructs a confidence interval by taking the middle 95% of the bootstrap distribution of the slope.

Fill in the code, then set `eval: true` .

``` r
ci_percentile <- get_confidence_interval(
  boot_fits,
  point_estimate = _____,
  level = ____,
  type = "percentile"
)

ci_percentile
```

- Visualize the bootstrap distribution with the confidence interval shaded, by adding `shade_confidence_interval()` to the output of `visualize()`.

Fill in the code, then set `eval: true` .

``` r
visualize(boot_fits) +
  shade_confidence_interval(endpoints = ______)
```

#### 3b. Standard error method

Another way to construct a confidence interval is to go a certain number of standard errors away from the observed slope in each direction:

\\ \text{point estimate} \pm z^\* \times SE \\

where \\SE\\ is the **bootstrap standard error**, the standard deviation of the bootstrapped slopes, and \\z^\*\\ depends on the confidence level (about 2, more precisely 1.96, for a 95% confidence interval).

> **NOTE:**
>
> The bootstrap standard error is the standard deviation of the bootstrap distribution of the slope. It estimates the same thing as the `std.error` column in the regression output from `tidy(df_fit)`: how much the slope would vary from one sample to another. The difference is in how it’s calculated: the bootstrap standard error is calculated **computationally**, by resampling the data many times, while the `std.error` in the regression output is calculated with a **theoretical** (mathematical) formula.

- Calculate the bootstrap standard error as the standard deviation of the bootstrap distribution of the slope.

Fill in the code, then set `eval: true` .

``` r
boot_fits |>
  ungroup() |> # boot_fits is grouped by replicate, ungroup to summarize across all
  filter(term == "______") |>
  summarize(se = sd(______))
```

But you don’t need to directly calculate this, `get_confidence_interval()` can do it for you using the standard error method.

Fill in the code, then set `eval: true` .

``` r
ci_se <- get_confidence_interval(
  boot_fits,
  point_estimate = _____,
  level = ____,
  type = "______"
)

ci_se
```

- Visualize the confidence interval calculated with the standard error method on the bootstrap distribution, as you did for the percentile method.

``` downlit
# add code here
```

- Visualize both intervals on the same plot to compare them, with the standard error interval outlined in red and the percentile interval outlined in blue. Setting `fill = NULL` draws only the endpoints, without shading, so the two intervals don’t cover each other.

Fill in the code, then set `eval: true` .

``` r
visualize(boot_fits) +
  shade_confidence_interval(
    endpoints = ______,
    color = "red",
    fill = NULL
  ) +
  shade_confidence_interval(
    endpoints = ______,
    color = "blue",
    fill = NULL
  )
```

- How does this interval compare to the one you calculated with the percentile method in Step 3a?

*Add response here.*

## Changing confidence level

- Modify the code from Step 3a to create a 90% confidence interval.

``` downlit
# add code here
```

- Modify the code from Step 3a to create a 99% confidence interval.

``` downlit
# add code here
```

- Which confidence level produces the most accurate confidence interval (90%, 95%, 99%)? Explain

*Add your response here.*

- Which confidence level produces the most precise confidence interval (90%, 95%, 99%)? Explain

*Add your response here.*

- If we want to be very certain that we capture the population parameter, should we use a wider or a narrower interval? What drawbacks are associated with using a wider interval?

*Add your response here.*
