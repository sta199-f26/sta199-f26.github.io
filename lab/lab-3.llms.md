# Lab 3

The one with all the pivoting

Lab

Due: End of lab on Thurs, Sep 17

> **IMPORTANT:**
>
> … and sit with them!

# Introduction

[Ross had a couch to move](https://youtu.be/L_PWbnHABsM?si=-8xSOXWFLNrPYUi4). You have data to reshape. The instruction? **Pivot!**

In this lab, you will use [`pivot_longer()`](https://tidyr.tidyverse.org/reference/pivot_longer.html) and [`pivot_wider()`](https://tidyr.tidyverse.org/reference/pivot_wider.html) to reshape data between wide and long formats. Before writing code, you will think through what each row should represent and predict the structure of the result. Then, you will put your predictions to the test with student scores and patient measurements, working up to a pivot that also cleans up column names and converts data types.

Make sure to upload your completed lab to Gradescope **by the end of your lab session** and commit and push your final version to GitHub.

## Learning objectives

By the end of this lab, you will:

- Reshape data between wide and long formats using [`pivot_longer()`](https://tidyr.tidyverse.org/reference/pivot_longer.html) and [`pivot_wider()`](https://tidyr.tidyverse.org/reference/pivot_wider.html).
- Predict the number of rows, column names, and data types produced by a pivot.
- Interpret missing values in reshaped data.
- Use `names_prefix`, `names_transform`, and `values_transform` to control names and data types when pivoting.

# Getting started

Clone your **lab-3** repository using the same process used in Lab 0.

1.  Go to the course GitHub organization at [github.com/sta199-f26](https://github.com/sta199-f26) and click on the repository with the prefix `lab-3`.
2.  Select the green **Code** button and choose **HTTPS** under **Clone**. Click on the clipboard icon to copy the repo URL.
3.  In Positron’s Welcome window, click on *New Folder From Git…*.
4.  Paste the repository URL into the dialog box labeled *Git repository URL* and select **OK**.
5.  Open `lab-3.qmd` in the Explorer pane.

Then, click *lab-3.qmd* to open the template Quarto file and update the `authors` field to add your name first (first and last) and then your teammates’ names (first and last). Render the document. If you get a popup window error, click “Try again”. Examine the rendered document and make sure your name is updated in the document. Commit and push your changes with a meaningful commit message and push to GitHub.

## Guidelines

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

# Packages

In this lab we will work with the **tidyverse** package.

``` downlit
library(tidyverse)
```

- **Run** the code cell by clicking on the green triangle (play) button for the code cell labeled `load-packages`. This loads the package to make its features (the functions and datasets in it) accessible from your *Console*.
- Then, **preview** the document, which loads this package to make its features (the functions and datasets in it) available for other code cells in your Quarto document.

# Questions

## Question 1

For this question, you will work with the following dataset called `scores`, containing paleontology and theater studies scores for the six students.

``` downlit
scores <- tribble(
  ~student_id , ~student_name , ~paleontology , ~theater ,
  "S1"        , "Rachel"      ,            25 ,       78 ,
  "S2"        , "Ross"        ,           100 ,       72 ,
  "S3"        , "Monica"      ,            40 ,       75 ,
  "S4"        , "Chandler"    ,            15 ,       74 ,
  "S5"        , "Phoebe"      ,            20 ,       80 ,
  "S6"        , "Joey"        ,            10 ,      100
)

scores
```

    # A tibble: 6 × 4
      student_id student_name paleontology theater
      <chr>      <chr>               <dbl>   <dbl>
    1 S1         Rachel                 25      78
    2 S2         Ross                  100      72
    3 S3         Monica                 40      75
    4 S4         Chandler               15      74
    5 S5         Phoebe                 20      80
    6 S6         Joey                   10     100

> **NOTE:**
>
> The [`tribble()`](https://tibble.tidyverse.org/reference/tribble.html) function is helpful for creating small data frames (`tibble`s) with an easier to read row-by-row layout.

It has four variables (`student_id`, `student_name`, `paleontology`, and `theater`) and six rows (one for each student).

You want to reshape `scores` so that each student has one row for paleontology and one row for theater. Keep both `student_id` and `student_name`, and store the subject names in a column called `subject` and the scores in a column called `score`.

1.  Before writing any code, answer the following questions:
    - What function would you use to reshape the data in this way?
    - Which columns should be pivoted, and which should remain as identifiers for each student?
    - How many rows and columns would the resulting data frame have? What would the column names be?
    - What would the two rows for Ross look like?
2.  Write the code to reshape the data frame as described above and save the result as `scores_longer`. Display `scores_longer` and check that it matches your predictions.

Preview, commit, and push your changes to GitHub with a succinct and informative commit message.

Make sure to commit and push all changed files so that your source control pane is empty afterward.

## Question 2

[Dr. Drake Ramoray](https://friends.fandom.com/wiki/Dr._Drake_Ramoray) is reviewing patient charts before morning rounds. For this question, you will help him reshape the following dataset called `patients`.

``` downlit
patients <- tribble(
  ~patient_id , ~measurement_time_ , ~systolic_bp ,
  "P1"        , "Morning"          ,          120 ,
  "P1"        , "Noon"             ,          115 ,
  "P1"        , "Evening"          ,          123 ,
  "P2"        , "Morning"          ,          118 ,
  "P2"        , "Evening"          ,          121
)

patients
```

    # A tibble: 5 × 3
      patient_id measurement_time_ systolic_bp
      <chr>      <chr>                   <dbl>
    1 P1         Morning                   120
    2 P1         Noon                      115
    3 P1         Evening                   123
    4 P2         Morning                   118
    5 P2         Evening                   121

It has three variables (`patient_id`, `measurement_time_`, and `systolic_bp` – short for systolic blood pressure) and five rows (one per patient per measurement time).

1.  Before writing any code, answer the following questions:
    - Suppose you want to reshape the data frame so that there is one row per patient and measurements at different times of the day are recorded in different columns. What function would you use to do this?
    - If you reshaped the data to have one row per patient,
      - how many rows would the resulting data frame have?
      - how many columns would the resulting data frame have and what would the column names be?
2.  Then, write the code to reshape the data frame as described above. What does the `NA` value mean in the resulting data frame?

Preview, commit, and push your changes to GitHub with a meaningful commit message.

Make sure to commit and push all changed files so that your source control pane is empty afterward.

## Question 3

For this question, you will work with a portion of [Dr. Ross Geller](https://friends.fandom.com/wiki/Ross_Geller)’s grade roster, stored in the following dataset called `quiz_scores`.

``` downlit
quiz_scores <- tribble(
  ~student_id , ~student_name , ~week_1 , ~week_2 , ~week_3 ,
  "S1"        , "Elizabeth"   , "80"    , "85"    , "90"    ,
  "S2"        , "Burt"        , "75"    , NA      , "88"    ,
  "S3"        , "Lydia"       , "92"    , "90"    , "95"    ,
  "S4"        , "Mel"         , "78"    , "82"    , NA
)

quiz_scores
```

    # A tibble: 4 × 5
      student_id student_name week_1 week_2 week_3
      <chr>      <chr>        <chr>  <chr>  <chr> 
    1 S1         Elizabeth    80     85     90    
    2 S2         Burt         75     <NA>   88    
    3 S3         Lydia        92     90     95    
    4 S4         Mel          78     82     <NA>  

It has four rows (one per student) and five columns: two identifying each student (`student_id` and `student_name`) and three containing weekly quiz scores (`week_1`, `week_2`, and `week_3`). Notice that the scores are stored as character strings (in quotation marks), and Burt’s score for week 2 is missing.

You want to reshape this data frame to have one row per student per week and four columns: `student_id`, `student_name`, `week`, and `score`. The `week` column should contain the integers `1`, `2`, and `3`, and `score` should be numeric. Keep both student identifiers and the row corresponding to Burt’s missing score.

1.  Before writing any code, answer the following questions:
    - What function would you use to reshape the data, and how many rows would the resulting data frame have?
    - Which columns should be pivoted, and which should remain as identifiers for each student?
    - If you only specified which columns to pivot and the new column names, what values and data types would you expect in `week`? What data type would you expect in `score`?

Then, complete the following steps:

2.  Read about `names_prefix` in the documentation for [`pivot_longer()`](https://tidyr.tidyverse.org/reference/pivot_longer.html). Reshape `quiz_scores` as described above using `names_prefix` within a single [`pivot_longer()`](https://tidyr.tidyverse.org/reference/pivot_longer.html) call, and save the result as `quiz_scores_longer`.

3.  Display `quiz_scores_longer` and use [`glimpse()`](https://pillar.r-lib.org/reference/glimpse.html) to check the variable types. How many rows and columns does `quiz_scores_longer` have? What data types are `student_id`, `student_name`, `week`, and `score`? Explain what the `names_prefix` argument does.

4.  Read about `names_transform` and `values_transform` in the documentation for [`pivot_longer()`](https://tidyr.tidyverse.org/reference/pivot_longer.html). Reshape `quiz_scores` as you did in part b, this time also using the `names_transform` and `values_transform` arguments within a single [`pivot_longer()`](https://tidyr.tidyverse.org/reference/pivot_longer.html) call. Save the result as `quiz_scores_longer`. Use the appropriate transformation for each variable. Display `quiz_scores_longer`. Which variables have different data types than they did in part c? Explain what changed and why the new data types are appropriate for these variables.

> **TIP:**
>
> Hint: [`as.integer()`](https://rdrr.io/r/base/integer.html) converts values to integers, and [`as.numeric()`](https://rdrr.io/r/base/numeric.html) converts values to numbers. Supply transformation functions without parentheses, using the form `list(column_name = function_name)`.

5.  Reshape `quiz_scores_longer` back to one row per student, retaining `student_id` and `student_name` and restoring the score columns `week_1`, `week_2`, and `week_3`. Use `names_prefix` in [`pivot_wider()`](https://tidyr.tidyverse.org/reference/pivot_wider.html) to restore the prefix. Check that the result has the same dimensions and column names as Dr. Geller’s original roster. How does the role of `names_prefix` differ between the [`pivot_longer()`](https://tidyr.tidyverse.org/reference/pivot_longer.html) and [`pivot_wider()`](https://tidyr.tidyverse.org/reference/pivot_wider.html) functions? How do the score column types in this result compare with those in the original `quiz_scores`?

Preview, commit, and push your changes to GitHub with a meaningful commit message.

Make sure to commit and push all changed files so that your source control pane is empty afterward.

# Wrap-up

## Submission

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

This lab is worth 30 points:

- 10 points for attending lab and submitting work by the end of lab; and
- 20 points for correct and complete answers, clear presentation, and following the required workflow.

The workflow portion includes making at least three meaningful commits, pushing the final `.qmd` and rendered PDF to GitHub, and keeping your work organized.

## Footnotes

[^1]: Remember, haikus not novellas when writing code!
