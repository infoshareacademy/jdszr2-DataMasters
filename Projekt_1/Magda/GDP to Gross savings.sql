-- koszyk 1 z danymi nt. GDP per capita PPP dla Chin i USA po 1990

with data1 as (
SELECT C."countrycode", I."IndicatorName", I."Value", I."Year", concat(I."CountryCode",I."Year") as id
	FROM "Country" C inner JOIN "Indicators" I
		ON C."countrycode" = I."CountryCode"
			where (C."countrycode" like 'CHN' or C."countrycode" like 'USA')
			and I."IndicatorName" = 'GDP per capita, PPP (current international $)'
			and "Year" > 1990
		order by "countrycode", "IndicatorName", "Year"
			),
			
-- koszyk 2 z danymi Gross savings (current US$)

data2 as (
SELECT C."countrycode", I."IndicatorName", I."Value", I."Year", concat(I."CountryCode",I."Year") as id
	FROM "Country" C inner JOIN "Indicators" I
		ON C."countrycode" = I."CountryCode"
			where (C."countrycode" like 'CHN' or C."countrycode" like 'USA')
			and I."IndicatorName" = 'Gross savings (current US$)'
			and "Year" > 1990
		order by "countrycode", "IndicatorName", "Year"
)

-- korelacja

select
	data1."countrycode",
	case when data1."countrycode" = 'CHN' then corr(data1."Value", data2."Value")
	when data1."countrycode" = 'USA' then corr(data1."Value", data2."Value")
	end as "Correlation"
	
from data1
join data2
on data1.id = data2.id
group by data1."countrycode"