# This script executes an EMLassemblyline workflow.

library(EMLassemblyline)
library(dplyr)
library(tidyr)
library(stringr)
library(lubridate)

template_core_metadata(
  path = '.',
  license = 'CCBY'
)


template_table_attributes(
  path = '.',
  data.path = '.',
  data.table = c('DataValues.csv',
                 'Methods.csv',
                 'QualityControlLevels.csv',
                 'Sites.csv',
                 'Sources.csv',
                 'Variables.csv')
)

# get start and end date
df_data <- read.csv('DataValues.csv', header = T, as.is = T)
df_data$LocalDateTime <- ymd_hms(df_data$LocalDateTime)
temp_cov_min <- min(date(df_data$LocalDateTime))
temp_cov_max <- max(date(df_data$LocalDateTime))

# get lat longs
df_sites <- read.csv('Sites.csv', header = T, as.is = T)
lat <- df_sites$Latitude[1]
long <- df_sites$Longitude[1]

make_eml(
  path = '.',
  data.path = '.',
  eml.path = '.',
  dataset.title = 'North Temperate Lakes LTER Meteorological Data - Woodruff Airport 1989 - current. CUAHSI ODM format',
  temporal.coverage = c(temp_cov_min, temp_cov_max),
  geographic.description = 'Noble F. Lee Municipal airport located at Woodruff, Vilas County, WI, USA',
  geographic.coordinates = c(lat, long, lat, long),
  maintenance.description = 'completed',
  data.table = c('DataValues.csv',
                 'Methods.csv',
                 'QualityControlLevels.csv',
                 'Sites.csv',
                 'Sources.csv',
                 'Variables.csv'),
  data.table.description = c('Values and variable names in long format',
                             'Method desciptions',
                             'Quality control levels as provided by CUAHSI',
                             'Site description and lat longs',
                             'Research project providing these data',
                             'Variable definitions'),
  data.table.quote.character = c('\"',
                                 '\"',
                                 '\"',
                                 '\"',
                                 '\"',
                                 '\"'),
  other.entity = c('convertNTL17.R'),
  other.entity.description = c('R script to convert original data into ODM format'),
  user.id = 'NTL',
  user.domain = 'LTER',
  package.id = 'knb-lter-ntl.370.3'
)
