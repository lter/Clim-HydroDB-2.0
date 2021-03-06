## This script fills templates for use with the EMLAssemblyline to create EML for ClimDB/HydroDB data.

library(tidyverse)
library(lubridate)
library(stringr)
library(EMLassemblyline)

## specify paths
  dir_climdb_tables <- "./climdb_tables"
  dir_eal_templates <- "./eal_templates"
  dir_output <- "./odm_tables"
  
## generate empty eal templates (only once)
#  template_core_metadata(
#    path = "./eal_templates",
#    license = 'CC0')
#  template_geographic_coverage(
#    path = dir_eal_templates,
#    empty = TRUE)

## read climDB tables
  site_personnel_role <- read_csv(paste(dir_climdb_tables,"site_personnel_role.csv",sep="/"))
  site <- read_csv(paste(dir_climdb_tables,"site.csv",sep="/"))
  research_site <- read_csv(paste(dir_climdb_tables,"research_site.csv",sep="/"))
  research_site_dates <- read_csv(paste(dir_climdb_tables,"climdb_site_variable_dates.csv",sep="/"))
  research_site_desc <- read_csv(paste(dir_climdb_tables,"research_site_descriptor.csv",sep="/"))
  personnel <- read_csv(paste(dir_climdb_tables,"personnel.csv",sep="/"))
  roles <- read_csv(paste(dir_climdb_tables,"personnel_role_eal.csv",sep="/"))
  site_lat_lon <- read_csv(paste(dir_climdb_tables,"climdb_site_lat_lon_working.csv",sep="/"))
  cont_vocab <- read_csv("./Variables_controlledVocab.csv")

## create vector of directories for sites' eal templates
  dir_site <- character(length(site$site_id))

