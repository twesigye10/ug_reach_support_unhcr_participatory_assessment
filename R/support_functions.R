# support functions


# function: extract others checks -----------------------------------------

extract_other_data <- function(input_tool_data, input_survey, input_choices) {
  
  # add and rename some columns
  df_data <- input_tool_data %>% 
    rename(uuid = `_uuid`) %>% 
    mutate(start_date = as_date(start))
  
  # get questions with other
  others_colnames <-  df_data %>% 
    select(ends_with("_other"), ends_with("_specify"), -contains("/")) %>% 
    colnames()
  
  # data.frame for holding _other response data
  df_other_response_data <- data.frame()
  
  for (cln in others_colnames) {
    
    current_parent_qn = str_replace_all(string = cln, pattern = "_other|_list_specify|_specify", replacement = "")
    
    if (current_parent_qn == "educ_challenge"){
      current_parent_qn = "education_challenges"
    }
    
    df_filtered_data <- df_data %>% 
      select(-contains("/")) %>% 
      select(uuid, start_date, location, other_text = cln, current_value = current_parent_qn) %>% 
      filter(!is.na(other_text), !other_text %in% c(" ", "NA")) %>% 
      mutate( other_name = cln, 
              int.my_current_val_extract = ifelse(str_detect(current_value, "\\bother\\b|\\bother_|_other\\b"), 
                                                  str_extract_all(string = current_value, pattern = "\\bother\\b|\\bother_\\w+\\b|\\w+_other\\b"), 
                                                  current_value),
              value = "",
              parent_qn = current_parent_qn)
    df_other_response_data <- rbind(df_other_response_data, df_filtered_data)
  }
  
  # arrange the data
  df_data_arranged <- df_other_response_data %>% 
    arrange(start_date, uuid)
  
  # get choices to add to the _other responses extracted
  df_grouped_choices <- input_choices %>% 
    group_by(list_name) %>% 
    summarise(choice_options = paste(name, collapse = " : ")) %>% 
    arrange(list_name)
  
  # extract parent question and join survey for extracting list_name
  df_data_parent_qns <- df_data_arranged %>% 
    left_join(input_survey %>% select(name, type), by = c("parent_qn"="name")) %>% 
    separate(col = type, into = c("select_type", "list_name"), sep =" ", remove = TRUE, extra = "drop" ) %>% 
    rename(name = parent_qn)
  
  # join other responses with choice options based on list_name
  df_join_other_response_with_choices <- df_data_parent_qns %>% 
    left_join(df_grouped_choices, by = "list_name") %>% 
    mutate(issue_id = "other_specify_checks",
           issue = "",
           checked_by = "",
           checked_date = as_date(today()),
           comment = "",
           reviewed = "",
           adjust_log = ""
    ) %>% 
    filter(str_detect(string = current_value, pattern = "\\bother\\b|\\bother_|_other\\b"))
  
  # care for select_one and select_multiple (change_response, add_option, remove_option)
  output <- list()
  # select_one checks
  output$select_one <- df_join_other_response_with_choices %>% 
    filter(str_detect(select_type, c("select_one|select one"))) %>% 
    mutate(type = "change_response")
  
  # select_multiple checks
  select_mu_data <- df_join_other_response_with_choices %>% 
    filter(str_detect(select_type, c("select_multiple|select multiple")))
  
  select_mu_add_option <- select_mu_data %>% 
    mutate(type = "add_option")
  select_mu_remove_option <- select_mu_data %>% 
    mutate(type = "remove_option",
           value = as.character(int.my_current_val_extract))
  
  output$select_multiple <- bind_rows(select_mu_add_option, select_mu_remove_option) %>% 
    arrange(uuid, start_date, name)
  
  # merge other checks
  merged_other_checks <- bind_rows(output) %>% 
    mutate(uuid_cl = "",
           so_sm_choices = choice_options) %>% 
    select(uuid,
           start_date,
           # progres_id,
           location,
           type,
           name,
           current_value,
           value,
           issue_id,
           issue,
           other_text,
           checked_by,
           checked_date,
           comment,
           reviewed,
           adjust_log,
           uuid_cl,
           so_sm_choices)
}

