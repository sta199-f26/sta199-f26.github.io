# AE 04: Sales taxes + data joining

Application exercise

# Getting started

## Packages

We’ll use the **tidyverse** package for this analysis.

``` downlit
library(tidyverse)
```

## Data

The data are available in the `data` folder.

``` downlit
sales_taxes <- read_csv("data/sales-taxes-26.csv")
us_regions <- read_csv("data/us-regions.csv")
```

And let’s take a look at the data.

``` downlit
# add code here
```

# Joining

Join the sales tax data with region data and save the joined data frame as a new data frame, not overwriting either data frame that goes into the join.

``` downlit
# add code here
```

Calculate the average sales tax of states in each region. What is surprising in the output?

``` downlit
# add code here
```

Identify the state with `NA` for region.

``` downlit
# add code here
```

Suprised? You shouldn’t be… Read [here](https://en.wikipedia.org/wiki/No_taxation_without_representation#District_of_Columbia) for more information on why you shouldn’t be surprised.

Apply a fix for the `NA` in region, and calculate the mean sales taxes for regions again. Display the results in ascending order of mean sales tax.

``` downlit
# add code here
```

# Joining another way

Accomplish the same task using a different join this time.

``` downlit
# add code here
```
