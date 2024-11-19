install.packages("tidyveres")

library(janitor)
library(lubridate)

my_data <- read_rds(file = "data_handling/data/messy_data.RDS") |> 
  as_tibble() |> 
  clean_names()

my_data |> 
  mutate(date2 = ymd(date),
         date3 = dmy(date),
         sex = tolower(sex),
         age = tolower(age)) |> 
  # concatenate date 2 and date3
  mutate(date = if_else(!is.na(date2), date2, date3),
         age = case_match(age,
                          c("j") ~ "juvenile",
                          c("a") ~ "adult",
                          .default = age)) |> 
  select(-date2, -date3) |> 
  mutrange(count)
