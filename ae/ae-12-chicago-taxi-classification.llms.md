# AE 12: Chicago taxi classification

Application exercise

In this application exercise, we will

- Split our data into testing and training
- Fit logistic regression regression models to testing data to classify outcomes
- Evaluate performance of models on testing data

We will use **tidyverse** and **tidymodels** for data exploration and modeling,

``` downlit
library(tidyverse)
library(tidymodels)
```

and the `chicago_taxi` dataset introduced in the lecture.

``` downlit
chicago_taxi <- read_csv("data/chicago-taxi.csv") |>
  mutate(
    tip = fct_relevel(tip, "no", "yes"),
    local = fct_relevel(local, "no", "yes"),
    dow = fct_relevel(dow, "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"),
    month = fct_relevel(month, "Jan", "Feb", "Mar", "Apr")
  )
```

    Rows: 2000 Columns: 7
    ── Column specification ────────────────────────────────────────────────────────
    Delimiter: ","
    chr (5): tip, company, local, dow, month
    dbl (2): distance, hour

    ℹ Use `spec()` to retrieve the full column specification for this data.
    ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

Remember from the lecture that the `chicago_taxi` dataset contains information on whether a trip resulted in a tip (`yes`) or not (`no`) as well as numerical and categorical features of the trip.

``` downlit
glimpse(chicago_taxi)
```

    Rows: 2,000
    Columns: 7
    $ tip      <fct> no, no, no, no, no, no, no, no, no, no, no, no, no, no, no, n…
    $ distance <dbl> 0.40, 0.96, 1.07, 1.13, 10.81, 3.60, 1.08, 0.85, 17.92, 0.00,…
    $ company  <chr> "other", "Taxicab Insurance Agency Llc", "Sun Taxi", "other",…
    $ local    <fct> yes, no, no, no, no, no, yes, no, no, yes, yes, no, no, no, n…
    $ dow      <fct> Fri, Mon, Fri, Sat, Sat, Wed, Wed, Tue, Tue, Sun, Fri, Fri, F…
    $ month    <fct> Mar, Apr, Feb, Feb, Apr, Mar, Mar, Mar, Jan, Apr, Apr, Feb, M…
    $ hour     <dbl> 17, 8, 15, 14, 14, 12, 13, 8, 20, 16, 20, 8, 15, 15, 12, 0, 1…

# Spending your data

Split your data into testing and training in a reproducible manner and display the split object.

``` downlit
# add code here
```

What percent of the original `chicago_taxi` data is allocated to training and what percent to testing? Compare your response to your neighbor’s. Are the percentages roughly consistent? What determines this in the `initial_split()`? How would the code need to be updated to allocate 80% of the data to training and the remaining 20% to testing?

``` downlit
# add code here
```

75% of the data is allocated to training and the remaining 25% to testing. This is because the `prop` argument in `initial_split()` is `3/4` by default. The code would need to be updated as follows for a 80%/20% split:

``` downlit
# split 80-20
# add code here
```

Let’s stick with the default split and save our testing and training data.

``` downlit
# add code here
```

# Model 1: Custom choice of predictors

## Fit

Fit a model for classifying trips as tipped or not based on a subset of predictors of your choice. Name the model `chicago_taxi_custom_fit` and display a tidy output of the model.

``` downlit
# add code here
```

## Predict

Predict for the testing data using this model.

``` downlit
# add code here
```

## Evaluate

Calculate the false positive and false negative rates for the testing data using this model.

``` downlit
# add code here
```

Another commonly used display of this information is a confusion matrix. Create this using the `conf_mat()` function. You will need to review the documentation for the function to determine how to use it.

``` downlit
# add code here
```

## Sensitivity, specificity, ROC curve

Calculate sensitivity and specificity and draw the ROC curve.

``` downlit
# add code here
```

# Model 2: All predictors

## Fit

Fit a model for classifying plots as forested or not based on all predictors available. Name the model `forested_full_fit` and display a tidy output of the model.

``` downlit
# add code here
```

## Predict

Predict for the testing data using this model.

``` downlit
# add code here
```

## Evaluate

Calculate the false positive and false negative rates for the testing data using this model.

``` downlit
# add code here
```

## Sensitivity, specificity, ROC curve

Calculate sensitivity and specificity and draw the ROC curve.

``` downlit
# add code here
```

# Model 1 vs. Model 2

Plot both ROC curves and articulate how you would use them to compare these models. Also calculate the areas under the two curves.

``` downlit
# add code here
```
