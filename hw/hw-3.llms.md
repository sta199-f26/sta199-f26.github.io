# HW 3

Inflation everywhere

HW

Due: Wed, Sep 23, 11:59 pm

# Introduction

Inflation makes headlines, but a single number can hide differences across countries, years, and the goods and services people buy. In this homework, you will explore these differences using inflation data from the Organisation for Economic Co-operation and Development (OECD).

You will begin with annual inflation rates for countries around the world from 1993 to 2025, comparing countries and examining how their inflation rates have changed over time. Then, you will focus on the United States, using annual inflation rates for 12 Consumer Price Index (CPI) expenditure categories, such as food, housing, and health. These data let you explore whether different types of household expenses have followed similar patterns over time.

Along the way, you will reshape and join data and create time series plots to communicate your findings.

## Learning objectives

By the end of this homework, you will:

- transform and summarize data while accounting for missing values;
- reshape data;
- join data frames using keys with different column names;
- create and customize time series plots; and
- compare and interpret inflation trends across countries and CPI expenditure categories.

# Getting Started

## Guidelines

The guidelines should feel familiar, as they are the same ones from earlier assignments. They are included below as a reminder.

### Code

Code should follow the [tidyverse style](https://style.tidyverse.org/). Particularly,

- there should be spaces before and line breaks after each `+` when building a `ggplot`,
- there should also be spaces before and line breaks after each `|>` in a data transformation pipeline,
- code should be properly indented,
- there should be spaces around `=` signs and spaces after commas.

Additionally, all code should be visible in the PDF output, i.e., should not run off the page on the PDF. Long lines that run off the page should be split across multiple lines with line breaks.

### Plots

- Plots should have an informative title and, if needed, also a subtitle.
- Axes and legends should be labeled with both the variable name and its units (if applicable).
- Careful consideration should be given to aesthetic choices.

### Workflow

Continuing to develop a sound workflow for reproducible data analysis is important as you complete the lab and other assignments in this course.

- You should have at least 3 commits with meaningful commit messages by the end of the assignment.
- Final versions of both your `.qmd` file and the rendered PDF should be pushed to GitHub.

## AI support and feedback

You can get immediate support as well as feedback on all of the questions with AI, based on rubrics designed by the course instructor, via the Codex extension in Positron, and using AI access provided by Duke University.

When working on your assignment, feel free to ask Codex for help, but don’t ask it to do your work for you. After completing a question, ask Codex to provide feedback on your answer, e.g., “Review my answer for Question 1.”

> **NOTE:**
>
> If you have not yet enabled Duke’s ChatGPT Edu access or installed the Codex extension for Positron, follow the instructions in [HW 1](../hw/hw-1.llms.md).

# Packages

You will use the **tidyverse** package for data wrangling and visualization.

``` downlit
library(tidyverse)
```

You may choose to load other packages as needed, particularly for improving your plots. If you do so, add the functions to load these packages in the code cell labeled `load-packages`.

# Questions

## Part 1: Inflation around the world

For this part of the analysis, you will work with inflation data from countries around the world spanning more than 30 years.

``` downlit
country_inflation <- read_csv("data/country-inflation.csv")
```

### Question 1

Let’s first get to know the data.

1.  [`glimpse()`](https://pillar.r-lib.org/reference/glimpse.html) at the `country_inflation` data frame and answer the following questions based on the output.
    - How many rows does `country_inflation` have and what does each row represent?
    - How many columns does `country_inflation` have and what does each column represent?
2.  Display the names of the countries included in the dataset. How many distinct countries are there?

> **TIP:**
>
> Find distinct countries with [`distinct()`](https://dplyr.tidyverse.org/reference/distinct.html) and print all countries with `print(n = ___)` added to your pipeline, where the blank is the number of distinct countries.

Preview, commit, and push your changes to GitHub with the commit message “Added answer for Question 1”. Make sure to commit and push all changed files so that your source control pane is empty afterward.

### Question 2

2024 is the last year for which we have data on inflation in the United States, so we’ll focus on that year for this question.

1.  Which countries had the three highest inflation rates in 2024? Your output must be a data frame with two columns, `country` and `2024`, with inflation rates in descending order, and three rows for the top three countries.

2.  Briefly comment on how the inflation rates for these countries compare to the inflation rate for the United States in that year.

> **TIP:**
>
> Column names that are numbers are not considered “proper” in R, so you’ll need to surround them with backticks (\`) to select them.

Preview, commit, and push your changes to GitHub with an informative and concise commit message. Make sure to commit and push all changed files so that your source control pane is empty afterward.

### Question 3

Let’s next focus on the years 1993 and 2025, which are the first and last years in the dataset.

1.  In a single pipeline,

    - filter the `country_inflation` data frame to include only the countries that have inflation data for both 1993 and 2025,
    - then, calculate the ratio of the inflation rate in 2025 to the inflation rate in 1993 for each country and store this information in a new column called `inf_ratio`,
    - then, select the variables `country` and `inf_ratio`, and
    - store the result in a new data frame called `country_inflation_ratios`.

2.  Then, in two separate pipelines,

    - arrange `country_inflation_ratios` in increasing order of `inf_ratio` and
    - arrange `country_inflation_ratios` in decreasing order of `inf_ratio`.

3.  Which country’s inflation increase is the largest over this time period and by how much?

4.  Which country’s inflation decrease is the largest over this time period and by how much?

Preview, commit, and push your changes to GitHub with an informative and concise commit message. Make sure to commit and push all changed files so that your source control pane is empty afterward.

### Question 4

Reshape (pivot) `country_inflation` such that each row represents a country/year combination. Then, display the resulting data frame and write a sentence describing it, including its dimensions (number of rows and columns) and the names of the columns.

> **WARNING:**
>
> - Your code must use a pivoting function. There are other ways you can do this reshaping move in R, but this question requires solving this problem by pivoting.
> - Your pivoting function must also ensure that in the resulting data frame the year variable is numeric.
> - The resulting data frame must be saved as something other than `country_inflation` so you (1) can refer to this data frame later in your analysis and (2) do not overwrite `country_inflation`. You should choose a short but informative name.

This would be a good time to get feedback from AI if you haven’t yet done so! Just launch Codex in Positron and ask it to review your answer for Question 4, or any earlier question(s).

### Question 5

Use the pivoted version of the `country_inflation` dataset that you created in Question 4 to answer this question.

> **WARNING:**
>
> - For each part, use a separate, single pipeline.
> - Your code must use the [`filter()`](https://dplyr.tidyverse.org/reference/filter.html) function for each part, not [`arrange()`](https://dplyr.tidyverse.org/reference/arrange.html).

1.  What is the highest inflation rate observed between 1993 and 2025? The output of the pipeline must be a data frame with one row and three columns. In addition to code and output, your response must include a single sentence stating the country and year.

2.  What is the lowest inflation rate observed between 1993 and 2025? The output of the pipeline must be a data frame with one row and three columns. In addition to code and output, your response must include a single sentence stating the country and year.

3.  Putting (a) and (b) together: What are the highest and the lowest inflation rates observed between 1993 and 2025? The output of the pipeline must be a data frame with two rows and three columns, with the rows corresponding to the highest and lowest inflation rates you identified in parts (a) and (b).

Preview, commit, and push your changes to GitHub with an informative and concise commit message.

### Question 6

Once again, use the pivoted version of the `country_inflation` dataset that you created in Question 4 to answer this question.

1.  Create a vector called `countries_of_interest` which contains the names of up to five countries you want to visualize the inflation rates for over the years. For example, if these countries are Türkiye and the United States, you can express this as follows:

``` downlit
countries_of_interest <- c("Türkiye", "United States")
```

If they are Türkiye, the United States, and Chile, you can express this as follows:

``` downlit
countries_of_interest <- c("Türkiye", "United States", "Chile")
```

So on and so forth… Then, in 1-2 sentences, state why you chose these countries.

> **NOTE:**
>
> Your `countries_of_interest` must consist of no more than five countries. Make sure that the country names are spelled exactly as they appear in the dataset.

2.  In a single pipeline, filter your pivoted dataset to include only the `countries_of_interest` from part (a), and save the resulting data frame with a new name so you (1) can refer to this data frame later in your analysis and (2) do not overwrite the data frame you’re starting with. Use a short but informative name. Then, in a new pipeline, find the [`distinct()`](https://dplyr.tidyverse.org/reference/distinct.html) countries in the data frame you created.

> **TIP:**
>
> The number of distinct countries in the filtered data frame you created in part (b) must equal the number of countries you chose in part (a). If it doesn’t, you might have misspelled a country name or made a mistake in filtering for these countries. Go back and correct your work.

3.  Using your data frame from part (b), create a plot of annual inflation vs. year for these countries. Then, in 1-2 sentences, state how you customized your plot.

> **WARNING:**
>
> In your plot:
>
> - Data must be represented with points as well as lines connecting the points for each country.
> - Each country must be represented by a distinct line color and by points with a matching color and a distinct shape.
> - The axes and legend must be properly labeled.
> - The plot must have an appropriate title (and optionally a subtitle).
> - The plot must be customized in at least one way – you could change the default color scale or theme, or make other customizations.

4.  In a few sentences, describe the patterns you observe in your plot from part (c), particularly focusing on anything you find surprising or not surprising, based on your knowledge (or lack thereof) of these countries’ economies.

You know what to do: Preview, commit, and push your changes to GitHub with an informative and concise commit message. Make sure to commit and push all changed files so that your source control pane is empty afterward.

## Part 2: Inflation in the United States

The OECD defines inflation as follows:

> Inflation is a rise in the general level of prices of goods and services that households acquire for the purpose of consumption in an economy over a period of time.
>
> The main measure of inflation is the annual inflation rate which is the movement of the Consumer Price Index (CPI) from one month/period to the same month/period of the previous year expressed as percentage over time.
>
> Source: [OECD CPI FAQ](https://www.oecd.org/sdd/prices-ppp/consumerpriceindices-frequentlyaskedquestionsfaqs.htm#1)

CPI is broken down into 12 expenditure categories, such as food, housing, and health. Your goal in this part is to create another time series plot of annual inflation, this time for the US only.

The data you will need to create this visualization are spread across two files:

- `us-inflation.csv`: Annual inflation rate for the US for 12 CPI expenditures. Each expenditure is identified by an ID number.
- `cpi-expenditures.csv`: A “lookup table” of CPI expenditure ID numbers and their descriptions.

Let’s load both of these files.

``` downlit
us_inflation <- read_csv("data/us-inflation.csv")
cpi_expenditures <- read_csv("data/cpi-expenditures.csv")
```

### Question 7

1.  How many columns and how many rows does the `us_inflation` dataset have? What are the variables in it? Which years do these data span? Write a brief narrative (1-2 sentences) summarizing this information.

2.  How many columns and how many rows does the `cpi_expenditures` dataset have? What are the variables in it? Write a brief narrative (1-2 sentences) summarizing this information.

3.  Create a new dataset by joining the `us_inflation` dataset with the `cpi_expenditures` dataset.

- Determine which type of join is the most appropriate one and use that.

- Note that the two datasets don’t have a variable with a common name, though they do have variables that contain common information but are named differently. You will need to first figure out which variables those are, and then define the `by` argument and use the [`join_by()`](https://dplyr.tidyverse.org/reference/join_by.html) function to indicate these variables to join the datasets by.

- Use a short but informative name for the joined dataset, and do not overwrite either of the datasets that go into creating it.

Then, find the number of rows and columns of the resulting dataset and report the names of its columns. Add a brief narrative (1-2 sentences) summarizing this information.

You know what to do!

### Question 8

1.  Create a vector called `expenditures_of_interest` which contains the descriptions or IDs of CPI expenditures you want to visualize. Your `expenditures_of_interest` must consist of no more than five expenditures. If you’re using descriptions, make sure that the expenditure descriptions are spelled exactly as they appear in the dataset. Then, in 1-2 sentences, state why you chose these expenditures.

> **TIP:**
>
> Refer back to the guidance provided in [Question 6](#question-6) if you’re not sure how to create this vector.

2.  In a single pipeline, filter your joined dataset to include only the `expenditures_of_interest` from part (a), and save the resulting data frame with a new name so you (1) can refer to this data frame later in your analysis and (2) do not overwrite the data frame you’re starting with. Use a short but informative name. Then, in a new pipeline, find the [`distinct()`](https://dplyr.tidyverse.org/reference/distinct.html) expenditures in the data frame you created.

You know what to do!

### Question 9

Using your data frame from the previous question, create a plot of annual inflation vs. year for these expenditures. Then, in a few sentences, describe the patterns you observe in the plot, particularly focusing on anything you find surprising or not surprising, based on your knowledge (or lack thereof) of inflation rates in the US over the last decade.

> **WARNING:**
>
> In your plot:
>
> - Data must be represented with points as well as lines connecting the points for each expenditure.
> - Each expenditure must be represented by a distinct line color and by points with a matching color and a distinct shape.
> - The axes and legend must be properly labeled.
> - The plot must have an appropriate title (and optionally a subtitle).
> - The plot must be customized in at least one way – you could change the default color scale or theme, or make other customizations.
> - If your legend has labels that are too long, you can try moving the legend to the bottom and stacking the labels vertically. *Hint:* The `legend.position` and `legend.direction` arguments of the [`theme()`](https://ggplot2.tidyverse.org/reference/theme.html) function will be useful.
>
> ``` downlit
> ggplot(...) +
>   ... +
>   theme(
>     legend.position = "bottom",
>     legend.direction = "vertical"
>   )
> ```

This would be a good time to get feedback from AI if you haven’t yet done so! Just launch Codex in Positron and ask it to review your answer for Question 9, or any earlier question(s).

You know what to do!

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

Before you wrap up the assignment, make sure that you preview, commit, and push one final time so that the final versions of both your `.qmd` file and the rendered PDF are pushed to GitHub and your source control pane is empty. We will be checking these to make sure you have been practicing how to commit and push changes.

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

Submit your final version of `hw-3.pdf` to Gradescope. Be sure to select the pages associated with each question.

A subset of the questions will be carefully graded for correctness and quality of explanation by the course instructional team. You will receive that feedback in about a week.

There are also workflow points for:

- committing at least three times as you work through your homework,
- having your final version of `.qmd` and `.pdf` files in your GitHub repository, and
- overall organization.
