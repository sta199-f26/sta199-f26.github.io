# HW 7 Rubric

Rubric

HW

This is the rubric for AI feedback, not necessarily the rubric for grading. It follows the question numbering and content of the current `hw-7.qmd`.

# Feedback guidance

- Review the student’s submitted work against the assignment and these criteria. Identify what is correct, what needs attention, and why; offer focused prompts for revision rather than completed answers or replacement code.
- Do not supply undiscovered thresholds, numerical estimates, interval bounds, p-values, test decisions, or substantive conclusions. Check these against the student’s code, output, and data when available.
- Accept equivalent valid approaches unless the assignment explicitly requires a particular method or a single pipeline. Use the course’s tidyverse and tidymodels conventions when giving code feedback.
- Simulation results may vary with the seed. Check the method and consistency of the results rather than requiring a particular numerical answer.
- Identify an upstream error once, then distinguish its downstream consequences from new errors. Evaluate interpretations against the student’s displayed results while noting any effect on the requested analysis.
- If source code, rendered output, reference images, data, or GitHub history are unavailable, state which checks cannot be verified. Do not infer completion from a claim alone.

# Part 1 - Babies

## Question 1

1.  Code reads the supplied birth data and saves the unmodified data frame as `births14_raw`.

2.  A single pipeline identifies rows missing at least one of the five specified variables, without requiring all five values to be missing.

3.  Output displays only the five requested variables and includes all qualifying rows.

4.  Code handles missing values explicitly and does not filter on unrelated variables.

## Question 2

1.  A single pipeline starts from `births14_raw` and removes rows with missing values among the variables identified in Question 1.

2.  Missing values in unrelated columns do not cause additional rows to be discarded.

3.  Code saves the result as `births14` and retains the original columns.

4.  Code obtains the dimensions of the updated data frame, and the narrative states both the number of rows and the number of columns consistently with that output and the assignment’s row-count check.

## Question 3

1.  The analysis uses the birth data to investigate the relationship between mother’s age and the recorded maturity categories, rather than relying on medical knowledge or external sources.

2.  Displayed summary statistics and/or a visualization provide enough evidence to locate the boundary between categories.

3.  The narrative describes the investigation and states a threshold with clear boundary conventions consistent with the displayed evidence.

4.  The conclusion distinguishes an age-category rule from a statement about average ages within categories.

## Question 4

1.  The analysis uses the birth data to investigate the relationship between recorded weight and the low-birthweight categories, rather than relying on medical knowledge or external sources.

2.  Displayed summary statistics and/or a visualization examine the category boundary closely enough to support the proposed threshold.

3.  The narrative describes the investigation and states a threshold in the correct units, supported by the displayed evidence.

4.  The response checks whether the proposed classification rule accounts for observations at the boundary and acknowledges any ambiguity or exceptions in the recorded data rather than asserting an unsupported exact separation.

## Question 5

1.  A single pipeline recodes all three requested categorical variables with the exact labels specified in the assignment.

2.  Recoding preserves each observation’s category membership and does not introduce unintended missing values.

3.  The same pipeline moves the three recoded variables to the front, in the requested order, and saves the result back to `births14`.

4.  Output displays the first 10 rows of the updated data frame. Displaying only the columns that fit across the page is acceptable.

## Question 6

1.  Part (a). A single pipeline produces a summary table from the prepared `births14` data, with the same group combinations, rows, columns, and ordering as the reference table.

2.  Part (a). Counts are calculated correctly for each displayed category within each combination of mother’s age category and smoking status.

3.  Part (a). Each displayed percentage uses the appropriate group total as its denominator, with rounding and percentage formatting matching the reference.

4.  Part (a). The rendered table has the requested column names, caption, and table number. Check the rendered document when numbering cannot be verified from source alone.

5.  Part (b). The bar plot reproduces the reference’s variable mappings, bar arrangement, faceting, and axis scales.

6.  Part (b). The plot reproduces the reference’s title, axis labels, category labels, legend labels and position, and other visible details. Figure width and aspect ratio are reasonably close; exact dimensions are not required.

