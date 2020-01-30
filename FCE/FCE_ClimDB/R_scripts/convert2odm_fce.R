# Convert ClimDB data from FCE lTER into CUAHSI ODM format

library(tidyverse) 
library(lubridate)
# library(chunked)

## specify inputs
    dir_data <- "data"
    dir_odm_tables <- "odm_tables"
    data_table_name <- "FCE_Everglades_ClimDB_data.csv"
    UTCOffset <- -5 # to Florida Standard Time

in_file <- file.path(dir_data,data_table_name)
df_met <- read_csv(in_file, header = TRUE, sep = ",",
                    col_types = list(col_character(), col_character(), col_character(), 
                                     col_double(), col_character(), 
                                     col_double(), col_character(), 
                                     col_double(), col_character(),col_double(), col_character()))
# Reformat date and time
df_met$Date <-as.Date((df_met$Date), "%Y%m%d")

## run this code section only once to:
