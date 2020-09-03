#!/bin/bash
  
# queries climdb for raw values, exports one csv per research site.
# copied from psql2csv.sh, from  mgb 2Oct2009m and mob 18mar2011

# actions:
# cycle thru a list of site_codes
# create a sql statement for site
# send sql to climdb via mspsql 
# output csv table in a sub dir


## TO DO: YOU MAY NOT NEED TO QUERY FOR THIS. CURRENT PLAN IS FOR ALL TABLES TO LOOK THE SAME.


# NOTE: DB PASSWORD NOT STORED IN GIT. ask James or Margaret, then populate that field.

# Usage:
#   basename list_of_site_codes
#   if output dir does not exist, pwd is used

# PROCESS CMD LINE 
# site_codes=$2;
# outdir=$1;


# SET UP
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


# Fixed strings, to build the query
# queryHead="select  TOP 100 site_code, sampledate, value from dbo.climdb_raw where site_code = ";
queryHead="SELECT raw.value AS 'DataValue', raw.sampledate AS 'LocalDateTime', 'NA' AS 'UTCOffset', 'NA' AS 'DateTimeUTC', rs.res_site_code AS 'SiteCode', raw.variable AS 'VariableCode', 0 AS 'MethodCode', raw.site_id AS 'SourceCode','-9999' AS 'QualityControlLevelCode'  from dbo.climdb_raw raw JOIN dbo.research_site rs ON raw.res_site_id = rs.res_site_id where raw.site_code = '";

queryTail="';";

# mssql command line options
as_csv=" --format csv " # still ugly. has a multi header (with col names prefixed), everything is a string.
# vars=" -v sample=fruit " # --variable assignment
connection=" -s 129.24.124.181 -o 3733 -u climdbquery -d climdb -p 'INSERT_PW' "
# optional - request longer timeout. this may have to be several minutes. 1mil ms is about 16 min. 
timeout=" -T 1000000";

# PROCESS CMD LINE ARGS
outdir="./"$2;



while IFS= read -r line; do
    site=$line;
    echo "";
    echo ""; 
    echo "Site code: $site";

    # Build the query, save to a temp file:
    queryString="$queryHead""$site""$queryTail";
    echo $queryString > tmp.sql;
    queryIn='tmp.sql';

    # build the output path:
    queryOut="$parent_dir""$slash""$site""$slash""$entity_dir""$slash"$site'_ODM_value_table.csv';

    if [ -f $queryIn ]; then
        #    echo "" 
        cmd='mssql '" $as_csv $connection $timeout "'<'" $queryIn "'>'" $tmpout";
        echo $cmd;
        # execute the query:
        eval $cmd;
        # echo "";        
        echo 'saving to '"$queryOut";

        # clean out the cruft left by mssql
        sed '/^Connecting/d' tmp.csv | sed '/^sql-cli/d' | sed '/^Enter/d' | sed '/Executed/d' | sed 's/^mssql> //' | sed '/^$/d' > $queryOut; 


        #echo cp -p $1".*" $outdir;
        #echo ""
    else
        echo $queryIn not found;
    fi


done < $site_codes

