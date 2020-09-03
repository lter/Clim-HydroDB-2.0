/*CREATE VIEW dbo.vw_four_generations 
AS */
select top(10000) 
-- parent columns
rs.res_site_id as "parent_res_site_id", rs.site_id, rs.res_site_parent_id, rs.res_site_code, rs.res_site_name,
-- child columns
child1.res_site_id as "child1_res_site_id", child1.site_id, child1.res_site_parent_id, child1.res_site_code, child1.res_site_name,
-- 
child2.res_site_id as "child2_res_site_id", child2.site_id, child2.res_site_parent_id, child2.res_site_code, child2.res_site_name,
-- 
child3.res_site_id as "child3_res_site_id", child3.site_id, child3.res_site_parent_id, child3.res_site_code, child3.res_site_name
-- 
from dbo.research_site rs 
left outer join dbo.research_site child1
on child1.res_site_parent_id = rs.res_site_id 
--
left outer join dbo.research_site child2
on child2.res_site_parent_id = child1.res_site_id 
--
left outer join dbo.research_site child3
on child3.res_site_parent_id = child2.res_site_id 
--
order by rs.res_site_code, child1.res_site_code, child2.res_site_code, child3.res_site_code
;
