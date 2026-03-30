# Run the 2SLS regressions using the previous specs -----------------------
iv_models <- list(
  "Baseline" = feols(price_change ~ 1 | net_penalty ~ avg_mcare, data = hcris.final),
  "+ Beds" = feols(price_change ~ avg_beds | net_penalty ~ avg_mcare, data = hcris.final),
  "+ Medicaid" = feols(price_change ~ avg_beds + avg_medicaid | net_penalty ~ avg_mcare, data = hcris.final)
)


# Create table ------------------------------------------------------------
q9 <- modelsummary(iv_models,
                   stars = TRUE,
                   title = "2SLS Estimates: Effect of Net Penalty on Price Changes (2011-2014)",
                   coef_map = c("fit_net_penalty" = "Net Penalty ($1k)",
                                "avg_beds" = "Avg. Beds",
                                "avg_medicaid" = "Avg. Medicaid Discharges"),
                   gof_map = c("nobs", "f.stat_first" = "F-Stat (First Stage)"))


