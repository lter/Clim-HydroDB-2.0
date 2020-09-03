SELECT dt.descriptor_type_code as dt_descriptor_type_code, 
	dt.descriptor_type_name AS dt_descriptor_type_name, 
	rsd.last_update AS rsd_last_update, 
	rsd.site_id AS rsd_site_id, 
	rs.site_id AS rs_site_id, 
	rs.res_site_code AS rs_res_site_code, 
	rs.res_site_name AS rs_res_site_name, 
	site.site_code AS parent_site_code, 
	site.site_name AS parent_site_name, 
	REPLACE(rsd.descriptor_value, CHAR(13) + CHAR(10), '') as rsd_method_description -- replace newlines
from dbo.descriptor_type dt
JOIN dbo.research_site_descriptor rsd on dt.descriptor_type_id = rsd.descriptor_type_id 
JOIN dbo.research_site rs on rsd.site_id = rs.site_id
JOIN dbo.site site on site.site_id = rs.site_id
where dt.descriptor_type_code LIKE 'airt_method%' 
 AND rs.res_site_code = 'WS07'
 -- AND site.site_code = 'GCE'