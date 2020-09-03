# README

directory holds Climdb scripts to pull stuff for a single data package, containing all the tables in their native format, plus EML metadata.

package ID: edi.605

## EAL metadata
- We are planning to use EMLAssemblyLine for this dataset. Some may be created manually.
  - EAL metadata tables we will need:
    - attributes.txt: tab sep table for each data object (23)
    - personnel
    - keywords
    - TBD
    - 

## Data Table dumps:
- One script cycles through the 23 tables, with SELECT *
- Most tables are too big for git.
