
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