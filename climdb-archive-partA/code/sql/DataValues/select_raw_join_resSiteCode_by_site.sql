/* select top 10 *  from dbo.vw_join_site_descriptors; */
 /* select  DISTINCT site_name, site_id, res_site_code  from dbo.vw_join_site_descriptors where res_site_parent_id IS  NULL */
 SELECT raw.value AS 'DataValue', raw.sampledate AS 'LocalDateTime', 'NA' AS 'UTCOffset', 'NA' AS 'DateTimeUTC', rs.res_site_code AS 'SiteCode', 
 raw.variable AS 'VariableCode', 'NA' AS 'MethodCode', 'NA' AS 'SourceCode','-9999' AS 'QualityControlLevelCode' 
 from dbo.climdb_raw raw
 JOIN dbo.research_site rs ON raw.res_site_id = rs.res_site_id 
 where raw.site_code = 'AND'
 ;
 
  --, variable AS 'VariableCode', 'NA' AS 'MethodCode', 'NA' AS 'SourceCode','-9999' AS 'QualityControlLevelCode' 
