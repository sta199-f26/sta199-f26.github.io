# AE 02: Gerrymandering + data exploration I

Application exercise

## Getting started

### Packages

We’ll use the **tidyverse** package for this analysis.

``` downlit
library(tidyverse)
```

### Data

``` downlit
gerrymander <- read_csv("data/gerrymander.csv")
```

``` downlit
glimpse(gerrymander)
```

    Rows: 443
    Columns: 14
    $ district       <chr> "AK-00", "AL-01", "AL-02", "AL-03", "AL-04", "AL-05", "…
    $ state_abb      <chr> "AK", "AL", "AL", "AL", "AL", "AL", "AL", "AL", "AR", "…
    $ state          <chr> "Alaska", "Alabama", "Alabama", "Alabama", "Alabama", "…
    $ house_rep_20   <chr> "Don Young", "Jerry Carl", "Barry Moore", "Mike Rogers"…
    $ house_party_20 <chr> "Republican", "Republican", "Republican", "Republican",…
    $ house_rep_22   <chr> "Mary Sattler Peltola", "Jerry L Carl", "Barry Moore", …
    $ house_party_22 <chr> "Democrat", "Republican", "Republican", "Republican", "…
    $ house_rep_24   <chr> "Nick Begich", "Barry Moore", "Shomari Figures", "Mike …
    $ house_party_24 <chr> "Republican", "Republican", "Democrat", "Republican", "…
    $ harris_24      <dbl> 41.41, 21.89, 53.52, 26.18, 15.96, 34.20, 29.68, 61.45,…
    $ trump_24       <dbl> 54.54, 76.94, 45.31, 72.71, 83.02, 64.02, 68.47, 37.50,…
    $ gerry_22       <chr> NA, "F", "F", "F", "F", "F", "F", "F", "C", "C", "C", "…
    $ gerry_24       <chr> NA, "B", "B", "B", "B", "B", "B", "B", "C", "C", "C", "…
    $ gerry_26       <chr> NA, "B", "B", "B", "B", "B", "B", "B", "C", "C", "C", "…

## Districts at the tails

Make side-by-side box plots of percent of vote received by Trump in 2024 Presidential Election by prevalence of gerrymandering. Identify any Congressional Districts that are potential outliers. Are they different from the rest of the Congressional Districts within the given gerrymandering level due to high support or low support for Trump in the 2024 Presidential Election? Which state are they in? Which city are they in?

``` downlit
# add code here
```

## Flips

How does the prevalence of various levels of gerrymandering for the 2026 election vary among Congressional Districts that flipped from Republican to Democrat in the 2024 election compared to the 2022 election? Support your answer with a visualization as well as summary statistics. **Hint:** Calculate the conditional distribution of prevalance of various levels of gerrymandering based on whether a Democrat flipped the seat in the 2024 election compared to the 2022 election.

``` downlit
# add code here
```

``` downlit
# add code here
```

``` downlit
# add code here
```
