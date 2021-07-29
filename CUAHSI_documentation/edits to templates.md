# Template Spreadsheet Edits

Edits to spreadsheets are documented here in case this must be repeated.

## Changes made to both templates

* For controlled vocabularies, provide link to CV.
* For controlled vocabularies, indicate which column from the CV to use.
* Typo and formatting cleanup.
* Made the templates more consistent with each other.
* If an optional column has no default, leave it blank instead of `NULL`.
* Indicate when column values must be unique.

### Introduction

* Instructed user to upload data and metadata to EDI.
* Correctly spelled `Observations Data Model`.

### Description of Tables

* Corrected **Sources** table description to say that this table describes who collected the data.

## Changes made to advanced template only

Added disclaimer on first page that samples, offsets, and ValueID may be flawed.

### Description of Tables for advanced template

* For Categories, gave a hint that DataValues should always be numerical.

### Variables

* Changed many constraints from `Mandatory; Foreign Key` to `Controlled Vocabulary`.

### OffsetTypes

* Add OffsetTypeCode

### DataValues

* Add ValueID
