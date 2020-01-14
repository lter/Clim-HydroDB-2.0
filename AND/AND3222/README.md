## Files for conversion of package knb-lter-and.3222.36 into CUAHSI ODM format.

Data set title: "Meteorological data from benchmark stations at the Andrews Experimental Forest, 1957 to present."

### Convert subset
* Table: MS00111.txt
* PROBE_CODE: "AIRCEN08","AIRPRI08","AIRUPL08","AIRVAN08" (5 minute air temperatures)

### Requirements
* Create ODM tables: 1. Variables.csv, 2.Methods.csv, 3.Sites.csv, 4.Sources.csv 5.QualityControlLevels.csv
          according to instructions in ["CUAHSI Data Formatting Guide"](https://www.cuahsi.org/uploads/pages/img/CUAHSI_Formatting_Guide.pdf)
          using [controlled vocabulary](http://his.cuahsi.org/mastercvreg/edit_cv11.aspx?tbl=VariableNameCV&id=1157579162).
 * In R working directory create subdirectories "odm_tables" and "data".
 * Place ODM tables in "odm_tables" dir and input data in "data" dir.

### Questions
* When should 15 minute averaging be started? At first data contribution or full hour?
