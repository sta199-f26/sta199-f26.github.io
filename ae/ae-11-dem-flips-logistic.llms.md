# AE 11: Predicting Dem flips

Application exercise

In this application exercise, we will

- Fit a logistic regression model for a binary response variable in R
- Use a logistic regression model to predict probabilities and classify new observations
- Compare logistic regression models using AIC

We will predict whether a U.S. House seat flipped to Democrat in the 2026 midterm elections, using data from Decision Desk HQ as of 2026-11-04 at 11:14 am. At that time, some races had been called and others had not. We’ll learn from the called races and make predictions for the uncalled ones.

``` downlit
library(tidyverse)
library(tidymodels)
```

``` downlit
midterm_26 <- read_csv("data/midterm-26.csv")
```

    Rows: 435 Columns: 19
    ── Column specification ────────────────────────────────────────────────────────
    Delimiter: ","
    chr (15): district, state_abb, state, house_rep_20, house_party_20, house_re...
    dbl  (4): harris_24, trump_24, margin_26, flip_dem_24_26

    ℹ Use `spec()` to retrieve the full column specification for this data.
    ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` downlit
glimpse(midterm_26)
```

    Rows: 435
    Columns: 19
    $ district       <chr> "AK-00", "AL-01", "AL-02", "AL-03", "AL-04", "AL-05", "…
    $ state_abb      <chr> "AK", "AL", "AL", "AL", "AL", "AL", "AL", "AL", "AR", "…
    $ state          <chr> "Alaska", "Alabama", "Alabama", "Alabama", "Alabama", "…
    $ house_rep_20   <chr> "Don Young", "Jerry Carl", "Barry Moore", "Mike Rogers"…
    $ house_party_20 <chr> "Republican", "Republican", "Republican", "Republican",…
    $ house_rep_22   <chr> "Mary Sattler Peltola", "Jerry L Carl", "Barry Moore", …
    $ house_party_22 <chr> "Democrat", "Republican", "Republican", "Republican", "…
    $ house_rep_24   <chr> "Nick Begich", "Barry Moore", "Shomari Figures", "Mike …
    $ house_party_24 <chr> "Republican", "Republican", "Democrat", "Republican", "…
    $ harris_24      <dbl> 41.41, 21.89, 53.52, 26.18, 15.96, 34.20, 29.68, 61.45,…
    $ trump_24       <dbl> 54.54, 76.94, 45.31, 72.71, 83.02, 64.02, 68.47, 37.50,…
    $ gerry_22       <chr> NA, "F", "F", "F", "F", "F", "F", "F", "C", "C", "C", "…
    $ gerry_24       <chr> NA, "B", "B", "B", "B", "B", "B", "B", "C", "C", "C", "…
    $ gerry_26       <chr> NA, "B", "B", "B", "B", "B", "B", "B", "C", "C", "C", "…
    $ rating_26      <chr> "Lean R", "Safe R", "Lean R", "Safe R", "Safe R", "Safe…
    $ leader_26      <chr> "Republican", "Republican", "Democrat", "Republican", "…
    $ margin_26      <dbl> 9.00, 18.00, 8.00, 28.00, 50.00, 7.00, 15.00, 39.00, 35…
    $ called_26      <chr> "uncalled", "called", "called", "called", "called", "ca…
    $ flip_dem_24_26 <dbl> NA, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, 0, 0, NA, …

The variables we’ll use in this analysis are

- `district`: Congressional district
- `called_26`: Whether the 2026 race had been called (`called`) or not (`uncalled`)
- `flip_dem_24_26`: 1 if the seat was held by a Republican after 2024 and a Democrat leads in 2026, 0 otherwise (`NA` for uncalled races)
- `trump_24`: Trump’s 2024 vote share (%) in the district
- `gerry_26`: Grade (A-F) of the state’s 2026 congressional map from the Redistricting Report Card, where A is the fairest and F is the most gerrymandered

**Goal:** Use Trump’s 2024 vote share and the state’s gerrymandering grade to predict whether a seat flips to Democrat.

# Data prep

Make `flip_dem_24_26` a factor (so we can use it as the outcome of a logistic regression model), and split the data into called and uncalled races.

``` downlit
midterm_26 <- midterm_26 |>
  mutate(flip_dem_24_26 = as.factor(flip_dem_24_26))

midterm_called <- midterm_26 |>
  filter(called_26 == "called")

midterm_uncalled <- midterm_26 |>
  filter(called_26 == "uncalled")
```

How many called and uncalled races are there?

``` downlit
# add code here
```

*Add your response here.*

# Exercises

## Exercise 1

1.  Among the called races, how many seats flipped to Democrat?

``` downlit
# add code here
```

*Add your response here.*

2.  Calculate the proportion of called seats that flipped to Democrat for each gerrymandering grade. What do you notice?

``` downlit
# add code here
```

*Add your response here.*

3.  Visualize the relationship between `trump_24`, `gerry_26`, and `flip_dem_24_26` for the called races.

``` downlit
# add code here
```

## Exercise 2

1.  Fit a logistic regression model predicting `flip_dem_24_26` from `trump_24` and `gerry_26` using the called races.

``` downlit
# add code here
```

2.  Write out the fitted model for the log-odds.

*Add your response here.*

3.  Interpret the coefficient for `gerry_26B` in terms of odds.

*Add your response here.*

4.  The coefficients for `gerry_26C` and `gerry_26D` are very large and negative, with huge standard errors. Why? Hint: Look back at your answer to Exercise 1b.

*Add your response here.*

## Exercise 3

NY-17 is one of the uncalled races.

1.  What are Trump’s 2024 vote share and the gerrymandering grade for NY-17?

``` downlit
# add code here
```

*Add your response here.*

2.  What is the predicted probability that NY-17 flips to Democrat? Answer the question using the [`predict()`](https://rdrr.io/r/stats/predict.html) function with the appropriate `type` argument.

``` downlit
# add code here
```

*Add your response here.*

3.  A probability is nice, but we want an actual decision. Classify NY-17. What threshold does [`predict()`](https://rdrr.io/r/stats/predict.html) use by default?

``` downlit
# add code here
```

*Add your response here.*

4.  Now try AK-00, another uncalled race. What happens, and why?

``` downlit
# add code here
```

*Add your response here.*

## Exercise 4

1.  Predict the probability of flipping to Democrat and classify all uncalled races. How many are predicted to flip to Democrat?

``` downlit
# add code here
```

*Add your response here.*

2.  Which uncalled races have the highest predicted probability of flipping to Democrat?

``` downlit
# add code here
```

*Add your response here.*

3.  The overall proportion of called seats that flipped is about 0.1. Classify the uncalled races again, this time using 0.1 as the threshold. How many are predicted to flip now?

``` downlit
# add code here
```

*Add your response here.*

## Exercise 5

In the slides, we fit a model predicting `flip_dem_24_26` from `trump_24` only. Is the model with `gerry_26` better?

1.  Fit the model from the slides, then compare the AIC values of the two models using `glance()`.

``` downlit
# add code here
```

2.  Take a look at the `nobs` column in the output. Why can’t we compare these AIC values directly?

*Add your response here.*

3.  Refit both models on the called seats that have a gerrymandering grade, and compare the AIC values. Which model is better?

``` downlit
# add code here
```

*Add your response here.*
