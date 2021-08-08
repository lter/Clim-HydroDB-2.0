# Files for conversion of package knb-lter-and.3222.36 into CUAHSI ODM CSV format

Data set title: "Meteorological data from benchmark stations at the Andrews Experimental Forest, 1957 to present."

## Convert subset of data package

* Table: MS00111.txt
* SITECODE values: "CENMET","PRIMET","UPLMET","VANMET" (5 minute air temperatures)
* Each SITECODE value is an independent site with different locations (lat, lon).

### Pre-requisites

Create ODM tables according to instructions in "CUAHSI Data Formatting Guide" using controlled vocabulary:

    1. Variables.csv
    2. Methods.csv
    3. Sites.csv
    4. Sources.csv
    5. QualityControlLevels.csv 
    6. Qualifiers.csv

### Workflow

    - In R working directory create subdirectories "odm_tables" and "data".
    - Place ODM tables in "odm_tables" dir.
    - Place input data in ClimDB format in "data" dir.
    - Run program convert2odm_fce.R to convert data in ClimDB/HydroDB into ODM format and write into DataVlaues.csv file.
