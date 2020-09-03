-- select  TOP 100 value AS 'DataValue', sampledate AS 'LocalDateTime', 'NA' AS 'UTCOffset', 'NA' AS 'DateTimeUTC', site_code AS 'SiteCode', variable AS 'VariableCode',  'NA' AS 'MethodCode', 'NA' AS 'SourceCode','-9999' AS 'QualityControlLevelCode' from dbo.climdb_raw where site_code = 'SBC';

select  TOP 100 value AS 'DataValue', 
	sampledate AS 'LocalDateTime', 
	'NA' AS 'UTCOffset', 
	'NA' AS 'DateTimeUTC', 
	site_code AS 'SiteCode', 
	variable AS 'VariableCode',  
	0 AS 'MethodCode',  -- integer (default)
	site_id AS 'SourceCode', -- integer
	'-9999' AS 'QualityControlLevelCode' -- text (default) 
from dbo.climdb_raw where site_code = 'SBC';
