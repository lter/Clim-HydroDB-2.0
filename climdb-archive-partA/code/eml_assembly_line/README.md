<h2>Create EML for data packages of LTER ClimDB/HydroDB data in CUAHSI ODM format</h2>

<b>Data set title: "Weather and hydrological data for SITE, previously held in LTER ClimDB/HydroDB (XXXX to XXXX)"</b>

<h3>Pre-requisites</h3>

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

Workflow


<h3>Comments</h3>

For automated processing of all sites' EAL templates the ClimDB/HydroDB table: researchsite_sitetype.csv had to be augmented with missing data for research stations with IDs: 697, 709, 710, 711, 712.

There was no geographic information for several sites. We looked those up and added them to table "climdb_site_lat_lon_working".

The ClimDB roles were mapped to the EML roles
1 -> Principal Investigator
2 -> Creator
3 -> Contact
4 -> Creator
5 -> Contact
6 -> Associated party
7 -> Associated party
