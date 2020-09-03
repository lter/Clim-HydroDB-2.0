#!/bin/bash
  
# builds a simple table for each contributor in a list..
# table is very simple, three columns, header plus one data row (TBD: 2 data rows, see examples). 

# actions:
# cycle thru a list of site_codes
# make a small table in the code dir

# Usage:
#   basename list_of_site_codes
#   if output dir does not exist, pwd is used


# SET UP (totally not fancy)
# input 
site_codes=$1;

# Temporary file
tmpout='tmp.csv';


# output - with site var, build a string for the table output directory
slash='/';
git_clone_loc='/Users/mob/Desktop/EDI_files_at_msi/EDI/thematic_standardization/ClimDB/git_clones';
git_repo='Clim-HydroDB-2.0';
repo_subdir='climdb-archive-partA/data_packages/by_site_ODM_fmt';
entity_dir='data_objects';
parent_dir="$git_clone_loc""$slash""$git_repo""$slash""$repo_subdir";

# string to create a file name:
filename_tail='_ODM_QualityControlLevels_table.csv';


# build the temp file:
headerLine='"QualityControlLevelCode","Definition","Explanation"';
recordLine1='"0","Raw","unedited data, such as the output from a sensor"';
recordLine2='"1","Edited data","Data that have passed some objective quality assurance procedure"';
recordLine3='"2","Derived data","Derived product, potentially from multiple sensors, that require some subjective judgment"';
recordLine4='"3","Interpreted product","requiring more assumptions and judgments (e.g., rainfall inferred from radar reflectance)"';
recordLine5='"4","Knowledge product","requiring inferences, potentially from multiple disciplines, and combining multiple measurements, each with their own assumptions"';
recordLine6='"-9999","Unknown","unknown"';



   # make the line endings match the tables coming from mssql. thank stackoverflow for the CR hack.
    echo "$headerLine"$'\r' > $tmpout;
    echo "$recordLine1"$'\r' >> $tmpout;
    echo "$recordLine2"$'\r' >> $tmpout;
    echo "$recordLine3"$'\r' >> $tmpout;
    echo "$recordLine4"$'\r' >> $tmpout;
    echo "$recordLine5"$'\r' >> $tmpout;
    echo "$recordLine6"$'\r' >> $tmpout;



while IFS= read -r line; do
    site=$line;
    echo ""; 
    echo "Site code: $site";

 #   # Build the small table, save to a temp file:
 #   headerLine='col1,col2,col3';
 #   recordLine1='0,quality level unknown,quality level unknown';
 #   recordLine2='1,some other level,TBD';

#    # make the line endings match the tables coming from mssql. thank stackoverflow for the CR hack.
#    echo "$headerLine"$'\r' > $tmpout;
#    echo "$recordLine1"$'\r' >> $tmpout;

    # build the output path, with filename:
    queryOut="$parent_dir""$slash""$site""$slash""$entity_dir""$slash""$site""$filename_tail";
    echo 'saving '"$queryOut";

    cp $tmpout  $queryOut;


done < $site_codes

