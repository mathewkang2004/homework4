# Calculate the number of unique hospitals in the data --------------------
q2 <- HCRIS_data %>%
  summarize(`Unique Hospitals` = n_distinct(provider_number)) %>%
  kable()