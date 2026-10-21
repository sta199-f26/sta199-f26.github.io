# North Carolina county data

## Sources

County population and land area:

- [2020 Decennial Census, P1 race table](https://api.census.gov/data/2020/dec/pl/groups/P1.html), accessed through the `tidycensus` R package on September 7, 2025. The script uses `P1_001N`, the total 2020 population.
- [2020 Census TIGER/Line county files](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.2020.html), accessed through `tidycensus` and `tigris`. The Census `ALAND` field supplies land area in square meters.

County characteristics and education measures:

- [myFutureNC 2026 County Attainment Profiles](https://dashboard.myfuturenc.org/county-data-and-resources/), retrieved September 5, 2026.
- The local source workbook is `2026_MFNC_Attainment_Profile_Data_Summary.xlsx`. Its Sources sheet states that Carolina Demography compiled and calculated the data for myFutureNC. See the [2026 County Profile Data Guidance](https://dashboard.myfuturenc.org/wp-content/uploads/2026/02/2026_myFutureNC_County_Profile_Data_Guidance.pdf) for detailed definitions and source information.

The myFutureNC measures draw on several original sources. Those retained here
include the 2024 five-year American Community Survey, Census Small Area Income
and Poverty Estimates, and North Carolina Department of Public Instruction
data. The year represented therefore varies by measure.

## Variables

- `county`: North Carolina county name.
- `land_area_m2`: County land area in square meters from the Census `ALAND`
  field.
- `land_area_mi2`: County land area in square miles, calculated from
  `land_area_m2`.
- `pop_2020`: Total county population from the 2020 Decennial Census.
- `pop_dens_2020`: 2020 population per square mile of land area.
- `county_type`: myFutureNC peer county classification: `Urban`, `Suburban`,
  `Rural - Metro`, or `Rural - Non-Metro`.
- `median_hh_income`: Median household income in U.S. dollars.
- `p_foreign_born`: Proportion of residents who are foreign born.
- `p_child_poverty`: Proportion of children living below the poverty line.
- `p_single_parent_hh`: Proportion of occupied households headed by an
  unmarried parent.
- `p_broadband`: Proportion of households with broadband internet service.
- `p_home_ownership`: Proportion of occupied housing units that are
  owner-occupied.
- `p_family_sustaining_wage`: Proportion of adults ages 25–44 whose family
  income is at least 300% of the federal poverty line, myFutureNC's threshold
  for a family-sustaining wage.
- `p_edu_lths`: Proportion of adults ages 25–44 whose highest educational
  attainment is less than high school.
- `p_edu_hsged`: Proportion of adults ages 25–44 whose highest educational
  attainment is a high school diploma or GED.
- `p_edu_scnd`: Proportion of adults ages 25–44 whose highest educational
  attainment is some college with no degree.
- `p_edu_ndc`: Estimated proportion of adults ages 25–44 whose highest
  educational attainment is a non-degree credential.
- `p_edu_assoc`: Proportion of adults ages 25–44 whose highest educational
  attainment is an associate degree.
- `p_edu_ba`: Proportion of adults ages 25–44 whose highest educational
  attainment is a bachelor's degree.
- `p_edu_mapl`: Proportion of adults ages 25–44 whose highest educational
  attainment is a master's degree or higher.
- `p_edu_hs_grad_rate`: High school graduation rate for traditional public
  school students.
- `p_edu_chronic_absent_rate`: Chronic absenteeism rate for traditional public
  school students.

The myFutureNC workbook notes that its K–12 profile measures, other than charter
profiles, are limited to traditional public school students. This differs from
state dashboard values that include charter school students.

## Data preparation

Run `nc-county.R` from the project root. The script:

1. downloads 2020 population and geographic data for all U.S. counties;
2. calculates land area in square miles and 2020 population density;
3. filters to North Carolina's 100 counties;
4. reads selected county characteristics and education measures from the
   myFutureNC workbook;
5. joins the two sources by county name; and
6. writes `nc-county.csv` in this directory.

The resulting file has 100 rows, one per North Carolina county, and 22 columns.
Variables beginning with `p_` are proportions stored on a 0–1 scale.
