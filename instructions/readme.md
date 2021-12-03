# Instructions

## Basic Steps

To convert your data to ODM CSV format:

1. Open **HyMet_Template.xlsx**.
2. Determine if the provided tables meet your needs.  If you need additional descriptors such as lab methods, groups, or provenance, bring in columns and tables from **Advanced_Formatting_Template.xlsx** in the **CUAHSI_documentation** folder.
3. Fill in the metadata tables (everything except DataValues) and export each to CSV. This is typically done by hand since the tables are usually lightweight.
4. Fill in the DataValues table in the spreadsheet if your data are simple enough.  For a more reproducible workflow, write a script to convert your raw data into the DataValues.csv format.
5. Generate EML for the tables you exported.
6. Upload the data package to EDI.

## Tips

* The templates inclue instructions on which controlled vocabularies to use, allowable values in certain fields, and much more.  Be sure to read them carefully even if you are generating your tables outside of the template.
* Don't include time zone information in the datetimes. For example, use `2021-07-29T08:30` instead of `2021-07-29T08:30-5`.  You can indicate the `-5` part in the UTCOffset column.
* For the units controlled vocabulary, use the units name, not the abbreviation.
* Find CUAHSI controlled vocabularies at http://his.cuahsi.org/mastercvreg/cv11.aspx.
* You only need to export the OffsetTypes and Qualifiers tables if you have vertical or horizontal offsets, or data qualifiers, in your data.
* If you wish to publish your data with CUAHSI, you can set up an account and log in via their [HydroServer site](http://hydroserver.cuahsi.org/).

## Other Files in this Folder

This folder includes some deprecated files, such as [CUAHSI_table_descriptions.md](CUAHSI_table_descriptions.md). That file includes instructions painstakingly transcribed from the CUAHSI templates.  However, at that time, the templates included many mistakes.  The templates have since been corrected and should now be used as the definitive source of information on each table and column in the ODM CSV format.
