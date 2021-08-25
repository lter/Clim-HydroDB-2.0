# This script executes an EMLassemblyline workflow.

# The basic layout of this script:
# 1. load libraries
# 2. config the script. mainly these are directory settings.
# 3. Set metadata variables. high level first, then dataTables & attributes, then otherEntity(s).
# 4. Assemble EML using the metadata vars.
# Secondary Goal: a template for future scripts, that includes basic instructions. 

# reminders:
# before running, in R-studio, you MUST set the working dir. 
# setwd("~/Desktop/EDI_files_at_msi/EDI/thematic_standardization/ClimDB/git_clones/Clim-HydroDB-2.0/climdb-archive-partA/data_packages/native_db_format/EAL_pkg_edi_605")
# download URL will be filename + head 
# https://regan.edirepository.org/climdb/git_clones/Clim-HydroDB-2.0/climdb-archive-partA/data_packages/native_db_format/data_objects/

# in finished EML, replace the schemaLocation (eml.xsd) with this: https://nis.lternet.edu/schemas/EML/eml-2.2.0/xsd/eml.xsd

# ------------------------------
# ------------------------------
# LOAD LIBRARIES
library(EMLassemblyline)
library(dplyr)
library(tidyr)
library(stringr)

# ------------------------------
# ------------------------------
# SCRIPT CONFIG
# paste0 means paste with no space. yes, really. 
# parent path is ~/.../git_clone/
parent_path <- "."
data_obj_path <- paste0(parent_path,'/', "../data_objects")
# data_obj_path <- paste0(parent_path,'/', "data_objects_temp")
# metadata_path <- paste0(parent_path,'/', "metadata_templates_temp/incoming")
metadata_path <- paste0(parent_path,'/', "metadata_templates/tsv_from_gd")
output_path   <- paste0(parent_path,'/', "eml")

entity_URL_head = 'https://regan.edirepository.org/climdb/git_clones/Clim-HydroDB-2.0/climdb-archive-partA/data_packages/native_db_format/data_objects/'

# ------------------------------
# ------------------------------
###
# ASSEMBLE METADATA

# HIGH LEVEL METADATA
user_id <- "mobrien"
user_domain <- 'EDI'
package_id <- "edi.605.3"

dataset_title <- 'ClimHyrdoDB Archive: Meteorologic and hydrologic observations from LTER and USFS sites, 2001-2020 - orignal database format'


# high level metadata not available in tables
temp_cov <- c("2001-01-10", "2020-05-06")
maint_desc <- "completed"


# required metadata files. created with template_core_metadata function
# EAL WILL NOT USE THESE VARS!! Code assumes something (either doc or text) is populated, so you could use this to check their content.
abstract_metadata     <- 'abstract.docx'
methods_metadata      <- 'methods.docx'
intellrights_metadata <- 'intellectual_rights.txt'
keywords_metadata     <- 'keywords.txt'
people_metadata       <- 'personnel.txt'
# notes on MS-docs:
# these often have formatting which EAL at present does not handle. 
# quotes: escpae them in text. e.g., "Invertebrates" > \"Invertebrates\"
# sections, titles: add these later manually

# optional metadata files - but must have these exact names to be recognized 
# taxon_metadata        <-  'taxonomic_coverage.txt'
# this file if present may conflict with the per element vars (see next var group). 
# to ignore it, move to a temp area (or change its name)
# geocov_metadata       <- 'geographic_coverage.txt'

# metadata that might be found in a tables
# note, EAL will want coords ordered clockwise: geographic.coordinates = c(north, east, south, west),
# collected from actual data, not from contributor nominal locations.
geog_descr <- 'Contiguous United States (CONUS)'
north <- 50.635
south <- 24.512
east <- -66.018
west <- -124.903
geog_coord <- c(north, south, east, west)



# ------------------------------
# Non-TABLE ENTITY METADATA

# otherEntity filenames
otherEntity_file_names <- c(
 'schema_04a.jpg',
 'climdb_DDL.sql',
 'climhydro_userguide_2012.pdf',
 'climdb-docs.gzip',
 'climdb-docs_code_files_description.gzip'
)

