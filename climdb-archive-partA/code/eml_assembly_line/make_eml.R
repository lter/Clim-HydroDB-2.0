# This script executes an EMLassemblyline workflow for each site.

library(EMLassemblyline)
library(tidyverse)
library(lubridate)
library(stringr)

## specify input paths and read tables
    dir_climdb_tables <- "./climdb_tables"
    research_site_dates <- read_csv(paste(dir_climdb_tables,"climdb_site_variable_dates.csv",sep="/"))
    site <- read_csv(paste(dir_climdb_tables,"site.csv",sep="/"))

## eal input parameters
    user_id  <-  'EDI'
    user_domain  <-  'EDI'
    package_id  <-  c('edi.100.1') # add id for each site's package to vector (60)

    for (i in seq_along(site$site_id)) {
        eml_path <- paste('./odm_tables/',as.character(site$site_code[i]),sep = '')
        template_path <- paste(eml_path,'/eal_templates',sep = '')
        data_path <- paste(eml_path,'/data_objects',sep = '')
        other_entity <-  ''
        other_entity_description <-  ''

## get start and end date
        site_dates <- filter(research_site_dates, site_id == i)
        temp_cov_min <- min(site_dates$first_seen)
        temp_cov_max <- max(site_dates$most_recent)        

## data package title
        dataset_title <- paste('Weather and hydrological data for',site$site_name,'previously held in LTER ClimDB/HydroDB','(',temp_cov_min,'-',temp_cov_max,')',sep='')

## make eml with EMLAssemblyline
        make_eml(
        path = template_path,
        data.path = data_path,
        eml.path = eml_path,
        dataset.title = dataset_title,
        temporal.coverage = c(temp_cov_min , temp_cov_max),
        maintenance.description = 'completed',
        data.table.name = c('DataValues.csv',
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
        other.entity = other_entity,
        other.entity.description = other_entity_description,
        user.id = user_id,
        user.domain = user_domain,
        package.id = package_id[i]
        )
    } # i - loop over sites
