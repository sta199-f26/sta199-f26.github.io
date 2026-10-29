# Lab 5

Make up your other half

Lab

Due: End of lab on Thurs, Oct 29

> **IMPORTANT:**
>
> Nuff said!

# Introduction

In Part 1 of this lab you’ll “make up” data for an outcome variable to match certain criteria, and then visualize and summarize the relationship between your outcome and predictor variables as well as fit a model to evaluate whether the made up data meets the criteria you set out to achieve.

In Part 2, you’ll give us an update plans for preparing for your project presentation.

Make sure to upload your completed lab to Gradescope **by the end of your lab session** and commit and push your final version to GitHub.

## Getting started

By now you should be familiar with how to get started with a lab assignment by cloning the GitHub repo for the assignment. If you’re not sure how, refer back to an earlier lab.

Open the *lab-5.qmd* template Quarto file and update the `authors` field to add your name first (first and last) and then your teammates’ names (first and last). Render the document. Examine the rendered document and make sure your and your teammates’ names are updated in the document. Commit and push your changes with a meaningful commit message and push to GitHub.

Click to expand if you need a refresher on assignment guidelines.

### Code

Code should follow the [tidyverse style](https://style.tidyverse.org/). Particularly,

- there should be spaces before and line breaks after each `+` when building a `ggplot`,
- there should also be spaces before and line breaks after each `|>` in a data transformation pipeline,
- code should be properly indented,
- there should be spaces around `=` signs and spaces after commas.

Additionally, all code should be visible in the PDF output, i.e., should not run off the page on the PDF. Long lines that run off the page should be split across multiple lines with line breaks.[^1]

### Plots

- Plots should have an informative title and, if needed, also a subtitle.
- Axes and legends should be labeled with both the variable name and its units (if applicable).
- Careful consideration should be given to aesthetic choices.

### Workflow

Continuing to develop a sound workflow for reproducible data analysis is important as you complete the lab and other assignments in this course.

- You should have at least 3 commits with meaningful commit messages by the end of the assignment.
- Final versions of both your `.qmd` file and the rendered PDF should be pushed to GitHub.

# Part 1

## Packages

In this lab we will work with the **tidyverse** package.

``` downlit
library(tidyverse)
library(tidymodels)
```

## Data

You have half the data, just your predictor variable (`x`), you need in the following data frame:

``` downlit
our_data <- tibble(x = c(10, 20, 30, 40, 50, 60, 70, 80, 90, 100))
our_data
```

    # A tibble: 10 × 1
           x
       <dbl>
     1    10
     2    20
     3    30
     4    40
     5    50
     6    60
     7    70
     8    80
     9    90
    10   100

## Goal

Your goal is to “make up” the outcome variable `y` such that when you fit a linear regression model predicting `y` from `x`, the model are true about the model:

- For each additional unit in `x`, `y` is expected to be lower, on average, by (approximately) 2 units.

- For observations with `x` equal to 0, `y` is expected to be (approximately) 50.

- The model for predicting `y` from `x` explains (approximately) 60% of the variability in `y`.

## Question 1

Make up the values for `y` in the data frame above so that the linear regression model predicting `y` from `x` meets the criteria specified in the **Goal** section. Add these values to the data frame `our_data` and display the updated data frame.

> **TIP:**
>
> Solving Question 1 will require some trial and error, creativity, and patience. Specifically, it will require writing and testing the code for Questions 2 and 3 multiple times until you get the desired results.

## Question 2

Visualize the relationship between `x` and `y` using a scatter plot with a regression line. Comment on how the plot supports that the criteria specified in the **Goal** section are met.

## Question 3

Fit a linear regression model predicting `y` from `x`. Display the model coefficients and the R-squared value from the model summary. Comment on how the model coefficients and R-squared value support that the criteria specified in the **Goal** section are met.

Preview, commit, and push your changes to GitHub with a meaningful commit message.

Make sure to commit and push all changed files so that your source control pane is empty afterward.

# Part 2

## Question 4

List all of your upcoming project team meetings, including the day of the week, time of day, and location. If you don’t have any meetings scheduled, schedule them first, and then list the days, times, and locations.

## Question 5

Describe how you ensure your presentation slides are accessible from your project website at a URL like `https://sta199-f26.github.io/project-YOUR-TEAM-NAME/presentation.pdf`.

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

## Footnotes

[^1]: Remember, haikus not novellas when writing code!