# otherEntity names
otherEntity_names <- c(
 'ClimHydroDB Schema ERD',
 'ClimHydroDB table creation code',
 'Users Guide (PDF)',
 'ClimHydroDB documentation and related material',
 'ClimHydroDB documentation, code and web file description'
)

# otherEntity descriptions
otherEntity_descriptions <- c(
 'Entity relationship diagram (ERD) for ClimHydroDB',
 'SQL code for creating ClimHydroDB tables (DDL)',
 'Users Guide for ClimHydroDB - 2012 PDF',
 'Zipped presentations and related historical historical material',
 'Zipped documentation of the database and webserver file structure (2001, 2003)'
)

# otherEntity URLs
# example: data_obj_path <- paste0(parent_path,'/', "data_objects_temp")
otherEntity_urls <- c(
  paste0(entity_URL_head,'/', 'schema_04a.jpg'),
  paste0(entity_URL_head,'/', 'climdb_DDL.sql'),
  paste0(entity_URL_head,'/', 'climhydro_userguide_2012.pdf'),
  paste0(entity_URL_head,'/', 'climdb-docs.gzip'),
  paste0(entity_URL_head,'/', 'climdb-docs_code_files_description.gzip')
  
)



# ------------------------------
# DATA TABLE METADATA
# use a quoted, comma-separated list
file_names <- c(
  # to be substituted into EML
  #'climdb_raw.csv',
  # 'climdb_agg.csv',

  # 23 data tables  
  'climdb_agg_100lines.csv',
  'climdb_raw_100lines.csv',
  'harvest_raw.csv',
  'site_personnel_role.csv',
  'sitetype_descriptor_category.csv',
  'site.csv',
  'research_site_type.csv',
  'research_site_module.csv',
  'research_site_sitetype.csv',
  'research_site_descriptor.csv',
  'research_module_descriptor.csv',
  'research_site.csv',
  'research_module.csv',
  'personnel_mailing_list.csv',
  'personnel_role.csv',
  'personnel_TODO_RENAME.csv',
  'mailing_list.csv',
  'descriptor_category_type.csv',
  'descriptor_type.csv',
  'descriptor_category.csv',
  'climdb_site_variable_dates.csv',
  'climdb_variables.csv',
  'aggregate_type.csv'
  
  )

# use a quoted, comma-sep list, same order as file_names
entity_names <- 
  c(
    # to be substituted into EML
    #'climdb_raw.csv',
    # 'climdb_agg.csv',

    
    'climdb_agg_100lines',
    'climdb_raw_100lines',
    'harvest_raw',
    'site_personnel_role',
    'sitetype_descriptor_category',
    'site',
    'research_site_type',
    'research_site_module',
    'research_site_sitetype',
    'research_site_descriptor',
    'research_module_descriptor',
    'research_site',
    'research_module',
    'personnel_mailing_list',
    'personnel_role',
    'personnel_TODO_RENAME',
    'mailing_list',
    'descriptor_category_type',
    'descriptor_type',
    'descriptor_category',
    'climdb_site_variable_dates',
    'climdb_variables',
    'aggregate_type'
  )

