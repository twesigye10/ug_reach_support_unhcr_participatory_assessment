library(tidyverse)
library(srvyr)
library(janitor)
library(glue)

source("R/support_functions.R")

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