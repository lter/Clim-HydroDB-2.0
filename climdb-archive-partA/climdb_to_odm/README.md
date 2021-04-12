## Processing scripts for reformatting ClimDB/HydroDB tables for each site to CUAHSI ODM 1.1 format and create EML

**R scripts**

* **create_site_tables.R**
  * Script creates tables XXX_Sites.csv in ODM 1.1 format. XXX denotes the site code, for example AND.
  * output written to “./odm_tables/AND/data_objects/AND_Sites.csv”
  * Lat/Long information needs to be corrected by sites when reviewing data in staging!
  * added missing stations 697, 698, 709, 710, 711, 712 to research_site_sitetype.csv, so that processing worked.
* **update_datavalues.R**
  * Script updates DataValues.csv table created from ClimDB/HydroDB data in ODM 1.1 format with more appropriate values for SourceCode, QualityControlLevel, MethodCode.
* **create_eml_templates_for_stations.R**
  *  Script fills metadata templates for use with the EMLAssemblyline.
  *  Emty templates are generated at beginning and placed in ./eal_templates, in addtion to attributes for odm tables. Definition of attributes in odm tables is obtained from CUAHSI ODM 1.1 guidelines.
* **make_EML.R**
  *  Script runs EMLAssemblyline for each ClimDB/HydroDB site to make EML for data in ODM 1.1. format.