# if more than one, use a quoted, comma-sep list, same order as file_names
entity_descriptions <- c(
  # 'ClimDB aggregated data, 100 lines',
  # 'ClimDB raw data, 100 lines',
  # 'Self-referencing table of research sites within contributing sites. Contributing site is parent of sub-site(s)',
  # 'List of roles that occur at a site'

  
  'Aggregated meteorology and hydrology data by research_site, from the climdb_raw table',
  'Data before aggregation. A copy of what comes into harvest_raw if the harvest and QC were successful (no  errors or fatal errors; warnings are ingested)',
  'Raw data as harvested from contributor. Temporary table into which data are imported upon harvest (by site). The programmatic QC is performed on this table. This table is overwritten when a new site harvests data.',
  'Cross-reference table between 4 tables: site, research_module, personel_role and personnel',
  'Cross-reference table between 2 tables: research_site_type and descriptor_category',
  'List (controlled vocabulary) of contributing sites, typically an LTER, US Forest Service site, but also other field stations, some international. contains basic location info and URLs. This table was part of the initial ClimDB effort (early 90’s). For this 2003 version, ‘research_site’ became the main site table and metadata was stored in research_site_descriptor. The basic location and URL information here was carried over, but may be different than what was later recorded in research_site_descriptor',
  'List (controlled vocabulary) of types of research types (general area, watershed, station type). Table was used to control the web display and information access',
  'Cross-reference table between 2 tables: research_site and research_module',
  'Cross-reference table between 2 tables: research_site and research_site_type',
  'site-added content for describing research sites. long format (key-value pairs). Contains all the metadata for sites, watersheds, research_sites and paramaters.',
  'Cross-reference table between 2 tables: research_module and descriptor_category. Table was used to control the web display and for metadata update functions.',
  'Self-referencing table of research sites within contributing sites. Contributing site is parent of sub-site(s). A contributing site is at the top level. Key table for research sites.',
  'List (controlled vocabulary) of general modules the ClimHydroDB holds, for grouping other entries. Tables allows for grouping of research sites by module (originally set up as Climdb and Hydrodb, later extended for LTER, USFS and USGS.',
  'Cross-reference table between 2 tables: personnel and mailing_list',
  'List (controlled vocabulary) of roles for people at a contributing site',
  'People associated with a ClimHydroDB contribution',
  'mailing lists associated with ClimHydroDB, for management',
  'Cross-reference table between 2 tables: descriptor_type and descriptor_category. Controls which metadata descriptors go with which categories',
  'List (controlled vocabulary) and definitions of descriptors (e.g., name, text definition)',
  'List (controlled vocabulary) of categories for descriptors',
  'Table collects variables at each research site, with first/last dates seen. Code extracts the first and last dates by research site; part of the harvester',
  'List (controlled vocabulary) and descriptions (unit, QC) of measurements which can be harvested or aggregated',
  'List (controlled vocabulary) of types of aggregates computed by ClimHydroDB',
  'Aggregated meteorology and hydrology data, based on nine aggregate types',
  'Data before aggregation, QC applied TO DO: confirm'                       
                         
                         
                         )

# ATTRIBUTE INFO (dataTables)
# attribute lists and defintions of categorical variables
# ?? these are not listed in the call to make_eml. so presumably code knows where to look?
# entity attribute files can be incomplete and still in the metadata_path dir.
entity_attributes <- c(
  paste0(
 #   metadata_path,'/','attributes_climdb_agg.txt',
#    metadata_path,'/','attributes_climdb_raw.txt',
#    metadata_path,'/','attributes_research_site.txt',
#    metadata_path,'/','attributes_personnel_role.txt'
 
    metadata_path,'/','attributes_climdb_raw_100lines.txt',
    metadata_path,'/','attributes_harvest_raw.txt',
    metadata_path,'/','attributes_climdb_agg_100lines.txt',
    metadata_path,'/','attributes_site_personnel_role.txt',
    metadata_path,'/','attributes_sitetype_descriptor_category.txt',
    metadata_path,'/','attributes_site.txt',
    metadata_path,'/','attributes_research_site_type.txt',
    metadata_path,'/','attributes_research_site_module.txt',
    metadata_path,'/','attributes_research_site_sitetype.txt',
    metadata_path,'/','attributes_research_site_descriptor.txt',
    metadata_path,'/','attributes_research_module_descriptor.txt',
    metadata_path,'/','attributes_research_site.txt',
    metadata_path,'/','attributes_research_module.txt',
    metadata_path,'/','attributes_personnel_mailing_list.txt',
    metadata_path,'/','attributes_personnel_role.txt',
    metadata_path,'/','attributes_personnel_TODO_RENAME.txt',
    metadata_path,'/','attributes_mailing_list.txt',
    metadata_path,'/','attributes_descriptor_category_type.txt',
    metadata_path,'/','attributes_descriptor_type.txt',
    metadata_path,'/','attributes_descriptor_category.txt',
    metadata_path,'/','attributes_climdb_site_variable_dates.txt',
    metadata_path,'/','attributes_climdb_variables.txt',
    metadata_path,'/','attributes_aggregate_type.txt'
    
         )
)
  
