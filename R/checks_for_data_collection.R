library(tidyverse)
library(lubridate)
library(glue)
source("R/checks_for_other_responses.R")
source("R/checks_for_quantitative_tools.R")
source("R/checks_for_qualitative_tools.R")


# quantitative data -------------------------------------------------------

# PA_KI_questionnaire_September_2021
check_quantitative_tool_data(input_tool_data_name = "PA_KI_questionnaire_September_2021",
                             input_tool_name = "PA_KI_questionnaire_Tool_2021")

# PA_KI_questionnaire_October_2021_Kampala
check_quantitative_tool_data(input_tool_data_name = "PA_KI_questionnaire_October_2021_Kampala",
                             input_tool_name = "PA_KI_questionnaire_Tool_2021_Kampala")

# qualitative data -------------------------------------------------------

# host_community ----------------------------------------------------------

check_qualitative_tool_data(input_tool_data_name = "PA_KI_host_community_questionnaire_October_2021",
                            input_tool_name = "PA_KI_host_community_Tool_2021")

check_qualitative_tool_data(input_tool_data_name = "PA_KI_host_community_questionnaire_October_2021_Kampala",
                            input_tool_name = "PA_KI_host_community_Tool_2021_Kampala")

# key_stakeholders --------------------------------------------------------


check_qualitative_tool_data(input_tool_data_name = "PA_KI_key_stakeholders_questionnaire_October_2021",
                            input_tool_name = "PA_KI_key_stakeholders_Tool_2021")

check_qualitative_tool_data(input_tool_data_name = "PA_KI_key_stakeholders_questionnaire_October_2021_Kampala",
                            input_tool_name = "PA_KI_key_stakeholders_Tool_2021_Kampala")

# specific_groups --------------------------------------------------------


check_qualitative_tool_data(input_tool_data_name = "PA_KI_specific_groups_questionnaire_October_2021",
                            input_tool_name = "PA_KI_specific_groups_Tool_2021")

check_qualitative_tool_data(input_tool_data_name = "PA_KI_specific_groups_questionnaire_October_2021_Kampala",
                            input_tool_name = "PA_KI_specific_groups_Tool_2021_Kampala")


