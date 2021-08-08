# Conversion of FCE ClimDB/HydroDB data into CUAHSI ODM CSV format

## Data set title: "NOAA Daily Surface Meteorologic Data at NCDC Everglades Station (ID-082850)(FCE), South Florida from February 1924 to Present"

Package identifier: knb-lter-fce.1050.17

### ClimDB data table has 11 columns

    1. LTER_Site
    2. Station
    3. Date
    4. Daily_AirTemp_Mean_C
    5. Flag_Daily_AirTemp_Mean_C
    6. Daily_AirTemp_AbsMax_C
    7. Flag_Daily_AirTemp_AbsMax_C
    8. Daily_AirTemp_AbsMin_C
    9. Flag_Daily_AirTemp_AbsMin_C
    10. Daily_Precip_Total_mm
    11. Flag_Daily_Precip_Total_mm

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
    - Run program convert2odm_fce.R to convert data in ClimDB/HydroDB into ODM format and write into DataValues.csv file.
