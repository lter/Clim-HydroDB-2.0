<h2>Processing scripts for creating EML for data packages: LTER ClimDB/HydroDB tables reformatted to CUAHSI ODM 1.1 format for each site</h2>

**Pre-requisites**

1. 6 ODM tables according to instructions in "CUAHSI Data Formatting Guide" using controlled vocabulary
                        <ol>
                        <li>Variables.csv</li>
                        <li>Methods.csv</li>
                        <li>Sites.csv</li>
                        <li>Sources.csv</li>
                        <li>QualityControlLevels.csv</li>
                        <li>DataValues.csv</li>
                        </ol>             
2. Some ClimDB native tables with information on sites' characteristics, personnel & stations etc.

**R scripts**

* **create_site_tables.R**
  * Script creates tables XXX_Sites.csv in ODM 1.1 format. XXX denotes the site code, for example AND.
  * output written to “./odm_tables/AND/data_objects/AND_Sites.csv”
  * Lat/Long information needs to be corrected by sites when reviewing data in staging!
  * There was no geographic information for several sites. We looked those up and added them to table "climdb_site_lat_lon_working".
  * added missing stations 697, 698, 709, 710, 711, 712 to research_site_sitetype.csv, so that processing worked.
* **update_datavalues.R**
  * Script updates DataValues.csv table created from ClimDB/HydroDB data in ODM 1.1 format with more appropriate values for SourceCode, QualityControlLevel, MethodCode.
* **create_eml_templates_for_stations.R**
  *  Script fills metadata templates for use with the EMLAssemblyline.
  *  Emty templates are generated at beginning and placed in ./eal_templates, in addtion to attributes for odm tables. Definition of attributes in odm tables is obtained from CUAHSI ODM 1.1 guidelines.
  *  The ClimDB roles were mapped to the EML roles
    * 1 -> Principal Investigator
    * 2,4 -> Creator
    * 3,5 -> Contact
    * 6,7 -> Associated party
* **make_EML.R**
  *  Script runs EMLAssemblyline for each ClimDB/HydroDB site to make EML for data in ODM 1.1. format.

**After R-processing**
* Copy odm_tables in upload directory
* Delete eml_template directories: rm -r */eal_templates
* Rename files *_M.csv to *_Methods.csv and replace in edi.*.xml *_M.csv with *_Methods.csv (necessary bc EAL cannot handle table with name methods):
 * for f in */data_objects/*_M.csv; do mv -- "$f" "${f%M.csv}Methods.csv"; done;
 * for f in */edi*; do sed -i "s/_M.csv/_Methods.csv/g" "$f"; done
* Double check with: grep -i _Methods.csv */edi*
