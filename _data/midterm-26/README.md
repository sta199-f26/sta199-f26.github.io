# midterm-26

## Inputs

- `../gerrymander/gerrymander.csv`: district-level 2020-2024 House results, 2024 presidential results, and state gerrymandering grades. See `../gerrymander/README.md` for its sources.
- `house-seats-projections-<timestamp>.md`: 2026 House seat projections from Decision Desk HQ (<https://votes.decisiondeskhq.com/balance-of-power/2026/house>), copied from the web page at the time in the file name.
- `house-seats-uncalled-<timestamp>.md`: the subset of races Decision Desk HQ had not yet called at that time, copied from the same page.

Snapshots:

| Timestamp | Projections | Uncalled races |
|---|---|---|
| 2026-11-04, 9:38 am | `house-seats-projections-2026-11-04-09-38.md` | not available |
| 2026-11-04, 11:14 am | `house-seats-projections-2026-11-04-11-14.md` | `house-seats-uncalled-2026-11-04-11-14.md` |

## Data prep

1. `house-seats-projections-data-prep.R`: parses the `.md` files into `house-seats-projections-<timestamp>.csv`
2. `midterm-data-prep.R`: merges the projections onto `gerrymander.csv` by `district`

To process a new snapshot, set `timestamp` at the top of both scripts and run them from the project root.

## Interim datasets

`house-seats-projections-<timestamp>.csv` (435 rows, one per voting House seat)

## Final datasets

`midterm-<timestamp>.csv` (443 rows)

- `midterm-2026-11-04-09-38.csv`: 17 columns (no `called_26`)
- `midterm-2026-11-04-11-14.csv`: 18 columns. This is the one the slides use.

### Columns from `gerrymander.csv`

| Column | Description |
|---|---|
| `district` | Congressional district, e.g. `NC-04` (at-large districts are `-00`) |
| `state_abb` | State abbreviation |
| `state` | State name |
| `house_rep_20`, `house_rep_22`, `house_rep_24` | House representative elected in 2020, 2022, 2024 |
| `house_party_20`, `house_party_22`, `house_party_24` | Party of that representative |
| `harris_24` | Harris's 2024 vote share (%) in the district |
| `trump_24` | Trump's 2024 vote share (%) in the district |
| `gerry_22`, `gerry_24`, `gerry_26` | State's congressional map grade (Redistricting Report Card) for the 2022, 2024, and 2026 maps |

### Columns from the Decision Desk HQ snapshot

| Column | Description |
|---|---|
| `rating_26` | Race rating: `Toss-up`, `Lean D`, `Lean R`, `Likely D`, `Likely R`, `Safe D`, `Safe R` |
| `leader_26` | Party ahead (`Democrat` or `Republican`), from the "D +" / "R +" label |
| `margin_26` | Margin shown next to the party (percentage points) |
| `called_26` | `called` or `uncalled`: `uncalled` if the district is listed in `house-seats-uncalled-<timestamp>.md` (11:14 am snapshot onward) |

## Notes

- At-large districts are `-AL` on Decision Desk HQ (e.g. `AK-AL`) and were recoded to `-00` to match `gerrymander.csv`.
- DC's non-voting delegate (`DC-AL`) was dropped.
- Margins shown as `<0.1` were recorded as `0.05`; margins shown as `—` (FL-10, MA-05, MA-07) are `NA`.
- The snapshots don't say whether margins are live vote counts or pre-election estimates, and they sometimes disagree with the rating (e.g., AL-02 is `Lean R` but `D +8`). Check before interpreting.
- 8 districts in `gerrymander.csv` have no 2026 projection because they no longer exist after post-2020 redistricting (CA-53, IL-18, MI-14, MT-00, NY-27, OH-16, PA-18, WV-03). Their `_26` columns are `NA`.
