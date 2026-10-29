# HW 5

Eat, Crawl, Regress

HW

Due: Wed, Oct 28, 11:59 pm

# Introduction

In this homework, you will investigate relationships between variables in three settings: infant crawling, diet and life expectancy, and health and demographic characteristics of North Carolina counties. You will begin by using visualizations and correlation to study how temperature relates to the age at which babies begin crawling, including what happens when the variables are converted to different units. Next, you will use simple linear regression to examine how meat and carbohydrate consumption relate to life expectancy across countries. Finally, you will combine two datasets about North Carolina counties, choose an outcome and predictors, and fit models with quantitative and categorical predictors.

## Learning objectives

By the end of this homework, you will:

- create and interpret scatterplots for relationships between quantitative variables;
- calculate and interpret correlation coefficients and explain how linear unit conversions affect correlations and visualizations;
- join related datasets and select appropriate outcome and predictor variables;
- fit and interpret simple linear regression models with quantitative and categorical predictors, including predictions, residuals, and \\R^2\\;
- use residual plots to assess whether a linear model is appropriate; and
- distinguish association from causation.

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

# Part 1 - Crawling babies

A study conducted at the University of Denver, Benson ([1993](#ref-Benson:1993)), investigated whether babies take longer to learn to crawl in cold months, when they are often bundled in clothes that restrict their movement, than in warmer months. Infants born during the study year were split into twelve groups, one for each birth month. The data for this study are available in the `babies_crawl` dataset in the **openintro** package, which contains three variables of interest for this part of the homework:

- `month`: month of birth (1 = January, 2 = February, …, 12 = December)
- `avg_crawling_age`: average age at which babies born in a given month began crawling (in weeks)
- `temperature`: average outdoor temperature at 6 months of age (in degrees Fahrenheit, F)

We consider the average crawling age of babies in each group against the average temperature when the babies are six months old (that’s when babies often begin trying to crawl).

## Question 1

1.  Create a visualization displaying the relationship between temperature and crawling age.

2.  Describe the relationship in context of the data.

3.  Calculate the correlation between average crawling age (in weeks) and temperature (in F).

## Question 2

1.  Create a new variable `temperature_C` that converts the temperature from F to C using the formula \\C = (F - 32) \* 5/9\\.

2.  Create a new variable `avg_crawling_age_months` that converts the average crawling age from weeks to months using the formula \\months = weeks / 4.345\\.

3.  How would you expect the scatterplot and correlation from Question 1 to change after converting temperature to C and crawling age to months?

4.  Create a new scatterplot displaying the relationship between `temperature_C` and `avg_crawling_age_months`. Does the visualization support your expectations from part c?

5.  Calculate the correlation between `temperature_C` and `avg_crawling_age_months`. Does the correlation support your expectations from part c?

# Part 2 - Life expectancy

You et al. ([2022](#ref-You:2022)) studied the relationship between meat and carbohydrate consumption and life expectancy across 175 countries. Meat consumption is measured in kg per capita per year (averaged over 2011 to 2013). Carbohydrate consumption is measured as carbohydrate crops (e.g., cereals, root, sugar, etc.) in kg per capita per year (averaged over 2011 and 2013).

The dataset from this study is available in `you-2022.csv` in your `data` folder. From this dataset, you will work with the following variables:

- `country`: country name
- `meat`: meat consumption (in kg per capita per year)
- `cho_crops`: carbohydrate consumption (in kg per capita per year)
- `life_0`: life expectancy at birth (in years)

## Question 3

1.  Create a scatterplot displaying the relationship between meat consumption and life expectancy, and describe the relationship.

2.  Create a scatterplot displaying the relationship between carbohydrate consumption and life expectancy, and describe the relationship.

3.  Before you calculate a correlation, which plot appears to show a stronger correlation? Explain your reasoning.

4.  Calculate the correlation coefficients for the relationships visualized in parts a and b. Comment on whether the correlation coefficients support your reasoning in part c.

## Question 4

1.  Fit a linear model that predicts life expectancy from meat consumption and display the tidy model summary.

2.  Interpret the slope in the context of the data.

3.  Interpret the intercept in the context of the data. Is it meaningful? Why or why not?

4.  Pick a country of your choice from the dataset, use the model to predict its life expectancy based on its meat consumption, and calculate the residual. Comment on whether the model over- or under-predicts life expectancy for this country.

## Question 5

1.  Fit a linear model that predicts life expectancy from carbohydrate consumption and display the tidy model summary.

2.  Interpret the slope in the context of the data.

3.  Interpret the intercept in the context of the data. Is it meaningful? Why or why not?

4.  Calculate the R-squared value for the model and interpret it in context of the data.

5.  Plot residuals vs. the predicted values and comment on what this plot says about whether a linear model is a good fit for the data.

## Question 6

Comment on whether the results from the two models support causal conclusions between these three variables.

# Part 3 - Modeling the Old North State

For this part of the homework you will return to working with data on North Carolina counties.

- Dataset 1: `nc-places.csv` – See [Lecture 15](https://sta199-f26.github.io/slides/15-linear-regression-single-predictor.html#cdc-places) for a description of this dataset. The full data dictionary can be found [here](https://github.com/sta199-f26/sta199-f26.github.io/blob/main/_data/nc-places/README.md#variables).

- Dataset 2: `nc-county.csv` – See [Homework 2](hw-2.llms.md) for a description of this dataset. The full data dictionary can be found [here](https://github.com/sta199-f26/sta199-f26.github.io/blob/main/_data/nc-county/README.md#variables).

Both datasets are in your `data` folder.

## Question 7

Read `nc-places.csv` into a data frame called `nc_places` and `nc-county.csv` into a data frame called `nc_counties`. Join the two data frames by county name and save the result as `nc_counties_places`. Report the number of rows and columns of this data frame.

## Question 8

Choose three variables from `nc_counties_places` for the following purposes:

- Variable 1: Outcome variable – This should be a numeric variable that you want to predict and that might make sense to predict from other variables in the dataset. State which data frame it was originally included in: `nc_places` or `nc_counties`. Describe why you chose this variable as your outcome variable and why it might be interesting to predict.

- Variable 2: Predictor variable 1 – This should be a numeric variable that you think might be related to your outcome variable. State which data frame it was originally included in: `nc_places` or `nc_counties`. Describe why you chose this variable as your predictor variable and why it might be interesting to use it to predict your outcome variable.

- Variable 3: Predictor variable 2 – This should be a categorical variable that you think might be related to your outcome variable. State which data frame it was originally included in: `nc_places` or `nc_counties`. Describe why you chose this variable as your predictor variable and why it might be interesting to use it to predict your outcome variable. Additionally, state the reference (baseline) level and, optionally, change the level order if you think a different level should be the reference level.

Two of these variables must come from one of the datasets (`nc_places` or `nc_counties`) and the third variable must come from the other dataset.

## Question 9

1.  Fit a linear regression model predicting your outcome variable from Question 8 using the numeric predictor, Variable 2.

2.  Display the tidy model summary.

3.  Interpret the slope in the context of the data.

4.  Interpret the intercept in the context of the data. Is it meaningful? Why or why not?

5.  Calculate the R-squared value for the model and interpret it in context of the data.

## Question 10

1.  Fit a linear regression model predicting your outcome variable from Question 8 using the categorical predictor, Variable 3.

2.  Display the tidy model summary.

3.  Interpret the coefficient(s) for Variable 3 in the context of the data.

4.  Interpret the intercept in the context of the data. Is it meaningful? Why or why not?

5.  Calculate the R-squared value for the model and interpret it in context of the data.

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

Submit your final version of `hw-5.pdf` to Gradescope. Be sure to select the pages associated with each question.

A subset of the questions will be carefully graded for correctness and quality of explanation by the course instructional team. You will receive that feedback in about a week.

There are also workflow points for:

- committing at least three times as you work through your homework,
- having your final version of `.qmd` and `.pdf` files in your GitHub repository, and
- overall organization.

## References

Benson, J. B. 1993. “Season of Birth and Onset of Locomotion: Theoretical and Methodological Implications.” *Infant Behavior and Development* 16 (1): 69–81. <https://doi.org/10.1016/0163-6383(93)80029-8>.

You, W., R. Henneberg, A. Saniotis, Y. Ge, and M. Henneberg. 2022. “Total Meat Intake Is Associated with Life Expectancy: A Cross-Sectional Data Analysis of 175 Contemporary Populations.” *International Journal of General Medicine* 15: 1833–51.