extract_other_for_qualitative_data <- function(input_tool_data, input_survey, input_choices) {
  
  # add and rename some columns
  df_data <- input_tool_data %>% 
    rename(uuid = `_uuid`) %>% 
    mutate(start_date = as_date(`_submission_time`))
  
  # get questions with other
  others_colnames <-  df_data %>% 
    select(ends_with("_other"), ends_with("_specify"), -contains("/")) %>% 
    colnames()
  
  # data.frame for holding _other response data
  df_other_response_data <- data.frame()
  
  for (cln in others_colnames) {
    
    current_parent_qn = str_replace_all(string = cln, pattern = "_other|_list_specify|_specify", replacement = "")
    
    if (current_parent_qn == "educ_challenge"){
      current_parent_qn = "education_challenges"
    }
    
    df_filtered_data <- df_data %>% 
      select(-contains("/")) %>% 
      select(uuid, start_date, contact_information_location, other_text = cln, current_value = current_parent_qn) %>% 
      filter(!is.na(other_text), !other_text %in% c(" ", "NA")) %>% 
      mutate( other_name = cln, 
              int.my_current_val_extract = ifelse(str_detect(current_value, "\\bother\\b|\\bother_|_other\\b"), 
                                                  str_extract_all(string = current_value, pattern = "\\bother\\b|\\bother_\\w+\\b|\\w+_other\\b"), 
                                                  current_value),
              value = "",
              parent_qn = current_parent_qn)
    df_other_response_data <- rbind(df_other_response_data, df_filtered_data)
  }
  
  # arrange the data
  df_data_arranged <- df_other_response_data %>% 
    arrange(start_date, uuid)
  
  # get choices to add to the _other responses extracted
  df_grouped_choices <- input_choices %>% 
    group_by(list_name) %>% 
    summarise(choice_options = paste(name, collapse = " : ")) %>% 
    arrange(list_name)
  
  # extract parent question and join survey for extracting list_name
  df_data_parent_qns <- df_data_arranged %>% 
    left_join(input_survey %>% select(name, type), by = c("parent_qn"="name")) %>% 
    separate(col = type, into = c("select_type", "list_name"), sep =" ", remove = TRUE, extra = "drop" ) %>% 
    rename(name = parent_qn)
  
  # join other responses with choice options based on list_name
  df_join_other_response_with_choices <- df_data_parent_qns %>% 
    left_join(df_grouped_choices, by = "list_name") %>% 
    mutate(issue_id = "other_specify_checks",
           issue = "",
           checked_by = "",
           checked_date = as_date(today()),
           comment = "",
           reviewed = "",
           adjust_log = ""
    ) %>% 
    filter(str_detect(string = current_value, pattern = "\\bother\\b|\\bother_|_other\\b"))
  
  # care for select_one and select_multiple (change_response, add_option, remove_option)
  output <- list()
  # select_one checks
  output$select_one <- df_join_other_response_with_choices %>% 
    filter(str_detect(select_type, c("select_one|select one"))) %>% 
    mutate(type = "change_response")
  
  # select_multiple checks
  select_mu_data <- df_join_other_response_with_choices %>% 
    filter(str_detect(select_type, c("select_multiple|select multiple")))
  
  select_mu_add_option <- select_mu_data %>% 
    mutate(type = "add_option")
  select_mu_remove_option <- select_mu_data %>% 
    mutate(type = "remove_option",
           value = as.character(int.my_current_val_extract))
  
  output$select_multiple <- bind_rows(select_mu_add_option, select_mu_remove_option) %>% 
    arrange(uuid, start_date, name)
  
  # merge other checks
  merged_other_checks <- bind_rows(output) %>% 
    mutate(uuid_cl = "",
           so_sm_choices = choice_options) %>% 
    select(uuid,
           start_date,
           # progres_id,
           contact_information_location,
           type,
           name,
           current_value,
           value,
           issue_id,
           issue,
           other_text,
           checked_by,
           checked_date,
           comment,
           reviewed,
           adjust_log,
           uuid_cl,
           so_sm_choices)
}


# function: checks for qualitative data -----------------------------------

check_qualitative_tool_data <- function(input_tool_data_name, input_tool_name) {
  # read data 
  df_tool_data <- readxl::read_excel(paste0("inputs/", input_tool_data_name,".xlsx")) %>% 
    mutate(i.check.uuid = `_uuid`,
           i.check.start_date = as_date(`_submitted_by`),
           # i.check.progres_id = progres_id,
           i.check.contact_information_location = contact_information_location
           # start = as_datetime(start),
           # end = as_datetime(end)
    )
  
  df_survey <- readxl::read_excel(paste0("inputs/", input_tool_name, ".xlsx"), sheet = "survey")
  df_choices <- readxl::read_excel(paste0("inputs/", input_tool_name, ".xlsx"), sheet = "choices")
  
  
  # others checks
  
  df_others_data <- extract_other_for_qualitative_data(input_tool_data = df_tool_data, 
                                                       input_survey = df_survey, 
                                                       input_choices = df_choices)
  
  # combine logic and others checks
  df_combined_checks <- df_others_data
  
  # output the resulting data frame
  write_csv(x = df_combined_checks, file = paste0("outputs/", butteR::date_file_prefix(), "_", input_tool_data_name, "_combined_checks.csv"), na = "")
  
}