for (i in seq_along(site$site_id)) {
    
    dir_site[i] <- paste(dir_output,'/',as.character(site$site_code[i]),'/eal_templates',sep = '')
## create output directory for eal templates if not yet established or remove existing eal templates
    if (!dir.exists(dir_site[i])){
      dir.create(dir_site[i])
    } else {
      file.remove(dir(dir_site[i],pattern = "\\.txt", full.names = TRUE))   
    }    

## create eal templates: abstract, intellectual_rights, methods, personnel, keywords, geographic_coverage
## abstract.txt (include site name, acronym, station names with begin & end date)
    
for (i in seq_along(site$site_id)) {

## select site's stations      
      site_stations <- filter(research_site, site_id == i) %>%
                        filter(!(res_site_id == i))

## filter dates for site (for each station and observable)
      site_dates <- filter(research_site_dates, site_id == i)

  ## select stations and their SiteCodes that have values in DataValue.csv
      dir_site_tables <- paste(dir_output,'/',as.character(site$site_code[i]),sep = '')
      dir_site_data <- paste(dir_site_tables,'/data_objects',sep='')
if (file.exists(paste(dir_site_data,'/',as.character(site$site_code[i]),'_DataValues.csv',sep = ''))) {      
      data_values<- read_csv(paste(dir_site_data,'/',as.character(site$site_code[i]),'_DataValues.csv',sep = ''))           
      unique_SiteCodes <- unique(data_values$SiteCode)
      unique_VariableCodes <- unique(data_values$VariableCode)
      stations <- filter(site_stations, site_stations$res_site_code %in% unique_SiteCodes)   

## select station ids for “site i"
      res_site_ids <- stations$res_site_id

## initiate character vector: station name, begin date, end date
        station_list <- character(length(stations$res_site_id))

  ## fill vector with site's station name, begin date, end date: if available else no date listed   
    for (j in seq_along(stations$res_site_id)) {        
          station_name <- stations$res_site_name[j]          
         station_dates <- filter(site_dates,res_site_id == as.numeric(res_site_ids[j]))
      if (!is.na(station_dates[1,1])) {
         station_first_seen <- year(min(station_dates$first_seen))
         station_most_recent <- year(max(station_dates$most_recent))
         station_list[j] <- paste("(",j,") ",toString(station_name, quote=FALSE)," (",station_first_seen,",",station_most_recent,")",sep = "")
      } else {
         station_list[j] <- paste("(",j,") ",toString(station_name, quote=FALSE),sep = "")
  
      } # if - statement
      } # j - loop over site's stations

    abstract_part1 <- paste("The National Science Foundation's Long-Term Ecological Research (LTER) program and many ",
                              "U.S. Forest Service Experimental Research Stations collect and maintain extensive, long-term ecological databases",
                              "including streamflow and meteorological measurements.",
                              "These databases have been widely used in intersite comparisons, modeling studies, and land management-related studies. ",
                              "Intersite research was facilitated by a centralized database called Climate and Hydrology Database Projects (CLIMDB/HYDRODB), initiated in 1998. ",
                              "The database was actively maintained until approximately 2015, and received contributions from 45 contributing LTER and USFS sites. ",
                              "In 2018, it was decided that a more modern system aligned with a broader community would be more appropriate for this type of data. ",
                              "The system maintained by the Consortium of Universities for the Advancement of Hydrologic Science (CUAHSI) was chosen.")
    abstract_part2 <- paste("This data package contains data contributed by the site ",site$site_name[i],
                    " (",site$site_code[i],") ",
                    "to ClimDBHydroDB, which has been reformatted to the Observations Data Model (ODM) 1.1 model for contribution to the CUAHSI system. ",
                    "This package contains the six data tables required for upload to CUAHSI. ",
                    "Data are available for ",toString(length(stations$res_site_id)), " station(s): ",
                    toString(station_list, quote=FALSE),".",sep="")
    abstract <- paste(abstract_part1,"\n","\n",abstract_part2,sep="")

  ## write template "abstract.txt"
      file_abstract <- paste(dir_site[i],"/abstract.txt",sep = "")
      fileConn<-file(file_abstract)
      writeLines(abstract, fileConn)
      close(fileConn)

## write template "intellectual_rights.txt"
      file_rights <- paste(dir_site[i],"/intellectual_rights.txt",sep = "")
      file.copy(paste(dir_eal_templates,"/","intellectual_rights.txt",sep = ""), file_rights, overwrite = TRUE)

## write template "methods.txt"
      methods <- paste("The data were extracted from the ClimDB/HydroDB database with SQL statements ",
                       "and converted into tables conforming to Observations Data Model (ODM) 1.1. Export and EML creation ",
                       "scripts can be found at https://github.com/lter/Clim-HydroDB-2.0. ",
                       "Appropriate text metadata (not available from ClimDB/HydroDB) was added, ",
                       "including abstract, these extraction methods, keywords, and geographic coverage ",
                       "(if missing from ClimDB/HydroDB).",sep="")
      file_methods <- paste(dir_site[i],"/methods.txt",sep = "")
      fileConn<-file(file_methods)
      writeLines(methods, fileConn)
      close(fileConn)                   

## filter personnel info for site
      personnel_info <- filter (site_personnel_role, site_id == i)
## initiate tibble: info on personnel of site
      personnel_site  <- tibble(givenName = character(),              
                        middleInitial = character(),
                        surName = character(),
                        organizationName = character(),
                        electronicMailAddress = character(),
                        userId = character(),
                        role = character(),
                        projectTitle = character(),
                        fundingAgency = character(),
                        fundingNumber = character())

## select site's stations, remove line for site itself (res_site_id == i)
      site_stations <- filter(research_site, site_id == i) %>%
                        filter(!(res_site_id == i))
## identify personnel ids for each station      
      for (j in seq_along(site_stations$res_site_id)) {
         personnel_ids <-  distinct(personnel_info,personnel_id)
## identify role ids for each person related to the station j of site i
         for (k in seq_along(personnel_ids$personnel_id)) {
            role_ids <- filter(personnel_info, personnel_id == personnel_ids$personnel_id[k]) %>% 
                        select(personnel_role_id)
            person <- personnel_ids$personnel_id[k]
## identify roles of personnel k for station j of site i and add row to tibble personnel_site
            for (l in seq_along(role_ids$personnel_role_id)) {
               personnel_site <- add_row(personnel_site,givenName = personnel$first_name[which(personnel$personnel_id==person)],
                                 middleInitial = personnel$middle_name[which(personnel$personnel_id==person)],
                                 surName = personnel$last_name[which(personnel$personnel_id==person)],
                                 organizationName	 =  personnel$address[which(personnel$personnel_id==person)],
                                 electronicMailAddress	= personnel$email1[which(personnel$personnel_id==person)],
                                 userId	= '',
                                 role	= roles$personnel_role_desc[which(roles$personnel_role_id==as.integer(role_ids$personnel_role_id[l]))],
                                 projectTitle	 =  '',
                                 fundingAgency	= '',
                                 fundingNumber	=  '')
            } # l - loop over roles of personnel
         } # k - loop over station's personnel
      } # j - loop over site's stations

## write template "personnel.txt"
      personnel_site <- unique(personnel_site)
      check_creator <- any(personnel_site$role=="Creator")
      if (!check_creator) {print(paste(site$site_code[i]," no creator",sep=""))
        test <- filter(personnel_site,personnel_site$role=="Principal Investigator")
       test <- mutate(test,role="Creator")
       personnel_site <- bind_rows(personnel_site,test)
        personnel_site <- arrange(personnel_site,desc(role))
      }
      check_creator <- any(personnel_site$role=="Creator")
      if (!check_creator) {print(paste(site$site_code[i]," no creator",sep=""))
        test <- filter(personnel_site,personnel_site$role=="Contact")
        test <- mutate(test,role="Creator")
        personnel_site <- bind_rows(personnel_site,test)
        personnel_site <- arrange(personnel_site,desc(role))
      }
      check_contact <- any(personnel_site$role=="Contact")
      if (!check_contact) {print(paste(site$site_code[i]," no contact",sep=""))
        test <- filter(personnel_site,personnel_site$role=="Principal Investigator")
        test <- mutate(test,role="Contact")
        personnel_site <- bind_rows(personnel_site,test)
        personnel_site <- arrange(personnel_site,desc(role))
      }
## new
      test <- filter(personnel_site,personnel_site$role=="Creator")
      test <- mutate(test,givenName='',middleInitial='',surName=paste(site$site_name[i],"LTER",sep=" "),organizationName='',electronicMailAddress='',userId='')
      test <- unique(test)
      personnel_site <- bind_rows(personnel_site,test)
      personnel_site <- arrange(personnel_site,-desc(givenName))      
## new      
      file_personnel <- paste(dir_site[i],"/personnel.txt",sep = "")
      write.table(personnel_site, file_personnel, append = TRUE, quote = F, row.names = F, sep = "\t",na = "")

## write template "keywords.txt"
      keywords_site  <- tibble(keyword = character(),              
                            keywordThesaurus = character())
      nr_keywords <- length(cont_vocab$VariableCode)+3
      keyword <- character(nr_keywords)
      keyword[1] <- "LTER ClimDB/HydroDB"
      keyword[2] <- site$site_name[i]
      keyword[3] <- "Observations Data Model (ODM) 1.1"
      for (j in seq_along(cont_vocab$VariableCode)) {
          keyword[j+3] <- cont_vocab$ControlledVocab[j]
      }
####
      for (j in seq_along(cont_vocab$VariableCode)) {
      check_variables <- any(unique_VariableCodes==cont_vocab$VariableCode[j])
      if (!check_variables) {print(cont_vocab$VariableCode[j])
        keyword <- keyword[-(j+3)]
        }
      }
      keyword <- unique(keyword)
      nr_keywords <- length(keyword)
####      
      for (j in 1:nr_keywords) {
         keywords_site <-  add_row(keywords_site,keyword = keyword[j],
                           keywordThesaurus = '')
      }
      file_keywords <- paste(dir_site[i],"/keywords.txt",sep = "")
      write.table(keywords_site, file_keywords, append = TRUE, quote = F, row.names = F, sep = "\t")

## write template "geographic_coverage.txt"
## initiate tibble: geographic coverage
      geographic_coverage_site <- tibble(geographicDescription = character(),
                                    northBoundingCoordinate = numeric(),
                                    southBoundingCoordinate = numeric(),
                                    eastBoundingCoordinate = numeric(),
                                    westBoundingCoordinate = numeric())
## add coverage to tibble
      geographic_coverage_site <- add_row(geographic_coverage_site,
                                 geographicDescription = site$site_code[i],
                                 northBoundingCoordinate = site_lat_lon$site.latitude_deg[i],
                                 southBoundingCoordinate = site_lat_lon$site.latitude_deg[i],
                                 eastBoundingCoordinate = site_lat_lon$site.longitude_deg[i],
                                 westBoundingCoordinate = site_lat_lon$site.longitude_deg[i])
      file_coverage <- paste(dir_site[i],"/geographic_coverage.txt",sep = "")
      write.table(geographic_coverage_site, file_coverage, append = TRUE, quote = F, row.names = F, sep = "\t")
  } # i - loop over sites

## create eal templates: attribute.txt
  for (i in seq_along(site$site_id)) {
    file_attributes_DataValues <- paste(dir_site[i],'/attributes_',site$site_code[i],'_DataValues.txt',sep = "")
    file_attributes_Methods <- paste(dir_site[i],'/attributes_',site$site_code[i],'_M.txt',sep = "")
    file_attributes_QualityControlLevels <- paste(dir_site[i],'/attributes_',site$site_code[i],'_QualityControlLevels.txt',sep = "")
    file_attributes_Sites <- paste(dir_site[i],'/attributes_',site$site_code[i],'_Sites.txt',sep = "")
    file_attributes_Sources <- paste(dir_site[i],'/attributes_',site$site_code[i],'_Sources.txt',sep = "")
    file_attributes_Variables <- paste(dir_site[i],'/attributes_',site$site_code[i],'_Variables.txt',sep = "")
    file.copy(paste(dir_eal_templates,'/attributes_DataValues.txt',sep=''), file_attributes_DataValues, overwrite = TRUE)
    file.copy(paste(dir_eal_templates,'/attributes_M.txt',sep=''), file_attributes_Methods, overwrite = TRUE)
    file.copy(paste(dir_eal_templates,'/attributes_QualityControlLevels.txt',sep=''), file_attributes_QualityControlLevels, overwrite = TRUE)
    file.copy(paste(dir_eal_templates,'/attributes_Sites.txt',sep=''), file_attributes_Sites, overwrite = TRUE)
    file.copy(paste(dir_eal_templates,'/attributes_Sources.txt',sep=''), file_attributes_Sources, overwrite = TRUE)
    file.copy(paste(dir_eal_templates,'/attributes_Variables.txt',sep=''), file_attributes_Variables, overwrite = TRUE)
  } #if    
  } # i - loop over sites
  
      
