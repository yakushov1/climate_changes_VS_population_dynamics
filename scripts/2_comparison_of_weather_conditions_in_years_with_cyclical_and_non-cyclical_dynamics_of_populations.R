library(tidyverse)
library(MuMIn)


climatic_parametr <- read_csv2("data/climate_for_model.csv")

#years with winter survival rate higher than the median (for each species)
years_with_big_mortality <- read_csv2('data/survival_rate_higher_than_the_median.csv')


# type of dynamics (derived from previous work based on the wavelet transform
# and analysis of population status indicators - details in the manuscript)
type_of_dynamic_for_all_spec <- tibble(Year = c(1976:1994, 2008:2023)) |> 
  mutate(S._araneus = case_when(Year %in% c(1976:1990, 2017:2023) ~ 1,
                                .default = 0),
         S._caecutiens = case_when(Year %in% c(1976:1987) ~ 1,
                                   .default = 0),
         S._isodon = case_when(Year %in% c(1976:1994, 2017:2023) ~ 1,
                               .default = 0),
         C._rutilus = case_when(Year %in% c(1980:1994, 2017:2023) ~ 1,
                                .default = 0),
         M._oeconomus = case_when(Year %in% c(1976:1992, 2017:2023) ~ 1,
                                  .default = 0)) |> 
  pivot_longer(!Year, names_to = "Spec", values_to = "Type") |> 
  left_join(climatic_parametr, by = "Year")


for_model <- years_with_big_mortality |> 
  left_join(type_of_dynamic_for_all_spec, by = c('Year', 'Spec')) |> 
  select(-Year, -Spec)


# model -------------------------------------------------------------------

model_type <- glm(Type~.,family = "binomial", for_model)

options(na.action="na.fail")
all_models <- dredge(model_type)
best <- model.avg(all_models, subset = delta<2)

summary(best)

n_models <- all_models |> 
  filter(delta<2) |> 
  nrow()

best_models <- all_models |> 
  filter(delta<2)


table_1 <- best_models |> 
  as_tibble() |>
  select(-c(Autumn, Sn_11:Sn_5, df, logLik, delta, weight)) |> 
  mutate(across(everything(), \(x) round(x, 3)))

avg_result <- summary(best)$coefmat.subset |> 
  as_tibble(rownames = "features") |> 
  cbind(confint(best)) |> 
  rename(P_val = `Pr(>|z|)`) |> 
  select(-`z value`) |> 
  mutate(N_models = n_models)

table_2 <- avg_result |> 
  filter(P_val<0.05) |> 
  mutate(across(2:7, \(x) round(x, 4)))



