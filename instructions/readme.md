# Instructions

## Basic Steps

To convert your data to ODM CSV format:

1. Open the standard template Excel file in the **CUAHSI_documentation** folder.
2. Determine if the provided tables meet your needs.  For climDB data, typically the only additional table needed is a table defining data qualifiers, e.g., "M" for missing values and "B" for low battery voltage on sensor.  If you have data qualifiers, add a QualifierCode column to the DataValues table, and add a separate Qualifiers.csv table, as illustrated in the advanced template.
3. Fill in the metadata tables (everything except DataValues) and export each to CSV. This is typically done by hand since the tables are usually lightweight.
4. Fill in the DataValues table in the spreadsheet if your data are simple enough.  For a more reproducible workflow, write a script to convert your raw data into the DataValues.csv format.
5. Generate EML for the six (or seven if you used Qualifiers) tables.
6. Upload the data package to EDI.

## Tips

* The templates inclue instructions on which controlled vocabularies to use, allowable values in certain fields, and much more.  Be sure to read them carefully even if you are generating your tables outside of the template.
* Start with the standard template.  If you need advanced features, only use the parts of the advanced template that you actually need.  For example, if you don't need to describe lab methods for individual samples, then leave the samples and lab methods tables out.
* Don't include time zone information in the datetimes. For example, use `2021-07-29T08:30` instead of `2021-07-29T08:30-5`.  You can indicate the `-5` part in the UTCOffset column.
* For the units controlled vocabulary, use the units name, not the abbreviation.
* Find CUAHSI controlled vocabularies at http://his.cuahsi.org/mastercvreg/cv11.aspx.
* If you wish to publish your data with CUAHSI, you can set up an account and log in via their [HydroServer site](http://hydroserver.cuahsi.org/).

## Other Files in this Folder

This folder includes some deprecated files, such as [CUAHSI_table_descriptions.md](CUAHSI_table_descriptions.md). That file includes instructions painstakingly transcribed from the CUAHSI templates.  However, at that time, the templates included many mistakes.  The templates have since been corrected and should now be used as the definitive source of information on each table and column in the ODM CSV format.
