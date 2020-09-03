(SELECT DISTINCT -- TOP 1000 -- *
rs.res_site_code, RTRIM(LTRIM(rs.res_site_name)),
-- d.descriptor_type_code, 
d.descriptor_type_name, -- can you filter on these for a col? or will you need post-proc, e.g., spread? 
rsd.descriptor_value,
raw.site_code AS raw_parent_code,
'WGS84' AS 'lat_long_ref',
'mean sea level' AS 'elevation_ref',
NULL AS 'local_x',
NULL AS 'local_y',
NULL AS 'position_accuracy',
NULL AS 'SiteType'
from dbo.research_site rs
JOIN dbo.research_site_descriptor rsd ON rsd.res_site_id = rs.res_site_id
JOIN dbo.descriptor_type d ON rsd.descriptor_type_id = d.descriptor_type_id
JOIN dbo.climdb_raw raw ON raw.res_site_id = rs.res_site_id
WHERE (d.descriptor_type_code LIKE '%lat%' or d.descriptor_type_code LIKE '%lon%' or d.descriptor_type_code LIKE '%elev%' )
AND raw.site_code = 'AND' 
)

-- RTRIM(LTRIM(REPLACE(REPLACE(s.site_name, CHAR(13) + CHAR(10), ''),CHAR(10), '')))