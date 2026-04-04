# Calculate the number of unique hospitals in the data --------------------
q2 <- HCRIS_data %>%
  group_by(year) %>%
  summarize(unique_hospitals = n_distinct(provider_number)) %>%
  ggplot(aes(x = year, y = unique_hospitals)) +
  geom_line(color = "darkblue", size = 1) +
  geom_point(color = "darkblue", size = 3) +
  scale_x_continuous(breaks = 2009:2019) +
  coord_cartesian(ylim = c(0, 7500)) +
  labs(
    x = "Year",
    y = "Number of Unique Hospital IDs"
  ) +
  theme_minimal()
