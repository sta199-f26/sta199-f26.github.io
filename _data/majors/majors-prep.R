library(tidyverse)
library(readxl)

major_files <- list.files(
  here::here("_data", "majors"),
  pattern = "\\.xlsx?$",
  full.names = TRUE
)

# Keep primary and secondary majors (BS, BS2, AB, AB2) and minors.
majors_raw <- tibble(file = major_files) |>
  mutate(
    department = str_remove(str_extract(file, "[^/]+$"), "\\.xlsx?$"),
    data = map(file, read_excel)
  ) |>
  select(department, data) |>
  unnest(data) |>
  filter(
    !str_detect(`Final description of plan`, "^Interdepartmental"),
    str_detect(
      `Final description of plan`,
      "\\((BS|BS2|AB|AB2)\\) - (Major|Secondary)$| - Minor$"
    ),
    !(department == "Computer Science" &
      str_detect(`Final description of plan`, " - Minor$") &
      `Final description of plan` != "Computer Science - Minor - Minor")
  )

names(majors_raw) <- c("department", "academic_plan", "year", "degree", "count")

majors_long <- majors_raw |>
  mutate(
    academic_plan = case_when(
      str_detect(academic_plan, "(BS2)") ~ "BS2",
      str_detect(academic_plan, "(BS)") ~ "BS",
      str_detect(academic_plan, "(AB2)") ~ "BA2",
      str_detect(academic_plan, "(AB)") ~ "BA",
      str_detect(academic_plan, "Minor") ~ "Minor",
      .default = academic_plan
    )
  ) |>
  select(!c(degree))

majors <- majors_long |>
  pivot_wider(
    id_cols = c(department, academic_plan),
    names_from = year,
    values_from = count
  )

write_csv(majors, "_data/majors/majors.csv")
write_csv(majors, "slides/data/majors.csv")

majors_plot_data <- majors |>
  filter(academic_plan != "Minor") |>
  pivot_longer(
    cols = -c(department, academic_plan),
    names_to = "year",
    values_to = "count",
    names_transform = list(year = as.integer)
  ) |>
  mutate(
    count = replace_na(count, 0),
    academic_plan = factor(academic_plan, levels = c("BS", "BS2", "BA", "BA2"))
  )

ggplot(
  majors_plot_data,
  aes(x = year, y = count, color = academic_plan)
) +
  geom_line(aes(linetype = academic_plan), linewidth = 1.1, na.rm = TRUE) +
  geom_point(size = 1) +
  facet_grid(
    cols = vars(department),
    labeller = labeller(department = label_wrap_gen(width = 15)),
    scales = "free_y"
  ) +
  scale_color_viridis_d(option = "D", end = 0.8) +
  scale_linetype_manual(
    values = c(
      BS = "solid",
      BS2 = "dashed",
      BA = "solid",
      BA2 = "dashed"
    )
  ) +
  scale_x_continuous(
    breaks = c(2012, 2019, 2026),
    labels = function(x) sprintf("'%02d", as.integer(x) %% 100)
  ) +
  scale_y_continuous(limits = c(0, NA), expand = expansion(mult = c(0, 0.08))) +
  labs(
    title = "Majors across departments",
    subtitle = "Duke University | Completions by academic year",
    x = NULL,
    y = "Number of graduates",
    color = NULL,
    linetype = NULL,
    caption = "BS2 and BA2 indicate second majors. Missing counts are treated as zero."
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", size = 20, color = "#012169"),
    plot.subtitle = element_text(color = "grey40", margin = margin(b = 15)),
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank(),
    strip.text = element_text(face = "bold", hjust = 0),
    legend.position = "inside",
    legend.position.inside = c(0.97, 0.97),
    legend.justification = c("right", "top"),
    legend.direction = "horizontal",
    legend.background = element_rect(fill = "white", color = NA),
    plot.caption = element_text(color = "grey45", hjust = 0),
    plot.margin = margin(15, 20, 15, 15)
  )
