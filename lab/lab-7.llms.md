# Lab 7

Leavin’ on a jet plane, confidently

Lab

Due: End of lab on Thurs, Nov 19

# Introduction

In this lab you’ll explore the relationship between distance and air time of flights out of RDU in 2024.

And you’ll work in what’s considered a pretty unlikely situation: you have access to population data – all flights out of RDU in 2024! But we’ll ask you to pretend that you didn’t actually have access and you need to work with sample data. How? Hang in there, get the population data loaded first, then we’ll explain the next steps!

## Getting started

By now you should be familiar with how to get started with a lab assignment by cloning the GitHub repo for the assignment. If you’re not sure how, refer back to an earlier lab.

Open the *lab-7.qmd* template Quarto file and update the `authors` field to add your name first (first and last) and then your teammates’ names (first and last). Render the document. Examine the rendered document and make sure your and your teammates’ names are updated in the document. Commit and push your changes with a meaningful commit message and push to GitHub.

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

## Packages

In this lab we will work with the **tidyverse** and **tidymodels** packages.

``` downlit
library(tidyverse)
library(tidymodels)
```

    Warning: package 'dials' was built under R version 4.6.2

    Warning: package 'yardstick' was built under R version 4.6.2

## Population data

The dataset, called `rdu-flights.csv`, can be found in the `data` folder.

# Questions

## Question 1 - Sample

Take a random sample of 100 flights and store it as `rdu_flights_sample`. Each person in the class should have a different sample.

## Question 2 - Visualize

Visualize the relationship between `distance` and `air_time` using a scatter plot. Also add a regression line to the scatter plot. Do not show the standard error ribbon around the regression line.

How does the relationship between the variables in your sample compare to that of others in your team or others in the class? How do the regression lines compare? Exactly the same? Wildly different? Somewhere in between?

## Question 3 - Model and estimate

Fit a model predicting `air_time` using `distance` using the sample data. Display the model summary.

How does the slope estimate in your sample compare to that of others in your team or others in the class? Exactly the same? Wildly different? Somewhere in between?

## Question 4 - Quantify(ish) uncertainty

Mark your slope estimate from Question 3 on the number line on the board. Then, based on the slope estimates from the entire class, determine a reasonable range of values for the estimate of the slope of the relationship between `distance` and `air_time`. How do you define “reasonable”?

# One last thing…

We’re working on a manuscript about experimenting with AI tools to support student learning, and we’d love to incorporate your feedback on your experience using Codex for homework feedback or other aspects of the course. We would be so appreciative if you would fill out the anonymous survey we shared with you as a Canvas announcement this morning.

It should take no more than 5 minutes to complete.

If you have any questions about the form or the project, we’re always happy to chat!

# Wrap-up

> **WARNING:**
>
> Before you wrap up the assignment, make sure that you render, commit, and push one final time so that the final versions of both your `.qmd` file and the rendered PDF are pushed to GitHub and your Git pane is empty. We will be checking these to make sure you have been practicing how to commit and push changes.

## Submission

By now you should also be familiar with how to submit your assignment in Gradescope.

Click to expand if you need a refresher on how to get started with a lab assignment.

Submit your PDF document to Gradescope by the end of the lab to be considered “on time”:

- Go to <http://www.gradescope.com> and click *Log in* in the top right corner.
- Click *School Credentials* \\\rightarrow\\ *Duke NetID* and log in using your NetID credentials.
- Click on your *STA 199* course.
- Click on the assignment, and you’ll be prompted to submit it.
- Mark all the pages associated with question. All the pages of your lab should be associated with at least one question (i.e., should be “checked”).

> **IMPORTANT:**
>
> Make sure you have:
>
> - attempted every question;
> - previewed your Quarto document;
> - committed and pushed all final changes to GitHub, ending with no pending or staged changes in the Source Control pane; and
> - submitted your rendered PDF to Gradescope.

## Grading and feedback

- This lab is worth 30 points:
  - 10 points for being in lab and turning in *something* – no partial credit for this part.
  - 20 points for:
    - answering the questions correctly – there is partial credit for this part.
    - following the workflow – there is partial credit for this part.
- The workflow points are for:
  - committing at least three times as you work through your lab,
  - having your final version of `.qmd` and `.pdf` files in your GitHub repository, and
  - overall organization.
- You’ll receive feedback on your lab on Gradescope within a week.

Good luck, and have fun with it!

## Footnotes

[^1]: Remember, haikus not novellas when writing code!
