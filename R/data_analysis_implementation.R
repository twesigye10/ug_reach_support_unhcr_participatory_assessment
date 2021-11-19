library(tidyverse)
library(srvyr)
library(janitor)
library(glue)

source("R/support_functions.R")

vars_for_split_general <- c("all", "only_settlements")
vars_for_split_kampala <- c("all")

# quantitative data -------------------------------------------------------
data_analysis(input_clean_data_name = "clean_data_PA_KI_questionnaire_September_2021",
             input_dap_name = "r_dap_phone_survey",
             input_vars_for_split = vars_for_split_general)

data_analysis(input_clean_data_name = "clean_data_PA_KI_questionnaire_September_2021_bidibidi",
             input_dap_name = "r_dap_phone_survey_bidibidi",
             input_vars_for_split = vars_for_split_general)

data_analysis(input_clean_data_name = "clean_data_PA_KI_questionnaire_October_2021_Kampala",
             input_dap_name = "r_dap_phone_survey",
             input_vars_for_split = vars_for_split_kampala)

# qualitative data -------------------------------------------------------

# host_community ----------------------------------------------------------
data_analysis(input_clean_data_name = "clean_data_PA_KI_host_community_questionnaire_October_2021",
             input_dap_name = "r_dap_host",
             input_vars_for_split = vars_for_split_general)

data_analysis(input_clean_data_name = "clean_data_PA_KI_host_community_questionnaire_October_2021_Kampala",
             input_dap_name = "r_dap_host",
             input_vars_for_split = vars_for_split_kampala)

# key_stakeholders --------------------------------------------------------
data_analysis(input_clean_data_name = "clean_data_PA_KI_key_stakeholders_questionnaire_October_2021",
             input_dap_name = "r_dap_key_stakeholders",
             input_vars_for_split = vars_for_split_general)

data_analysis(input_clean_data_name = "clean_data_PA_KI_key_stakeholders_questionnaire_October_2021_Kampala",
             input_dap_name = "r_dap_key_stakeholders",
             input_vars_for_split = vars_for_split_kampala)

# specific_groups --------------------------------------------------------
data_analysis(input_clean_data_name = "clean_data_PA_KI_specific_groups_questionnaire_October_2021",
             input_dap_name = "r_dap_specific_groups",
             input_vars_for_split = vars_for_split_general)

data_analysis(input_clean_data_name = "clean_data_PA_KI_specific_groups_questionnaire_October_2021_Kampala",
             input_dap_name = "r_dap_specific_groups",
             input_vars_for_split = vars_for_split_kampala)

# other_minorities --------------------------------------------------------
data_analysis(input_clean_data_name = "clean_data_PA_KI_other_minorities_questionnaire_October_2021",
             input_dap_name = "r_dap_other_minorities",
             input_vars_for_split = vars_for_split_general)

data_analysis(input_clean_data_name = "clean_data_PA_KI_other_minorities_questionnaire_October_2021_Kampala",
             input_dap_name = "r_dap_other_minorities",
             input_vars_for_split = vars_for_split_kampala)