# function: checks for quantitative data -----------------------------------
check_quantitative_tool_data <- function(input_tool_data_name, input_tool_name) {
  # read data 
  df_tool_data <- readxl::read_excel(paste0("inputs/", input_tool_data_name,".xlsx")) %>% 
    mutate(i.check.uuid = `_uuid`,
           i.check.start_date = as_date(start),
           # i.check.progres_id = progres_id,
           i.check.location = location,
           start = as_datetime(start),
           end = as_datetime(end)
    )
  
  df_survey <- readxl::read_excel(paste0("inputs/", input_tool_name, ".xlsx"), sheet = "survey")
  df_choices <- readxl::read_excel(paste0("inputs/", input_tool_name, ".xlsx"), sheet = "choices")
  
  # output holder -----------------------------------------------------------
  
  logic_output <- list()
  
  # general checks -------------------------------------------------------------
  
  # Time interval for the survey
  
  min_time_of_survey <- 20
  max_time_of_survey <- 120
  
  df_c_survey_time <-  df_tool_data %>% 
    mutate(int.survey_time_interval = lubridate::time_length(end - start, unit = "min"),
           int.survey_time_interval = ceiling(int.survey_time_interval),
           
           i.check.type = "remove_survey",
           i.check.name = "uuid",
           i.check.current_value = "",
           i.check.value = i.check.uuid,
           i.check.issue_id = case_when(
             int.survey_time_interval < min_time_of_survey ~ "less_survey_time",
             # int.survey_time_interval > max_time_of_survey ~ "more_survey_time",
             TRUE ~ "normal_survey_time" ),
           i.check.issue = glue("{int.survey_time_interval} min taken to do the survey"),
           i.check.other_text = "",
           i.check.checked_by = "",
           i.check.checked_date = as_date(today()),
           i.check.comment = "", 
           i.check.reviewed = "",
           i.check.adjust_log = "",
           i.check.uuid_cl = "",
           i.check.so_sm_choices = "")%>% 
    filter(i.check.issue_id %in% c("less_survey_time")) %>% 
    dplyr::select(starts_with("i.check"))%>% 
    rename_with(~str_replace(string = .x, pattern = "i.check.", replacement = ""))
  
  if(exists("df_c_survey_time")){
    if(nrow(df_c_survey_time) > 0){
      logic_output$df_c_survey_time <- df_c_survey_time
    }
  }
  
  
  # duplicates
  
  # logical checks to be identified
  
  # combine checks ----------------------------------------------------------
  
  df_logic_checks <- bind_rows(logic_output)
  
  # others checks
  
  df_others_data <- extract_other_data(input_tool_data = df_tool_data, 
                                       input_survey = df_survey, 
                                       input_choices = df_choices)
  
  # combine logic and others checks
  df_combined_checks <- bind_rows(df_logic_checks, df_others_data)
  
  # output the resulting data frame
  write_csv(x = df_combined_checks, file = paste0("outputs/", butteR::date_file_prefix(), "_", input_tool_data_name, "_combined_checks.csv"), na = "")
  
}

# function: cleaning log -----------------------------------

