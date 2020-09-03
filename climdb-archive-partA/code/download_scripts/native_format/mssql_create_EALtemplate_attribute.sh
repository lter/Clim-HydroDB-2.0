#!/bin/bash
  
# query the DB-system tables for info about the columns, create EAL attribute tables (some placeholders).

# script queries climdb for table content, exports one csv(?) per DB-table.
# copied from psql2csv.sh, from mgb 2Oct2009m and mob 18mar2011

# actions:
# cycle thru a list of tables
# create a sql statement for each
# send sql to climdb via mspsql 
# output csv table in a sub dir

# NOTE: DB PASSWORD NOT STORED IN GIT. ask James or Margaret, then populate that field.

# Usage:
#   basename list_of_tables
#   if output dir does not exist, pwd is used

# SET UP
# PROCESS CMD LINE 
# input 
tables=$1;

# Temporary file
tmpout='tmp.csv';


# output - with table var, build a string for the table output directory
slash='/';
git_clone_loc='/Users/mob/Desktop/EDI_files_at_msi/EDI/thematic_standardization/ClimDB/git_clones';
git_repo='Clim-HydroDB-2.0';
repo_subdir='climdb-archive-partA/data_packages/native_db_format';
entity_dir='EAL_pkg_edi_605/metadata_templates';
parent_dir="$git_clone_loc""$slash""$git_repo""$slash""$repo_subdir";


# Fixed strings, to build the query
queryHead="SELECT DISTINCT c.name  AS 'attributeName', 'TO_DO' AS 'attributeDefinition', t.Name  AS 'class', 'TO_DO' AS 'unit', 'TO_DO' AS 'dateTimeFormatString', c.is_nullable AS 'missingValueCode', 'Not Available' AS 'missingValueCodeExplanation' FROM sys.columns c INNER JOIN sys.types t ON c.user_type_id = t.user_type_id LEFT OUTER JOIN sys.index_columns ic ON ic.object_id = c.object_id AND ic.column_id = c.column_id LEFT OUTER JOIN sys.indexes i ON ic.object_id = i.object_id AND ic.index_id = i.index_id WHERE c.object_id = OBJECT_ID('dbo.";

queryTail="');";

# mssql command line options
as_csv=" --format csv " # still ugly. has a multi header (with col names prefixed), everything is a string.
# vars=" -v sample=fruit " # --variable assignment
connection=" -s 129.24.124.181 -o 3733 -u climdbquery -d climdb -p 'INSERT_PW' "
# optional - request longer timeout. this may have to be several minutes. 1mil ms is about 16 min. 
timeout=" -T 1000000";
# increased timeout.
# timeout=" -T 10000000";

# PROCESS CMD LINE ARGS
# outdir="./"$2;



while IFS= read -r line; do
    table=$line;
    echo "";
    echo ""; 
    echo "Table: $table";
    # build a filename for the EAL metadata table
    EAL_filename='attributes_'"$table"'.txt';

    # Build the query, save to a temp file:
    queryString="$queryHead""$table""$queryTail";
    echo "$queryString";
    echo "$queryString" > tmp.sql;
    queryIn='tmp.sql';


    # build the output path:
    queryOut="$parent_dir""$slash""$entity_dir""$slash""$EAL_filename";

    if [ -f $queryIn ]; then
        #    echo "" 
        cmd='mssql '" $as_csv $connection $timeout "'<'" $queryIn "'>'" $tmpout";
        echo $cmd;
       # execute the query:
       eval $cmd;
       # echo "";        
       echo 'saving to '"$queryOut";

       # clean out the cruft left by mssql
       # TO DO: EAL metadata tables are tab-sep, plus remove the quoted strings.
       sed '/^Connecting/d' tmp.csv | sed '/^sql-cli/d' | sed '/^Enter/d' | sed '/Executed/d' | sed 's/^mssql> //' | sed '/^$/d' | sed 's/"//g' | tr ',' '\t' > $queryOut; 


        #echo cp -p $1".*" $outdir;
        #echo ""
    else
        echo $queryIn not found;
    fi


done < $tables

