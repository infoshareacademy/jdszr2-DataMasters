-------------	
--Create table with Exports and GPD per capita

drop table if exists "ExportsGDPpc";
create table "ExportsGDPpc" as

-- data1 with Exports of goods and services (current US$)

with data1 as (
select C."CountryCode", I."IndicatorName", I."Value", I."Year", S."Topic",  CN."Description", concat(I."CountryCode",I."Year") as id
	from "Country" C inner join "Indicators" I
		on C."CountryCode" = I."CountryCode"
		inner join "Series" S
		on I."IndicatorName" = S."IndicatorName"
		left join "CountryNotes" CN
		on C."CountryCode" = CN."Countrycode" and S."SeriesCode" = CN."Seriescode"
			where (C."CountryCode" like 'CHN' or C."CountryCode" like 'USA')
			and I."IndicatorName" = 'Exports of goods and services (current US$)'
			and "Year" > 1990
		order by "CountryCode", "Topic", "IndicatorName", "Year"
	),
			
-- data2 with GDP per capita, PPP (current international $)

data2 as (
select C."CountryCode", I."IndicatorName", I."Value", I."Year", S."Topic",  CN."Description", concat(I."CountryCode",I."Year") as id
	from "Country" C inner join "Indicators" I
		ON C."CountryCode" = I."CountryCode"
		inner join "Series" S
		on I."IndicatorName" = S."IndicatorName"
		left join "CountryNotes" CN
		on C."CountryCode" = CN."Countrycode" and S."SeriesCode" = CN."Seriescode"
			where (C."CountryCode" like 'CHN' or C."CountryCode" like 'USA')
			and I."IndicatorName" = 'GDP per capita, PPP (current international $)'
			and "Year" > 1990
		order by "CountryCode", "Topic", "IndicatorName", "Year"
	)

select 
	data1."CountryCode",
	data1."Year",
	data1."Value" as "Exports of goods and services (current US$)",
	data2."Value" as "GDP per capita, PPP (current international $)"
	
from data1
join data2
on data1.id = data2.id
order by data1."CountryCode", "Year";	
	
-------------
--Create table with exports and GDP	

drop table if exists "ExportsGDP";
create table "ExportsGDP" as

-- data1 with Exports of goods and services (current US$)

with data1 as (
select C."CountryCode", I."IndicatorName", I."Value", I."Year", S."Topic",  CN."Description", concat(I."CountryCode",I."Year") as id
	from "Country" C inner join "Indicators" I
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
	
-- data3 with GDP, PPP (current international $)

data3 as (
select C."CountryCode", I."IndicatorName", I."Value", I."Year", S."Topic",  CN."Description", concat(I."CountryCode",I."Year") as id
	from "Country" C inner join "Indicators" I
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

select 
	data1."CountryCode",
	data1."Year",
	data1."Value" as "Exports of goods and services (current US$)",
	data3."Value" as "GDP, PPP (current international $)"
from data1
join data3
on data1.id = data3.id
order by data1."CountryCode", "Year";

-------------
--Create table with Exports as Percentage of GDP

drop table if exists "Exports_asPerc";
create table "Exports_asPerc" as

--exports as % of GDP for China

with exp_chn as (
select C."CountryCode", I."IndicatorName", I."Value", I."Year", S."Topic",  CN."Description"
	from "Country" C inner join "Indicators" I
		on C."CountryCode" = I."CountryCode"
		inner join "Series" S
		on I."IndicatorName" = S."IndicatorName"
		left join "CountryNotes" CN
		on C."CountryCode" = CN."Countrycode" and S."SeriesCode" = CN."Seriescode"
			where C."CountryCode" like 'CHN'
			and I."IndicatorName" = 'Exports of goods and services (% of GDP)'
			and "Year" > 1990
		order by "CountryCode", "Topic", "IndicatorName", "Year"
	),
			
-- exports as % of GDP for USA

exp_usa as (
select C."CountryCode", I."IndicatorName", I."Value", I."Year", S."Topic",  CN."Description"
	from "Country" C inner join "Indicators" I
		on C."CountryCode" = I."CountryCode"
		inner join "Series" S
		on I."IndicatorName" = S."IndicatorName"
		left join "CountryNotes" CN
		on C."CountryCode" = CN."Countrycode" and S."SeriesCode" = CN."Seriescode"
			where C."CountryCode" like 'USA'
			and I."IndicatorName" = 'Exports of goods and services (% of GDP)'
			and "Year" > 1990
		order by "CountryCode", "Topic", "IndicatorName", "Year"
	)
select 
	exp_chn."Year",
	exp_chn."Value" as "China",
	exp_usa."Value" as "USA"
from exp_chn
join exp_usa
on exp_chn."Year" = exp_usa."Year"
order by "Year"
