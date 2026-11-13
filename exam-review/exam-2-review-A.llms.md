# Exam 2 review

Suggested answers

1.  \(c\) For every additional \$1,000 of annual salary, the model predicts the raise to be higher, on average, by 0.0155%.

2.  \(d\) \\R^2\\ of `raise_2_fit` is higher than \\R^2\\ of `raise_1_fit` since `raise_2_fit` has an additional predictor, and \\R^2\\ never decreases when a predictor is added.

3.  The reference level of `performance_rating` is High, since it’s the first level alphabetically. Therefore, the coefficient of -2.40 means that, holding annual salary constant, employees with a Successful performance rating are predicted to get raises that are 2.40 percentage points lower, on average, than employees with a High performance rating. In this context, a negative coefficient makes sense since we would expect those with a High performance rating to get higher raises than those with a Successful performance rating.

4.  \(a\) “Poor”, “Successful”, “High”, “Top”.

5.  \(c\) Option 3. It’s a linear model with no interaction effect, so parallel lines. And since the coefficient for `salary_typeSalaried` is positive, the line for Salaried employees has a higher intercept. The equations of the lines are as follows:

    - Hourly:

      \\ \begin{align\*} \widehat{percent\\incr} &= 1.24 + 0.0000137 \times annual\\salary + 0.913 \times salary\\typeSalaried \\ &= 1.24 + 0.0000137 \times annual\\salary + 0.913 \times 0 \\ &= 1.24 + 0.0000137 \times annual\\salary \end{align\*} \\

    - Salaried:

      \\ \begin{align\*} \widehat{percent\\incr} &= 1.24 + 0.0000137 \times annual\\salary + 0.913 \times salary\\typeSalaried \\ &= 1.24 + 0.0000137 \times annual\\salary + 0.913 \times 1 \\ &= 2.153 + 0.0000137 \times annual\\salary \end{align\*} \\

6.  \(c\) The model predicts that the percentage increase employees with Successful performance get, on average, is higher by a factor of 1025 compared to the employees with Poor performance rating.

7.  The model predicts that employees with an annual salary of \$0 get a raise of 1.87%, on average.

8.  \(d\) `as.numeric(str_remove(runtime, " mins"))`

9.  \(e\) Blue City \\\>\\ Rang De Basanti \\\>\\ Winter Sleep

10. \(b\) 19% of the variability in movie scores is explained by their runtimes.

11. \(a\) summarize

12. \(b\) A value between 0 and 0.434.

13. \(e\) G-rated movies that are 0 minutes in length are predicted to score, on average, 4.525 points.

14. \(c\) All else held constant, for each additional minute of runtime, movie scores will be higher by 0.021 points on average.

15. \(c\) is greater than

16. \(a\) \\\widehat{score} = (4.525 - 0.257) + 0.021 \times runtime\\

17. 1.  Holding runtime constant, R-rated movies are predicted to score, on average, 0.257 points lower than G-rated movies.
    2.  We should compare the models using adjusted R-squared, not R-squared. R-squared always increases (or stays the same) when we add a predictor, even if the predictor isn’t useful, so the increase in R-squared alone doesn’t tell us `rating` is a useful predictor. Adjusted R-squared penalizes for the number of predictors. Adjusted R-squared is slightly higher for `score_runtime_rating_fit` (0.191 vs. 0.187), so we would choose the model with `runtime` and `rating`, though the improvement is quite small and the simpler model may be preferred for parsimony.

18. \(b\) Training: 70%, Testing: 30%. The `prop` argument of `initial_split()` sets the proportion of the data that goes into the training set.

19. - Intercept: For emails with 0 dollar signs, where “winner” doesn’t appear, and without “urgent” in the subject, the model predicts the log-odds of the email being spam to be -2.24.
    - `dollar`: Holding all else constant, for each additional dollar sign in an email, the log-odds of the email being spam are predicted to be lower by 0.0597, on average.
    - `winneryes`: Holding all else constant, emails where “winner” appears are predicted to have log-odds of being spam that are higher by 1.63, on average, compared to emails where “winner” doesn’t appear.
    - `urgent_subj1`: Holding all else constant, emails with “urgent” in the subject are predicted to have log-odds of being spam that are higher by 2.99, on average, compared to emails without “urgent” in the subject.

    (Alternatively, the slopes can be interpreted in terms of odds by exponentiating them: e.g., the odds of an email being spam are predicted to be multiplied by \\e^{1.63} \approx 5.1\\ if “winner” appears in the email, holding all else constant.)

20. - `email_aug_A |>`: Start with the augmented testing data, which contains the observed outcome (`spam`) as well as the model’s predicted probabilities (`.pred_0`, `.pred_1`) and predicted class (`.pred_class`) for each email in the testing set.
    - `group_by(spam) |>`: Group the data by the observed outcome, i.e., whether the email is actually spam (`1`) or not (`0`).
    - `count(.pred_class)`: Within each group, count the number of emails predicted to be in each class.

    Together, the pipeline computes the confusion matrix: the number of emails in each combination of actual (`spam`) and predicted (`.pred_class`) class, i.e., the numbers of true negatives, false positives, false negatives, and true positives.

21. The row for emails that are actually spam (`spam` = 1) and predicted to be spam (`.pred_class` = 1) is missing. This is because the model never predicts any email in the testing set to be spam, so there are 0 emails in this combination, and `count()` doesn’t show combinations with no observations.

22. - False positive rate = (number of emails that are not spam but are predicted to be spam) / (number of emails that are not spam) = \\\frac{FP}{FP + TN}\\ = \\\frac{1}{1072 + 1}\\
    - False negative rate = (number of emails that are spam but are predicted to be not spam) / (number of emails that are spam) = \\\frac{FN}{FN + TP}\\ = \\\frac{104}{104 + 0}\\

23. 1.  x-axis: 1 - specificity (i.e., the false positive rate), y-axis: sensitivity (i.e., the true positive rate).
    2.  The diagonal line represents a model that classifies at random, i.e., a model that is no better than guessing (area under the curve of 0.5).
    3.  Model B appears to have better classification ability since its ROC curve is closer to the top-left corner of the plot, i.e., it has higher sensitivity for most values of 1 - specificity, and hence a larger area under the curve. Model A’s ROC curve is close to the diagonal line, so it is not much better than guessing.

24. \(b\) `page |> html_elements(".title") |> html_attr("href")`. The `.` in `.title` selects elements with `class="title"`, and the URL is stored in the `href` attribute of the `<a>` element, not in its text, so we need `html_attr("href")`. Option (a) returns the title text, `"On dining at Duke"`, and option (d) returns all attributes (both `class` and `href`), not just the URL. Options (c) and (e) treat `href` as if it were an element (tag), but it’s an attribute, so `html_elements("href")` finds nothing.

25. \(b\) `chronicle |> mutate(article_content = map_chr(url, scrape_article))`. `scrape_article()` works on a single URL, so we need `map_chr()` to apply it to each URL in turn (the vector to iterate over comes first, then the function). `map_chr()` returns a character vector, one value per row, which `mutate()` adds as a new column. Option (a) would result in an error, since `scrape_article()` would pass all 500 URLs to `read_html()` at once, but `read_html()` can only read one page at a time. Option (c) has the arguments of `map_chr()` in the wrong order. Option (e) would create a list column instead of a character column, and option (d) would collapse the data frame to just the `article_content` column.

26. \(a\) and (d).

27. A parsimonious model is the simplest model with the best predictive performance.
