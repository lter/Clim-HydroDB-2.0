# Clim-HydroDB-2.0

Material related to converting the original climHydroDB into CUAHSI ODM CSV format.

## Introduction

ClimHydroDB was a harmonized database of meteorological and hydrologic data from several LTER sites and other data sources.  While the old system has been retired, sites can still enable synthesis and science by archiving data in a harmonized format. The chosen format is called CUAHSI ODM CSV, and is comprised of a CSV table of data values along with additional CSV tables that provide metadata about those data values, such as a table for station location information and a table for variable descriptions.

## Help for LTER sites with archiving meteorological and hydrologic data

You can find brief instructions for building ODM CSV files in the **instructions** folder.  The instructions reference templates found in the **CUAHSI_documentation** folder. You can see example files in the **ODM_CSV_Examples** folder.

## Major activities (also see issues)

### Past activities

* Working group meeting to come up with a plan for climDB migration. See [LTER-EDI working group members](https://github.com/lter/Clim-HydroDB-2.0/blob/master/meeting_notes/working_group_members.md).
* Strategic workshop in March 2019 on “Next generation climate/hydrological data products” (organized by EDI, LTER, Forest Service) for developing a strategy on harmonizing weather, climate and hydrological data in the EDI data repository and ClimDB/HydroDB  (University of New Mexico, Albuquerque, NM).
  * Workshop results were presented at LTER Information Manager Water Cooler on April 9, 2019.
  * Reported activities to LTER Science Council in May 2019.
* Explore the ODM data model and CUAHSI functionality regarding its suitability for LTER and EDI meteorological and hydrological data products.
  * Contacted CUAHSI regarding services & recommendations for our data products (April 2019).
  * EDI webinar (June 18, 2019) “CUAHSI Tools for Data Management”: Introducing example data in CUAHSI and the functionality of the CUAHSI workspace (speaker: Martin Seul, Technical Director of CUAHSI).
  * Working Session at ESIP Summer Meeting (Tacoma, WA, July 2019): “Preparing climate and hydrological time series data for submission to CUAHSI”. Moderator: Corinna Gries (EDI); Speakers: M. Seul (CUAHSI), W. Sheldon (LTER), M. O’Brien (EDI), S. Remillard (LTER).
* Discuss with LTER IM Exec:
  * Determine timeline of ClimDB/HydroDB retirement and archiving in EDI.
  * Set deadline for LTER sites' updates met and hydro data to ClimDB/HydroDB.
  * Provide metadata for site information in CUAHSI site worksheet.

### Ongoing and upcoming activities

* Provide examples of converting site L0 raw and ClimDB/HydroDB data to CUAHSI/ODM standard (L1)
  * Develop workflow and best practices for data conversion from L0 to L1 using the GCE toolbox and R/Python.

* Establish workflow and best practices documentation in EDI's gitHub space for:
  * Available tools for converting data from raw (L0) to ODM (L1) data model.
  * Explore automated workflow available in PASTA
  * Develop examples of how to access/extract ODM CSV data in EDI via R or API interface, for one parameter across all LTER sites (maintaining ClimDB/HydroDB functionality).
  * Vocabulary: mapping between LTER and EML site parameter names and ODM controlled vocabulary.

* Brainstorming about possible L2 products (data products for education and outreach, NCO synthesis working groups, time averages and spatial aggregates, input for great "L50" products like waterviz.org, or smartforests.org.

* Online hackathon with LTER Information Managers to fill out ODM tables.
