#!/bin/bash
  
# export the climDB content it its native format, for archive as an EML desccribed package.

# script queries climdb for table content exports content, one csv(?) per table.
# copied from psql2csv.sh, from mgb 2Oct2009m and mob 18mar2011

# actions:
# cycle thru a list of tables
# create a sql statement for each
# send sql to climdb via mspsql 
# output csv table in a sub dir

# NOTE:
# the climdb_raw table is large. 
# When I first ran, I got a memory error, had first to run:
# bash-3.2$ export NODE_OPTIONS=--max-old-space-size=8192
# per: https://support.snyk.io/hc/en-us/articles/360002046418-JavaScript-heap-out-of-memory
# also note you probably have to up the timeout limit for this one table. but you can leave it high for all of them. 


# NOTE: DB PASSWORD NOT STORED IN GIT. ask James or Margaret, then populate that field.

# Usage:
#   basename list_of_tables
#   if output dir does not exist, pwd is used

# PROCESS CMD LINE 

# SET UP
# input 
site_codes=$1;

# Temporary file
tmpout='tmp.csv';


# output - with site var, build a string for the table output directory
slash='/';
git_clone_loc='/Users/mob/Desktop/EDI_files_at_msi/EDI/thematic_standardization/ClimDB/git_clones';
git_repo='Clim-HydroDB-2.0';
repo_subdir='climdb-archive-partA/data_packages/native_db_format';
entity_dir='data_objects';
parent_dir="$git_clone_loc""$slash""$git_repo""$slash""$repo_subdir";


# Fixed strings, to build the query
# queryHead="select  TOP 100 site_code, sampledate, value from dbo.climdb_raw where site_code = ";
queryHead="SELECT * FROM ";
queryTail=";";

# mssql command line options
as_csv=" --format csv " # still ugly. has a multi header (with col names prefixed), everything is a string.
# vars=" -v sample=fruit " # --variable assignment
connection=" -s 129.24.124.181 -o 3733 -u climdbquery -d climdb -p 'INSERT_PW' "
# optional - request longer timeout. this may have to be several minutes. 1mil ms is about 16 min. 
# timeout=" -T 1000000";
# increase the timeout for climdb_raw table.
timeout=" -T 10000000";

# PROCESS CMD LINE ARGS
outdir="./"$2;



while IFS= read -r line; do
    site=$line;
    echo "";
    echo ""; 
    echo "Table: $site";

    # Build the query, save to a temp file:
    queryString="$queryHead""$site""$queryTail";
    echo "$queryString";
    echo "$queryString" > tmp.sql;
    queryIn='tmp.sql';


    # build the output path:
    queryOut="$parent_dir""$slash""$entity_dir""$slash"$site'.csv';

    if [ -f $queryIn ]; then
        #    echo "" 
        cmd='mssql '" $as_csv $connection $timeout "'<'" $queryIn "'>'" $tmpout";
        echo $cmd;
       # execute the query:
       eval $cmd;
       # echo "";        
       echo 'saving to '"$queryOut";

       # clean out the cruft left by mssql
       # TO DO: you may want to replace the NULLs with a string (define a MVC). but technically, this is not the original data anymore, so maybe not.
       sed '/^Connecting/d' tmp.csv | sed '/^sql-cli/d' | sed '/^Enter/d' | sed '/Executed/d' | sed 's/^mssql> //' | sed '/^$/d' > $queryOut; 


        #echo cp -p $1".*" $outdir;
        #echo ""
    else
        echo $queryIn not found;
    fi


done < $site_codes

