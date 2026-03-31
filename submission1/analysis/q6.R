# Run regressions ---------------------------------------------------------
ols_models <- list(
  "Baseline" = lm(price_change ~ net_penalty, data = hcris.final),
  "+ Beds" = lm(price_change ~ net_penalty + avg_beds, data = hcris.final),
  "+ Medicaid" = lm(price_change ~ net_penalty + avg_beds + avg_medicaid, data = hcris.final)
)


# Create table ------------------------------------------------------------
q6 <- modelsummary(ols_models, 
                   stars = TRUE, 
                   fmt = 3,
                   title = "OLS Estimates of Net Penalty on Price Changes",
                   coef_map = c("(Intercept)" = "Intercept",
                                "net_penalty" = "Net Penalty",
                                "avg_beds" = "Avg. Beds",
                                "avg_medicaid" = "Avg. Medicaid Discharges"),
                   gof_map = c("nobs", "r.squared"),
                   output = "latex")

