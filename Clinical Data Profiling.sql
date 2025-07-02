
--use health_protection;


--SELECT  * FROM ClinicalData;


select * from INFORMATION_SCHEMA.columns where TABLE_NAME like 'ClinicalData';

select column_name,ordinal_position, data_type, character_maximum_length into #1
from INFORMATION_SCHEMA.columns where TABLE_NAME like 'ClinicalData';

select * from #1;

alter table #1 add maximum nvarchar(max);
alter table #1 add minimum nvarchar(max);
alter table #1 add nulls int;
alter table #1 add distinct_count int;
alter table #1 add mean float;
alter table #1 add median float;
alter table #1 add mode nvarchar(max);
alter table #1 add SD float;
alter table #1 add Zero_Values int;



declare @i int =1
declare @j int

set @j = (select MAX(ordinal_position) from #1)

declare @columnname nvarchar(max)
declare @datatype nvarchar(max)

declare @sql nvarchar(max)

while @i<= @j
begin

select @columnname = column_name , @datatype = data_type from #1 where ORDINAL_POSITION = @i

 -- Handle numeric columns
    IF @dataType IN ('int', 'float', 'real', 'decimal', 'numeric', 'money', 'smallint', 'tinyint')
     BEGIN
       
     set @sql = 'update #1 set maximum  = (select max('+@columnname+') from ClinicalData) where ORDINAL_POSITION ='+ CAST(@i as varchar(max))
     exec sp_executesql @sql

     set @sql = 'update #1 set minimum  = (select min('+@columnname+') from ClinicalData) where ORDINAL_POSITION ='+ CAST(@i as varchar(max))
     exec sp_executesql @sql

     set @sql = 'update #1 set mean  = (select avg(cast('+@columnname+' as bigint)) from ClinicalData) where ORDINAL_POSITION ='+ CAST(@i as varchar(max))
     exec sp_executesql @sql

     set @sql = 'update #1 set SD  = (select stdev('+@columnname+') from ClinicalData) where ORDINAL_POSITION ='+ CAST(@i as varchar(max))
     exec sp_executesql @sql

     set @sql = 'update #1 set Zero_Values  = (select count( *) from ClinicalData where '+@columnname+'= 0)  where ORDINAL_POSITION ='+ CAST(@i as varchar(max))
     exec sp_executesql @sql

     set @sql = 'update #1 set nulls  = (select count( *) from ClinicalData where '+@columnname+' is null)  where ORDINAL_POSITION ='+ CAST(@i as varchar(max))
     exec sp_executesql @sql

     set @sql = 'update #1 set distinct_count  = (select count(distinct '+@columnname+') from ClinicalData) where ORDINAL_POSITION ='+ CAST(@i as varchar(max))
     exec sp_executesql @sql

     set @sql = 'update #1 set mode = (select string_agg(' + @columnname +', '','')  from
(select ' + @columnname +',dense_rank() over(order by [count All] desc) [DR] from
(select ' + @columnname +',count(*) [Count All] from ClinicalData
group by ' + @columnname +') x) y where DR = 1) where ORDINAL_POSITION ='+ CAST(@i as varchar(max))
exec sp_executesql @sql


    set @sql = '--select * from ClinicalData

select ' + @columnname +',ROW_NUMBER() over(order by ' + @columnname +') [rn] into #2 from ClinicalData

--Select * from #2

declare @l int

declare @m int, @n int , @x float

