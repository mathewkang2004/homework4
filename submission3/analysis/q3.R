q3 <- HCRIS_data %>%
  filter(!is.na(tot_charges) & tot_charges > 0) %>%
  group_by(year) %>%
  mutate(
    p99 = quantile(tot_charges, 0.99, na.rm = TRUE),
    p01 = quantile(tot_charges, 0.01, na.rm = TRUE),
    tot_charges = pmin(pmax(tot_charges, p01), p99)
  )

q3.plot <- ggplot(q3, aes(x = factor(year), y = tot_charges)) +
  geom_violin(fill = "darkblue", color = "darkblue", alpha = 0.7, draw_quantiles = c(0.25, 0.5, 0.75)) +
  scale_y_log10(labels = label_comma()) +
  stat_summary(fun = median, geom = "line", aes(group = 1), color = "orange", size = 1.2) +
  stat_summary(fun = median, geom = "point", color = "orange", size = 3) +
  labs(
    x = "Year",
    y = "Total Charges (Log10)"
  ) +
  theme_minimal()