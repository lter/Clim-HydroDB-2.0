# Convert subset of package: knb-lter-and.3222.36 into CUAHSI ODM format
# Data set title: "Meteorological data from benchmark stations at the Andrews Experimental Forest, 1957 to present."
# Subset: Table MS00111.txt and PROBE_CODES "AIRCEN08","AIRPRI08","AIRUPL08","AIRVAN08" (5 minute air temperatures)

library(tidyverse) 
library(lubridate)
library(chunked)

## specify inputs

    dir_data <- "data"
    data_table_name <- "MS00111.txt"
    probe_code <- c("AIRCEN08","AIRPRI08","AIRUPL08","AIRVAN08")
    UTCOffset <- -8 # to Pacific Standard Time
    dir_odm_tables <- "odm_tables"

### BEGIN - Run code section only once to
##  - Create separate csv files from MS00111.txt for probe_code vector in dir_data
##  - Determine unique AIRTEMP_METHOD codes for ODM table "methods.csv"
##  - Use package chunk for chunkwise reading of large data file and apply dplyr commands to each chunk
#
#    in_file <- file.path(dir_data,data_table_name)
#    for (val in probe_code) {
#        read_table_chunkwise(file=in_file, header = TRUE, sep = ",") %>%
#        filter(PROBE_CODE == val) %>%
#        write_chunkwise(file=file.path(dir_data, paste(val, "csv", sep=".")))
#    }
## Determine unique AIRTEMP_METHOD codes for completation of ODM table "methods.csv" and
#
#    method_code<-tibble(method=character(0))
#    for (val in probe_code) {
#        df_met <- read_csv(file=file.path(dir_data, paste(val, "csv", sep=".")))    
#        method_code <- rbind(method_code,rename(as.tibble(unique(df_met$AIRTEMP_METHOD)),method = value))
#        method_code <- unique(method_code)
#    }
## Complete ODM table "methods.csv" for unique method_codes
### END section
    
# read information from ODM tables and assign to columns of "DataValues.csv"

odm_table_sources <- read_csv(file.path(dir_odm_tables, "Sources.csv"))
SourceCode <- odm_table_sources$SourceCode #"AND"

odm_table_sites <- read_csv(file.path(dir_odm_tables, "Sites.csv"))

odm_table_variables <- read_csv(file.path(dir_odm_tables, "Variables.csv"))
VariableCode <- odm_table_variables$VariableCode[1]   #"AIRTEMP_MEAN"

# Make ODM table "DataValues.csv" for each probe_code
for (val in probe_code) {
    i <- which(probe_code==val)
# Read data from input tables
    df_met <- read_csv(file=file.path(dir_data, paste(val, "csv", sep=".")))

# determine 15 minute time intervals and add column to data
# drop the records that didn't parse into datetime
    df_met <- drop_na(df_met, DATE_TIME)
# determine 15 minute intervals and add column to tibble df_met
    df_met$LocalDateTime <- cut(df_met$DATE_TIME, breaks='15 min')
# assign type date/time
    df_met$LocalDateTime <- ymd_hms(df_met$LocalDateTime)
# calculate 15 minute averages of 5 minute air temperature values and assign Method and Flag
    df_temp_mean <- df_met %>% group_by(LocalDateTime) %>% summarize(DataValue = mean(AIRTEMP_MEAN))
    df_mean_MethodCode <- df_met %>% group_by(LocalDateTime) %>% summarize(MethodCode = first(AIRTEMP_METHOD))
    df_mean_QualityControlLevelCode <- df_met %>% group_by(LocalDateTime) %>% summarize(QualityControlLevelCode = first(AIRTEMP_MEAN_FLAG))

# Make ODM table "DataValues.csv"
    df_odm <-  df_temp_mean %>% mutate(MethodCode = df_mean_MethodCode$MethodCode,
                                       QualityControlLevelCode = df_mean_QualityControlLevelCode$QualityControlLevelCode,
                                       UTCOffset,
                                       DateTimeUTC = LocalDateTime + hours(-UTCOffset),
                                       SiteCode = odm_table_sites$SiteCode[i],
                                       VariableCode,
                                       SourceCode,
                                       QualityControlLevelCode)

    # replace missing values NA with -9999 
    df_odm$DataValue[is.na(df_odm$DataValue)] <- -9999
    
# re-order columns
    df_odm <- select(df_odm, DataValue, LocalDateTime, UTCOffset, DateTimeUTC, SiteCode, VariableCode, MethodCode, SourceCode, QualityControlLevelCode)
    
# write "DataValues.csv"
    out_file <- file.path(dir_odm_tables,paste(val,"DataValues.csv", sep="_"))
    write_csv(df_odm,out_file)
}

