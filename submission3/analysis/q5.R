q5 <- HCRIS_data %>%
  filter(year >= 2012 & year <= 2019) %>%
  mutate(hvbp_payment = ifelse(is.na(hvbp_payment), 0, hvbp_payment),
         hrrp_payment = ifelse(is.na(hrrp_payment), 0, abs(hrrp_payment)),
         penalty = as.numeric(hvbp_payment - hrrp_payment < 0)) %>%
  group_by(year) %>%
  summarize(
    total_hospitals = n(),
    hrrp_penalized = sum(hrrp_payment > 0),
    hvbp_penalized = sum(hvbp_payment < 0),
    net_penalty = sum(penalty > 0),
    hrrp_share = hrrp_penalized / total_hospitals,
    hvbp_share = hvbp_penalized / total_hospitals,
    penalty_share = net_penalty / total_hospitals
  ) %>%
  pivot_longer(cols = c(hrrp_share, hvbp_share, penalty_share),
               names_to = "Program", values_to = "Share")


# Plot data ---------------------------------------------------------------
q5.plot <- ggplot(q5, aes(x = year, y = Share, color = Program, group = Program)) +
  geom_line(size = 1.2) +
  geom_point(size = 3) +
  scale_y_continuous(labels = scales::percent, limits = c(0, .6)) +
  scale_x_continuous(breaks = 2012:2019) +
  scale_color_manual(values = c("hrrp_share" = "orange", "hvbp_share" = "darkblue", "penalty_share" = "darkgreen"),
                     labels = c("HRRP (Readmissions)", "HVBP (Value-Based)", "Net Penalty")) +
  labs(
    x = "Year",
    y = "Percent of Hospitals Penalized",
    color = "Penalty Program"
  ) +
  theme_minimal() +
  theme(legend.position = "bottom")
