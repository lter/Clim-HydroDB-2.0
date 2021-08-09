# Convert subset of data package knb-lter-and.3222.36 into CUAHSI ODM format
# Data set title: "Meteorological data from benchmark stations at the Andrews Experimental Forest, 1957 to present."
# Subset: use Table MS00111.txt and select air temperatures from benchmark station PRIMET at 350 cm height
# Air temperature intervals: 15 minutes and 5 minutes (not averaged to 15 minutes yet)

library(tidyverse) 
library(lubridate)
library(chunked)

## specify inputs

    dir_data <- "./data"
    data_table_name <- "MS00111.txt"
    site_code <- "PRIMET"
    UTCOffset <- -8 # to Pacific Standard Time
    dir_odm_tables <- "./odm_tables"

## run code section only once to
#  - create separate data file from MS00111.txt for site_code "PRIMET" and height "350"
#  - determine AIRTEMP_METHOD codes for ODM table "methods.csv"
#  - use package chunk for chunkwise reading of large data file and apply dplyr commands to each chunk
#
#    
#    in_file <- file.path(dir_data,data_table_name)
#    read_table_chunkwise(file=in_file,header = TRUE, sep = ",") %>%
#    filter(SITECODE == "PRIMET") %>%
#    filter(HEIGHT == "350") %>%
#    write_chunkwise(file=file.path(dir_data, paste(site_code, "csv", sep=".")))
#
#    df_met <- read_csv(file=file.path(dir_data, paste(site_code, "csv", sep=".")))
#    method_code <- unique(df_met$AIRTEMP_METHOD) #edit Methods.csv table accordingly
#    
## end section

# read air temperature data from data file and assign column "DataValue"
    df_met <- read_csv(file=file.path(dir_data, paste(site_code, "csv", sep=".")))
    df_temp <- select(df_met,DataValue=AIRTEMP_MEAN)

# read information from ODM tables that will be addded as columns to ODM table "DataValues.csv"

    odm_table_sources <- read_csv(file.path(dir_odm_tables, "Sources.csv"))
    SourceCode <- odm_table_sources$SourceCode #"AND"

    odm_table_sites <- read_csv(file.path(dir_odm_tables, "Sites.csv"))
    SiteCode <- odm_table_sites$SiteCode[2]  #"PRIMET"

    odm_table_variables <- read_csv(file.path(dir_odm_tables, "Variables.csv"))
    VariableCode <- odm_table_variables$VariableCode[1]   #"AIRTEMP_MEAN"
    
    QualityControlLevelCode = 1
    
    df_met_QualityCode <- df_met$AIRTEMP_MEAN_FLAG
    df_temp_MethodCode <- df_met$AIRTEMP_METHOD     #Should it be probe_code?
    
# make ODM table "DataValues.csv"
    df_odm <- df_temp %>% mutate(LocalDateTime = df_met$DATE_TIME,
                      UTCOffset,
                      DateTimeUTC = df_met$DATE_TIME + hours(-UTCOffset),
                      SiteCode,
                      VariableCode,
                      SourceCode,
                      MethodCode = df_temp_MethodCode,
                      QualityControlLevelCode = 1,
                      QualifierCode = df_met_QualityCode)
    
# replace missing values NA with -9999 
    df_odm$DataValue[is.na(df_odm$DataValue)] <- -9999

# re-order columns
    df_odm <- select(df_odm, DataValue, LocalDateTime, UTCOffset, DateTimeUTC, SiteCode, VariableCode, MethodCode, SourceCode, QualityControlLevelCode, QualifierCode)
    
# write "DataValues.csv"
    out_file <- file.path(dir_odm_tables,paste(site_code,"DataValues.csv", sep=","))
    write_csv(df_odm,out_file)
