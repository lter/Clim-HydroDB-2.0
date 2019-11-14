# DRAFT - Request for Comments (RFC) - 2019-mm-dd - DRAFT
## Project Name


### Background 
ClimHy (aka ClimDB/HydroDB) [https://climhy.lternet.edu](https://climhy.lternet.edu/) is a web harvester and data warehouse that provides uniform access to common daily meteorological and streamflow measurements through a single portal. Participating sites primarily include LTER and USFS stations, although a few additional organizations have participated. In addition to site-generated climate and hydrology data contributions, data from nearby, site-identified USGS streamflow gauges and NCEI weather stations are harvested automatically on a weekly basis using a MATLAB-based workflow hosted by GCE-LTER. The original prototype for ClimHy was developed at North Temperate Lakes LTER in 1997 (Henshaw et al. 1998), and the current version was developed and hosted at the Andrews LTER from 2002-2010. ClimHy was later migrated to the now-defunct LTER Network Office and no further upgrades were implemented. The data and metadata are stored in a SQL Database Server and the harvester and data access pages are written in Perl.

The ClimHy data warehouse accepts 14 measurement parameters represented by 22 attributes in a daily time step. Precipitation, stream discharge, and air temperature are the most common data values contributed by sites, accounting for more than 75% of the measurements in the database. The primary use of the data has been for research, synthesis, and education (e.g., K-12, undergraduates). However, contribution to and use of ClimHy is declining, likely due to antiquated architecture. This is an opportunity for the scientific and technological communities to evaluate the needs and desire for accessing harmonized multi-site and multi-agency climate and hydrology data, the infrastructure required to collect and store these data, and consider new technologies or workflows based on current data storage models (i.e., PASTA).

### RFC Process
This RFC requests comments from the community on this project. Please send comments to: project-lead (email) and EDI support (support@environmentaldatainitiative.org), or discuss on original recipient list. For more information, contact EDI at info@environmentaldatainitiative.org. Please send comments on this RFC by COB on YYYY-MM-DD. If there are no major objections we will proceed with the following implementation:



### General recommendation 
CUAHSI - paragraph describing benefits
- CUAHSI HIS

two phases 
#### Phase 1. migrate climdb to ODM 1.1 format 
Two steps, performed by EDI
- archive the content of climdb
- export content in the ODM 1.1 format for inclusion in CUAHSI HIS

#### Phase 2. EDI mediates contributions from climdb-contributiors to CUAHSI
- climdb contributors would use tables in the ODM format with EML described datsets 
- with a harmonization workflow if necessary
- Details to be worked out, depending on what we learn from Phase 1

### Planned implementation
#### Phase 1: 

- who: EDI, with help from GCE, toolbox
- tasks overview
- timeline (anticipated)

1. Archive climdb as a DB dump.
    1. data package in EDI holding the text-dump (otherEntity)
2. Export climdb content to ODM format to prepare it for CUASHI
    1. As EML data packages in EDI
    2. Tasks:
        1. Determine the exact packaging scheme (anticipating 1/climdb-contributor, eg, lter site)
        1. Determine aggregation level (anticipating hourly)
        1. Request additional metadata (for CUAHSI)
        1. Coordinate with CUAHSI to accept these
            1. e.g., Timing, ownership, volume


#### Phase 2: implementation depends on what we learn from phase 1

