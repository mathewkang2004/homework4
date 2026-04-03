q4 <- HCRIS_data %>%
  filter(year >= 2009 & year <= 2019) %>%
  filter(if_all(c(tot_discounts, tot_charges, ip_charges, icu_charges, ancillary_charges, tot_mcare_payment, tot_discharges, mcare_discharges), ~ !is.na(.))) %>%
  mutate(
    discount_factor = 1 - (tot_discounts / tot_charges),
    price_num = (ip_charges + icu_charges + ancillary_charges) * discount_factor - tot_mcare_payment,
    price_denom = tot_discharges - mcare_discharges
  ) %>%
  filter(price_denom > 0) %>%
  mutate(price = price_num / price_denom) %>%
  filter(price > 0) %>%
  select(provider_number, year, price) %>%
  group_by(year) %>%
  mutate(
    p95 = quantile(price, 0.95, na.rm = TRUE),
    p05 = quantile(price, 0.05, na.rm = TRUE),
    price = pmin(pmax(price, p05), p95)
  ) %>%
  ungroup()


# Plot data ---------------------------------------------------------------
q4.plot <- ggplot(q4, aes(x = factor(year), y = price)) +
  geom_violin(fill = "darkblue", color = "darkblue", alpha = 0.7, draw_quantiles = c(0.25, 0.5, 0.75)) +
  stat_summary(fun = median, geom = "line", aes(group = 1), color = "orange", size = 1.2) +
  stat_summary(fun = median, geom = "point", color = "orange", size = 3) +
  scale_y_continuous(labels = label_comma()) +
  labs(
    x = "Year",
    y = "Estimated Price per Discharge"
  ) +
  theme_minimal()



