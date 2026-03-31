# First stage: regressing penalty -----------------------------------------
fs_models <- list(
  "Baseline" = feols(net_penalty ~ avg_mcare, data = hcris.final),
  "+ Beds" = feols(net_penalty ~ avg_mcare + avg_beds, data = hcris.final),
  "+ Medicaid" = feols(net_penalty ~ avg_mcare + avg_beds + avg_medicaid, data = hcris.final)
)


# Reduced stage: regressing price change ----------------------------------
rf_models <- list(
  "Baseline" = feols(price_change ~ avg_mcare, data = hcris.final),
  "+ Beds" = feols(price_change ~ avg_mcare + avg_beds, data = hcris.final),
  "+ Medicaid" = feols(price_change ~ avg_mcare + avg_beds + avg_medicaid, data = hcris.final)
)


# Create table ------------------------------------------------------------
q8.1 <- modelsummary(fs_models, 
                     stars = TRUE, 
                     title = "First Stage: 2012 Net Penalty on Pre-Penalty Medicare Volume",
                     coef_map = c("(Intercept)" = "Intercept",
                                  "avg_mcare" = "Avg. Medicare Discharges (per 100)",
                                  "avg_beds" = "Avg. Beds",
                                  "avg_medicaid" = "Avg. Medicaid Discharges"),
                     gof_map = c("nobs", "r.squared"))

q8.2 <- modelsummary(rf_models, 
                     stars = TRUE, 
                     title = "Reduced Form: Price Change (2011-2014) on Pre-Penalty Medicare Volume",
                     coef_map = c("(Intercept)" = "Intercept",
                                  "avg_mcare" = "Avg. Medicare Discharges (per 100)",
                                  "avg_beds" = "Avg. Beds",
                                  "avg_medicaid" = "Avg. Medicaid Discharges"),
                     gof_map = c("nobs", "r.squared"))