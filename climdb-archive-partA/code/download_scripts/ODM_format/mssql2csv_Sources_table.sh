#!/bin/bash
  
# queries climdb for raw values, exports one csv per research site.
# copied from psql2csv.sh, from  mgb 2Oct2009m and mob 18mar2011

# actions:
# cycle thru a list of site_codes
# create a sql statement for site
# send sql to climdb via mspsql 
# output csv table in a sub dir

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

# create a file name with this string:
filename_tail='_ODM_Sources_table.csv';

# Fixed strings, to build the query
queryHead="SELECT DISTINCT s.site_code AS 'SourceCode', REPLACE(REPLACE(s.site_name, CHAR(13) + CHAR(10), ''),CHAR(10), '')  AS 'Organization', 'Description not available' AS 'SourceDescription', COALESCE(RTRIM(LTRIM(s.site_url)), 'unknown') AS 'SourceLink', RTRIM(LTRIM(p.first_name)) + ' ' + p.middle_name + ' ' + RTRIM(LTRIM(p.last_name)) AS 'ContactName', COALESCE(LTRIM(RTRIM(REPLACE(REPLACE(p.email1, CHAR(13) + CHAR(10), ''),CHAR(10), ''))) , 'unknown') AS 'Email', 'unknown' AS 'Citation' from dbo.site s JOIN dbo.site_personnel_role spr 	on s.site_id = spr.site_id JOIN dbo.personnel_role pr 	on pr.personnel_role_id = spr.personnel_role_id JOIN dbo.personnel p 	on spr.personnel_id = p.personnel_id WHERE pr.personnel_role_desc = 'Data Set Contact' AND s.site_code = '" ;

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
    queryOut="$parent_dir""$slash""$site""$slash""$entity_dir""$slash""$site""$filename_tail";

    if [ -f $queryIn ]; then
        #    echo "" 
        cmd='mssql '" $as_csv $connection $timeout "'<'" $queryIn "'>'" $tmpout";
        echo $cmd;
        # execute the query:
        eval $cmd;
        # echo "";        
        echo 'saving to '"$queryOut";

        # clean out the cruft left by mssql, and then since is a 1-line file, save only 2 lines total.
        sed '/^Connecting/d' tmp.csv | sed '/^sql-cli/d' | sed '/^Enter/d' | sed '/Executed/d' | sed 's/^mssql> //' | sed '/^$/d' | head -2 > $queryOut; 


        #echo cp -p $1".*" $outdir;
        #echo ""
    else
        echo $queryIn not found;
    fi


done < $site_codes

