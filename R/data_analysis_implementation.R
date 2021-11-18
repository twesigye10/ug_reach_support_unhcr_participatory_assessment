library(tidyverse)
library(srvyr)
library(janitor)
library(glue)

source("R/data_analysis_function.R")

# process dap -------------------------------------------------------

df_host_dap <- read_sheet(ss = "1Q-kOf4SppwKRWVvYJ4PJNzRJmFwRsM_S625bkbut7tw", sheet = "DAP_host")

df_key_stakeholders <- read_sheet(ss = "1Q-kOf4SppwKRWVvYJ4PJNzRJmFwRsM_S625bkbut7tw", sheet = "DAP_key_stakeholders")

df_minority_dap <- read_sheet(ss = "1Q-kOf4SppwKRWVvYJ4PJNzRJmFwRsM_S625bkbut7tw", sheet = "DAP_minority")

df_others_dap <- read_sheet(ss = "1Q-kOf4SppwKRWVvYJ4PJNzRJmFwRsM_S625bkbut7tw", sheet = "DAP_others")

df_phonesurvey_dap <- read_sheet(ss = "1Q-kOf4SppwKRWVvYJ4PJNzRJmFwRsM_S625bkbut7tw", sheet = "DAP_phone_surveys")



# check indicators --------------------------------------------------------

readxl::read_excel(path = "inputs/PA_KI_host_community_questionnaire_October_2021.xlsx") %>% 
  select(contains("/")) %>% 
  colnames() %>% 
  str_replace(pattern = "/\\w+", replacement = "") %>% 
  unique()

# quantitative data -------------------------------------------------------
data_analysis(input_clean_data_name = "PA_KI_questionnaire_September_2021_combined_checks",
             input_dap_name = "PA_KI_questionnaire_September_2021",
             input_vars_for_split = vars_for_split)

data_analysis(input_clean_data_name = "PA_KI_questionnaire_October_2021_Kampala_combined_checks",
             input_dap_name = "PA_KI_questionnaire_October_2021_Kampala",
             input_vars_for_split = vars_for_split)

# qualitative data -------------------------------------------------------

# host_community ----------------------------------------------------------
data_analysis(input_clean_data_name = "PA_KI_host_community_questionnaire_October_2021_combined_checks",
             input_dap_name = "PA_KI_host_community_questionnaire_October_2021",
             input_vars_for_split = vars_for_split)

data_analysis(input_clean_data_name = "PA_KI_host_community_questionnaire_October_2021_Kampala_combined_checks",
             input_dap_name = "PA_KI_host_community_questionnaire_October_2021_Kampala",
             input_vars_for_split = vars_for_split)

# key_stakeholders --------------------------------------------------------
data_analysis(input_clean_data_name = "PA_KI_key_stakeholders_questionnaire_October_2021_combined_checks",
             input_dap_name = "PA_KI_key_stakeholders_questionnaire_October_2021",
             input_vars_for_split = vars_for_split)

data_analysis(input_clean_data_name = "PA_KI_key_stakeholders_questionnaire_October_2021_Kampala_combined_checks",
             input_dap_name = "PA_KI_key_stakeholders_questionnaire_October_2021_Kampala",
             input_vars_for_split = vars_for_split)

# specific_groups --------------------------------------------------------
data_analysis(input_clean_data_name = "PA_KI_specific_groups_questionnaire_October_2021_combined_checks",
             input_dap_name = "PA_KI_specific_groups_questionnaire_October_2021",
             input_vars_for_split = vars_for_split)

data_analysis(input_clean_data_name = "PA_KI_specific_groups_questionnaire_October_2021_Kampala_combined_checks",
             input_dap_name = "PA_KI_specific_groups_questionnaire_October_2021_Kampala",
             input_vars_for_split = vars_for_split)

# other_minorities --------------------------------------------------------
data_analysis(input_clean_data_name = "PA_KI_other_minorities_questionnaire_October_2021_combined_checks",
             input_dap_name = "PA_KI_other_minorities_questionnaire_October_2021",
             input_vars_for_split = vars_for_split)

data_analysis(input_clean_data_name = "PA_KI_other_minorities_questionnaire_October_2021_Kampala_combined_checks",
             input_dap_name = "PA_KI_other_minorities_questionnaire_October_2021_Kampala",
             input_vars_for_split = vars_for_split)