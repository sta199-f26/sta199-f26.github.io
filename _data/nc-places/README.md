# North Carolina CDC PLACES data

## Source

- [CDC PLACES: Local Data for Better Health, County Data, 2025 release](https://data.cdc.gov/500-Cities-Places/PLACES-Local-Data-for-Better-Health-County-Data-20/swc5-untb)
- Retrieved October 19, 2026 through the CDC Open Data API.
- The 2025 release uses 2023 Behavioral Risk Factor Surveillance System data
  for 35 measures. Short sleep and four other biennial measures use 2022 data.

CDC PLACES publishes model-based small-area estimates rather than direct county
survey estimates. See the [PLACES methodology](https://www.cdc.gov/places/methodology/)
for details.

## Data preparation

Run `nc-places-prep.R` from the project root. The script:

1. downloads North Carolina county records from the 2025 release;
2. retains age-adjusted prevalence estimates for every available measure;
3. reshapes the records to one row per county; and
4. writes `nc-places.csv` here and to `slides/data/`.

The resulting file has 100 rows (one per North Carolina county), three county
identifier columns, and all 40 age-adjusted measure columns in the current
release. The single-predictor regression lesson selects three columns from this
file; the remaining columns are available for later modeling lessons. Measure
names are generated from the CDC short question text, so newly added measures
will be retained automatically.

## Variables

- `county`: North Carolina county name.
- `county_fips`: Five-digit county FIPS code.
- `population`: Census 2023 county population estimate.
- `mental_distress`: Percentage of adults whose mental health was not good for at least 14
  of the previous 30 days.
- `loneliness`: Percentage of adults who always, usually, or sometimes feel lonely.
- `lack_social_emotional_support`: Percentage of adults who usually or always lack needed
  social and emotional support.
- `food_insecurity`: Percentage of adults experiencing food insecurity during the previous
  12 months.
- `housing_insecurity`: Percentage of adults experiencing housing insecurity during the
  previous 12 months.
- `transportation_barrier`: Percentage of adults for whom a lack of reliable
  transportation created a barrier during the previous 12 months.
- `uninsured`: Percentage of adults aged 18–64 without current health insurance.
- `smoking`: Percentage of adults who currently smoke cigarettes.
- `physical_inactivity`: Percentage of adults reporting no leisure-time physical activity
  during the previous month.
- `short_sleep`: Percentage of adults who usually sleep fewer than seven hours in a
  24-hour period.
- `obesity`: Percentage of adults with a body mass index of at least 30 kg/m² based on
  self-reported height and weight.
- `depression`: Percentage of adults ever told by a health professional that they had a
  depressive disorder.
- `fair_or_poor_health`: Percentage of adults reporting fair or poor general health.

Additional measures in the current release:

- `all_teeth_lost`: Percentage of adults aged 65 years or older who have lost all their teeth.
- `annual_checkup`: Percentage of adults who had a routine checkup within the previous year.
- `any_disability`: Percentage of adults with any disability.
- `arthritis`: Percentage of adults with arthritis.
- `binge_drinking`: Percentage of adults reporting binge drinking.
- `cancer_non_skin_or_melanoma`: Percentage of adults with non-skin cancer or melanoma.
- `cholesterol_screening`: Percentage of adults who received cholesterol screening.
- `cognitive_disability`: Percentage of adults with a cognitive disability.
- `colorectal_cancer_screening`: Percentage of adults aged 45–75 years who received colorectal cancer screening.
- `copd`: Percentage of adults with chronic obstructive pulmonary disease.
- `coronary_heart_disease`: Percentage of adults with coronary heart disease.
- `current_asthma`: Percentage of adults with current asthma.
- `dental_visit`: Percentage of adults who had a dental visit within the previous year.
- `diabetes`: Percentage of adults with diagnosed diabetes.
- `food_stamps`: Percentage of adults who received food stamps during the previous 12 months.
- `frequent_physical_distress`: Percentage of adults whose physical health was not good for at least 14 of
  the previous 30 days.
- `hearing_disability`: Percentage of adults with a hearing disability.
- `high_blood_pressure_medication`: Percentage of adults with high blood
  pressure who take medication for it.
- `high_blood_pressure`: Percentage of adults with high blood pressure.
- `high_cholesterol`: Percentage of adults with high cholesterol among those who have had their
  cholesterol screened.
- `independent_living_disability`: Percentage of adults with an independent-living disability.
- `mammography`: Percentage of women aged 50–74 years who received a mammogram.
- `mobility_disability`: Percentage of adults with a mobility disability.
- `self_care_disability`: Percentage of adults with a self-care disability.
- `stroke`: Percentage of adults who have had a stroke.
- `utility_services_threat`: Percentage of adults who experienced a threat of utility shut-off during the previous
  12 months.
- `vision_disability`: Percentage of adults with a vision disability.

All percentage columns are age-adjusted prevalence estimates from the same
PLACES release. These estimates share a common modeling procedure and can be
highly correlated. Future multiple-regression lessons should use a small,
substantively motivated subset rather than treating all columns as
interchangeable candidate predictors.
