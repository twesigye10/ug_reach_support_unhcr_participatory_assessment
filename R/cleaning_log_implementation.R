library(tidyverse)
library(lubridate)
library(glue)
library(googlesheets4)
source("R/data_analysis_function.R")

# process dap -------------------------------------------------------

df_host_dap <- read_sheet(ss = "1Q-kOf4SppwKRWVvYJ4PJNzRJmFwRsM_S625bkbut7tw", sheet = "DAP_host")

df_key_stakeholders <- read_sheet(ss = "1Q-kOf4SppwKRWVvYJ4PJNzRJmFwRsM_S625bkbut7tw", sheet = "DAP_key_stakeholders")

df_minority_dap <- read_sheet(ss = "1Q-kOf4SppwKRWVvYJ4PJNzRJmFwRsM_S625bkbut7tw", sheet = "DAP_minority")

df_others_dap <- read_sheet(ss = "1Q-kOf4SppwKRWVvYJ4PJNzRJmFwRsM_S625bkbut7tw", sheet = "DAP_others")

df_phonesurvey_dap <- read_sheet(ss = "1Q-kOf4SppwKRWVvYJ4PJNzRJmFwRsM_S625bkbut7tw", sheet = "DAP_phone_surveys")

