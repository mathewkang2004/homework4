# Run the 2SLS regressions using the previous specs -----------------------
iv_models <- list(
  "Baseline" = feols(price_change ~ 1 | net_penalty ~ avg_mcare, data = hcris.final),
  "+ Beds" = feols(price_change ~ avg_beds | net_penalty ~ avg_mcare, data = hcris.final),
  "+ Medicaid" = feols(price_change ~ avg_beds + avg_medicaid | net_penalty ~ avg_mcare, data = hcris.final)
)


# Create table ------------------------------------------------------------
q9 <- modelsummary(iv_models,
                   stars = TRUE,
                   output = "latex",
                   fmt = fmt_decimal(2),
                   title = "2SLS Estimates: Effect of Net Penalty on Price Changes (2011-2014)",
                   coef_map = c("(Intercept)" = "Intercept",
                     "fit_net_penalty" = "Net Penalty (per $1,000)",
                                "avg_beds" = "Avg. Beds (per 100)",
                                "avg_medicaid" = "Avg. Medicaid Discharges (per 100)"),
                   gof_map = c("nobs", "f.stat_first" = "F-Stat (First Stage)"))


