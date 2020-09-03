#!/bin/bash
  
# each contributor gets a copy of the same table, to be used by contributors as a template or example.
# table is 11 cols and a header. __ rows. See Variables_table.csv 

# actions:
# cycle thru a list of site_codes
# copy the template table to the site-code dir

# Usage:
#   basename list_of_site_codes
#   if output dir does not exist, pwd is used


# SET UP (totally not fancy)
# input 
site_codes=$1;

# Template table
template='Variables_table_template.csv';

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
filename_tail='_ODM_Variables_table.csv';

# you may need to edit line endings in the template, to make them match the mssql output.
# currently, the google spreadsheet download saved them with \r\n, however.
# if you need this in the future, see stackoverflow, for something like
#    echo "$recordLine4"$'\r' >> $tmpout; 
# which you used for the methods table.
cp $template $tmpout;


while IFS= read -r line; do
    site=$line;
    echo ""; 
    echo "Site code: $site";

    # build the output path, with filename:
    queryOut="$parent_dir""$slash""$site""$slash""$entity_dir""$slash""$site""$filename_tail";
    echo 'saving '"$queryOut";

    cp $tmpout  $queryOut;


done < $site_codes

