library(tidyverse)
library(lubridate)
library(glue)
source("R/checks_for_other_responses.R")

# read data 
df_tool_data <- readxl::read_excel("inputs/PA_KI_test_data.xlsx") %>% 
  mutate(i.check.uuid = `_uuid`,
         i.check.start_date = as_date(start),
         i.check.progres_id = progres_id,
         i.check.location = location
         )

df_survey <- readxl::read_excel("inputs/PA_KI_questionnaire_Tool_2021.xlsx", sheet = "survey")
df_choices <- readxl::read_excel("inputs/PA_KI_questionnaire_Tool_2021.xlsx", sheet = "choices")



