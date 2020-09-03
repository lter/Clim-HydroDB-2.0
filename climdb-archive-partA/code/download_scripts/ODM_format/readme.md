# Readme

Directory holds scripts and control files for downloading content from ClimDB in the ODM format.

## ODM has 6 required tables:
- Variables
- Sites
- Sources
- Methods
- QualityControl
- DataValues

Tables are arranged as a star schema, with DataValues table at the center, and FKs to the other 5 tables.

## To run
These bash scripts use the command line MS-SQL client to pull data from Climdb and arrange it for ODM. 
Input for all scripts is a list of sites (organizations) for which a table will be created.

To run these, you will need to:
1. clone this repository
1. install mssql (and whatever else you need for running bash shell - not covered here)
2. set the path variables in each script for your own directory structure
3. request the climdb password. 


## Table descriptions
- Variables
  - a mapping between ClimDB and CUAHSI vocabs, so the same for all contributors. contributors may want to customize (see CUAHSI upload info elsewhere in this repo)
- Sites
  - A preliminary table of research sites for each contributor. Needs post-processing to pivot lat, long, elev. See issue TBA 
- Sources 
  - one line table with contributor info (some likely to need updating by contributors)
- Methods
  - TBD
- QualityControl
  - ClimDb does not hold QC info at the granularity ODM allows. so this is a template table, and the same for all contributors. may need customization
- DataValues
  - central table. In most cases, the table is too large for git storage. some short versions here for testing
