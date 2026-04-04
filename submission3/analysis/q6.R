# Run regressions ---------------------------------------------------------
ols_models <- list(
  "Baseline" = lm(price_change ~ net_penalty, data = hcris.final),
  "+ Beds" = lm(price_change ~ net_penalty + avg_beds, data = hcris.final),
  "+ Medicaid" = lm(price_change ~ net_penalty + avg_beds + avg_medicaid, data = hcris.final)
)


# Create table ------------------------------------------------------------
q6 <- modelsummary(ols_models, 
                   stars = TRUE, 
                   fmt = fmt_decimal(2),
                   title = "OLS Estimates of Net Penalty on Price Changes",
                   coef_map = c("(Intercept)" = "Intercept",
                                "net_penalty" = "Net Penalty (per $1,000)",
                                "avg_beds" = "Avg. Beds (per 100)",
                                "avg_medicaid" = "Avg. Medicaid Discharges (per 100)"),
                   gof_map = c("nobs", "r.squared"),
                   output = "latex")

