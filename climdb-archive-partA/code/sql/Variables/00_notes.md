# Variables table:

This table maps between the organzation's variable codes and CUAHSI's. The organization in this case is climDB, so all the tables can be the same. 

## Decisions: 
1. we don't need to build this table to exactly correspond with what each climdb-contributor has in climdb. since it is a parent table (for DataValues), it can have all the climdb vars in it, and some may not be used for a particular climdb contributor.

2. Fields should be reviewed by each contributor to make sure they match the local practices. e.g.,
2.1 methods
2.2 dataType (derived or field obs)

## table creation
with a small script, copied this table to each site/data_objects directory.


