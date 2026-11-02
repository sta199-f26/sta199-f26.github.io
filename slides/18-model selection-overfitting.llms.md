# Model selection and overfitting

Lecture 18

Author

Affiliation

Prof. Mine Çetinkaya-Rundel

Duke University\
STA 199 - Fall 2026

Published

November 2, 2026

# Warm-up

## While you wait: Participate 📱💻

At the end of last class, I asked you to write a description for what [this code](https://sta199-f26.github.io/ae/ae-10-nc-places-multi-model.html#comparing-the-two-models-visually) from AE 10 does. Copy and paste your response here.

[![QR code for Wooclap](images/18/wooclap-qr.png)](images/18/wooclap-qr.png)

Go to [wooclap.com](https://app.wooclap.com/SLCBQZT) and use the code SLCBQZT.

# Model selection

## What is the difference between \\R^2\\ and adjusted \\R^2\\?

- \\R^2\\:
  - Proportion of variability in the outcome explained by the model.
  - Useful for quantifying the fit of a given model.
- Adjusted \\R^2\\:
  - Proportion of variability in the outcome explained by the model, with a penalty added for the number of predictors in the model.
  - Useful for comparing models.

## Using adjusted \\R^2\\ to compare models

- Fit two (or more) models to the same data set with different sets of predictors, selected based on subject-matter knowledge and/or exploratory data analysis results, compared their adjusted \\R^2\\ values, and selected the model with the highest adjusted \\R^2\\ value.

- Perform stepwise selection (forward or backward) to select a model that maximizes adjusted \\R^2\\:

  - Backward elimination: Start with a model that includes all candidate predictors, and iteratively remove the predictor that results in the largest increase in adjusted \\R^2\\ until no further improvement is observed.
  - Forward selection: Start with a model that includes no predictors, and iteratively add the predictor that results in the largest increase in adjusted \\R^2\\ until no further improvement is observed.

## Demo: Backward elimination

Goal: Predict `mental_distress`. Candidate variables: `development_tier`, `loneliness`, and `short_sleep`. Method for model selection: Backward elimination using adjusted \\R^2\\ as decision criterion.

- Start with all three predictors; use the same 100 counties for every model since there are no missing values in these four variables.

- At each step, try removing each remaining predictor and keep the removal only if it increases adjusted \\R^2\\ the most.

- Treat development tier as one predictor even though when fitting the model it is represented by two dummy variables.

## Backward elimination: Step 0

``` downlit
md_full_fit <- linear_reg() |>
  fit(
    mental_distress ~ development_tier + loneliness + short_sleep,
    data = nc_places
  )

glance(md_full_fit) |> select(adj.r.squared)
```

    # A tibble: 1 × 1
      adj.r.squared
              <dbl>
    1         0.678

## Backward elimination: Step 1

Fit each model obtained by removing **one predictor** from the full model.

``` downlit
md_no_tier_fit <- linear_reg() |>
  fit(mental_distress ~ loneliness + short_sleep, data = nc_places)
glance(md_no_tier_fit) |> select(adj.r.squared)
```

    # A tibble: 1 × 1
      adj.r.squared
              <dbl>
    1         0.587

``` downlit
md_no_lone_fit <- linear_reg() |>
  fit(mental_distress ~ development_tier + short_sleep, data = nc_places)
glance(md_no_lone_fit) |> select(adj.r.squared)
```

    # A tibble: 1 × 1
      adj.r.squared
              <dbl>
    1         0.612

``` downlit
md_tier_sleep_fit <- linear_reg() |>
  fit(mental_distress ~ development_tier + loneliness, data = nc_places)
glance(md_tier_sleep_fit) |> select(adj.r.squared)
```

    # A tibble: 1 × 1
      adj.r.squared
              <dbl>
    1         0.681

## Participate 📱💻

Which variable should we drop in Step 1 of backward elimination using adjusted \\R^2\\?

| Predictor removed | Adjusted R² |
|-------------------|-------------|
| None (full model) | 0.6780      |
| Development tier  | 0.5868      |
| Loneliness        | 0.6121      |
| Short sleep       | 0.6810      |

- Development tier
- Loneliness
- Short sleep
- None; keep all three predictors

[![QR code for Wooclap](images/18/wooclap-qr.png)](images/18/wooclap-qr.png)

Go to [wooclap.com](https://app.wooclap.com/SLCBQZT) and use the code SLCBQZT.

## Backward elimination: Step 2

Start from `mental_distress ~ development_tier + loneliness` (i.e., `md_tier_sleep_fit`) and try removing each remaining predictor.

``` downlit
md_lone_fit <- linear_reg() |>
  fit(mental_distress ~ loneliness, data = nc_places)
glance(md_lone_fit) |> select(adj.r.squared)
```

    # A tibble: 1 × 1
      adj.r.squared
              <dbl>
    1         0.588

``` downlit
md_tier_fit <- linear_reg() |>
  fit(mental_distress ~ development_tier, data = nc_places)
glance(md_tier_fit) |> select(adj.r.squared)
```

    # A tibble: 1 × 1
      adj.r.squared
              <dbl>
    1         0.545

## Participate 📱💻

Which variable should we drop in Step 2 of backward elimination using adjusted \\R^2\\?

| Predictor removed    | Adjusted R² |
|----------------------|-------------|
| None (current model) | 0.6810      |
| Development tier     | 0.5881      |
| Loneliness           | 0.5452      |

- Development tier
- Loneliness
- None; keep both predictors and stop

[![QR code for Wooclap](images/18/wooclap-qr.png)](images/18/wooclap-qr.png)

Go to [wooclap.com](https://app.wooclap.com/SLCBQZT) and use the code SLCBQZT.

**Stop:** Neither removal improves adjusted \\R^2\\. The selected model is **`mental_distress ~ development_tier + loneliness`**, with adjusted \\R^2\\ = 0.681.

## Using other criteria to compare models

Same model selection approaches (subject-matter knowledge, stepwise selection) can be used with various model comparison criteria, such as:

- Maximize adjusted \\R^2\\
- *Minimize Akaike Information Criterion (AIC)*
- *Minimize Bayesian Information Criterion (BIC)*
- …

> **NOTE:**
>
> Only mentioning criteria other than adjusted \\R^2\\ here to build awareness that other criteria exist. We will not cover all of them in detail in this course (and this is not even a complete list), but you will encounter them in higher-level modeling courses and in practice.

## Balancing fit and complexity

- More complex models (i.e., models with more predictors) tend to fit the data at hand better, but may not generalize well to new data.

- Model selection criteria, like adjusted \\R^2\\, help balance model fit and complexity to avoid overfitting by penalizing models with more predictors.

## Overfitting

- Overfitting occurs when a model captures not only the underlying relationship between predictors and outcome but also the random noise in the data.

- Overfitted models that perform well on the observed data can perform poorly on new, unseen data.

  - Good news: We have techniques to detect and prevent overfitting.
  - Bad news: We won’t get into those until next week.

What are some features of datasets (that we have discussed so far) that could lead to overfitting?

# Story development

## Structure: presentation + write-up

- Start with your goal / high-level question

- Don’t chronicle your steps, but instead tell us a compelling story of what you set out to find and what you found

- “No significant results” or “no concrete relationships” are still results – what did you learn? how deep did you dig and with what tools and techniques?

## “But… Therefore…”

Advice from those much more successful than me at telling stories:

# An error occurred.

Unable to execute JavaScript.

# Technical writing with Quarto

## Your project write-up with Quarto

- Figure sizing: `fig-width`, `fig-asp`, etc. in code cells. [\[example\]](https://github.com/sta199-f26/project-teaching-team/blob/main/index.qmd#L207-L208)

- Figure layout:

  - `layout-ncol` for placing multiple figures in a chunk. [\[example\]](https://github.com/sta199-f26/project-teaching-team/blob/main/index.qmd#L163)
  - Further control over figure layout with the [**patchwork**](https://patchwork.data-imaginist.com/articles/patchwork.html) package.

- Cell options for what makes it in your final report: `message`, `echo`, etc. [\[example\]](https://github.com/sta199-f26/project-teaching-team/blob/main/index.qmd#L6-L7)

- Noting outside resources and formal citations:

  - AI Disclosure [\[example\]](https://github.com/sta199-f26/project-teaching-team/blob/main/ai-disclosure.qmd)
  - Citations [\[example\]](https://github.com/sta199-f26/project-teaching-team/blob/main/index.qmd#L119)

- Finalizing your report with `echo: false`. [\[example\]](https://github.com/sta199-f26/project-teaching-team/blob/main/index.qmd#L5)

## Building your project website with Quarto

- The `docs` folder.

- Making sure your website reflects your latest changes.

- Customizing the look of your website.

  - Quarto themes: Learn more at <https://quarto.org/docs/output-formats/html-themes.html>. [\[example\]](https://github.com/sta199-f26/project-teaching-team/blob/3417f86ae9e42a2f793da3c935f009506a2a866d/_quarto.yml#L41-L43)
  - For the adventurous: Customizing your website with `_brand.yml`, learn more at <https://quarto.org/docs/authoring/brand.html>.

## Slides

- **Option 1:** Make your slides not in Quarto but make sure they’re available in your Quarto project website.

> **IMPORTANT:**
>
> Make sure the presentation is called `presentation.pdf`.

- **Option 2:** Make your slides with Quarto.

# Code smell and style

## Code smell

> One way to look at smells is with respect to principles and quality: “Smells are certain structures in the code that indicate violation of fundamental design principles and negatively impact design quality”. Code smells are usually not bugs; they are not technically incorrect and do not prevent the program from functioning. Instead, they indicate weaknesses in design that may slow down development or increase the risk of bugs or failures in the future.

Source: [Code smell on Wikipedia](https://en.wikipedia.org/wiki/Code_smell)

## Code style

Follow the [Tidyverse style guide](https://style.tidyverse.org/):

- Spaces before and line breaks after each `+` when building a ggplot

- Spaces before and line breaks after each `|>` in a data transformation pipeline,

- Proper indentation

- Spaces around `=` signs and spaces after commas

- Lines should not span more than 80 characters, long lines should be broken up with each argument on its own line
