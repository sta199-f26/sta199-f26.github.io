# Presentation

Milestone 6

Project

# Presentation + slides

## Slides

In addition to the written report, your team will also create presentation slides and deliver a presentation that summarize and showcase your project. Introduce your research question and dataset, showcase visualizations, and discuss the primary conclusions. These slides should serve as a brief visual addition to your written report and will be graded for content and quality.

You can create your slides with any software you like (Keynote, PowerPoint, Google Slides, etc.). We recommend choosing an option that’s easy to collaborate with, e.g., Google Slides. If you choose this option, save the slides as a PDF and upload it to your repo as `presentation.pdf`.

You can also use Quarto to make your slides! While we won’t be covering making slides with Quarto in the class, we would be happy to help you with it in office hours. It’s no different than writing other documents with Quarto, so the learning curve will not be steep!

The slide deck should be roughly 6 content slides + 1 title slide. Here is a *suggested* outline as you think through the slides; you ***do not*** have to use this exact format for the 6 slides.

- Title Slide
- Slide 1: Introduce the topic and motivation
- Slide 2: Introduce the data
- Slides 3-5: Highlights from EDA
- Slide 6: Conclusions + discussion + critique

## Presentation

Presentations will be in person in lab. All team members must participate in the presentation. **The presentation must be no longer than 5 minutes.**

## Grading

The presentation is worth 20 points, broken down as follows:

| Total            | 20 pts |
|------------------|--------|
| **Slides**       | 10 pts |
| **Presentation** | 10 pts |

### Slides

Are the slides well organized and readable, with concise text and figures that have legible labels, legends, etc.?

### Presentation

- Time management: Did the team divide the time well among themselves and finish within the time limit?
- Professionalism: How well did the team present? Does the presentation appear to be well practiced? Did everyone get a chance to say something meaningful about the project?
- Teamwork: Did the team present a unified story, or did it seem like independent pieces of work patched together?
- Creativity and critical thought: Is the project carefully thought out? Does it appear that time and effort went into the planning and implementation of the project?
- Content: Including, but not limited to the following:
  - Is the question well articulated in the presentation?
  - Can the question be answered with the data?
  - Does the analysis answer the question?
  - Are the conclusion(s) made based on the analysis justifiable?
  - Are the limitations carefully considered and articulated?

### Presentation order

``` downlit
library(tidyverse)
library(gt)
library(googlesheets4)
gs4_deauth()

make_presentation_table <- function(df) {
  df |>
    mutate(team_name = paste0("[", team_name, "](", repo_url, ")")) |>
    mutate(presentation = paste0("[pdf](", presentation_url, ")")) |>
    select(-repo_url, -presentation_url)  |>
    relocate(team_name, presentation) |>
    gt() |>
    fmt_markdown(
      columns = everything() 
    ) |>
    cols_label(
      team_name = "Team",
      presentation = "Presentation",
      teams_for_feedback = "Teams to Give Feedback To"
    )
}
```

## L1 - 8:30 am

