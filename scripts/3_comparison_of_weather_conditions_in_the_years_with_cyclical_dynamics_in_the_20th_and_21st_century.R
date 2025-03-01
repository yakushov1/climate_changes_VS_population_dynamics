library(tidyverse)
library(Kendall)

climatic_data <- read_csv2("data/climate_for_model.csv") |> 
  filter(Year >= 1976 & !(Year %in% c(1995:2007))) |> 
  mutate(Period = case_when(Year %in% c(1976:1991) ~ "cyclic_XX",
                            Year %in% c(2017:2023) ~ "cyclic_XXI",
                            .default = "non_cyclic"),
         .before = 1)  |> 
  select(-Year)


trends_analysis <- rbind((climatic_data |>
                            filter(Period == "cyclic_XX") |>
                            summarise(across(2:12, \(x) MannKendall(x)$sl)) |>
                            mutate(Period = "cyclic_XX", .before = 1)),
                         (climatic_data |>
                            filter(Period == "cyclic_XXI") |>
                            summarise(across(2:12, \(x) MannKendall(x)$sl)) |>
                            mutate(Period = "cyclic_XXI", .before = 1)),
                         (climatic_data |>
                            filter(Period == "non_cyclic") |>
                            summarise(across(2:12, \(x) MannKendall(x)$sl)) |>
                            mutate(Period = "non_cyclic", .before = 1))
)



compare_cycl_XX_XXI <- climatic_data |> 
  filter(Period != "cyclic_XXI")  |> 
  pivot_longer(cols = !Period, names_to = "Parametr", values_to = "Val") |> 
  mutate(across(c(Period,Parametr), \(x) as.factor(x))) |> 
  group_by(Period, Parametr) |> 
  summarise(Val = list(Val)) |> 
  spread(Period, Val) |> 
  group_by(Parametr) |>
  mutate(p_value = round(wilcox.test(unlist(cyclic_XX), unlist(non_cyclic))$p.value, 3)) |> 
  mutate(Pval_adj = p.adjust(p_value, "BY")) |> 
  select(Parametr, ends_with("_adj"))
