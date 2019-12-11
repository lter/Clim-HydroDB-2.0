# CUAHSI Table Descriptions

This doc was created from the 
1. CUAHSI Standard Formatting Template (see Excel file in CUAHSI_documentation dir)  
2. screenshot of the general table arrangement, from the CUAHSI guide PDF.



## Introduction
![ODM general file layout](ODM_model.png)


### 1. How to Use the Template													
The purpose of this document is to provide guidance in populating ODM 1.1.1 templates for uploading data using CUAHSI's ODM Uploader for Azure. 												

1. as a guide for creating tables by some other method
    1. create 6 tables that look like these

OR

2. To hold the data you indend to contribute to CUAHSI (copied from excel template):									
    1. Populate metadata and data values										
    2. Delete first column and 2nd, 3rd, 4th, and 5th rows so that only column headers and your metadata and data values remain												
    3. Export each sheet as a separate CSV file										
    4. Upload each CSV file using CUAHSI's Cloud HydroServer
											
												
													
													
### Required Columns
All 6 tables are required. Each table has some required columns. In each table's description, the `Constraint` row tells you if it's required (`mandatory`), or if the content comes from a controlled vocabulary

#### Color Key 												
Included here for completeness, but colors are only applied in the original excel spreadsheet (or if someone has converted these tables to html and added some styling for the color.). See the "Constraint row also, as it tells you if field is required or if it has a vocabulary source.

- Mandatory - orange 						
    -	Mandatory fields must contain a value. If information is unavailable, populate with "Unknown" as applicable.												
- Optional - green												
	Optional fields may be left blank.												
- Controlled Vocabulary - blue												
    - Controlled vocabulary terms for ODM 1.1.1 can be found be found here: http://his.cuahsi.org/mastercvreg/cv11.aspx 												
	- Note: All controlled vocabulary fields are mandatory although "Unknown" is a valid value for some.												
													
													
### For more information about the Observational Data Model: 
http://dx.doi.org/10.1029/2007WR006392 												
													
													
### Table Descriptions

![ODM general file layout](ODM_model.png)



| Table Name | Table Description | Comment |
|-----------------|----------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------|
| Variables | The Variables table lists the full descriptive information about what variables have been measured. This table is mandatory. |  |
| Methods | The Methods table lists the methods used to collect the data and any additional information about the method. This table is mandatory. |  |
| Sites | The Sites table provides information giving the spatial location at which data values have been collected. This table is mandatory. |  |
| Sources | "The Sources table lists the original sources of the data | providing information sufficient to retrieve and reconstruct the data value from the original data files if necessary. This table is mandatory." |
| Quality Control | The QualityControlLevels table contains the quality control levels that are used for versioning data within the database. This table is mandatory. |  |
| DataValues | The DataValues table contains the actual data values and keys to metadata tables. This table is mandatory. |  |														
																			
### Sites Table
| Field | SiteCode | SiteName | Latitude | Longitude | LatLongDatumSRSName | SiteType | Comments |
|---------------|------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------|------------------------------|-------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------|
| Data Type | Text (255) | Text (255) | Real | Real | Text | Text | Text (Unlimited) |
| Constraint | Mandatory; Unique; Allows only characters in the range of A-Z (case sensitive), 0-9, and ".", "-", and " " | Mandatory; Cannot contain tab, line feed, or carriage return characters | Mandatory; >=-90 AND <=90 | Mandatory; >=-180 and <=180 | Mandatory; Foreign Key |  | Optional |
| Description | User or organization-defined code that collects the data to identify the site. | Full name of the sampling site. | Latitude in decimal degrees. | Longitude in decimal degrees. East positive, West negative. | Full text name of the spatial reference system of the latitude and longitude coordinates in the SpatialReferences table. This should be from the SpatialReferences controlled vocabulary: http://his.cuahsi.org/mastercvreg/edit_cv11.aspx?tbl=SpatialReferences&id=869578136 | The type of site. This should be from the SiteType controlled vocabulary: http://his.cuahsi.org/mastercvreg/edit_cv11.aspx?tbl=SiteTypeCV&id=853578079 | Comments related to the site. |
| Default Value | There is no default value | There is no default value | N/A | N/A | Unknown |  |  |