| Team | Presentation | Teams to Give Feedback To |
|----|----|----|
| [magic](https://github.com/sta199-f26/project-magic) | [pdf](https://sta199-f26.github.io/project-magic/presentation.pdf) | fantastic4, garden, team |
| [fantastic4](https://github.com/sta199-f26/project-fantastic4) | [pdf](https://sta199-f26.github.io/project-fantastic4/presentation.pdf) | garden, team, geec |
| [garden](https://github.com/sta199-f26/project-garden) | [pdf](https://sta199-f26.github.io/project-garden/presentation.pdf) | team, geec, boom-shakalaka |
| [team](https://github.com/sta199-f26/project-team) | [pdf](https://sta199-f26.github.io/project-team/presentation.pdf) | geec, boom-shakalaka, brogrammers |
| [geec](https://github.com/sta199-f26/project-geec) | [pdf](https://sta199-f26.github.io/project-geec/presentation.pdf) | boom-shakalaka, brogrammers, magic |
| [boom-shakalaka](https://github.com/sta199-f26/project-boom-shakalaka) | [pdf](https://sta199-f26.github.io/project-boom-shakalaka/presentation.pdf) | brogrammers, magic, fantastic4 |
| [brogrammers](https://github.com/sta199-f26/project-brogrammers) | [pdf](https://sta199-f26.github.io/project-brogrammers/presentation.pdf) | magic, fantastic4, garden |

## L2 - 10:05 am

| Team | Presentation | Teams to Give Feedback To |
|----|----|----|
| [dysfunctional](https://github.com/sta199-f26/project-dysfunctional) | [pdf](https://sta199-f26.github.io/project-dysfunctional/presentation.pdf) | minion, git-good, mines-mean-as |
| [minion](https://github.com/sta199-f26/project-minion) | [pdf](https://sta199-f26.github.io/project-minion/presentation.pdf) | git-good, mines-mean-as, team-199 |
| [git-good](https://github.com/sta199-f26/project-git-good) | [pdf](https://sta199-f26.github.io/project-git-good/presentation.pdf) | mines-mean-as, team-199, awesome |
| [mines-mean-as](https://github.com/sta199-f26/project-mines-mean-as) | [pdf](https://sta199-f26.github.io/project-mines-mean-as/presentation.pdf) | team-199, awesome, statinators |
| [team-199](https://github.com/sta199-f26/project-team-199) | [pdf](https://sta199-f26.github.io/project-team-199/presentation.pdf) | awesome, statinators, dysfunctional |
| [awesome](https://github.com/sta199-f26/project-awesome) | [pdf](https://sta199-f26.github.io/project-awesome/presentation.pdf) | statinators, dysfunctional, minion |
| [statinators](https://github.com/sta199-f26/project-statinators) | [pdf](https://sta199-f26.github.io/project-statinators/presentation.pdf) | dysfunctional, minion, git-good |

## L3 - 10:05 am

| Team | Presentation | Teams to Give Feedback To |
|----|----|----|
| [stats-stars](https://github.com/sta199-f26/project-stats-stars) | [pdf](https://sta199-f26.github.io/project-stats-stars/presentation.pdf) | rdvarks, rainbow-unicorns, mines-children |
| [rdvarks](https://github.com/sta199-f26/project-rdvarks) | [pdf](https://sta199-f26.github.io/project-rdvarks/presentation.pdf) | rainbow-unicorns, mines-children, p-devils |
| [rainbow-unicorns](https://github.com/sta199-f26/project-rainbow-unicorns) | [pdf](https://sta199-f26.github.io/project-rainbow-unicorns/presentation.pdf) | mines-children, p-devils, stat-warriors |
| [mines-children](https://github.com/sta199-f26/project-mines-children) | [pdf](https://sta199-f26.github.io/project-mines-children/presentation.pdf) | p-devils, stat-warriors, stats-stars |
| [p-devils](https://github.com/sta199-f26/project-p-devils) | [pdf](https://sta199-f26.github.io/project-p-devils/presentation.pdf) | stat-warriors, stats-stars, rdvarks |
| [stat-warriors](https://github.com/sta199-f26/project-stat-warriors) | [pdf](https://sta199-f26.github.io/project-stat-warriors/presentation.pdf) | stats-stars, rdvarks, rainbow-unicorns |

## L4 - 11:45 am

| Team | Presentation | Teams to Give Feedback To |
|----|----|----|
| [green-apple](https://github.com/sta199-f26/project-green-apple) | [pdf](https://sta199-f26.github.io/project-green-apple/presentation.pdf) | mean-girls, confident-stats-victors, the-standard-deviants |
| [mean-girls](https://github.com/sta199-f26/project-mean-girls) | [pdf](https://sta199-f26.github.io/project-mean-girls/presentation.pdf) | confident-stats-victors, the-standard-deviants, the-outliers |
| [confident-stats-victors](https://github.com/sta199-f26/project-confident-stats-victors) | [pdf](https://sta199-f26.github.io/project-confident-stats-victors/presentation.pdf) | the-standard-deviants, the-outliers, freshman-core |
| [the-standard-deviants](https://github.com/sta199-f26/project-the-standard-deviants) | [pdf](https://sta199-f26.github.io/project-the-standard-deviants/presentation.pdf) | the-outliers, freshman-core, green-apple |
| [the-outliers](https://github.com/sta199-f26/project-the-outliers) | [pdf](https://sta199-f26.github.io/project-the-outliers/presentation.pdf) | freshman-core, green-apple, mean-girls |
| [freshman-core](https://github.com/sta199-f26/project-freshman-core) | [pdf](https://sta199-f26.github.io/project-freshman-core/presentation.pdf) | green-apple, mean-girls, confident-stats-victors |

## L5 - 11:45 am

| Team | Presentation | Teams to Give Feedback To |
|----|----|----|
| [commit-and-push](https://github.com/sta199-f26/project-commit-and-push) | [pdf](https://sta199-f26.github.io/project-commit-and-push/presentation.pdf) | the-best-team, standard-deviants, github-goblins |
| [the-best-team](https://github.com/sta199-f26/project-the-best-team) | [pdf](https://sta199-f26.github.io/project-the-best-team/presentation.pdf) | standard-deviants, github-goblins, limsanity |
| [standard-deviants](https://github.com/sta199-f26/project-standard-deviants) | [pdf](https://sta199-f26.github.io/project-standard-deviants/presentation.pdf) | github-goblins, limsanity, penguins-of-madagascar |
| [github-goblins](https://github.com/sta199-f26/project-github-goblins) | [pdf](https://sta199-f26.github.io/project-github-goblins/presentation.pdf) | limsanity, penguins-of-madagascar, commit-and-push |
| [limsanity](https://github.com/sta199-f26/project-limsanity) | [pdf](https://sta199-f26.github.io/project-limsanity/presentation.pdf) | penguins-of-madagascar, commit-and-push, the-best-team |
| [penguins-of-madagascar](https://github.com/sta199-f26/project-penguins-of-madagascar) | [pdf](https://sta199-f26.github.io/project-penguins-of-madagascar/presentation.pdf) | commit-and-push, the-best-team, standard-deviants |

## L6 - 1:25 pm

| Team | Presentation | Teams to Give Feedback To |
|----|----|----|
| [statistically-significant](https://github.com/sta199-f26/project-statistically-significant) | [pdf](https://sta199-f26.github.io/project-statistically-significant/presentation.pdf) | the-confidence-intervals, the-dinosaurs, j-o-k-e |
| [the-confidence-intervals](https://github.com/sta199-f26/project-the-confidence-intervals) | [pdf](https://sta199-f26.github.io/project-the-confidence-intervals/presentation.pdf) | the-dinosaurs, j-o-k-e, super-seniors |
| [the-dinosaurs](https://github.com/sta199-f26/project-the-dinosaurs) | [pdf](https://sta199-f26.github.io/project-the-dinosaurs/presentation.pdf) | j-o-k-e, super-seniors, not-your-standard-deviation |
| [j-o-k-e](https://github.com/sta199-f26/project-j-o-k-e) | [pdf](https://sta199-f26.github.io/project-j-o-k-e/presentation.pdf) | super-seniors, not-your-standard-deviation, group-by-szn |
| [super-seniors](https://github.com/sta199-f26/project-super-seniors) | [pdf](https://sta199-f26.github.io/project-super-seniors/presentation.pdf) | not-your-standard-deviation, group-by-szn, statistically-significant |
| [not-your-standard-deviation](https://github.com/sta199-f26/project-not-your-standard-deviation) | [pdf](https://sta199-f26.github.io/project-not-your-standard-deviation/presentation.pdf) | group-by-szn, statistically-significant, the-confidence-intervals |
| [group-by-szn](https://github.com/sta199-f26/project-group-by-szn) | [pdf](https://sta199-f26.github.io/project-group-by-szn/presentation.pdf) | statistically-significant, the-confidence-intervals, the-dinosaurs |

## L7 - 1:25 pm

| Team | Presentation | Teams to Give Feedback To |
|----|----|----|
| [newbees](https://github.com/sta199-f26/project-newbees) | [pdf](https://sta199-f26.github.io/project-newbees/presentation.pdf) | freshies, lick, joshs-favorites |
| [freshies](https://github.com/sta199-f26/project-freshies) | [pdf](https://sta199-f26.github.io/project-freshies/presentation.pdf) | lick, joshs-favorites, join-by-slay-factor |
| [lick](https://github.com/sta199-f26/project-lick) | [pdf](https://sta199-f26.github.io/project-lick/presentation.pdf) | joshs-favorites, join-by-slay-factor, stat-slayers |
| [joshs-favorites](https://github.com/sta199-f26/project-joshs-favorites) | [pdf](https://sta199-f26.github.io/project-joshs-favorites/presentation.pdf) | join-by-slay-factor, stat-slayers, group-by |
| [join-by-slay-factor](https://github.com/sta199-f26/project-join-by-slay-factor) | [pdf](https://sta199-f26.github.io/project-join-by-slay-factor/presentation.pdf) | stat-slayers, group-by, newbees |
| [stat-slayers](https://github.com/sta199-f26/project-stat-slayers) | [pdf](https://sta199-f26.github.io/project-stat-slayers/presentation.pdf) | group-by, newbees, freshies |
| [group-by](https://github.com/sta199-f26/project-group-by) | [pdf](https://sta199-f26.github.io/project-group-by/presentation.pdf) | newbees, freshies, lick |

## L8 - 3:05 pm

| Team | Presentation | Teams to Give Feedback To |
|----|----|----|
| [error](https://github.com/sta199-f26/project-error) | [pdf](https://sta199-f26.github.io/project-error/presentation.pdf) | fab-five, git-gods, just-kidding |
| [fab-five](https://github.com/sta199-f26/project-fab-five) | [pdf](https://sta199-f26.github.io/project-fab-five/presentation.pdf) | git-gods, just-kidding, java |
| [git-gods](https://github.com/sta199-f26/project-git-gods) | [pdf](https://sta199-f26.github.io/project-git-gods/presentation.pdf) | just-kidding, java, select-sampiyonlar |
| [just-kidding](https://github.com/sta199-f26/project-just-kidding) | [pdf](https://sta199-f26.github.io/project-just-kidding/presentation.pdf) | java, select-sampiyonlar, wakandata |
| [java](https://github.com/sta199-f26/project-java) | [pdf](https://sta199-f26.github.io/project-java/presentation.pdf) | select-sampiyonlar, wakandata, error |
| [select-sampiyonlar](https://github.com/sta199-f26/project-select-sampiyonlar) | [pdf](https://sta199-f26.github.io/project-select-sampiyonlar/presentation.pdf) | wakandata, error, fab-five |
| [wakandata](https://github.com/sta199-f26/project-wakandata) | [pdf](https://sta199-f26.github.io/project-wakandata/presentation.pdf) | error, fab-five, git-gods |

## L9 - 3:05 pm

| Team | Presentation | Teams to Give Feedback To |
|----|----|----|
| [team-tidyverse](https://github.com/sta199-f26/project-team-tidyverse) | [pdf](https://sta199-f26.github.io/project-team-tidyverse/presentation.pdf) | we-r-good-at-stats, r-data-better-than-yours, goodies |
| [we-r-good-at-stats](https://github.com/sta199-f26/project-we-r-good-at-stats) | [pdf](https://sta199-f26.github.io/project-we-r-good-at-stats/presentation.pdf) | r-data-better-than-yours, goodies, team-ggplot |
| [r-data-better-than-yours](https://github.com/sta199-f26/project-r-data-better-than-yours) | [pdf](https://sta199-f26.github.io/project-r-data-better-than-yours/presentation.pdf) | goodies, team-ggplot, team-longer |
| [goodies](https://github.com/sta199-f26/project-goodies) | [pdf](https://sta199-f26.github.io/project-goodies/presentation.pdf) | team-ggplot, team-longer, robbies-rockets |
| [team-ggplot](https://github.com/sta199-f26/project-team-ggplot) | [pdf](https://sta199-f26.github.io/project-team-ggplot/presentation.pdf) | team-longer, robbies-rockets, team-tidyverse |
| [team-longer](https://github.com/sta199-f26/project-team-longer) | [pdf](https://sta199-f26.github.io/project-team-longer/presentation.pdf) | robbies-rockets, team-tidyverse, we-r-good-at-stats |
| [robbies-rockets](https://github.com/sta199-f26/project-robbies-rockets) | [pdf](https://sta199-f26.github.io/project-robbies-rockets/presentation.pdf) | team-tidyverse, we-r-good-at-stats, r-data-better-than-yours |

## L10 - 4:40 pm

| Team | Presentation | Teams to Give Feedback To |
|----|----|----|
| [the-positron-pumpkins](https://github.com/sta199-f26/project-the-positron-pumpkins) | [pdf](https://sta199-f26.github.io/project-the-positron-pumpkins/presentation.pdf) | stats991, the-box-plot-bandits, data_mineRs |
| [stats991](https://github.com/sta199-f26/project-stats991) | [pdf](https://sta199-f26.github.io/project-stats991/presentation.pdf) | the-box-plot-bandits, data_mineRs, team-grizzly |
| [the-box-plot-bandits](https://github.com/sta199-f26/project-the-box-plot-bandits) | [pdf](https://sta199-f26.github.io/project-the-box-plot-bandits/presentation.pdf) | data_mineRs, team-grizzly, data-divas |
| [data_mineRs](https://github.com/sta199-f26/project-data_mineRs) | [pdf](https://sta199-f26.github.io/project-data_mineRs/presentation.pdf) | team-grizzly, data-divas, the-positron-pumpkins |
| [team-grizzly](https://github.com/sta199-f26/project-team-grizzly) | [pdf](https://sta199-f26.github.io/project-team-grizzly/presentation.pdf) | data-divas, the-positron-pumpkins, stats991 |
| [data-divas](https://github.com/sta199-f26/project-data-divas) | [pdf](https://sta199-f26.github.io/project-data-divas/presentation.pdf) | the-positron-pumpkins, stats991, the-box-plot-bandits |