7.  Part (c). In 1–2 sentences, the narrative identifies a specific misleading feature and explains its consequence for comparison, using evidence from the table and plot.

8.  Part (d). The revised visualization addresses the identified issue and supports the intended comparison of low-birthweight prevalence across groups.

9.  Part (d). Any calculated quantities use denominators appropriate to the stated conditional comparison; axis labels and scales accurately describe what is displayed.

10. Part (d). The explanation states what changed, why the choice improves the comparison, and what the revised plot shows. Claims agree with the plotted data and avoid causal interpretations.

## Question 7

1.  Part (a). Code fits the requested linear regression using baby weight as the response and mother’s age category as a categorical predictor, with the prepared `births14` data.

2.  Part (a). Code uses the course’s tidymodels workflow and displays tidy coefficient output.

3.  Part (b). Code sets a seed and generates 1,000 bootstrap resamples of observations, preserving response–predictor pairs and fitting the same model to each resample.

4.  Part (b). Code constructs and displays a 95% percentile bootstrap confidence interval for the requested non-intercept coefficient.

5.  Part (b). The interpretation states the confidence level, interval bounds, weight units, average or expected comparison, and comparison direction consistently with the fitted reference category.

6.  Part (b). The interval is interpreted as uncertainty about a population mean difference, rather than an interval containing individual baby weights or a probability assigned to the fixed parameter.

7.  Part (c). The plot displays the bootstrap slope distribution actually used for the interval, with readable labels identifying the coefficient and units.

8.  Part (c). The description of shape and center agrees with the displayed distribution and relates its center to the observed coefficient.

9.  Part (d). The conclusion about a discernible difference follows from the displayed confidence interval, explains the relevance of the null value, and addresses the specified groups in context. No separate hypothesis test is required.

## Question 8

1.  Part (a). Code fits the requested additive linear regression using baby weight as the response, mother’s numeric age and categorical smoking status as predictors, and the prepared `births14` data.

2.  Part (a). Code uses the course’s tidymodels workflow and displays tidy coefficient output.

3.  Part (b). Code sets a seed, generates 1,000 bootstrap resamples of complete observations, and fits the same two-predictor model to each resample.

4.  Part (b). Code constructs and displays separate 95% percentile bootstrap confidence intervals for both requested non-intercept coefficients, with each interval clearly identified.

5.  Part (b). The numeric-age interval interpretation states the confidence level, bounds, response units, and average or expected difference for a one-year age increment, holding smoking status constant.

6.  Part (b). The smoking-status interval interpretation states the confidence level, bounds, response units, and average or expected comparison between the fitted categories, holding mother’s age constant.

7.  Part (b). Both interpretations agree with the coefficient signs, reference category, and displayed intervals, and avoid causal claims or claims about individual outcomes.

8.  Part (c). Plots display the bootstrap distributions used for both slope intervals, with labels that distinguish the coefficients and their units.

9.  Part (c). Descriptions of shapes and centers agree with the displayed distributions and relate the centers to the corresponding observed coefficients.

# Part 2 - Lemurs

## Data preparation for Questions 9 and 10

1.  Code reads the supplied lemur file and saves the unmodified data frame as `lemurs_raw`.

2.  Code applies both filtering conditions specified in the assignment and saves the result as `lemurs`.

3.  The analysis data agree with the assignment’s row-count check and contain one observation per distinct animal identifier.

4.  Both questions use this filtered data frame consistently. Age refers to age at weighing, and weight refers to the measurement taken on that date.

## Question 9

1.  Part (a). A scatterplot places age at weighing on the x-axis and weight on the y-axis and includes a fitted linear regression line.

2.  Part (a). Axis labels are readable and include the appropriate units.

3.  Part (a). The narrative accurately describes the relationship shown and supports its assessment of a linear model with visible features of the plot. It does not treat a fitted line alone as evidence of linearity.

