# Files for conversion of of sub-set of package knb-lter-and.3222.36 into CUAHSI ODM CSV format

Data set title: "Meteorological data from benchmark stations at the Andrews Experimental Forest, 1957 to present."

## Subset of data package Table MS00111.txt (air temperatures)
* Values for four benchmark stations: "CENMET","PRIMET","UPLMET","VANMET" (SITECODE)
* Air temperature frequency ranges between hourly and 5 minute averages.
* Sensor heights: 150 cm, 250 cm, 350 cm, 450 cm
* Processed in this example are data for the PRIMET station with a sensor height of 350 cm.

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
    - Place input data MS00111.txt in "data" dir.
    - Run program convert2odm_and.R to convert data into ODM format and write into DataValues.csv file.