set @l = (select max(rn) from #2)

set @m = @l%2 -- remainder

set @n = @l/2 -- Integral Quotient

if @m = 0 
begin
set @x = (select avg(' + @columnname +') [Median ' + @columnname +'] from #2 where rn in (@n,@n+1))
end

if @m <> 0 
begin
set @x = (select ' + @columnname +' [Median ' + @columnname +'] from #2 where rn = @n+1)
end

update #1 set median = @x where ORDINAL_POSITION ='+ CAST(@i as varchar(max))
exec sp_executesql @sql


     END



      -- Handle date columns
    IF @dataType IN ('date', 'datetime', 'datetime2', 'smalldatetime', 'time')
     BEGIN
       
     set @sql = 'update #1 set maximum  = (select max('+@columnname+') from ClinicalData) where ORDINAL_POSITION ='+ CAST(@i as varchar(max))
     exec sp_executesql @sql

     set @sql = 'update #1 set minimum  = (select min('+@columnname+') from ClinicalData) where ORDINAL_POSITION ='+ CAST(@i as varchar(max))
     exec sp_executesql @sql

    
    

     set @sql = 'update #1 set Zero_Values  = (select count( *) from ClinicalData where '+@columnname+'= ''1900-01-01'')  where ORDINAL_POSITION ='+ CAST(@i as varchar(max))
     exec sp_executesql @sql

     set @sql = 'update #1 set nulls  = (select count( *) from ClinicalData where '+@columnname+' is null)  where ORDINAL_POSITION ='+ CAST(@i as varchar(max))
     exec sp_executesql @sql

     set @sql = 'update #1 set distinct_count  = (select count(distinct '+@columnname+') from ClinicalData) where ORDINAL_POSITION ='+ CAST(@i as varchar(max))
     exec sp_executesql @sql

     set @sql = 'update #1 set mode = (select string_agg(' + @columnname +', '','')  from
(select ' + @columnname +',dense_rank() over(order by [count All] desc) [DR] from
(select ' + @columnname +',count(*) [Count All] from ClinicalData
group by ' + @columnname +') x) y where DR = 1) where ORDINAL_POSITION ='+ CAST(@i as varchar(max))
exec sp_executesql @sql


        END

      
    -- Handle non numeric column for max and min

    IF @dataType IN ('varchar', 'nvarchar', 'text', 'char', 'nchar')
     BEGIN
       
     set @sql = 'update #1 set maximum  = (select max('+@columnname+') from ClinicalData) where ORDINAL_POSITION ='+ CAST(@i as varchar(max))
     exec sp_executesql @sql

     set @sql = 'update #1 set minimum  = (select min('+@columnname+') from ClinicalData) where ORDINAL_POSITION ='+ CAST(@i as varchar(max))
     exec sp_executesql @sql

    
    
     set @sql = 'update #1 set Zero_Values  = (select count( *) from ClinicalData where '+@columnname+'= ''0'')  where ORDINAL_POSITION ='+ CAST(@i as varchar(max))
     exec sp_executesql @sql

     set @sql = 'update #1 set nulls  = (select count( *) from ClinicalData where '+@columnname+' is null)  where ORDINAL_POSITION ='+ CAST(@i as varchar(max))
     exec sp_executesql @sql

     set @sql = 'update #1 set distinct_count  = (select count(distinct '+@columnname+') from ClinicalData) where ORDINAL_POSITION ='+ CAST(@i as varchar(max))
     exec sp_executesql @sql

     set @sql = 'update #1 set mode = (select string_agg(' + @columnname +', '','')  from
(select ' + @columnname +',dense_rank() over(order by [count All] desc) [DR] from
(select ' + @columnname +',count(*) [Count All] from ClinicalData
group by ' + @columnname +') x) y where DR = 1) where ORDINAL_POSITION ='+ CAST(@i as varchar(max))
exec sp_executesql @sql


       END


   -- Handle non numeric column for max and min

    IF @dataType IN ('bit')
     BEGIN
       
     
    
    
     set @sql = 'update #1 set Zero_Values  = (select count( *) from ClinicalData where '+@columnname+'= ''0'')  where ORDINAL_POSITION ='+ CAST(@i as varchar(max))
     exec sp_executesql @sql

     set @sql = 'update #1 set nulls  = (select count( *) from ClinicalData where '+@columnname+' is null)  where ORDINAL_POSITION ='+ CAST(@i as varchar(max))
     exec sp_executesql @sql

     set @sql = 'update #1 set distinct_count  = (select count(distinct '+@columnname+') from ClinicalData) where ORDINAL_POSITION ='+ CAST(@i as varchar(max))
     exec sp_executesql @sql

     set @sql = 'update #1 set mode = (select string_agg(' + @columnname +', '','')  from
(select ' + @columnname +',dense_rank() over(order by [count All] desc) [DR] from
(select ' + @columnname +',count(*) [Count All] from ClinicalData
group by ' + @columnname +') x) y where DR = 1) where ORDINAL_POSITION ='+ CAST(@i as varchar(max))
exec sp_executesql @sql


       END



set @i = @i+1
end;
