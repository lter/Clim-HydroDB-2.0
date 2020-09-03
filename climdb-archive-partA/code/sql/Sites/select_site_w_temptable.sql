If(OBJECT_ID('tempdb..#temp_site_long') Is Not Null)
Begin
    Drop Table #temp_site_long
End;


CREATE table #temp_site_long
(
col1 TEXT, -- res_site_code
col2 TEXT, -- res_site_name
col3 TEXT, -- descriptor_type_name
col4 FLOAT, -- descriptor_value
col5 TEXT -- raw_parent_site
) 
;
AS 

(SELECT DISTINCT -- TOP 1000 -- *
rs.res_site_code, rs.res_site_name,
-- d.descriptor_type_code, 
d.descriptor_type_name, -- can you filter on these for a col? or will you need post-proc, e.g., spread? 
rsd.descriptor_value,
raw.site_code AS raw_parent_code
from dbo.research_site rs
JOIN dbo.research_site_descriptor rsd ON rsd.res_site_id = rs.res_site_id
JOIN dbo.descriptor_type d ON rsd.descriptor_type_id = d.descriptor_type_id
JOIN dbo.climdb_raw raw ON raw.res_site_id = rs.res_site_id
WHERE (d.descriptor_type_code LIKE '%lat%' or d.descriptor_type_code LIKE '%lon%' or d.descriptor_type_code LIKE '%elev%' )
AND raw.site_code = 'AND' 
)

DECLARE @cols AS NVARCHAR(MAX)='';
DECLARE @query AS NVARCHAR(MAX)='';

SELECT @cols = @cols + QUOTENAME(col3) + ',' FROM (SELECT DISTINCT )
