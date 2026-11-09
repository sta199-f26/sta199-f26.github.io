# HW 6

Weighing the odds

HW

Due: Wed, Nov 11, 11:59 pm

# Introduction

In this homework, you will use regression models to explore powerlifting records and attitudes toward government spending on scientific research. You will begin by comparing linear models that predict squat weight from age and age squared. Next, you will prepare data from the General Social Survey and use logistic regression to predict views on government spending on scientific research from education and political views. You will interpret predicted probabilities and odds ratios, then compare models with main effects and interactions.

## Learning objectives

By the end of this homework, you will:

- prepare data for modeling by filtering observations, transforming numeric variables, and combining and reordering categorical levels;
- fit and interpret linear regression models and compare their fit using \\R^2\\;
- fit and interpret logistic regression models with quantitative and categorical predictors;
- use predicted probabilities to calculate odds and odds ratios and connect them to model coefficients; and
- fit models with interactions and use model statistics to compare logistic regression models.

## Guidelines

By now you should be familiar with guidelines for homework assignments. If not, please refer to an earlier homework assignment for details.

## AI support and feedback

You can get immediate support as well as feedback on all of the questions with AI, based on rubrics designed by the course instructor, via the Codex extension in Positron, and using AI access provided by Duke University.

When working on your assignment, feel free to ask Codex for help, but don’t ask it to do your work for you. After completing a question, ask Codex to provide feedback on your answer, e.g., “Review my answer for Question 1.”

# Packages

