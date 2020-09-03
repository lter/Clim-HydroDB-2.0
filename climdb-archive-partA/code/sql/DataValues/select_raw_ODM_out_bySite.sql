/* select top 10 *  from dbo.vw_join_site_descriptors; */
 /* select  DISTINCT site_name, site_id, res_site_code  from dbo.vw_join_site_descriptors where res_site_parent_id IS  NULL */
 SELECT value AS 'DataValue', sampledate AS 'LocalDateTime', 'NA' AS 'UTCOffset', 'NA' AS 'DateTimeUTC', res_site_id AS 'SiteCode', 
 variable AS 'VariableCode', 'NA' AS 'MethodCode', 'NA' AS 'SourceCode','-9999' AS 'QualityControlLevelCode' from dbo.climdb_raw where site_code = 'FCE';