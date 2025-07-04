

use health_protection;

select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME like 'ClinicalData';



declare @i int =1 
declare @sql nvarchar(max)
declare @j int 

set @j = (SELECT MAX(ordinal_position) from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME like 'ClinicalData')

declare @columnname varchar(max)

while @i<=@j
begin

set @columnname = (select column_name from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME like 'ClinicalData' and ORDINAL_POSITION = @i)

set @sql = 'select ' + @columnname + ', COUNT(*) [Frequency] from ClinicalData group by ' + @columnname + ' order by count(*)  desc'

exec sp_executesql @sql

set @i = @i+1
end;
