/* SELECT DISTINCT s.site_id, s.site_code, s.site_name, s.site_url,
spr.site_id, spr.personnel_id, spr.personnel_role_id,
pr.personnel_role_id, pr.personnel_role_desc,
p.first_name, p.middle_name, p.last_name, p.email1
from dbo.site s
JOIN dbo.site_personnel_role spr
	on s.site_id = spr.site_id
JOIN dbo.personnel_role pr
	on pr.personnel_role_id = spr.personnel_role_id
JOIN dbo.personnel p
	on spr.personnel_id = p.personnel_id
WHERE pr.personnel_role_desc = 'Data Set Contact'
-- 	WHERE pr.personnel_role_desc = 'Principal Investigator'
*/
SELECT DISTINCT 
-- s.site_id, 
s.site_code AS 'SourceCode', RTRIM(LTRIM(REPLACE(REPLACE(s.site_name, CHAR(13) + CHAR(10), ''),CHAR(10), ''))) AS 'Organization', 'Description not available' AS 'SourceDescription', COALESCE(RTRIM(LTRIM(s.site_url)), 'unknown') AS 'SourceLink',
-- spr.site_id, spr.personnel_id, spr.personnel_role_id, 
-- pr.personnel_role_id, pr.personnel_role_desc,
-- REPLACE(rsd.descriptor_value, CHAR(13) + CHAR(10), '')
RTRIM(LTRIM(p.first_name)) + ' ' + p.middle_name + ' ' + RTRIM(LTRIM(p.last_name)) AS 'ContactName', 
COALESCE(LTRIM(RTRIM(REPLACE(REPLACE(p.email1, CHAR(13) + CHAR(10), ''),CHAR(10), ''))) , 'unknown') AS 'Email',
'unknown' AS 'Citation'
from dbo.site s
JOIN dbo.site_personnel_role spr
	on s.site_id = spr.site_id
JOIN dbo.personnel_role pr
	on pr.personnel_role_id = spr.personnel_role_id
JOIN dbo.personnel p
	on spr.personnel_id = p.personnel_id
WHERE pr.personnel_role_desc = 'Data Set Contact'
AND s.site_code = 'AND'