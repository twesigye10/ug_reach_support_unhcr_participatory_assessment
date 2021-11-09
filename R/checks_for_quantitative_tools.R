
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