library(EML)

# make EML
# there are 60 unique site id. each one needs and EML, each will become a data package that contains ODM tables


# read in csv files containing metadata downloaded from climdb

time <- read.csv('site_variable_dates.csv')
personnelInfo <- read.csv('personnel.csv')
personnelSite <- read.csv('site_personnel_role.csv')
variables <- read.csv('variables.csv')
sites <- read.csv('site.csv')
All_attributes <- read.csv('attributes.csv')

# Set site_id number 
i = 1 

#### PERSONNEL ####

SitePersonnel <- split(personnelSite, personnelSite$site_id)

creatorInfo <- SitePersonnel[[i]]$personnel_id[which(SitePersonnel[[i]]$personnel_role_id==1)]

givenName <- personnelInfo$first_name[which(personnelInfo$personnel_id %in% creatorInfo)]
surName <- personnelInfo$last_name[which(personnelInfo$personnel_id %in% creatorInfo)]
email <- personnelInfo$email1[which(personnelInfo$personnel_id %in% creatorInfo)]

allCreator <- cbind(givenName, surName, email)
allCreator <- gsub(" ", '', allCreator)
allCreator <- gsub("\n", '', allCreator)
R_person_cre <- c()
for(j in 1:nrow(allCreator)){
	R_person_cre[j] <- person(allCreator[j,1], allCreator[j,2], , allCreator[j,3], "cre")
}

creator <- as_emld(list(remove=R_person_cre))

otherInfo <- SitePersonnel[[i]]$personnel_id[which(SitePersonnel[[i]]$personnel_role_id!=1)]
OthgivenName <- personnelInfo$first_name[which(personnelInfo$personnel_id %in% otherInfo)]
OthsurName <- personnelInfo$last_name[which(personnelInfo$personnel_id %in% otherInfo)]
Othemail <- personnelInfo$email1[which(personnelInfo$personnel_id %in% otherInfo)]

allOther <- cbind(OthgivenName, OthsurName, Othemail)
allOther <- gsub(" ", '', allOther)

R_person_other <- list()
for(j in 1:nrow(allOther)){
	R_person_other[j] <- person(allOther[j,1], allOther[j,2], , allOther[j,3], "ctb")
}

associatedParty <- as_emld(list(remove=R_person_other))


#### COVERAGE ####

begin <- strsplit(min(time$first_seen[which(time$site_id==i)]), ' ')[[1]][1]
end <- strsplit(max(time$most_recent[which(time$site_id==i)]), ' ')[[1]][1]

# this is the result of the SQL query that Gastil wrote to un-nest all of the children sites within the 60 parents
NestedChildren <- read.csv('NestedChildren.csv')
SiteLatLong <- read.csv('SiteLatLong.csv')

# split these results apart by site_id
AllParentsChildren <- split(NestedChildren, NestedChildren$site_id)

coords <- split(SiteLatLong, SiteLatLong$site_id) 

focus <- coords[[i]]
west <- max(focus$descriptor_value[grep('west', focus$descriptor_type_name)])
east <- max(focus$descriptor_value[grep('east', focus$descriptor_type_name)])
north <- max(focus$descriptor_value[grep('north', focus$descriptor_type_name)])
south <- max(focus$descriptor_value[grep('south', focus$descriptor_type_name)])

coverage <- set_coverage(begin = begin, end = end,
               geographicDescription = sites$site_name[which(sites$site_id==i)],
               west = west, east = east,
               north = north, south = south)
coverage_list <- list(geographicCoverage=list(coverage)[[1]]$geographicCoverage, temporalCoverage=list(coverage)[[1]]$temporalCoverage)

# geographic info for each site
to.rm <- which(focus$res_site_name==sites$site_name[which(sites$site_id==i)])
focus <- focus[-to.rm, ]  

siteInfo <- list()               
for(j in 1:length(unique(focus$res_site_name))){
	index <- which(focus$res_site_name==unique(focus$res_site_name)[j])
	if(length(index)==2){
		Latitude <- unique(focus[index,]$descriptor_value[which(focus[index,]$descriptor_value >0)])
		Longitude <- unique(focus[index,]$descriptor_value[which(focus[index,]$descriptor_value <0)])
		Descriptor <- gsub('  ', '', unique(focus[index,]$res_site_name))
		siteInfo[[j]] <- set_coverage(geographicDescription=Descriptor, west=Longitude, east=Longitude, north=Latitude, south=Latitude)
	} else {
		west <- focus[index,]$descriptor_value[grep('west', focus[index,]$descriptor_type_name)]
		east <- focus[index,]$descriptor_value[grep('east', focus[index,]$descriptor_type_name)]
		north <- focus[index,]$descriptor_value[grep('north', focus[index,]$descriptor_type_name)]
		south <- focus[index,]$descriptor_value[grep('south', focus[index,]$descriptor_type_name)]
		Descriptor <- gsub('  ', '', unique(focus[index,]$res_site_name))
		siteInfo[[j]] <- set_coverage(geographicDescription=Descriptor, west=west, east=east, north=north, south=south)
	}
}