### Variables Table
| Field | VariableCode | VariableName | VariableUnitsName | DataType | SampleMedium | ValueType | IsRegular | TimeSupport | TimeUnitsName | GeneralCategory | NoDataValue |
|---------------|---------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Data Type | Text (50) | Text (255 characters or less) | Text (255) | Text (255) | Text (255) | Text (255) | Boolean | Real | Text (255) | Text (255) | Real |
| Constraint | Allows only characters in the range of A-Z (case sensitive), 0-9, ".", "-", and "_" | Controlled Vocabulary | Controlled Vocabulary | Controlled Vocabulary | Controlled Vocabulary | Controlled Vocabulary | Mandatory | Mandatory | Mandatory; Foreign Key | Mandatory; Foreign Key | Mandatory |
| Description | User or organization-defined code to describe the variable. If for example, you are measuring streamflow, you may name this SF. | Full text name of the variable that was measured, observed, modeled, etc. Example: Streamflow. Choose from the Variable Name controlled vocabulary: http://his.cuahsi.org/mastercvreg/edit_cv11.aspx?tbl=VariableNameCV&id=1157579162 | The name of units of the data values associated with a variable. Example: degree. Choose from the Units controlled vocabulary: http://his.cuahsi.org/mastercvreg/edit_cv11.aspx?tbl=Units&id=1125579048 | The recorded value over the time interval being sampled. Example: average. Choose from the DataType controlled vocabulary: http://his.cuahsi.org/mastercvreg/edit_cv11.aspx?tbl=DataTypeCV&id=789577851 | The medium in which the sample or observation was taken or made. Example: Surface water. Choose from the SampleMedium controlled vocabulary: http://his.cuahsi.org/mastercvreg/edit_cv11.aspx?tbl=SampleMediumCV&id=821577965. | Text value indicating what type of data value is being recorded. Example: Field Observation. Choose from the ValueType controlled vocabulary: http://his.cuahsi.org/mastercvreg/edit_cv11.aspx?tbl=ValueTypeCV&id=1141579105 | Value indicates whether the data values are from a regularly sampled time series. Choose TRUE or FALSE. | Numerical value that indicates the time support (or temporal footprint) of the data values. 0 is used to indicate data values that are instantaneous. Other values indicate the time over which the data values are implicitly or explicitly averaged or aggregated. The Timesupport goes along with TimeUnitsName if IsRegularlyMeasured = TRUE. | The name of units of the time support. If TimeSupport is 0, indicating an instantaneous observation, a unit needs to still be given for completeness, although it is somewhat arbitrary. Choose from the Units controlled vocabulary: http://his.cuahsi.org/mastercvreg/edit_cv11.aspx?tbl=Units&id=1125579048 | General category of data. Example: Hydrology. Choose from the GeneralCategory controlled vocabulary: http://his.cuahsi.org/mastercvreg/edit_cv11.aspx?tbl=GeneralCategoryCV&id=805577908 | Numeric value used to encode no data values for this variable. When formatting the Data Values table, use this number to indicate no data value was measured. |
| Default Value | There is no default value | There is no default value | There is no default value | Unknown | Unknown | Unknown | FALSE | 0 (Assumes instantaneous samples where no other information is available) | "hours" | Unknown | -9999 |


### Methods Table
| Field | MethodCode | MethodDescription | MethodLink |
|---------------|--------------------------------------------------------------------------------------------------------|----------------------------------|------------------------------------------------------|
| DataType | Text (50) | Text (Unlimited) | Text (500) |
| Constraint | Mandatory; Unique; Allows only characters in the range of A-Z (case sensitive), 0-9, ".", "-", and "_" | Mandatory | Optional |
| Description | User or organization-defined code that collects the data to identify the method used for measurement. | Text description of each method. | Link to additional reference material on the method. |
| Default Value | There is no default value | There is no default value | NULL |


### Sources Table
| Field | SourceCode | Organization | SourceDescription | SourceLink | ContactName | Email | Citation |
|---------------|--------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------|-------------------------------------------------------------------------|----------------------------------------------------------------------------------------------|
| Data Type | Text (50) | Text (255) | Text (Unlimited) | Text (500) | Text (255) | Text (255) | Text (Unlimited) |
| Constraint | Mandatory; Unique; Allows only characters in the range of A-Z (case sensitive), 0-9, ".", "-", and "_" | Mandatory; Cannot contain tab, line feed, or carriage return characters | Mandatory | Optional | Mandatory; Cannot contain tab, line feed, or carriage return characters | Mandatory; Cannot contain tab, line feed, or carriage return characters | Mandatory |
| Description | Code used to identify the organization that created the data. | Name of the organization that collected the data. This should be the agency or organization that collected the data, even if it came out of a database consolidated from many sources such as STORET. | Full text description of the source of the data. | Link that can be pointed at the original data file and/or associated metadata stored in the digital library or URL of data source. | Name of the contact person for the data source. | Email addresss for the contact person. | Text string that give the citation to be used when the data from each source are referenced. |
| Default Value | There is no default value | There is no default value | There is no default value | NULL | Unknown | Unknown | Unknown |

 
### Quality Control Levels Table
| Field | QualityControlLevelCode | Definition | Explanation |
|---------------|----------------------------------------------------------------------------------------------|-------------------------------------------------------------------------|---------------------------------------|
| Data Type | Text (50) | Text (50) | Text (Unlimited) |
| Constraint | Mandatory; Cannot contain tab, line feed, or carriage return characters | Mandatory; Cannot contain tab, line feed, or carriage return characters | Mandatory |
| Description | Code used to identify the level of quality control to which data values have been subjected. | Definition of Quality Control Level. | Explanation of Quality Control Level. |
| Default Value | There is no default value. | There is no default value. | There is no default value. |



### Data Values
| Field | DataValue | LocalDateTime | UTCOffset | DateTimeUTC | SiteCode | VariableCode | MethodCode | SourceCode | QualityControlLevelCode |
|---------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------|--------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------|
| DataType | Real | Date/Time | Real | Date/Time | Text | Text | Integer | Integer | Text |
| Constraint | Mandatory | Mandatory | Mandatory | Mandatory | Mandatory; Foreign Key | Mandatory; Foreign Key | Mandatory; Foreign Key | Mandatory; Foreign Key | Mandatory; Foreign Key |
| Description | The numeric value of the observation. For Categorical variables, a number is stored here. The Variables table has DataType as Categorical and the Categories table maps from the DataValue onto Category Description. | Local date and time at which the data value was observed. Represented in an implementation specific format. | Offset in hours from UTC time of the corresponding LocalDateTime value. | Universal UTC date and time at which the data value was observed. Represented in an implementation specific format. | Code used by organization that collects the data to identify the site. | Code used by the organization that collects the data to identify the variable. | Code used by the organization that collects the data to identify the Method, which is defined in the Methods table. | Code used by the organization that collects the data to identify the source, which is defined in the Sources table. | Code which identifies the level of quality control that the value has been subjected to. This references the QualityControlLevels table. |
| Default Value | There is no default value | There is no default value. | There is no default value. | There is no default value. | There is no default value | There is no default value | 0 (No method specified) | There is no default value | -9999 (Unknown) |
