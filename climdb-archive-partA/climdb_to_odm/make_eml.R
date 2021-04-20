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
    package_id  <-  c('edi.680.1','edi.781.1','edi.795.1','edi.797.1','edi.761.1','edi.762.1',
                      'edi.763.1','edi.764.1','edi.765.1','edi.766.1','edi.767.1','edi.768.1',
                      'edi.769.1','edi.770.1','edi.771.1','edi.772.1','edi.773.1','edi.774.1',
                      'edi.775.1','edi.776.1','edi.777.1','edi.778.1','edi.779.1','edi.780.1',
                      'edi.727.2','edi.782.1','edi.783.1','edi.784.1','edi.785.1','edi.786.1',
                      'edi.787.1','edi.788.1','edi.789.1','edi.790.1','edi.791.1','edi.792.1',
                      'edi.793.1','edi.794.1','edi.728.2','edi.796.1','edi.729.2','edi.798.1',
                      'edi.799.1','edi.800.1','edi.801.1','edi.802.1','edi.803.1','edi.804.1',
                      'edi.805.1','edi.806.1','edi.807.1','edi.808.1','edi.809.1','edi.810.1',
                      'edi.811.1','edi.812.1','edi.813.1','edi.814.1','edi.815.1','edi.816.1') 
# site$site_code
#    [1] "AND" "ARC" "BES" "BNZ" "CAS" "CDR" "CWT" "ENT" "FER" "FLE" "FRA" "GLA" "GRE" "HBR"
#    [15] "HFR" "HOR" "JRN" "KBS" "KNZ" "LUQ" "MAR" "MCM" "LNO" "NEV" "NTL" "NWT" "PAL" "PIE"
#    [29] "PIN" "PRI" "SDF" "SEV" "SGS" "SIE" "SIL" "SNT" "TEN" "VCR" "FCE" "GCE" "SBC" "CAP"
#    [43] "FEM" "CBE" "UMA" "MEF" "KEW" "MEW" "YEF" "SWS" "TAE" "TTC" "FSH" "HAE" "SER" "WRC"
#    [57] "LHC" "MCR" "CCE" "OLY"    
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
        
