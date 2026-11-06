# GSS 2024 teaching extract

`gss-2024.csv` is a small teaching extract from the 2024 General Social Survey (GSS) Cross-section, Release 3a (July 2026), produced by NORC at the University of Chicago.

It retains respondents with a substantive response to `MARITAL` and contains:

- `year`: GSS survey year;
- `marital_status`: current marital status;
- `age`: respondent age in years (top-coded at 89);
- `education_years`: completed years of formal education;
- `children`: number of children (8 means eight or more);
- `happiness`: self-reported general happiness;
- `health`: self-reported general health;
- `employment_status`: current employment status;
- `party_id`: party identification.

The source file is [GSS 1972--2024 Cross-Sectional Cumulative Data, Release 3a](https://gss.norc.org/content/dam/gss/get-the-data/documents/stata/GSS_stata.zip). The preparation script is `gss-2024-prep.R`.

Use the data descriptively: it is a cross-sectional survey, so associations do not establish causation. `happiness`, `health`, `employment_status`, and `party_id` retain `NA` when the original response was non-substantive (for example, "don't know" or "no answer"). The extract intentionally does not impute missing responses.


## Expanded extract for HW 6

`gss-2024-more-cols.csv` retains the same rows and original nine columns as
`gss-2024.csv`, and adds:

- `natsci`: views on government spending on scientific research ("Too little",
  "About right", or "Too much");
- `polviews`: political views, from "Extremely liberal" to "Extremely conservative",
  including "Moderate, middle of the road";
- `consci`: confidence in the people running the scientific community ("A great
  deal", "Only some", or "Hardly any");
- `techesy`: agreement that technology makes life easier;
- `harmgood1`: agreement that technology does more harm than good;
- `nextgen1`: agreement that technology provides more opportunities.

The three technology variables use five response levels, from "Strongly agree"
to "Strongly disagree", including "Neither agree nor disagree". "Can't choose"
is treated as a non-substantive response and recorded as `NA`.
HW 6 focuses on `natsci`, `education_years`, and `polviews`; the additional
science and technology variables are included for other analyses.

Education is already included as `education_years` (source variable `EDUC`).
Non-substantive responses in the added columns are recorded as `NA`; no rows are
dropped for missing values in these columns. The homework asks students to remove
incomplete cases and recode the categories themselves.

`ADVFRONT` is present in the cumulative source but has no substantive responses
in 2024, so this extract uses `NATSCI` instead. See the
[2024 Release 3a codebook](https://gss.norc.org/content/dam/gss/get-documentation/pdf/codebook/GSS%202024%20Codebook%20R3a.pdf)
for question descriptions and response codes.

To regenerate the expanded CSV from the repository root:

```sh
Rscript _data/gss/gss-2024-more-cols-prep.R
```

The script downloads the same Release 3a source archive linked above. To reuse an
already extracted source file, pass its path as the first argument:

```sh
Rscript _data/gss/gss-2024-more-cols-prep.R /path/to/gss7224_r3a.dta
```