You will use the [**tidyverse**](https://www.tidyverse.org/packages), [**tidymodels**](https://www.tidymodels.org/), and [**openintro**](https://openintro.org/) packages for this homework, at a minimum.

``` downlit
library(tidyverse)
library(tidymodels)
library(openintro)
```

# Part 1 - Do you even lift?

In this part, you will be working with data from www.openpowerlifting.org. This data was sourced from Tidy Tuesday and contains international powerlifting records at various meets. At each meet, each lifter gets three attempts at lifting max weight on three lifts: the bench press, squat and deadlift. For all of the following exercises, you should include units on axes labels, e.g. “Bench press (lbs)” or “Bench press (kg)”. “Age (years)” etc. This is good practice.

## Question 1

1.  Let’s begin by taking a look at the **squat lifting** records.

    - Read in the `ipf.csv` file that is in your data folder and save it as `ipf`.
    - First, remove any observations that are negative for squat.
    - Next, create a new column called `best3_squat_lbs` that converts the record from kilograms to pounds.
    - Save your data frame as `ipf_squat`.
    - Report the number of rows and columns of this new data frame.

> **NOTE:**
>
> You may need to use an outside resource to find the conversion formula. Make sure you cite it.

2.  Using the `ipf_squat` data frame you created in part (a), create a scatter plot to investigate the relationship between squat (in lbs) and age.

    - Age should be on the x-axis.
    - Adjust the `alpha` level of your points to get a better sense of the density of the data.
    - Add a linear trend-line.
    - Summarize the trend you observe in at most 4 sentences.

3.  - Write down the linear population model to predict lift squat lbs from age.
    - Fit the linear model, and save it as `age_fit`.
    - Re-write your previous equation replacing the population parameters with the numeric estimates. This is called the “fitted” linear model.
    - Interpret each estimate of \\\beta\\, and comment on whether the interpretations are meaningful in the context of the data.

## Question 2

1.  Building on your `ipf_squat` data frame, create a new column called `age2` that takes the age of each lifter and squares it. Save it to your data frame `ipf_squat`. Next, plot squat in lbs vs `age2` and add a linear best fit line. How does the fit of the model compare to the one from earlier?

2.  One metric to assess the fit of a model is the correlation squared, also known as \\R^2\\. Fit the age\\^2\\ model and save the object as `age2_fit`. Compare \\R^2\\ of the new model (squat vs. age\\^2\\) to the \\R^2\\ of the earlier model (squat vs. age). Which has a higher \\R^2\\?

This would be a good time to get feedback from AI if you haven’t already! Just launch Codex in Positron and ask it to review your answer for any question(s) you haven’t yet reviewed. Revise your answers based on the feedback before moving on.

Preview, commit, and push your changes to GitHub with an informative and concise commit message.

# Part 2 - Supporting scientific research

The General Social Survey (GSS) gathers data on contemporary American society in order to monitor and explain trends and constants in attitudes, behaviours, and attributes. Hundreds of trends have been tracked since 1972. In addition, since the GSS adopted questions from earlier surveys, trends can be followed for up to 70 years. The GSS contains a standard core of demographic, behavioural, and attitudinal questions, plus topics of special interest. Among the topics covered are civil liberties, crime and violence, intergroup tolerance, morality, national spending priorities, psychological well-being, social mobility, and stress and traumatic events. In this part you will work with variables from the 2024 General Social Survey.

One of the variables we’ll be working with is `natsci`, which measures whether respondents think the government spends “Too little”, “About right”, or “Too much” on supporting scientific research.

Specifically, this question is phrased as:

> We are faced with many problems in this country, none of which can be solved easily or inexpensively. I’m going to name some of these problems, and for each one I’d like you to name some of these problems, and for each one I’d like you to tell me whether you think we’re spending too much money on it, too little money, or about the right amount. First, are we spending too much, too little, or about the right amount on supporting scientific research.

Additionally, we will work with the following variables:

- `education_years`: completed years of formal education
- `polviews`: political views, ranging from “Extremely liberal” to “Extremely conservative”

## Question 3

1.  Read in the `gss-2024-more-cols.csv` file that is in your data folder and save it as `gss24`. Report its number of rows and columns.

2.  Create a new data frame called `gss24_natsci` that only contains the variables `natsci`, `education_years`, and `polviews`. Then, use the [`drop_na()`](https://tidyr.tidyverse.org/reference/drop_na.html) function to remove rows that contain NAs from this new data frame. Report the number of rows and columns of `gss24_natsci`. Additionally, report what percent of the observations were discarded at this step.

3.  Recode `natsci` such that “Too little” remains its own level and “About right” and “Too much” are combined into a new level called “Not too little”. Then, make `natsci` a factor with levels in the following order: “Not too little” and “Too little”. Finally, [`count()`](https://dplyr.tidyverse.org/reference/count.html) how many times each new level appears in `natsci`.

> **TIP:**
>
> With the tidymodels logistic regression workflow used in class, logistic regression coefficients model the second outcome level, so order the levels as “Not too little” and then “Too little”.

4.  Combine the levels of the `polviews` variable such that levels that have the word “liberal” in them are lumped into a level called “Liberal” and those that have the word conservative in them are lumped into a level called “Conservative”. Rename “Moderate, middle of the road” to “Moderate”. Then, make `polviews` a factor with levels in the following order: “Conservative”, “Moderate”, and “Liberal”. Finally, [`count()`](https://dplyr.tidyverse.org/reference/count.html) how many times each new level appears in the `polviews` variable.

## Question 4

1.  Fit a logistic regression model that predicting the probability of responding that the government spends too little on supporting scientific research (`Too little` in `natsci`) from `education_years` using `gss24_natsci`. Report the tidy output of the model.

2.  Interpret the slope and the intercept of the model in the context of the data.

3.  Predict the predicting the probability of responding that the government spends too little on supporting scientific research (`Too little` in `natsci`) for someone with 7 years of education and someone with 8 years of education. Convert each predicted probability to odds using \\p / (1 - p)\\. Then, calculate the odds ratio (odds for 8 years / odds for 7 years) and describe how it relates to the slope of the model you interpreted in part (b).

> **TIP:**
>
> The odds is defined as \\p / (1 - p)\\, where p is the probability of the event of interest. The odds ratio is the ratio of two odds.

## Question 5

1.  Fit another model predicting the probability of responding that the government spends too little on supporting scientific research (`Too little` in `natsci`) from both `education_years` and `polviews`. Consider only the main effects of `education_years` and `polviews` for this question.

2.  Interpret the slopes and the intercept of the model in the context of the data.

3.  Predict the probability of responding that the government spends too little on supporting scientific research (`Too little` in `natsci`) for a Conservative person with 7 years of education and a Conservative person with 8 years of education. Convert each predicted probability to odds using \\p / (1 - p)\\. Then, calculate the odds ratio (odds for 8 years / odds for 7 years) and describe how it relates to the slope(s) of the model you interpreted in part (b).

4.  Predict the probability of responding that the government spends too little on supporting scientific research (`Too little` in `natsci`) for a Liberal person with 7 years of education and a Liberal person with 8 years of education. Convert each predicted probability to odds using \\p / (1 - p)\\. Then, calculate the odds ratio (odds for 8 years / odds for 7 years) and describe how it relates to the slope(s) of the model you interpreted in part (b).

Preview, commit, and push your changes to GitHub with an informative and concise commit message.

## Question 6

1.  Fit one more model predicting the probability of responding that the government spends too little on supporting scientific research (`Too little` in `natsci`) from both `education_years` and `polviews`. Consider only the main effects of `education_years` and `polviews` as well as their interaction for this question. Display the tidy output of the model.

2.  Which of the three models (education only, education + polviews, and education + polviews + interaction) do you think is the best model? Justify your answer in 1-2 sentences with appropriate model statistics.

Get feedback from AI if you haven’t already! Just launch Codex in Positron and ask it to review your answer for any question(s) you haven’t yet reviewed. Revise your answers based on the feedback before moving on.

# AI use disclosure

The purpose of the disclosure is for you to reflect on how you’re using AI in this course. It also helps us learn how students are effectively using AI.

- Did you use an LLM / generative AI tool when completing this assignment? (Yes or No)

- If Yes, list all of the ways you used it from the list below.

  - I used it to clarify the question(s).
  - I used it to better understand concept(s).
  - I asked it to help write code.
  - I gave it my code and asked it to help fix it.
  - I asked it about an error or unexpected code behavior.
  - I used it to get feedback on my answer(s).
  - I pasted the question prompt in and asked for help, but wrote my own answer.
  - I pasted the question prompt in and copied at least part of its response into my Quarto document.
  - Other (please specify)

- If Yes, list all the AI tools you used.

  - Include the model name and version (if known). For example, “ChatGPT GPT-5.5” or “Claude Sonnet 4”.
  - Include the tool as well. For example, “Codex extension in Positron”, “ChatGPT in a web browser”, etc.

Additionally, cite any other non-AI sources you used to help you complete the assignment, along with the question(s) for which you used each source.

**Sample citations:**

- Example 1: All questions: 5.6 Luna Light, in Codex in Positron.
- Example 2: I used ChatGPT GPT-5.5 for Questions 5 and 7. Prompt: “Why did my code have an error?” (pasted code).

# Wrap-up

Before you wrap up the assignment, make sure that you preview, commit, and push one final time so that the final versions of both your `.qmd` file and the rendered PDF are pushed to GitHub, and your source control pane is empty. We will be checking these to make sure you have been practicing committing and pushing changes.

## Submission

Submit your PDF document to Gradescope by the deadline to be considered “on time”:

- Go to <http://www.gradescope.com> and click *Log in* in the top right corner.
- Click *School Credentials* \\\rightarrow\\ *Duke NetID* and log in using your NetID credentials.
- Click on your *STA 199* course.
- Click on the assignment, and you’ll be prompted to submit it.
- Mark all the pages associated with question. All the pages of your homework should be associated with at least one question (i.e., should be “checked”).

> **IMPORTANT:**
>
> Make sure you have:
>
> - attempted all questions
> - included an AI use disclosure
> - rendered your Quarto document
> - committed and pushed everything to your GitHub repository such that the Git pane in Positron is empty
> - uploaded your PDF to Gradescope
> - selected your pages on Gradescope for each question

## Grading and feedback

You can get immediate feedback on all of the questions with AI.

Submit your final version of `hw-6.pdf` to Gradescope. Be sure to select the pages associated with each question.

A subset of the questions will be carefully graded for correctness and quality of explanation by the course instructional team. You will receive that feedback in about a week.

There are also workflow points for:

- committing at least three times as you work through your homework,
- having your final version of `.qmd` and `.pdf` files in your GitHub repository, and
- overall organization.
