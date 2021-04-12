# This script executes an EMLassemblyline workflow for each ClimDB/HydroDB site.

library(EMLassemblyline)
library(tidyverse)
library(lubridate)
library(stringr)

## specify input paths and read odm tables for site and date information
    dir_climdb_tables <- "./climdb_tables"
    research_site_dates <- read_csv(paste(dir_climdb_tables,"climdb_site_variable_dates.csv",sep="/"))
    site <- read_csv(paste(dir_climdb_tables,"site.csv",sep="/"))

## eal input parameters
    user_id  <-  'EDI'
    user_domain  <-  'EDI'
    package_id  <-  c('edi.100.1',........) # add id for each site's package to vector of length number of ClimDB/HydroDB sites
    maintenance_description  <-  'completed'
    data_table_description <- c('Variable definitions',
                                'Values and variable names in long format',
                                'Quality control levels as provided by CUAHSI',
                                'Site description and lat longs',
                                'Method desciptions',
                                'Research project providing these data')
    data_table_quote_character <-  c('\"',
                                   '\"',
                                   '\"',
                                   '\"',
                                   '\"',
                                   '\"')

## Loop over all sites to run EMLAssemblyline and create EML
    for (i in seq_along(site$site_id)) {
        dir_site_data <- paste("./odm_tables/",as.character(site$site_code[i]),sep = '')
        if (file.exists(dir_site_data)) {
    # 
## site dependent input parameters for EAL
            eml_path <- paste('./odm_tables/',as.character(site$site_code[i]),sep = '')
            print(site$site_code[i])
            template_path <- paste(eml_path,'/eal_templates',sep = '')
            data_path <- paste(eml_path,'/data_objects',sep = '')
            other_entity <-  ''
            other_entity_description <-  ''
            data_tables <- c(paste(as.character(site$site_code[i]),'_Variables.csv',sep = ''),
            paste(as.character(site$site_code[i]),'_DataValues.csv',sep = ''),
            paste(as.character(site$site_code[i]),'_QualityControlLevels.csv',sep = ''),
            paste(as.character(site$site_code[i]),'_Sites.csv',sep = ''),
            paste(as.character(site$site_code[i]),'_M.csv',sep = ''),
            paste(as.character(site$site_code[i]),'_Sources.csv',sep = ''))
            data_table_names = c('Variables','DataValue','QualityControlLevels',
                                 'Sites','Methods','Sources')
            data_table_descriptions <- c('Variable definitions','Values and variable names in long format',
                                         'Quality control levels',
                                         'Site description and lat longs',
                                         'Methods',
                                         'Research project providing these data')

## get start and end date
            site_dates <- filter(research_site_dates, site_id == i)
            temp_cov_min <- min(site_dates$first_seen)
            temp_cov_max <- max(site_dates$most_recent)
            temporal_coverage <- c(temp_cov_min , temp_cov_max)
            year_begin <- substring(temp_cov_min,1,4)
            year_end <- substring(temp_cov_max,1,4)

## data package title
            dataset_title <- paste('Weather and hydrological data formatted to ODM 1.1 for ',site$site_name,', archived from ClimDB/HydroDB',' (',year_begin,' to ',year_end,')',sep='')

## make eml with EMLAssemblyline
            make_eml(
                    path = template_path,
                    data.path = data_path,
                    eml.path = eml_path,
                    dataset.title = dataset_title[i],
                    temporal.coverage = temporal_coverage,
                    maintenance.description = maintenance_description,
                    data.table = data_tables,        
                    data.table.name = data_table_names,
                    data.table.description = data_table_descriptions,
#        data.table.quote.character = '\"',
#            data_table_quote_character,
                    user.id = user_id,
                    user.domain = user_domain,
                    package.id = package_id[i]
            )
        } #if
    } # i - loop over sites
        
