

select * into new_table
from ClinicalData;

select top 10 * from new_table;

select max(year(AdmissionDate)) from new_table;

select min(year(AdmissionDate)) from new_table;

update new_table 
set AdmissionDate =
		case when year(AdmissionDate)>2030
		then dateadd(day,(abs(CHECKSUM(NEWID())))%(DATEDIFF(DAY,'2024-01-01','2030-12-31')+1),'2024-01-01')
		else AdmissionDate
		end ;

select 
HospitalID,
AdmissionDate,
TotalAdmissions,
Readmissions,
Infections,
TotalDeaths
from new_table;