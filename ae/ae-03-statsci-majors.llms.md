# AE 03: Tidying Stat Sci majors

Application exercise

> **IMPORTANT:**
>
> These are suggested answers. This document should be used as reference only, it’s not designed to be an exhaustive key.

## Data

The data come from the [Office of the University Registrar](https://registrar.duke.edu/registration/enrollment-statistics).

``` downlit
library(tidyverse)

majors <- read_csv("data/majors.csv")

statsci_majors <- majors |>
  filter(
    department == "Statistical Science",
    academic_plan != "Minor"
  )
```

And let’s take a look at the data.

``` downlit
statsci_majors
```

    # A tibble: 4 × 17
      department      academic_plan `2026` `2025` `2024` `2023` `2022` `2021` `2020`
      <chr>           <chr>          <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>
    1 Statistical Sc… BS                49     45     39     54     32     35     27
    2 Statistical Sc… BS2               28     23     20     27     16     17     17
    3 Statistical Sc… BA                 2     NA      1      2     NA     NA      1
    4 Statistical Sc… BA2                1     NA     NA     NA     NA      2      1
    # ℹ 8 more variables: `2019` <dbl>, `2018` <dbl>, `2017` <dbl>, `2016` <dbl>,
    #   `2015` <dbl>, `2014` <dbl>, `2013` <dbl>, `2012` <dbl>

## Pivoting

- **Demo:** Pivot the `statsci` data frame *longer* such that:

  - Each row represents a degree type / year combination
  - `year` and `n`umber of graduates for that year are columns in the data frame
  - The resulting `year` column is numeric

``` downlit
# add code here
```

- **Your Turn:** Now, repeat your code from above, but this time **save the result** to a **new** variable name.

``` downlit
# add code here
```

## Plotting

- **Your turn:** Now we will start making our plot, but let’s not get too fancy right away. Just get the geoms right for now and use default colors for different academic plans.

``` downlit
# add code here
```

- **Question**: Why was the pivot necessary in order to create this plot?

*Add your response here!*

- **Question:** What aspects of the plot need to be updated still?

*Add your response here.*

- **Demo:** Update `statsci_majors_longer` to fix the discontinuities.

``` downlit
# add code here
```

- **Demo:** Update x-axis scale such that the years displayed go from 2012 to 2026 in increments of 2 years. Do this by adding on to your pipeline from earlier.

``` downlit
# add code here
```

- **Demo:** Update line colors using the following level / color assignments. Once again, do this by adding on to your pipeline from earlier.
  - “BS” = “cadetblue4”

  - “BS2” = “cadetblue3”

  - “BA” = “lightgoldenrod4”

  - “BA2” = “lightgoldenrod3”

``` downlit
# add code here
```

- **Your turn:** Update the plot labels (`title`, `subtitle`, `x`, `y`, and `caption`) and use [`theme_minimal()`](https://ggplot2.tidyverse.org/reference/ggtheme.html). Once again, do this by adding on to your pipeline from earlier.

``` downlit
# add code here
```

- **Demo:** Move the legend into the plot, make its background white, and its border gray.

``` downlit
# add code here
```

- **Demo:** Finally, set `fig-width: 8` and `fig-height: 5` for your plot in the chunk options.

``` downlit
# add code here
```