cleaning_log <- function(input_log_name, input_tool_data_name, input_tool_name, input_vars_to_remove_from_data) {
  # read data
  df_cleaning_log <- read_csv(paste0("inputs/", input_log_name, ".csv")) %>% 
    mutate(adjust_log = ifelse(is.na(adjust_log), "apply_suggested_change", adjust_log)) %>%
    filter(adjust_log != "delete_log", !is.na(value), !is.na(uuid)) %>% 
    mutate(sheet = NA, index = NA, relevant = NA) %>% 
    select(uuid, type, name, value, issue_id, sheet, index, relevant, issue)
  
  read_tool_data <- readxl::read_excel(path = paste0("inputs/", input_tool_data_name, ".xlsx")) %>% 
    filter(consent == "yes")
  
  df_raw_data <- tibble()
  
  # apply different filters to the data depending on the file name and columns in that file
  if(str_detect(string = input_tool_data_name, pattern = fixed(pattern = "kampala", ignore_case = TRUE)) ){
    
    if("contact_information_location" %in% colnames(read_tool_data)){
      df_raw_data <- read_tool_data %>% 
        filter(contact_information_location == "kampala")
    } else{
      df_raw_data <- read_tool_data %>% 
        filter(location == "kampala")
    }
  } else{
    
    if("contact_information_location" %in% colnames(read_tool_data)){
      df_raw_data <- read_tool_data %>% 
        filter(contact_information_location != "kampala" )
    } else{
      df_raw_data <- read_tool_data %>% 
        filter(location != "kampala")
    }
  }
  
  # tool and choices
  df_survey <- readxl::read_excel(paste0("inputs/", input_tool_name, ".xlsx"), sheet = "survey") 
  df_choices <- readxl::read_excel(paste0("inputs/", input_tool_name, ".xlsx"), sheet = "choices") 
  
  # find all new choices to add to choices sheet ----------------------------
  
  # gather choice options based on unique choices list
  df_grouped_choices<- df_choices %>% 
    group_by(list_name) %>% 
    summarise(choice_options = paste(name, collapse = " : "))
  # get new name and ad_option pairs to add to the choices sheet
  new_vars <- df_cleaning_log %>% 
    filter(type %in% c("change_response", "add_option")) %>% 
    left_join(df_survey, by = "name") %>% 
    filter(str_detect(string = type.y, pattern = "select_one|select one|select_multiple|select multiple")) %>% 
    separate(col = type.y, into = c("select_type", "list_name"), sep =" ", remove = TRUE, extra = "drop") %>% 
    left_join(df_grouped_choices, by = "list_name") %>%
    filter(!str_detect(string = choice_options, pattern = value ) ) %>%
    rename(choice = value ) %>%
    select(name, choice) %>%
    distinct() %>% # to make sure there are no duplicates
    arrange(name)
  
  # create kobold object ----------------------------------------------------
  
  kbo <- kobold::kobold(survey = df_survey, 
                        choices = df_choices, 
                        data = df_raw_data, 
                        cleaning = df_cleaning_log)
  
  # modified choices for the survey tool --------------------------------------
  df_choises_modified <- butteR:::xlsform_add_choices(kobold = kbo, new_choices = new_vars)
  
  # special treat for variables for select_multiple, we need to add the columns to the data itself
  df_survey_sm <- df_survey %>% 
    mutate(q_type = case_when(str_detect(string = type, pattern = "select_multiple|select multiple") ~ "sm",
                              str_detect(string = type, pattern = "select_one|select one") ~ "so",
                              TRUE ~ type)) %>% 
    select(name, q_type)
  # construct new columns for select multiple
  new_vars_sm <- new_vars %>% 
    left_join(df_survey_sm, by = "name") %>% 
    filter(q_type == "sm") %>% 
    mutate(new_cols = paste0(name,"/",choice))
  
  # add new columns to the raw data -----------------------------------------
  
  df_raw_data_modified <- df_raw_data %>% 
    butteR:::mutate_batch(nm = new_vars_sm$new_cols, value = F )
  
  # make some cleanup -------------------------------------------------------
  kbo_modified <- kobold::kobold(survey = df_survey %>% filter(name %in% colnames(df_raw_data_modified)), 
                                 choices = df_choises_modified, 
                                 data = df_raw_data_modified, 
                                 cleaning = df_cleaning_log )
  kbo_cleaned <- kobold::kobold_cleaner(kbo_modified)
  
  # handling Personally Identifiable Information(PII) -----------------
  
  df_handle_pii <- kbo_cleaned$data %>% 
    mutate(across(any_of(input_vars_to_remove_from_data), .fns = ~na_if(., .)))
  
  # handling added responses after starting data collection and added responses in the cleaning process-----------------
  
  sm_colnames <-  df_handle_pii %>% 
    select(contains("/")) %>% 
    colnames() %>% 
    str_replace_all(pattern = "/.+", replacement = "") %>% 
    unique()
  
  df_handle_sm_data <- df_handle_pii
  
  for (cur_sm_col in sm_colnames) {
    df_updated_data <- df_handle_sm_data %>% 
      mutate(
        across(contains(paste0(cur_sm_col, "/")), .fns = ~ifelse(!is.na(!!sym(cur_sm_col)) & is.na(.) , FALSE, .)),
        across(contains(paste0(cur_sm_col, "/")), .fns = ~ifelse(is.na(!!sym(cur_sm_col)), NA, .))
      )
    df_handle_sm_data <- df_updated_data
  }
  
  df_final_cleaned_data <- df_handle_sm_data
  
  # write final modified data -----------------------------------------------------
  
  write_csv(df_final_cleaned_data, file = paste0("outputs/", butteR::date_file_prefix(), "_clean_data_", input_tool_data_name, ".csv"))
  write_csv(df_final_cleaned_data, file = paste0("outputs/", "clean_data_", input_tool_data_name, ".csv"))
  
}


# function: data analysis -------------------------------------------------

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
                     str_replace(string = input_clean_data_name, pattern = "^clean_data_", replacement = ""), 
                     ".csv"),
              na="")
}

# function: check indicators for the dap --------------------------------------------------------
get_indicators_for_dap <- function(input_tool_name) {
  df_survey <- readxl::read_excel(paste0("inputs/", input_tool_name, ".xlsx"), sheet = "survey")
  df_survey %>% 
    filter(str_detect(string = type, pattern = "integer|select_one|select_multiple")) %>% 
    pull(name)
}