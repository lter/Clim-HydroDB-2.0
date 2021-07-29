# Converts Package ID: knb-lter-ntl.17.27 Cataloging System:https://pasta.edirepository.org into CUAHSI ODM format
# Data set title: North Temperate Lakes LTER Meteorological Data - Woodruff Airport 1989 - current.

library(dplyr)
library(tidyr)
library(lubridate)
library(ggplot2)

# get the high frequncy data, this seems to not get all data 
#download csv file from PASTA to local directory
#infile <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/17/27/dd95edb804b0f222424b2efe5547ce68"
#infile <- sub("^https","http",infile) 
infile <- 'ntl17_4_v7.csv'
df_met <- read.csv(infile, header=T, as.is = T) 

df_met$datetime <- paste(df_met$sampledate, df_met$sampletime)
df_met$datetime <- ymd_hms(df_met$datetime)

# drop the records that didn't parse into datetime
df_met <- drop_na(df_met, datetime)

# turn the datetime into 15 minute intervals
df_met$LocalDateTime <- cut(df_met$datetime, breaks='15 min')

# turn it back into date format
df_met$LocalDateTime <- ymd_hms(df_met$LocalDateTime)


# aggregate for each 15 minutes, map column name to variable name
# and do some data checking
df_temp_mean <- df_met %>% group_by(LocalDateTime) %>% summarise(AirTemp_Mean_C = mean(air_temp))
summary(df_temp_mean)
df_temp_max <- df_met %>% group_by(LocalDateTime) %>% summarise(AirTemp_Max_C = max(air_temp))
summary(df_temp_max)
df_temp_min <- df_met %>% group_by(LocalDateTime) %>% summarise(AirTemp_Min_C = min(air_temp))
summary(df_temp_min)
df_precip <- df_met %>% group_by(LocalDateTime) %>% summarise(Precip_Total_mm = sum(tot_precip))
summary(df_precip)
df_rel_hum <- df_met %>% group_by(LocalDateTime) %>% summarise(Rel_Humidity_percent = mean(rel_hum))
summary(df_rel_hum)
df_wind_speed <- df_met %>% group_by(LocalDateTime) %>% summarise(Windspeed_ms = mean(wind_speed))
summary(df_wind_speed)

# figure out data problems
# find data flags
# this is all not needed right now, but I'll leave it in in case we'll go with advanced upload later
# 
# df_temp_flags <- filter(df_met, nchar(flag_air_temp) > 0)
# df_temp_flags <- df_temp_flags %>% select(LocalDateTime, flag_air_temp) %>% 
#   group_by(LocalDateTime) %>%
#   summarize(QualityControlLevelCode = first(flag_air_temp))
# 
# df_precip_flags <- filter(df_met, nchar(flag_tot_precip) > 0)
# df_precip_flags <- df_precip_flags %>% select(LocalDateTime, flag_tot_precip) %>% 
#   group_by(LocalDateTime) %>%
#   summarize(QualityControlLevelCode = first(flag_tot_precip))
# 
# df_rel_hum_flags <- filter(df_met, nchar(flag_rel_hum) > 0)
# df_rel_hum_flags <- df_rel_hum_flags %>% select(LocalDateTime, flag_rel_hum) %>% 
#   group_by(LocalDateTime) %>%
#   summarize(QualityControlLevelCode = first(flag_rel_hum))
# 
# df_wind_speed_flags <- filter(df_met, nchar(flag_wind_speed) > 0)
# df_wind_speed_flags <- df_wind_speed_flags %>% select(LocalDateTime, flag_wind_speed) %>% 
#   group_by(LocalDateTime) %>%
#   summarize(QualityControlLevelCode = first(flag_wind_speed))

#make the long format for each table
df_odm_temp_mean <- df_temp_mean %>% gather('VariableCode', 'DataValue', 2)
df_odm_temp_max <- df_temp_max %>% gather('VariableCode', 'DataValue', 2)
df_odm_temp_min <- df_temp_min %>% gather('VariableCode', 'DataValue', 2)
df_odm_precip <- df_precip %>% gather('VariableCode', 'DataValue', 2)
df_odm_rel_hum <- df_rel_hum %>% gather('VariableCode', 'DataValue', 2)
df_odm_windspeed <- df_wind_speed %>% gather('VariableCode', 'DataValue', 2)

# add methods codes to temperature and precipitation table
#combine all temp tables into one, it's all the same method
df_odm_temp <- df_odm_temp_max
df_odm_temp <- bind_rows(df_odm_temp, df_odm_temp_mean)
df_odm_temp <- bind_rows(df_odm_temp, df_odm_temp_min)

df_odm_temp$MethodCode <- 'air_temp_sensor'
df_odm_precip$MethodCode <- 'precipitation_sensor'
df_odm_rel_hum$MethodCode <- 'rel_humidity_sensor'
df_odm_windspeed$MethodCode <- 'wind_sensor'

# add QualityControlCode columns
# with flag for temp
# df_odm_temp <- left_join(df_odm_temp, df_temp_flags)
# df_odm_precip <- left_join(df_odm_precip, df_precip_flags)
# df_odm_rel_hum <- left_join(df_odm_rel_hum, df_rel_hum_flags)
# df_odm_windspeed <- left_join(df_odm_windspeed, df_wind_speed_flags)

#combine tables into final ODM
df_odm <- rbind(df_odm_temp, df_odm_precip)
df_odm <- rbind(df_odm, df_odm_rel_hum)
df_odm <- rbind(df_odm, df_odm_windspeed)

# # change flags to standards
# 
# df_odm$QualityControlLevelCode[df_odm$QualityControlLevelCode == 'H'] <- 'Q'
# df_odm$QualityControlLevelCode[df_odm$QualityControlLevelCode == 'K'] <- 'Q'
# df_odm$QualityControlLevelCode[df_odm$QualityControlLevelCode == 'D'] <- 'M'

# df_odm$QualityControlLevelCode[is.na(df_odm$DataValue)] <- "M"

df_odm$DataValue[is.na(df_odm$DataValue)] <- -9999

#add the rest of the columns

df_odm$UTCOffset <- -6
df_odm$SiteCode <- "AP"
df_odm$SourceCode <- "NTL_LTER"
df_odm$QualityControlLevelCode <- '1'

df_odm$DateTimeUTC <- df_odm$LocalDateTime - hours(6)

df_odm <- select(df_odm, DataValue, LocalDateTime, UTCOffset, DateTimeUTC, SiteCode, VariableCode, MethodCode, SourceCode, QualityControlLevelCode)

# write the whole file out for upload to EDI repo
write.csv(df_odm, file = 'DataValues.csv', row.names = F, na = '')

# then break it up into ~500k record chunks for upload to CUAHSI

numrows <- nrow(df_odm)
numchunks <- ceiling(numrows/500000)
start_record <- 1
end_record <- 500000

for(i in 1:numchunks){
  
  df_odm_chunk <- slice(df_odm, start_record:end_record)
  
  write.csv(df_odm_chunk, file = paste('DataValues', i, '.csv', sep = ''), row.names = F)
  
  start_record <- start_record + 500000
  end_record <- end_record + 500000
  
}

# do some more quality checking

ggplot(data = df_precip, aes(x = LocalDateTime, y = Precip_Total_mm)) +
  geom_point() +
  labs(x = "Date",
       y = "Total Precipitation (mm)",
       title = "Precipitation Data")