4.  Part (b). Code fits the requested linear model to the filtered lemurs and displays tidy coefficient output using the course’s tidymodels workflow.

5.  Part (b). The slope interpretation agrees with the fitted estimate, uses grams per day, and describes an average or expected weight comparison for a one-day difference in age within the stated population and age range.

6.  Part (c). Hypotheses concern the population slope, identify the relevant variables and population, and match a two-sided test. Sample estimates are not presented as population hypotheses.

7.  Part (c). Code calculates the observed slope from the original filtered data, consistent with the model in part (b).

8.  Part (c). Code sets a seed and generates 1,000 permutations under the specified independence null, breaking the pairing between age and weight while retaining their observed marginal values.

9.  Part (c). Each permutation produces the same slope statistic as the observed analysis. Bootstrap resampling and a model summary’s theoretical p-value do not replace the requested permutation procedure.

10. Part (c). The randomization distribution is visualized with readable labels identifying the slope statistic and units.

11. Part (c). Code calculates and displays a two-sided p-value using the observed slope and the simulated null distribution.

12. Part (c). If no simulated statistics are at least as extreme as the observed statistic, feedback distinguishes finite simulation resolution from a claim that the true p-value is exactly zero.

13. Part (d). The hypothesis decision follows from the reported p-value and specified discernability level, and a one-sentence conclusion addresses the research question in context.

14. Part (d). The conclusion distinguishes evidence about an association from proof of a hypothesis or a causal effect, and does not generalize to other taxa or ages without justification.

## Question 10

1.  Part (a). The predicted inclusion or exclusion of the null value is justified using the student’s hypothesis test in Question 9 and treats test–interval agreement as an expectation rather than a guarantee.

2.  Part (b). Code sets a seed and generates 1,000 bootstrap resamples of complete observations from the filtered lemurs, retaining the age–weight pair within each sampled row.

3.  Part (b). Code refits the same model and extracts its age slope for each resample, rather than permuting values or using the intercept.

4.  Part (b). Code constructs and displays the requested 95% percentile bootstrap interval using the bootstrap slope distribution.

5.  Part (c). The visualization displays the same bootstrap slope distribution used to construct the interval, with readable labels and units.

6.  Part (c). The description of shape and center agrees with the displayed distribution and the observed estimate.

7.  Part (c). The comparison of distribution centers correctly explains the different purposes and generation processes of the bootstrap and randomization procedures, rather than attributing the distinction merely to different seeds.

8.  Part (d). The interval interpretation includes the confidence level, reported bounds, slope units, average or expected comparison, and relevant taxon and age range.

9.  Part (d). The response correctly reports whether the displayed interval contains the null value and compares that finding with the hypothesis test, without requiring exact agreement between the two procedures.

10. Part (e). The response evaluates the proposed individual-growth interpretation using the observational unit and measurement structure, and explains which kind of conclusion the fitted slope supports. Feedback should prompt the student to reason from the study design rather than supply the conclusion.

# Overall

These criteria apply throughout the homework. Check them when asked for overall feedback, when noticed during a question review, or as the student finishes the assignment.

1.  Code is readable, with appropriate indentation, line breaks after pipes and plot layers, spaces around assignment and named arguments, and spaces after commas. Consistent indentation with two spaces, four spaces, or tabs is acceptable.

2.  Code uses appropriate course tools without unnecessary package reloading, redundant steps, or hard-coded analytical results. Equivalent valid implementations are acceptable.

3.  Code, displayed output, and narrative agree. Labels distinguish populations, groups, parameters, statistics, and units clearly.

4.  The document renders successfully and is organized so questions, lettered parts, plots, and interpretations are easy to locate.

5.  The final `.qmd` and rendered PDF exist in the remote GitHub repository, and at least three commits have been made and pushed. Verify repository evidence when available; otherwise mark these checks as unverified.

6.  The AI-use disclosure states whether an LLM or generative AI tool was used and, if so, describes its uses and lists tools and model names and versions if known.

7.  Non-AI sources used are cited with the questions for which they were used.
