## Create tables XXX_Sites.csv in ODM 1.1 format. XXX denotes the source of the data, for example AND LTER.

library(tidyverse)
library(lubridate)
library(stringr)
library(EMLassemblyline)

## specify input paths
  dir_climdb_tables <- "./climdb_tables"

## read climDB tables
  site_personnel_role <- read_csv(paste(dir_climdb_tables,"site_personnel_role.csv",sep="/"))
  site <- read_csv(paste(dir_climdb_tables,"site.csv",sep="/"))
  research_site <- read_csv(paste(dir_climdb_tables,"research_site.csv",sep="/"))
  research_site_type <- read_csv(paste(dir_climdb_tables,"research_site_sitetype.csv",sep="/"))
  research_site_dates <- read_csv(paste(dir_climdb_tables,"climdb_site_variable_dates.csv",sep="/"))
  research_site_desc <- read_csv(paste(dir_climdb_tables,"research_site_descriptor.csv",sep="/"))
  personnel <- read_csv(paste(dir_climdb_tables,"personnel.csv",sep="/"))
  roles <- read_csv(paste(dir_climdb_tables,"personnel_role_eal.csv",sep="/"))
  site_lat_lon <- read_csv(paste(dir_climdb_tables,"climdb_site_lat_lon_working.csv",sep="/"))

## create vector of directories for Sites.csv tables
  dir_site <- character(length(site$site_id))
  dir_site_data <- character(length(site$site_id))
   for (i in seq_along(site$site_id)) {
    dir_site_tables <- paste('./odm_tables/',as.character(site$site_code[i]),sep = '')
    
    dir_site[i] <- paste(dir_site_tables,'/eal_templates',sep = '')
    dir_site_data[i] <- paste(dir_site_tables,'/data_objects',sep='')
    file.remove(dir(dir_site_data[i],pattern = "\\_Sites.txt", full.names = TRUE))   
  } # i - loop over sites

## note: added missing stations 697, 698, 709, 710, 711, 712 to file research_site_sitetype.csv assuming type.
   for (i in seq_along(site$site_id)) {
     dir_site_tables <- paste('./odm_tables/',as.character(site$site_code[i]),sep = '')
     dir_site[i] <- paste(dir_site_tables,'/eal_templates',sep = '')
     dir_site_data[i] <- paste(dir_site_tables,'/data_objects',sep='')     
     data_values<- read_csv(paste(dir_site_data[i],'/',as.character(site$site_code[i]),'_DataValues.csv',sep = ''))
     
## select site's stations      
      site_stations <- filter(research_site, site_id == i)%>%
                        filter(!(res_site_id == i))
      
## select station ids for “site i"
      res_site_ids <- site_stations$res_site_id
      
## initiate tibble for site's stations information
      site_table  <- tibble(SiteCode = character(),
                            SiteName = character(),
                            Latitude = numeric(),
                            Longitude = numeric(),
                            LatLongDatumSRSName = character(),
                            SiteType = character(),
                            Comments = character())
      
## fill vector with site's stations names, begin date, end date: if available else no date listed   
##  create ODM file Sites_table for each station, listing the research stations
## Use CUAHSI controlled vocabulary to assign site type: "Stream", "Atmosphere", "Land"
## http://his.cuahsi.org/mastercvreg/edit_cv11.aspx?tbl=SiteTypeCV&id=853578079
  
      for (j in seq_along(site_stations$res_site_id)) {   
          station_types <- filter(research_site_type,res_site_id==site_stations$res_site_id[j])

          if (station_types$res_sitetype_id == 1) {
            type_desc <- "Land"
          } else if (station_types$res_sitetype_id == 2) {
            type_desc <- "Land"
          } else if (station_types$res_sitetype_id == 3) {
            type_desc <- "Stream"
          } else if (station_types$res_sitetype_id == 4) {
            type_desc <- "Land"
          }
                    
#          height <- 1000.
          latitude <- site_lat_lon$site.latitude_deg[i]
          longitude <- site_lat_lon$site.longitude_deg[i]
          site_table  <- add_row(site_table,SiteCode = site_stations$res_site_code[j],
                                 SiteName = site_stations$res_site_name[j],
                                 Latitude = site_lat_lon$site.latitude_deg[i],
                                 Longitude = site_lat_lon$site.longitude_deg[i],
                                 LatLongDatumSRSName = '',
                                 SiteType = type_desc,
                                 Comments = '')
      } # j - loop over site's stations
      
## select stations and their SiteCodes that have values in DataValue.csv
      unique_SiteCodes <- unique(data_values$SiteCode)
      site_table <- filter(site_table, SiteCode %in% unique_SiteCodes)

## write XXX_Sites.csv table   
      file_sites_info <- paste(dir_site_data[i],'/',site$site_code[i],"_Sites.csv",sep = "")
      write_csv(site_table, file_sites_info, append = FALSE, quote = F)

} # i - loop over sites
  
  