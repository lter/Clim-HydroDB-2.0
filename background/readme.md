# Background

## ClimHydroDB

ClimDB/HydroDB (built in late 90's) is a centralized server to provide open access to long-term meteorological and streamflow records from a collection of research sites. Due to  aging and unmaintainable software, as well as data limitations in terms of parameters and time resolution, and other more sophisticated systems have been developed since which may match our needs.

EDI, LTER and USFS jointly organized an workshop to review current practices and develop a strategy for the next steps.
https://environmentaldatainitiative.org/dataset-design/met-hydro-data-package-design/

## Participants

Todo: list here.

## Data harmonization

EDI has developed a [data harmonization framework](https://environmentaldatainitiative.org/dataset-design/), in which primary data are reformatted to a common intermediate for reuse.
It is currently being successfully applied to designing data packages for [community survey data: ecocomDP](https://github.com/EDIorg/ecocomDP). The figure below shows a schematic of the concept. Archived raw data (level 0 - L0) are converted to a common harmonized data model (level 1 - L1). The L1 data allow for a straightforward data discovery and conversion into derived data products (level 2 - L2) in support of synthesis studies and other uses.

 ![Figure 1. General data package harmonization workflow](harmonization_procedure_general.png)

### Data models for met and hydrologic data

A number of data models are commonly used in the research community for harmonizing meteorological and hydrological data. The most prominent of these is the ODM data model for time series, developed and used by the [Consortium of Universities for the Advancement of Hydrologic Science (CUHASI)](https://cuahsi.org). The CUAHSI data platform provides tools for visualization, analysis and might provide some of the ClimDB/HydroDB plotting functionality.  Hence, the ODM CSV model of the CUAHSI HIS is a good candidate for the L1 data model.

At the workshop, a first draft of a workflow was designed for converting all ClimDB/HydroDB products (L0) as well as meteorological and hydrological data in the EDI repository (raw L0) to L1 data packages. If the ODM CSV data model is adopted, the data packages would be compatible for upload to CUAHSI, which would enable discovery and visualization functionality somewhat comparable to ClimDB/HydroDB.

 ![Figure 2. Harmonization of meterological and hydrological raw data using the CUAHSI/ODM data model](harmonization_procedure_odm.png)

Even if CUAHSI is not utilized as a repository for the data, there is still merit in having a harmonized format as has been proven with ecocomDP.

## Other expertise available to this group

Wade Sheldon's GCE Data Toolbox can be applied for the conversion of L0 data packages to the L1 data model. Margaret O'Brien is involved is several semantics projects which might benefit this project as well (although data must adhere to the CUAHSI ODM vocabulary). Vocabularies are also important for defining suitable keywords at the data package level and thereby enhance data discoverability in the EDI repository and via Google's data search.
