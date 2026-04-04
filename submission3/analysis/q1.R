# Combine raw df's into master df -----------------------------------------
hcris_raw <- bind_rows(v96, v10) %>%
  filter(year >= 2009 & year <= 2019)


# Identify duplicates -----------------------------------------------------
duplicates <- hcris_raw %>%
  group_by(year, provider_number) %>%
  summarize(report_count = n(), .groups = "drop") %>%
  filter(report_count > 1) %>%
  # Count how many unique hospitals file multiple reports
  group_by(year) %>%
  summarize(num_hospitals_multi = n_distinct(provider_number))


# Plot data ---------------------------------------------------------------
q1 <- ggplot(duplicates, aes(x = year, y = num_hospitals_multi)) +
  geom_line(color = "darkblue", size = 1) +
  geom_point(color = "darkblue", size = 3) +
  scale_x_continuous(breaks = 2009:2019) +
  coord_cartesian(ylim = c(0, 200)) +
  labs(
    x = "Year",
    y = "Number of Hospitals"
  ) +
  theme_minimal()

