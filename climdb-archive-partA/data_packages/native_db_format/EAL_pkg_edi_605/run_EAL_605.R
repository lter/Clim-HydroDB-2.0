# This script executes an EMLassemblyline workflow.

# The basic layout of this script:
# 1. load libraries
# 2. config the script. mainly these are directory settings.
# 3. Set metadata variables. high level first, then dataTables & attributes, then otherEntity(s).
# 4. Assemble EML using the metadata vars.
# Secondary Goal: a template for future scripts, that includes basic instructions. 

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
parent_path <- "."
data_obj_path <- paste0(parent_path,'/', "../data_objects")
metadata_path <- paste0(parent_path,'/', "metadata_templates")
output_path   <- paste0(parent_path,'/', "eml")

# ------------------------------
# ------------------------------
###
# ASSEMBLE METADATA

# HIGH LEVEL METADATA
user_id <- "mobrien"
user_domain <- 'EDI'
package_id <- "edi.605.1"

dataset_title <- 'TO DO: CLIMDB Archive - native format.'


# high level metadata not available in tables
temp_cov <- c("2001-01-10", "2020-05-06")
maint_desc <- "completed"


# required metadata files. created with template_core_metadata function
# EAL will not use these vars. The text version is assumed to be populated, so you could use this to check their content.
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
geog_descr <- 'Contiguous United States (CONUS)'
north <- 50.635
south <- 24.512
east <- -66.018
west <- -124.903

# ------------------------------
# DATA TABLE METADATA
# use a quoted, comma-separated list
file_names <- c('personnel_role.csv')

# use a quoted, comma-sep list, same order as file_names
entity_names <- 
  c(
    'ClimDB personnel_roles table'
  )

# if more than one, use a quoted, comma-sep list, same order as file_names
entity_descriptions <- c('Roles for climdb personnel')

# ATTRIBUTE INFO (dataTables)
# attribute lists and defintions of categorical variables
# ?? these are not listed in the call to make_eml. so presumably code knows where to look?
# entity attribute files can be incomplete and still in the metadata_path dir.
entity_attributes <- c(
  paste0(metadata_path,'/','attributes_personnel_role.txt')
)
  
# Categorical variables
# These are inferred to be present and ready to use if the attributes_* metadata has a var that is categorical. 
# So two don'ts
# 1. don't define catvars here, ie, no need for: entity_catvars    <- c('catvars_1_Data_Sources.txt')
# 2. don't keep in-progress catvars in metadata_path! stash them elsewhere 

# DATA FILES PHYSICAL DESCRPTION
# might be overkill to define a var because they will probably be all the same
# but it makes me so happy.
quote_character <- '\"'

# as for file name and description, an array of one per entity.
entity_quote_characters <-c(
  quote_character
)


make_eml(
  path = metadata_path,
  data.path = data_obj_path,
  eml.path = output_path,
  dataset.title = dataset_title,
  temporal.coverage = temp_cov,
 # geographic.description = geog_descr,
 # geographic.coordinates = geog_coord,
  maintenance.description = maint_desc,
  data.table = file_names,
  data.table.name = entity_names,
  data.table.description = entity_descriptions,
  data.table.quote.character = quote_character,
  user.id = user_id,
  user.domain = user_domain,
  package.id = package_id
)
