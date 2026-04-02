q3 <- HCRIS_data %>%
  filter(!is.na(tot_charges) & tot_charges > 0)

q3.plot <- ggplot(q3, aes(x = factor(year), y = tot_charges)) +
  geom_violin(fill = "darkblue", color = "darkblue", alpha = 0.7, draw_quantiles = c(0.25, 0.5, 0.75)) +
  scale_y_log10(labels = label_comma()) +
  labs(
    title = "Distribution of Total Charges Per Year",
    x = "Year",
    y = "Total Charges (Log10)"
  ) +
  theme_minimal()