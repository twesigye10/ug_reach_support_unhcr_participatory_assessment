library(tidyverse)
library(googlesheets4)

source("R/support_functions.R")

# process dap -------------------------------------------------------
dap_vars_to_lower <- c("split",	"disaggregation",	"subset_1",	"subset_2")

df_host_dap <- read_sheet(ss = "1Q-kOf4SppwKRWVvYJ4PJNzRJmFwRsM_S625bkbut7tw", sheet = "DAP_host") %>% 
  janitor::clean_names() %>% 
  mutate(across(any_of(dap_vars_to_lower), .fns = ~str_to_lower(string = .))) %>% 
  write_csv(file = "outputs/r_dap_host.csv", na = "NA")

df_key_stakeholders_dap <- read_sheet(ss = "1Q-kOf4SppwKRWVvYJ4PJNzRJmFwRsM_S625bkbut7tw", sheet = "DAP_key_stakeholders")%>% 
  janitor::clean_names() %>% 
  mutate(across(any_of(dap_vars_to_lower), .fns = ~str_to_lower(string = .))) %>% 
  write_csv(file = "outputs/r_dap_key_stakeholders.csv", na = "NA")

df_other_minorities_dap <- read_sheet(ss = "1Q-kOf4SppwKRWVvYJ4PJNzRJmFwRsM_S625bkbut7tw", sheet = "DAP_minority")%>% 
  janitor::clean_names() %>% 
  mutate(across(any_of(dap_vars_to_lower), .fns = ~str_to_lower(string = .))) %>% 
  write_csv(file = "outputs/r_dap_other_minorities.csv", na = "NA")

df_specific_groups_dap <- read_sheet(ss = "1Q-kOf4SppwKRWVvYJ4PJNzRJmFwRsM_S625bkbut7tw", sheet = "DAP_specific_groups")%>% 
  janitor::clean_names() %>% 
  mutate(across(any_of(dap_vars_to_lower), .fns = ~str_to_lower(string = .))) %>% 
  write_csv(file = "outputs/r_dap_specific_groups.csv", na = "NA")

df_phone_survey_dap <- read_sheet(ss = "1Q-kOf4SppwKRWVvYJ4PJNzRJmFwRsM_S625bkbut7tw", sheet = "DAP_phone_surveys")%>% 
  janitor::clean_names() %>% 
  mutate(across(any_of(dap_vars_to_lower), .fns = ~str_to_lower(string = .))) %>% 
  write_csv(file = "outputs/r_dap_phone_survey.csv", na = "NA")

# quantitative data -------------------------------------------------------

get_indicators_for_dap("PA_KI_questionnaire_Tool_2021")
get_indicators_for_dap("PA_KI_questionnaire_Tool_2021_Kampala")

# qualitative data -------------------------------------------------------

# host_community ----------------------------------------------------------
get_indicators_for_dap("PA_KI_host_community_Tool_2021")

get_indicators_for_dap("PA_KI_host_community_Tool_2021_Kampala")

# key_stakeholders --------------------------------------------------------
get_indicators_for_dap("PA_KI_key_stakeholders_Tool_2021")

get_indicators_for_dap("PA_KI_key_stakeholders_Tool_2021_Kampala")

# specific_groups --------------------------------------------------------
get_indicators_for_dap("PA_KI_specific_groups_Tool_2021")

get_indicators_for_dap("PA_KI_specific_groups_Tool_2021_Kampala")

# other_minorities --------------------------------------------------------
get_indicators_for_dap("PA_KI_other_minorities_Tool_2021")

get_indicators_for_dap("PA_KI_other_minorities_Tool_2021_Kampala")

