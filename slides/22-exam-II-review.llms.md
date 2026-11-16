# Exam 2 Review

Lecture 12

Author

Affiliation

Prof. Mine Çetinkaya-Rundel

Duke University\
STA 199 - Fall 2026

Published

November 16, 2026

# Warm-up

## While you wait: Request for participation 📱💻

We’re working on a manuscript about experimenting with AI tools to support student learning, and we’d love to incorporate your feedback on your experience using Codex for homework feedback or other aspects of the course. We would be so appreciative if you would fill out the following **anonymous** survey:

<https://forms.gle/pk88j5RXdFAs621k6Links>

It should take no more than 5 minutes to complete.

[![](images/22/sta199-ai.svg)](images/22/sta199-ai.svg)

If you have any questions about the form or the project, we’re always happy to chat!

Prof. Çetinkaya-Rundel and [Marie Neubrander](https://mneubrander.github.io/) (PhD student in Statistical Science)

> **IMPORTANT:**
>
> Participation is completely optional, but your feedback is greatly appreciated.

## Announcements

If you haven’t yet filled out your team evaluation on TEAMMATES, please do so immediately after class.

## From last time

- Go to your ae project in Positron.

- If you haven’t yet done so, make sure all of your changes up to this point are committed and pushed, i.e., there’s nothing left in your source control pane.

- If you haven’t yet done so, pull to get today’s application exercise file: `ae-12-chicago-taxi-classification.qmd`.

- Work through the application exercise in class, and render, commit, and push your edits by the end of class.

# Exam 2 review

## Exam 2

Exam 2 is on Wednesday, starts promptly at 1:25 pm!

- Covers all material up to and including today’s lecture

- Sample exam + model solutions for select HW questions are posted

- Exam will be in class, closed book, no calculators, no computers, just 1 notes sheet

- Notes sheet: 8.5x11, both sides, hand written or typed, any content you want, must be prepared by you

- We’ll direct you to your seat so get here early to allow time to get settled and read the instructions

## Types of questions

- Multiple-choice:
  - Some will be single best answer, no partial credit
  - Some will be *at least one* correct answer, with partial credit, and clearly identified with “Select all that apply”
- Open-ended:
  - Short answer, show your work, justify your reasoning
  - With partial credit

## Packages

``` downlit
library(tidyverse)
```

    ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ✔ dplyr     1.2.1     ✔ readr     2.2.0
    ✔ forcats   1.0.1     ✔ stringr   1.6.0
    ✔ ggplot2   4.0.3     ✔ tibble    3.3.1
    ✔ lubridate 1.9.5     ✔ tidyr     1.3.2
    ✔ purrr     1.2.2     
    ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ✖ dplyr::filter() masks stats::filter()
    ✖ dplyr::lag()    masks stats::lag()
    ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

``` downlit
library(tidymodels)
```

    ── Attaching packages ────────────────────────────────────── tidymodels 1.5.0 ──
    ✔ broom        1.0.13     ✔ rsample      1.3.2 
    ✔ dials        1.4.4      ✔ tailor       0.1.0 
    ✔ infer        1.1.0      ✔ tune         2.1.0 
    ✔ modeldata    1.5.1      ✔ workflows    1.3.0 
    ✔ parsnip      1.6.0      ✔ workflowsets 1.1.1 
    ✔ recipes      1.3.3      ✔ yardstick    1.4.0 
    ── Conflicts ───────────────────────────────────────── tidymodels_conflicts() ──
    ✖ scales::discard() masks purrr::discard()
    ✖ dplyr::filter()   masks stats::filter()
    ✖ recipes::fixed()  masks stringr::fixed()
    ✖ dplyr::lag()      masks stats::lag()
    ✖ yardstick::spec() masks readr::spec()
    ✖ recipes::step()   masks stats::step()

## Question 1

> Could we go over an example of how to write the different regression models? I’m trying to understand how to use the model output to write the fitted equation and interpret the slope, intercept, and all the different coefficients that have different tiers/dummy variables. I’m also confused about what changes between multiple regression, categorical predictors, interaction models, and logistic regression. How are you suppose to show the different levels?

## Model output: Linear

- Each row of the output of the `tidy()` function supplies a coefficient

``` downlit
cars_lin_fit <- linear_reg() |>
  fit(mpg ~ wt, data = mtcars)

tidy(cars_lin_fit)
```

    # A tibble: 2 × 5
      term        estimate std.error statistic  p.value
      <chr>          <dbl>     <dbl>     <dbl>    <dbl>
    1 (Intercept)    37.3      1.88      19.9  8.24e-19
    2 wt             -5.34     0.559     -9.56 1.29e-10

- \\\widehat{mpg}\\ is the predicted miles per gallon

- The `(Intercept)` stands alone in the model equation

- The other coefficients are multiplied by their corresponding predictors

\\\widehat{mpg} = 37.3 - 5.34 ~ wt\\

## Linear: Model output to equation

- **One numerical predictor**

  - Formula: `y ~ x`
  - Model equation: \\\hat y = b_0 + b_1x\\

. . .

- **Multiple predictors, main effects only**

  - Formula: `y ~ x1 + x2`
  - Model equation: \\\hat y = b_0 + b_1x_1 + b_2x_2\\

. . .

- **Multiple predictors, with interaction effects**

  - Formula: `y ~ x1 * x2`
  - Model equation: \\\hat y = b_0 + b_1x_1 + b_2x_2 + b_3x_1x_2\\

Source: Lectures 15–17; AE 10.

## Linear: Multiple predictors, main effects

- **One numerical predictor, one categorical predictor with two levels: A and B**

  - Formula: `y ~ x1 + x2`
  - Model equation: \\\hat y = b_0 + b_1x_1 + b_2x\_{2,B}\\

. . .

- **One numerical predictor, one categorical predictor with three levels: A, B, and C**

  - Formula: `y ~ x1 + x2`
  - Model equation: \\\hat y = b_0 + b_1x_1 + b_2x\_{2,B} + b_3x\_{2,C}\\

## Linear: Multiple predictors, interaction effects

- **One numerical predictor, one categorical predictor with two levels: A and B**

  - Formula: `y ~ x1 * x2`
  - Model equation: \\\hat y = b_0 + b_1x_1 + b_2x\_{2,B} + b_3x_1x\_{2,B}\\

. . .

- **One numerical predictor, one categorical predictor with three levels: A, B, and C**

  - Formula: `y ~ x1 * x2`
  - Model equation: \\\hat y = b_0 + b_1x_1 + b_2x\_{2,B} + b_3x\_{2,C} + b_4x_1x\_{2,B} + b_5x_1x\_{2,C}\\

## Logistic: Model output

- Each row of the output of `tidy()` supplies a **log-odds coefficient**

- \\\hat p\\ is the predicted probability of the event of interest (car getting above average mileage); the equation models its **log odds**

``` downlit
mtcars <- mtcars |>
  mutate(
    above_avg_mpg = as.factor(if_else(mpg > mean(mpg), 1, 0))
  )

cars_log_fit <- logistic_reg() |>
  fit(above_avg_mpg ~ wt, data = mtcars)

tidy(cars_log_fit)
```

    # A tibble: 2 × 5
      term        estimate std.error statistic p.value
      <chr>          <dbl>     <dbl>     <dbl>   <dbl>
    1 (Intercept)    19.9       8.34      2.39  0.0167
    2 wt             -6.39      2.58     -2.47  0.0134

- The `(Intercept)` is the predicted **log odds** when `wt = 0`

- The `wt` coefficient is multiplied by weight (in 1,000 lbs) to give its contribution to the predicted **log odds**

\\\log\left(\frac{\hat p}{1-\hat p}\right) = 19.95 - 6.39 \times wt\\

## Logistic: Model output to equation

- **One numerical predictor**

  - Formula: `y ~ x`
  - Model equation: \\\log\left(\frac{\hat p}{1-\hat p}\right) = b_0 + b_1x\\

. . .

- **Multiple predictors, main effects only**

  - Formula: `y ~ x1 + x2`
  - Model equation: \\\log\left(\frac{\hat p}{1-\hat p}\right) = b_0 + b_1x_1 + b_2x_2\\

. . .

- **Multiple predictors, with interaction effects**

  - Formula: `y ~ x1 * x2`
  - Model equation: \\\log\left(\frac{\hat p}{1-\hat p}\right) = b_0 + b_1x_1 + b_2x_2 + b_3x_1x_2\\

Source: Lectures 19–20; interaction structure from AE 10.

## Logistic: Multiple predictors, main effects

- **One numerical predictor, one categorical predictor with two levels: A and B**

  - Formula: `y ~ x1 + x2`
  - Model equation: \\\log\left(\frac{\hat p}{1-\hat p}\right) = b_0 + b_1x_1 + b_2x\_{2,B}\\

. . .

- **One numerical predictor, one categorical predictor with three levels: A, B, and C**

  - Formula: `y ~ x1 + x2`
  - Model equation: \\\log\left(\frac{\hat p}{1-\hat p}\right) = b_0 + b_1x_1 + b_2x\_{2,B} + b_3x\_{2,C}\\

## Logistic: Multiple predictors, interaction effects

- **One numerical predictor, one categorical predictor with two levels: A and B**
  - Formula: `y ~ x1 * x2`
  - Model equation: \\\log\left(\frac{\hat p}{1-\hat p}\right) = b_0 + b_1x_1 + b_2x\_{2,B} + b_3x_1x\_{2,B}\\

. . .

- **One numerical predictor, one categorical predictor with three levels: A, B, and C**

  - Formula: `y ~ x1 * x2`
  - Model equation: \\\log\left(\frac{\hat p}{1-\hat p}\right) = b_0 + b_1x_1 + b_2x\_{2,B} + b_3x\_{2,C} + b_4x_1x\_{2,B} + b_5x_1x\_{2,C}\\

## Categorical predictors

Let \\x\\ be loneliness prevalence (%), and let \\T_2\\ and \\T_3\\ indicate Tier 2 and Tier 3.

. . .

\\ \widehat{\text{mental distress %}} = 6.04 + 0.379x - 0.381T_2 - 1.41T_3 \\

. . .

| County tier | \\T_2\\ | \\T_3\\ | Fitted equation |
|:---|:--:|:--:|:---|
| Tier 1 (reference) | 0 | 0 | \\\begin{aligned}\hat y &= 6.04 + 0.379x - 0.381(0) - 1.41(0) \\ &= 6.04 + 0.379x\end{aligned}\\ |
| Tier 2 | 1 | 0 | \\\begin{aligned}\hat y &= 6.04 + 0.379x - 0.381(1) - 1.41(0) \\ &= 5.659 + 0.379x\end{aligned}\\ |
| Tier 3 | 0 | 1 | \\\begin{aligned}\hat y &= 6.04 + 0.379x - 0.381(0) - 1.41(1) \\ &= 4.63 + 0.379x\end{aligned}\\ |

. . .

- **\\k\\ levels → \\k-1\\ indicators**; the reference level has all indicators equal to 0.
- Holding loneliness constant, Tier 2 counties have predicted mental distress prevalence **0.381 percentage points lower** than Tier 1 counties, on average.
- The intercept predicts **6.04% for Tier 1 at 0% loneliness**, outside the observed range.

Source: Lecture 17, “Model - output and formula” and categorical-predictor interpretations.

## Q13: Interpreting an intercept

A model predicts movie `score` from `runtime` and `rating`. The reference rating is **G**, and the intercept is **4.525**.

What must be true for the fitted value to equal the intercept? [Link](https://sta199-f26.github.io/exam-review/exam-2-review.html#question-13)

. . .

- Set the numerical predictor to **0**: `runtime = 0` minutes.
- Set every rating indicator to **0**: the movie is **G-rated**.

**Answer (e):** G-rated movies that are 0 minutes in length are predicted to score, on average, **4.525 points**.

Source: Practice exam Q13 and suggested answer; Lectures 16–17.

## Lab 6 Q2b: Why logistic regression?

Why can’t we use an ordinary linear regression to model whether a hotel reservation was canceled from the arrival day of the month?

- The outcome is **binary**: canceled or not canceled.
- We want to model a **probability**, which must stay between **0 and 1**.
- A straight-line model of that probability can produce predictions below 0 or above 1.
- Logistic regression models the **log odds** as a linear function of the predictors; converting back always gives a valid probability.

Source: Lecture 19, “The challenge with 0s and 1s” and logistic regression.

## Logistic regression: Three scales

Let \\\hat{y}=b_0+b_1x+\cdots\\ and \\\hat p\\ be the predicted probability of success.

| Scale | From the fitted equation | Example: \\\hat{y}=-2.24\\ |
|:---|:---|:---|
| Log odds | \\\log\left(\frac{\hat p}{1-\hat p}\right)=\hat{y}\\ | \\-2.24\\ |
| Odds | \\\frac{\hat p}{1-\hat p}=e^{\hat{y}}\\ | \\e^{-2.24}\approx0.106\\ |
| Probability | \\\hat p=\frac{e^{\hat{y}}}{1+e^{\hat{y}}}\\ | \\\frac{0.106}{1.106}\approx0.096\\ |

- **Exponentiating undoes the natural log.** It converts log odds to odds.
- To get a probability, divide the odds by **1 + odds**.
- Exponentiate the **whole fitted expression** to predict odds; exponentiate a **slope** to get an odds multiplier for a one-unit increase in the corresponding predictor.

Student question(s):

> Would love clearer explanations on the difference between log odds, exponentiation, and what numbers or conversions we need to do in order to interpret intercepts and slopes for logistic regression. A clearer template on what are interpretations should be like would be extremely helpful!

> explanations for logistic regression + interaction models

Source: Lectures 19–20; practice exam Q19 intercept.

## Logistic regression: Interpretations

Sample interpretations for a model with main effects of predictors:

| Coefficient | Interpretation, holding other predictors constant |
|:---|:---|
| Intercept \\b_0\\ | At numerical predictors = 0 and categorical predictors at their reference levels, predicted **log odds** of the event are \\b_0\\. |
| Numerical slope \\b_j\\ | For each additional **one unit of \\x_j\\**, predicted **log odds** change by \\b_j\\; predicted **odds are multiplied by \\e^{b_j}\\**. |
| Category coefficient \\b_j\\ | For this level **compared with the reference level**, predicted **log odds** differ by \\b_j\\; predicted **odds are multiplied by \\e^{b_j}\\**. |

. . .

A multiplier of **0.8** means **20% lower odds**; **1.2** means **20% higher odds**. These are changes in **odds**, not percentage-point changes in probability.

Source: Lectures 19–20; practice exam Q19 suggested answer.

## Q19: Interpreting the spam model

Let \\\hat p=P(\text{spam}=1)\\, \\d\\ be the number of dollar signs, \\W=1\\ if “winner” appears, and \\U=1\\ if “urgent” is in the subject (0 otherwise).

\\\log\left(\frac{\hat p}{1-\hat p}\right)=-2.24-0.0597d+1.63W+2.99U\\

- **Intercept:** For emails with 0 dollar signs, no “winner”, and no “urgent” in the subject, predicted log odds of spam are −2.24, on average. The predicted odds are \\e^{-2.24}\\.
- **Dollar:** All else held constant, for each additional dollar sign, predicted odds of spam are multiplied by \\e^{-0.0597}\approx0.942\\ (**5.8% lower**).
- **Winner:** All else held constant, the predicted odds of emails with “winner” being spam are \\e^{1.63}\approx5.10\\ times those without it, on average.
- **Urgent:** All else held constant, the predicted odds of emails with “urgent” in the subject being spam are \\e^{2.99}\approx19.9\\ times those without it, on average.

Source: Practice exam Q19 and suggested answer (rounded coefficients).

## Q21: The missing confusion-matrix row

``` downlit
email_aug_A |>
  group_by(spam) |>
  count(.pred_class)
```

| Actual class | Predicted 0 (not spam) | Predicted 1 (spam) |
|:-------------|-----------------------:|-------------------:|
| 0 (not spam) |             1,072 (TN) |             1 (FP) |
| 1 (spam)     |               104 (FN) |         **0 (TP)** |

- The missing combination is actual spam = 1, predicted class = 1: there are **zero true positives**. [`count()`](https://dplyr.tidyverse.org/reference/count.html) omits this unobserved combination by default.

- The model does predict spam once, but that prediction is a false positive.

Source: Practice exam Q20–22 and the counts in the Q22 suggested answer.

## Sensitivity

\\\text{Sensitivity}=\frac{TP}{TP+FN}=1-\text{false negative rate}\\

. . .

- Sensitivity asks: Of all actual positives, how many did we catch?
  - If there are **100 actual positives** and we detect 90, sensitivity is **90%**: we miss **10**.
  - If we detect 99, sensitivity is **99%**: we miss **1**.
  - When missing a positive has a high cost, higher sensitivity helps reduce that costly error.

. . .

- Threshold tradeoff: Lowering the probability cutoff for a positive prediction generally catches more positives, but can also create more false positives. Choose a threshold with the error costs in mind.

Source: Lecture 21, “Sensitivity”, “False negative and positive”, and ROC curves.

## Model selection: How much improvement is enough?

**Use a criterion that balances fit and complexity, and state your reasoning.**

- On the same observations, adding predictors cannot lower ordinary \\R^2\\; this alone does not justify a larger model.

- Adjusted \\R^2\\ penalizes additional predictor coefficients. If the instruction is to maximize it, select the model with the higher value.

- There is no universal cutoff for “small enough”. For a judgment-based choice, weigh the size of the improvement against complexity, interpretability, and the modeling goal.

- Example: Q17b – Adjusted \\R^2\\ goes from **0.187** (`runtime`) to **0.191** (`runtime + rating`).

  - The higher-adjusted-\\R^2\\ rule selects `runtime + rating`. The gain is only 0.004, so preferring the simpler model for parsimony is also defensible **with an explanation**.

Source: Lecture 18, adjusted R-squared and balancing fit and complexity; practice exam Q17b suggested answer; AE 10 model comparison.

## Web scraping: The workflow

1.  **Inspect** the page. Use SelectorGadget to click a desired element, exclude unwanted matches, and check that the highlighted set matches what you want.
2.  **Read** the page with `read_html(url)`.
3.  **Select** the relevant nodes with `html_elements("CSS selector")`.
4.  **Extract** text with `html_text()` / `html_text2()`, or an attribute with `html_attr("href")`.
5.  **Combine and clean** the results in a tibble; make relative links into full URLs before reading article pages.
6.  **Repeat** a one-page function over article URLs with [`map_chr()`](https://purrr.tidyverse.org/reference/map.html); save the scraped data for analysis.

. . .

A selector identifies **nodes**; the extraction function determines **what you take from them**. Scrape in a script and save results to avoid scraping again on every render.

Source: Lectures 11 and 13; AE 7–8 Chronicle scraping scripts; practice exam Q24–25.

## Q24: Text or an attribute?

``` html
<div class="article-listing">
  <a class="title" href="/article/2026/09/duke-opinion-on-dining">On dining at Duke</a>
  <span class="byline">By Jane Doe</span>
</div>
```

How do we extract the article URL from `page`?

**Answer (b):**

``` downlit
page |> html_elements(".title") |> html_attr("href")
```

- `.title` selects the element with **class `title`**.
- `html_text()` would return **“On dining at Duke”**.
- `html_attr("href")` returns **`"/article/2026/09/duke-opinion-on-dining"`**.
- `href` is an **attribute**, so `html_elements("href")` does not select this link. `html_attrs()` returns **all** attributes.

Student question(s):

> 13, 24, 25 (web scraping in general would help)

> Q24, Q25!!! Especially web scraping. Hope can review everything about this!

> Question 24 and 25, web scraping,

> web scraping many pages, select gadget: 24 and 25

> Web scraping question 24 & 25

> Practice exam 24 and 25

> What are the key points of web scraping? Q24 Q25

> Questions 21, 22, 24 from exam 2

Source: Practice exam Q24 and suggested answer; Lecture 11.
