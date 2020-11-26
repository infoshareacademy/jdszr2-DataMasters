-------------	
--Create table with correlation of Exports and respectively GDP, PPP and GDP per capita, PPP for China and USA after 1990

drop table if exists "CorrelationExports";
create table "CorrelationExports"

-- data1 with Exports of goods and services (current US$) for China and USA after 1990

as
with data1 as (
SELECT C."CountryCode", I."IndicatorName", I."Value", I."Year", S."Topic",  CN."Description", concat(I."CountryCode",I."Year") as id
	FROM "Country" C inner JOIN "Indicators" I
		ON C."CountryCode" = I."CountryCode"
		inner join "Series" S
		on I."IndicatorName" = S."IndicatorName"
		left join "CountryNotes" CN
		on C."CountryCode" = CN."Countrycode" and S."SeriesCode" = CN."Seriescode"
			where (C."CountryCode" like 'CHN' or C."CountryCode" like 'USA')
			and I."IndicatorName" = 'Exports of goods and services (current US$)'
			and "Year" > 1990
		order by "CountryCode", "Topic", "IndicatorName", "Year"
			),
			
-- data2 with GDP per capita, PPP (current international $) for China and USA after 1990

data2 as (
SELECT C."CountryCode", I."IndicatorName", I."Value", I."Year", S."Topic",  CN."Description", concat(I."CountryCode",I."Year") as id
	FROM "Country" C inner JOIN "Indicators" I
		ON C."CountryCode" = I."CountryCode"
		inner join "Series" S
		on I."IndicatorName" = S."IndicatorName"
		left join "CountryNotes" CN
		on C."CountryCode" = CN."Countrycode" and S."SeriesCode" = CN."Seriescode"
			where (C."CountryCode" like 'CHN' or C."CountryCode" like 'USA')
			and I."IndicatorName" = 'GDP per capita, PPP (current international $)'
			and "Year" > 1990
		order by "CountryCode", "Topic", "IndicatorName", "Year"
),

-- data3 with GDP, PPP (current international $) for China and USA after 1990

data3 as (
SELECT C."CountryCode", I."IndicatorName", I."Value", I."Year", S."Topic",  CN."Description", concat(I."CountryCode",I."Year") as id
	FROM "Country" C inner JOIN "Indicators" I
		ON C."CountryCode" = I."CountryCode"
		inner join "Series" S
		on I."IndicatorName" = S."IndicatorName"
		left join "CountryNotes" CN
		on C."CountryCode" = CN."Countrycode" and S."SeriesCode" = CN."Seriescode"
			where (C."CountryCode" like 'CHN' or C."CountryCode" like 'USA')
			and I."IndicatorName" = 'GDP, PPP (current international $)'
			and "Year" > 1990
		order by "CountryCode", "Topic", "IndicatorName", "Year"
	)

-------
select
	data2."IndicatorName",
	data1."CountryCode",
	case when data1."CountryCode" = 'CHN' then corr(data1."Value", data2."Value")
	when data1."CountryCode" = 'USA' then corr(data1."Value", data2."Value")
	end as "Correlation"
	
from data1
join data2
on data1.id = data2.id
group by data1."CountryCode", data2."IndicatorName"

union 

select
	data3."IndicatorName",
	data1."CountryCode",
	case when data1."CountryCode" = 'CHN' then corr(data1."Value", data3."Value")
	when data1."CountryCode" = 'USA' then corr(data1."Value", data3."Value")
	end as "Correlation"
	
from data1
join data3
on data1.id = data3.id
group by data1."CountryCode", data3."IndicatorName"


