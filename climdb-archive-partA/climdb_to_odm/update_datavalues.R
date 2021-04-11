## This script updates DataValues table created from ClimDB/HydroDB data in ODM 1.1 format 
## with more appropriate values for SourceCode, QualityControlLevel, MethodCode.
## Run only once.

library(tidyverse)
library(lubridate)
library(stringr)

## specify paths
  dir_climdb_tables <- "./climdb_tables"
  dir_output <- "./odm_tables"

## read climDB tables
  site <- read_csv(paste(dir_climdb_tables,"site.csv",sep="/"))
  dir_site <- character(length(site$site_id))

  for (i in seq_along(site$site_id)) {
## Output directory for site i
      dir_site_data <- paste(dir_output,'/',as.character(site$site_code[i]),'/data_objects',sep = '')
      if (file.exists(dir_site_data)) {
## Read data tables      
      data_values <- read_csv(paste(dir_site_data,'/',as.character(site$site_code[i]),'_DataValues.csv',sep = ''))
      data_methods <- read_csv(paste(dir_site_data,'/',as.character(site$site_code[i]),'_M.csv',sep = ''))
      data_sources <- read_csv(paste(dir_site_data,'/',as.character(site$site_code[i]),'_Sources.csv',sep = ''))
## Update data values table
      data_values <- data_values %>% 
                     mutate(QualityControlLevelCode=1,
#                            SourceCode=data_sources$SourceCode[1])
                           SourceCode=site$site_code[i])
      data_methods <- rename(data_methods, VariableCode = MethodDescription)
      data_values <- data_values %>% 
                     left_join(data_methods, by = "VariableCode")
      data_values <- data_values %>% 
                    mutate(MethodCode.x = MethodCode.y) %>% 
                    select(-c(MethodCode.y,MethodLink)) %>% 
                    rename(MethodCode = MethodCode.x)
## Write DataValues table   
     file_data <- paste(dir_site_data,"/",as.character(site$site_code[i]),"_DataValues_new.csv",sep="")
     write_csv(data_values, file_data, append = F, quote = F, na = "NA")
    } #if
   } #i-loop
