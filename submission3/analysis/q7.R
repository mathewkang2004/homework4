q7 <- ggplot(hcris.final, aes(x = avg_mcare, y = net_penalty)) +
  geom_point(alpha = 0.6, color = "darkblue") +
  geom_smooth(method = "lm", color = "orange", se = FALSE) +
  scale_x_continuous(labels = label_comma()) +
  scale_y_continuous(labels = label_comma()) +
  labs(
    x = "Average Medicare Discharges in Hundreds (2009-2011)",
    y = "Net Penalty in Thousands in 2012 ($)"
  ) +
  theme_minimal()