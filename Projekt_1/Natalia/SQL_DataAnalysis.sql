-- wskaŸniki

	"IndicatorName" = 'GDP per capita, PPP (current international $)'
	"IndicatorName" = 'GINI index (World Bank estimate)'
	"IndicatorName" = 'Income share held by fourth 20%'
	"IndicatorName" = 'Income share held by highest 20%'
	"IndicatorName" = 'Income share held by lowest 20%'
	"IndicatorName" = 'Income share held by second 20%'
	"IndicatorName" = 'Income share held by third 20%'
	

-- widok danych po³¹czonych (bez korelacji)

with dane1 as

(SELECT C."countrycode", I."IndicatorName", I."Value", I."Year", S."Topic",  CN."description", concat(I."CountryCode", I."Year") as id
	FROM country C inner JOIN Indicators I
		ON C."countrycode" = I."CountryCode"
		inner join Series S
		on I."IndicatorName" = S."IndicatorName"
		left join CountryNotes CN
		on C."countrycode" = CN."countrycode" and S."SeriesCode" = CN."seriescode"
			where (C."countrycode" like 'CHN' or C."countrycode" like 'USA')
			and "Year" > 1990
			and I."IndicatorName" = 'GDP per capita, PPP (current international $)'
	order by "countrycode", "Year", "Topic", "IndicatorName"
),

dane2 as 

(SELECT C."countrycode", I."IndicatorName", I."Value", I."Year", S."Topic",  CN."description", concat(I."CountryCode", I."Year") as id
	FROM country C inner JOIN Indicators I
		ON C."countrycode" = I."CountryCode"
		inner join Series S
		on I."IndicatorName" = S."IndicatorName"
		left join CountryNotes CN
		on C."countrycode" = CN."countrycode" and S."SeriesCode" = CN."seriescode"
			where (C."countrycode" like 'CHN' or C."countrycode" like 'USA')
			and "Year" > 1990
			and I."IndicatorName" = 'GINI index (World Bank estimate)'
	order by "countrycode", "Year", "Topic", "IndicatorName"
)

select *
from dane1
join dane2
on dane1.id = dane2.id;

---------------------------------
--KORELACJA--


-- wyci¹gniêcie danych GDP

with dane1 as

(SELECT C."countrycode", I."IndicatorName", I."Value", I."Year", S."Topic",  CN."description", concat(I."CountryCode", I."Year") as id
	FROM country C inner JOIN Indicators I
		ON C."countrycode" = I."CountryCode"
		inner join Series S
		on I."IndicatorName" = S."IndicatorName"
		left join CountryNotes CN
		on C."countrycode" = CN."countrycode" and S."SeriesCode" = CN."seriescode"
			where (C."countrycode" like 'CHN' or C."countrycode" like 'USA')
			and "Year" > 1990
			and I."IndicatorName" = 'GDP per capita, PPP (current international $)'
	order by "countrycode", "Year", "Topic", "IndicatorName"
),

-- wyci¹gniêcie drugiego wskaŸnika

dane2 as 

(SELECT C."countrycode", I."IndicatorName", I."Value", I."Year", S."Topic",  CN."description", concat(I."CountryCode", I."Year") as id
	FROM country C inner JOIN Indicators I
		ON C."countrycode" = I."CountryCode"
		inner join Series S
		on I."IndicatorName" = S."IndicatorName"
		left join CountryNotes CN
		on C."countrycode" = CN."countrycode" and S."SeriesCode" = CN."seriescode"
			where (C."countrycode" like 'CHN' or C."countrycode" like 'USA')
			and "Year" > 1990
			and I."IndicatorName" = 'GINI index (World Bank estimate)'
	order by "countrycode", "Year", "Topic", "IndicatorName"
)

-- korelacja dwóch wskaŸników

select
	dane1."countrycode",
	case when dane1."countrycode" = 'CHN' then corr(dane1."Value", dane2."Value")
	when dane1."countrycode" = 'USA' then corr(dane1."Value", dane2."Value")
	end as "correlation"
	
from dane1
join dane2
on dane1.id = dane2.id
group by dane1."countrycode";
	
-------------------------------------
