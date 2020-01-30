# Convert ClimDB data from FCE lTER into CUAHSI ODM format

library(tidyverse) 
library(lubridate)

## specify inputs
    dir_data <- "data"
    dir_odm_tables <- "odm_tables"
    data_table_name <- "FCE_Everglades_ClimDB_data.csv"
    UTCOffset <- -5 # to Florida Standard Time

## read FCE data
    in_file <- file.path(dir_data,data_table_name)
    df_met <- read_csv(in_file,
                    col_types = list(col_character(), col_character(), col_character(), 
                                     col_double(), col_character(), 
                                     col_double(), col_character(), 
                                     col_double(), col_character(),col_double(), col_character()))
# reformat date and time
    df_met$Date <-as.Date((df_met$Date), "%Y%m%d")

## calulate daily mean air temperature 
## justification: http://www.nrcse.washington.edu/NordicNetwork/reports/temp.pdf
    df_met <- df_met %>%
              mutate(Daily_AirTemp_Mean_C = 0.5*(Daily_AirTemp_AbsMax_C+Daily_AirTemp_AbsMin_C))

# read information from ODM tables and assign to columns of "DataValues.csv"
    odm_table_sources <- read_csv(file.path(dir_odm_tables, "Sources.csv"))
    SourceCode <- odm_table_sources$SourceCode

    odm_table_sites <- read_csv(file.path(dir_odm_tables, "Sites.csv"))
    SiteCode <- odm_table_sites$SiteCode[1]

    odm_table_variables <- read_csv(file.path(dir_odm_tables, "Variables.csv"))
    VariableCode <- odm_table_variables$VariableCode[1]

## make ODM table "DataValues.csv"

# DataValues Table: Create colums 6:VariableCode(Text) and 9:QualityControlLevel col1(Text)
flags <- df_met %>%
    select (Date, Flag_Daily_AirTemp_Mean_C, Flag_Daily_AirTemp_AbsMax_C,Flag_Daily_AirTemp_AbsMin_C,Flag_Daily_Precip_Total_mm)  %>%
    pivot_longer(cols = starts_with("Flag_"), names_to = "VariableCode", values_to = "QualityControlLevel", values_drop_na = FALSE)

# make columns for ODM table "DataValues.csv"
df_odm <- df_met %>%
    select (-LTER_Site, -Station, -Flag_Daily_AirTemp_Mean_C, -Flag_Daily_AirTemp_AbsMax_C, -Flag_Daily_AirTemp_AbsMin_C, -Flag_Daily_Precip_Total_mm) %>%
    pivot_longer(cols = starts_with("Daily_"), names_to = "VariableCode", values_to = "DataValue", values_drop_na = FALSE)  %>%
    rename(LocalDateTime = Date) %>%
    mutate(SiteCode,
           SourceCode,
           UTCOffset,
           DateTimeUTC = LocalDateTime + hours(-UTCOffset),
           QualityControlLevelCode = flags$QualityControlLevel,
           MethodCode = case_when (
                  VariableCode=="Daily_Precip_Total_mm" ~ "PRECIP",
                  VariableCode=="Daily_AirTemp_Mean_C"  ~ "AIR_MEAN",                  
                  VariableCode=="Daily_AirTemp_AbsMax_C"  ~ "AIR_TMAX",
                  VariableCode=="Daily_AirTemp_AbsMin_C"  ~ "AIR_TMIN"))
    
# replace missing values NA with -9999 
    df_odm$DataValue[is.na(df_odm$DataValue)] <- -9999

# re-order columns
    df_odm <- select(df_odm, DataValue, LocalDateTime, UTCOffset, DateTimeUTC, SiteCode, VariableCode, MethodCode, SourceCode, QualityControlLevelCode)
    
# write "DataValues.csv"
    out_file <- file.path(dir_odm_tables,"DataValues.csv")
    write_csv(df_odm,out_file)
