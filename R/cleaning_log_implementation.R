library(tidyverse)
library(lubridate)
library(glue)

source("R/cleaning_log_function.R")

vars_to_remove <- c("contact_information_function",	"contact_information_enum_org",	"contact_information__enum_function")

# quantitative data -------------------------------------------------------Ta

cleaning_log(input_log_name = "PA_KI_questionnaire_September_2021_combined_checks",
             input_tool_data_name = "PA_KI_questionnaire_September_2021",
             input_tool_name = "PA_KI_questionnaire_Tool_2021", 
             input_vars_to_remove_from_data = vars_to_remove)

cleaning_log(input_log_name = "PA_KI_questionnaire_October_2021_Kampala_combined_checks",
             input_tool_data_name = "PA_KI_questionnaire_October_2021_Kampala",
             input_tool_name = "PA_KI_questionnaire_Tool_2021_Kampala", 
             input_vars_to_remove_from_data = vars_to_remove)

# qualitative data -------------------------------------------------------

# host_community ----------------------------------------------------------
cleaning_log(input_log_name = "PA_KI_host_community_questionnaire_October_2021_combined_checks",
             input_tool_data_name = "PA_KI_host_community_questionnaire_October_2021",
             input_tool_name = "PA_KI_host_community_Tool_2021", 
             input_vars_to_remove_from_data = vars_to_remove)

cleaning_log(input_log_name = "PA_KI_host_community_questionnaire_October_2021_Kampala_combined_checks",
             input_tool_data_name = "PA_KI_host_community_questionnaire_October_2021_Kampala",
             input_tool_name = "PA_KI_host_community_Tool_2021_Kampala", 
             input_vars_to_remove_from_data = vars_to_remove)

# key_stakeholders --------------------------------------------------------
cleaning_log(input_log_name = "PA_KI_key_stakeholders_questionnaire_October_2021_combined_checks",
             input_tool_data_name = "PA_KI_key_stakeholders_questionnaire_October_2021",
             input_tool_name = "PA_KI_key_stakeholders_Tool_2021", 
             input_vars_to_remove_from_data = vars_to_remove)

cleaning_log(input_log_name = "PA_KI_key_stakeholders_questionnaire_October_2021_Kampala_combined_checks",
             input_tool_data_name = "PA_KI_key_stakeholders_questionnaire_October_2021_Kampala",
             input_tool_name = "PA_KI_key_stakeholders_Tool_2021_Kampala", 
             input_vars_to_remove_from_data = vars_to_remove)

# specific_groups --------------------------------------------------------Ta
cleaning_log(input_log_name = "PA_KI_specific_groups_questionnaire_October_2021_combined_checks",
             input_tool_data_name = "PA_KI_specific_groups_questionnaire_October_2021",
             input_tool_name = "PA_KI_specific_groups_Tool_2021", 
             input_vars_to_remove_from_data = vars_to_remove)

cleaning_log(input_log_name = "PA_KI_specific_groups_questionnaire_October_2021_Kampala_combined_checks",
             input_tool_data_name = "PA_KI_specific_groups_questionnaire_October_2021_Kampala",
             input_tool_name = "PA_KI_specific_groups_Tool_2021_Kampala", 
             input_vars_to_remove_from_data = vars_to_remove)

# other_minorities --------------------------------------------------------
cleaning_log(input_log_name = "PA_KI_other_minorities_questionnaire_October_2021_combined_checks",
             input_tool_data_name = "PA_KI_other_minorities_questionnaire_October_2021",
             input_tool_name = "PA_KI_other_minorities_Tool_2021", 
             input_vars_to_remove_from_data = vars_to_remove)

cleaning_log(input_log_name = "PA_KI_other_minorities_questionnaire_October_2021_Kampala_combined_checks",
             input_tool_data_name = "PA_KI_other_minorities_questionnaire_October_2021_Kampala",
             input_tool_name = "PA_KI_other_minorities_Tool_2021_Kampala", 
             input_vars_to_remove_from_data = vars_to_remove)
