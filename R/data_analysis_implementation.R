library(tidyverse)
library(srvyr)
library(janitor)
library(glue)

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