# because the functions that put metadata in eml format create extra lists that are hidden. in order to combine things properly, need to extract the data we want and reformat 

newList <- list("Coverage")
for(j in 1:length(siteInfo)){
	newList[[j+1]] <- siteInfo[[j]][2]
	#names(newList[[j+1]]) <- ''
}	

newList[[1]] <- coverage_list

emlCoverage <- as_emld(list(remove=newList))


#### Attributes ###

split_attributes <- split(All_attributes, All_attributes$ODMtable)


attributesSites <- split_attributes$Sites[,1:6]
attributeListSites <- set_attributes(attributesSites, col_classes = split_attributes$Sites[,7])

attributesVariables <- split_attributes$Variables[,1:6]
IsRegular <- c(T="TRUE", F="FALSE")
factors <- data.frame(attributeName = "IsRegular",code = names(IsRegular),definition = unname(IsRegular))
attributeListVariables <- set_attributes(attributesVariables, factors, col_classes = split_attributes$Variables[,7])

attributesMethods <- split_attributes$Methods[,1:6]
attributeListMethods <- set_attributes(attributesMethods, col_classes = split_attributes$Methods[,7])

attributesSources <- split_attributes$Sources[,1:6]
attributeListSources <- set_attributes(attributesSources, col_classes = split_attributes$Sources[,7])

attributesQualityControl <- split_attributes$QualityControl[,1:6]
attributeListQualityControl <- set_attributes(attributesQualityControl, col_classes = split_attributes$QualityControl[,7])

attributesDataValues <- split_attributes$DataValues[,1:6]
attributeListDataValues <- set_attributes(attributesDataValues, col_classes = split_attributes$DataValues[,7])


# make physical #

fileDV <- paste(sites$site_code[i], "ODM", "value", "table.csv", sep='_')

physicalDataValues <- set_physical(fileDV, recordDelimiter = '\r\n', url=paste("https://github.com/lter/Clim-HydroDB-2.0/blob/master/climdb-archive-partA/data_packages/by_site_ODM_fmt/AND/data_objects/", fileDV, sep=''))

dataTableDataValues <- list(physical = physicalDataValues,
                 entityName = fileDV,
                 entityDescription = paste(sites$site_name[which(sites$site_id==i)], "climdb data in ODM DataValues table"),  
                 attributeList = attributeListDataValues)


fileQC <- paste(sites$site_code[i], "ODM", "qualitycontrol", "table.csv", sep='_')				

physicalQualityControl <- set_physical(fileQC, recordDelimiter = '\r\n', url=paste("https://github.com/lter/Clim-HydroDB-2.0/blob/master/climdb-archive-partA/data_packages/by_site_ODM_fmt/AND/data_objects/", fileQC, sep=''))

dataTableQualityControl <- list(physical = physicalQualityControl,
                 entityName = fileQC,
                 entityDescription = paste(sites$site_name[which(sites$site_id==i)], "climdb data in ODM QualityControl table"),  
                 attributeList = attributeListQualityControl)


fileSi <- paste(sites$site_code[i], "ODM", "sites", "table.csv", sep='_')
				
physicalSites <- set_physical(fileSi, recordDelimiter = '\r\n', url=paste("https://github.com/lter/Clim-HydroDB-2.0/blob/master/climdb-archive-partA/data_packages/by_site_ODM_fmt/AND/data_objects/", fileSi, sep=''))

dataTableSites <- list(physical = physicalSites,
                 entityName = fileSi,
                 entityDescription = paste(sites$site_name[which(sites$site_id==i)], "climdb data in ODM Sites table"),  
 				 attributeList = attributeListSites)


fileVar <- paste(sites$site_code[i], "ODM", "variables", "table.csv", sep='_')				

physicalVariables <- set_physical(fileVar, recordDelimiter = '\r\n', url=paste("https://github.com/lter/Clim-HydroDB-2.0/blob/master/climdb-archive-partA/data_packages/by_site_ODM_fmt/AND/data_objects/", fileVar, sep=''))