# Categorical variables
# These are inferred to be present and ready to use if the attributes_* metadata has a var that is categorical. 
# So two don'ts
# 1. don't define catvars here, ie, no need for: entity_catvars    <- c('catvars_1_Data_Sources.txt')
# 2. don't keep in-progress catvars in metadata_path! stash them elsewhere 

# climdb note: you have 2 or 3 tables with categorical vars -- the ones that hold sampled-variable info. 
# they are the same. this is the only place that the sampled variables will show up in the metadata.

# DATA FILES PHYSICAL DESCRPTION
# might be overkill to define a var because they will probably be all the same
# but it makes me so happy.
quote_character <- '\"'

# as for file name and description, an array of one per entity.
entity_quote_characters <-c(
  quote_character,
  quote_character,
  quote_character,
  quote_character,
  quote_character,
  quote_character,
  quote_character,
  quote_character,
  quote_character,
  quote_character,
  quote_character,
  quote_character,
  quote_character,
  quote_character,
  quote_character,
  quote_character,
  quote_character,
  quote_character,
  quote_character,
  quote_character,
  quote_character,
  quote_character,
  quote_character
  
)

entity_urls <- c(
  
  paste0(entity_URL_head,'/', 'climdb_agg_100lines.csv'),
  paste0(entity_URL_head,'/', 'climdb_raw_100lines.csv'),
  paste0(entity_URL_head,'/', 'harvest_raw.csv'),
  paste0(entity_URL_head,'/', 'site_personnel_role.csv'),
  paste0(entity_URL_head,'/', 'sitetype_descriptor_category.csv'),
  paste0(entity_URL_head,'/', 'site.csv'),
  paste0(entity_URL_head,'/', 'research_site_type.csv'),
  paste0(entity_URL_head,'/', 'research_site_module.csv'),
  paste0(entity_URL_head,'/', 'research_site_sitetype.csv'),
  paste0(entity_URL_head,'/', 'research_site_descriptor.csv'),
  paste0(entity_URL_head,'/', 'research_module_descriptor.csv'),
  paste0(entity_URL_head,'/', 'research_site.csv'),
  paste0(entity_URL_head,'/', 'research_module.csv'),
  paste0(entity_URL_head,'/', 'personnel_mailing_list.csv'),
  paste0(entity_URL_head,'/', 'personnel_role.csv'),
  paste0(entity_URL_head,'/', 'personnel_TODO_RENAME.csv'),
  paste0(entity_URL_head,'/', 'mailing_list.csv'),
  paste0(entity_URL_head,'/', 'descriptor_category_type.csv'),
  paste0(entity_URL_head,'/', 'descriptor_type.csv'),
  paste0(entity_URL_head,'/', 'descriptor_category.csv'),
  paste0(entity_URL_head,'/', 'climdb_site_variable_dates.csv'),
  paste0(entity_URL_head,'/', 'climdb_variables.csv'),
  paste0(entity_URL_head,'/', 'aggregate_type.csv')
  
  
)



# ASSEMBLE THE EML

make_eml(
  path = metadata_path,
  data.path = data_obj_path,
  eml.path = output_path,
  dataset.title = dataset_title,
  temporal.coverage = temp_cov,
  geographic.description = geog_descr,
  geographic.coordinates = geog_coord,
  maintenance.description = maint_desc,
  other.entity = otherEntity_file_names,
  other.entity.name = otherEntity_names,
  other.entity.description = otherEntity_descriptions,
  other.entity.url = otherEntity_urls,
  data.table = file_names,
  data.table.name = entity_names,
  data.table.description = entity_descriptions,
  data.table.quote.character = entity_quote_characters,
  data.table.url = entity_urls,
  user.id = user_id,
  user.domain = user_domain,
  package.id = package_id
)
