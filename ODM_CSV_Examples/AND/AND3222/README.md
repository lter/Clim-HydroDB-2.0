# Files for conversion of package knb-lter-and.3222.36 into CUAHSI ODM CSV format

Data set title: "Meteorological data from benchmark stations at the Andrews Experimental Forest, 1957 to present."

## Convert subset of data package

* Table: MS00111.txt
* SITECODE values: "CENMET","PRIMET","UPLMET","VANMET" (5 minute air temperatures)
* Each SITECODE value is an independent site with different locations (lat, lon).

## Requirements

* Create ODM tables: 1. Variables.csv, 2.Methods.csv, 3.Sites.csv, 4.Sources.csv 5.QualityControlLevels.csv according to instructions in ["CUAHSI Data Formatting Guide"](https://www.cuahsi.org/uploads/pages/img/CUAHSI_Formatting_Guide.pdf) using [controlled vocabulary](http://his.cuahsi.org/mastercvreg/cv11.aspx).
* In R working directory create subdirectories "odm_tables" and "data".
* Place ODM tables in "odm_tables" dir and input data in "data" dir.
