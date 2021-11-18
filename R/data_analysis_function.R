
data_analysis <- function(input_clean_data_name, input_dap_name, input_vars_for_split) {
  # load data ---------------------------------------------------------------
  
  df_cleaned <- read_csv(paste0("outputs/", input_clean_data_name,  ".csv"))
  
  dap <- read_csv(paste0("inputs/", input_dap_name,  ".csv")) %>% 
    janitor::clean_names()
  
  # analysis ----------------------------------------------------------------
  
  #  select variables from dap that are in the dataset
  variables_to_analyse <- dap$variable[dap$variable %in% colnames(df_cleaned)]
  
  # convert df to a survey using the srvyr package
  df_svy <- as_survey(df_cleaned)
  
  # outputs list
  outputs <- list()
  
  # overall analysis
  outputs$over_all_analysis <- butteR::survey_collapse(df = df_svy,
                                                       vars_to_analyze = variables_to_analyse) %>% 
    mutate(analysis_level = "overall")
  
  # split analysis by subset_1
  dap_all_subset <- dap %>% 
    filter(split %in% input_vars_for_split, !is.na(subset_1))
  
  # overall, subset_1
  
  dap_all_subset_split <- dap_all_subset %>% 
    split(.$subset_1)
  
  overall_subset1<-list()
  
  for (i in seq_along(dap_all_subset_split)) {
    print(i)
    subset_temp <- dap_all_subset_split[[i]]
    subset_value <- unique(subset_temp$subset_1)
    vars_temp <- subset_temp %>% pull(variable)
    overall_subset1[[subset_value]] <- butteR::survey_collapse(df = df_svy,
                                                               vars_to_analyze = vars_temp, 
                                                               disag = c(subset_value)) 
  }
  
  outputs$overall_subset1 <- bind_rows(overall_subset1) %>% 
    mutate(analysis_level = "by_subset_1")
  
  # merge all analysis
  full_analysis_long<- bind_rows(outputs)
  # write the output analysis
  full_analysis_long %>%
    write_csv(paste0("outputs/", 
                     butteR::date_file_prefix(),
                     "_full_analysis_long_format_", 
                     str_replace(string = input_clean_data_name, pattern = "^\\d{1,8}_", replacement = ""), 
                     ".csv"),
              na="")
}