dataTableVariables <- list(physical = physicalVariables,
                 entityName = fileVar,
                 entityDescription = paste(sites$site_name[which(sites$site_id==i)], "climdb data in ODM Variables table"),  
                 attributeList = attributeListVariables)


fileMet <- paste(sites$site_code[i], "ODM", "methods", "table.csv", sep='_')	

physicalMethods <- set_physical(fileMet, recordDelimiter = '\r\n', url=paste("https://github.com/lter/Clim-HydroDB-2.0/blob/master/climdb-archive-partA/data_packages/by_site_ODM_fmt/AND/data_objects/",fileMet,sep=''))

dataTableMethods <- list(physical = physicalMethods,
                 entityName = fileMet,
                 entityDescription = paste(sites$site_name[which(sites$site_id==i)], "climdb data in ODM Methods table"),   
                 attributeList = attributeListMethods)


fileSo <- paste(sites$site_code[i], "ODM", "sources", "table.csv", sep='_')
physicalSources <- set_physical(fileMet, recordDelimiter = '\r\n', url=paste("https://github.com/lter/Clim-HydroDB-2.0/blob/master/climdb-archive-partA/data_packages/by_site_ODM_fmt/AND/data_objects/",fileSo,sep=''))

dataTableSources <- list(physical = physicalSources,
                 entityName = fileSo,
                 entityDescription = paste(sites$site_name[which(sites$site_id==i)], "climdb data in ODM Sources table"),  
                 attributeList = attributeListSources)




#### THINGS IN STRINGS ####

title <- paste(sites$site_name[i], "- archive from climdb") 

abstract <- paste("The National Science Foundation's Long-Term Ecological Research", paste("(", "LTER", ")", sep=''), "program and many U. S. Forest Service Experimental Research Stations collect and maintain extensive, long-term ecological databases including streamflow and meteorological measurements. These databases have been widely used in intersite comparisons, modeling studies, and land management-related studies. Intersite research was facilitated by a centralized database called ClimHydroDB, initiated in 1998. The database was actively maintained until approximately 2015, and received contributions from 45 contributing LTER and USFS sites. In 2018, it was decided that a more modern system aligned with a broader community would be more appropriate for this type of data. The system maintained by the Consortium of Universities for the Advancement of Hydrologic Science", paste("(", "CUAHSI", ")", sep=''), "was chosen. This data package contains data contributed by the site", sites$site_name[i], paste("(",sites$site_code[i], ")", sep=''), "to ClimHydroDB, which has been reformatted to the ODM 1.1 model for contribution to the CUAHSI system. Data are availble from", length(unique(focus$res_site_name)), "research sites spanning", begin, "to", paste(end, ".", sep=''), "This package contains the six data tables required for upload to CUAHSI.") 

pubDate <- "2020-08-01"

intellectualRights <- "This data package is released to the “public domain” under Creative Commons CC0 1.0 “No Rights Reserved” (see: https://creativecommons.org/publicdomain/zero/1.0/). It is considered professional etiquette to provide attribution of the original work if this data package is shared in whole or by individual components. A generic citation is provided for this data package on the website https://portal.edirepository.org (herein “website”) in the summary metadata page. Communication (and collaboration) with the creators of this data package is recommended to prevent duplicate research or publication. This data package (and its components) is made available “as is” and with no warranty of accuracy or fitness for use. The creators of this data package and the website shall not be liable for any damages resulting from misinterpretation or misuse of the data package or its components. Periodic updates of this data package may be available from the website."

methods <- "methods will go here"

keywords <- list(keyword = list("climdb", sites$site_name[which(sites$site_id==i)]))


#### Combine everything to make eml ####

dataset <- list(title = title,
               creator = creator,
               pubDate = pubDate,
               intellectualRights = intellectualRights,
               abstract = abstract,
               associatedParty = associatedParty,
               keywordSet = keywords,
               coverage = emlCoverage,
               #contact = contact,
               methods = methods,
               dataTable = list(dataTableSources, dataTableMethods, dataTableSites, dataTableDataValues, dataTableVariables, dataTableQualityControl))
               
eml <- list(packageId = uuid::UUIDgenerate(),
           system = "https://pasta.edirepository.org", # type of identifier
           dataset = dataset)


fileName <- paste(gsub(" ", "", sites$site_name[which(sites$site_id==i)]), "_eml.xml", sep='')

write_eml(as_emld(eml), fileName) 
eml_validate(fileName)





