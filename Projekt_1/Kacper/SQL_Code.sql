---Stworzenie tabeli "lista_wskaznikow" ze wszystkimi wskaŸnikami i liczb¹ mówi¹c¹ ile danych z wybranego wskaŸnika w ogóle mamy.

create table lista as
(with dane  as
(SELECT C.*, I.*, S.*
	FROM country C inner JOIN indicators I
		ON C.countrycode = I."CountryCode" 
		inner join series S
		on I."IndicatorName" = S.indicatorname 
			where S.topic like 'Infrastructure: Technology' and (C.countrycode like 'CHN' or C.countrycode like 'USA'))
select CountryCode, Topic, IndicatorName, count("Year") from dane
group by CountryCode, Topic, IndicatorName
order by topic, IndicatorName, CountryCode, count("Year"));


--- update tabel (zamiana formatu string: YR2000 na int:2000) 

update footnotes set "Year" =  REPLACE("Year", 'yr', ''); 
update footnotes set "Year" =  REPLACE("Year", 'YR', '');
alter table footnotes alter column "Year" TYPE integer USING ("Year"::integer);

update seriesnotes set "Year" =  REPLACE("Year", 'yr', ''); 
update seriesnotes set "Year" =  REPLACE("Year", 'YR', '');
alter table seriesnotes alter column "Year" TYPE integer USING ("Year"::integer);

--- Wybór danych, dla wybranych wskaŸników, ze z³¹czeniem z wszystkich tabel, w³¹czeni z opisami z tabel: FootNotes, CountryNodes, SeriesNode. (W tym poni¿szym przyk³adzie wskaŸniki wybrane i analizowane przez Kacpra)

with dane  as
(SELECT distinct C."countrycode" , I."IndicatorName",I."Value", I."Year", S.topic,  CN.description as descripton_CN, SN."Description" as descripton_SN, FN.description as description_FN
	FROM country C inner JOIN Indicators i
		ON C."countrycode" = I."CountryCode"
		inner join Series s
		on I."IndicatorName" = S."indicatorname"
		full outer join footnotes FN
		on C."countrycode" = FN."countrycode" and S."seriescode" = FN."seriescode" and I."Year"= FN."Year"
		full outer join Seriesnotes SN
		on  S."seriescode" = SN."Seriescode" and I."Year"= SN."Year"
 		left join CountryNotes cn
		on C."countrycode" = CN."countrycode" and S."seriescode" = CN."seriescode"
			where I."Year" >1990 and (C."countrycode" like 'CHN' or C."countrycode" like 'USA'))
select "countrycode", "Year", "Value", "descripton_cn", "description_fn", "descripton_sn", "IndicatorName" from dane
where "IndicatorName" = 'GDP, PPP (current international $)' or 
"IndicatorName" = 'GDP per capita, PPP (current international $)' or
"IndicatorName" =  'High-technology exports (current US$)' or
"IndicatorName" = 'Trademark applications, total' or 
"IndicatorName" = 'Scientific and technical journal articles' or
"IndicatorName" ='Electricity production from coal sources (% of total)' or
"IndicatorName" ='Electricity production from hydroelectric sources (% of total)' or
"IndicatorName" ='Electricity production from natural gas sources (% of total)' or
"IndicatorName" ='Electricity production from nuclear sources (% of total)' or
"IndicatorName" ='Electricity production from oil sources (% of total)' or
"IndicatorName" ='Electricity production from renewable sources, excluding hydroelectric (% of total)' or
"IndicatorName" = 'Arms exports (SIPRI trend indicator values)' or
"IndicatorName" = 'Arms import (SIPRI trend indicator values)' or
"IndicatorName" = 'Research and development expenditure (% of GDP)'
order by "countrycode", "IndicatorName", "Year"

---Stworzenie tabel do liczenia korelacji (dla ka¿dego wskaŸnika osobna tabela)
create table high_tech_exports_USA as
with korelacje as (
SELECT distinct C."countrycode" , I."IndicatorName",I."Value", I."Year",  CN.description as descripton_CN, SN."Description" as descripton_SN, FN.description as description_FN
	FROM country C inner JOIN Indicators i
		ON C."countrycode" = I."CountryCode"
		inner join Series s
		on I."IndicatorName" = S."indicatorname"
		full outer join footnotes FN
		on C."countrycode" = FN."countrycode" and S."seriescode" = FN."seriescode" and I."Year"= FN."Year"
		full outer join Seriesnotes SN
		on  S."seriescode" = SN."Seriescode" and I."Year"= SN."Year"
 		left join CountryNotes cn
		on C."countrycode" = CN."countrycode" and S."seriescode" = CN."seriescode"
			where I."Year" >1989 and (C."countrycode" = 'USA') and ("IndicatorName" = 'GDP, PPP (current international $)' or "IndicatorName" = 'High-technology exports (current US$)')
			order by "countrycode", "Year")
select t1."IndicatorName", t1."Year", t1."Value" as "GDP, PPP (current international $)", t2."Value" as "High-technology exports (current US$)" from korelacje as t1
join korelacje as t2 on t1."Year" = t2."Year" and t1."IndicatorName" != t2."IndicatorName"
where t1."Value" > t2."Value"
order by "Year"

--- wyliczenie korelacji
select corr("GDP, PPP (current international $)"::numeric, "Research and development expenditure (% of GDP)"::numeric) from Research_and_development_expenditure;
select corr("GDP, PPP (current international $)"::numeric, "Research and development expenditure (% of GDP)"::numeric) from Research_and_development_expenditure_USA;

select corr("GDP, PPP (current international $)"::numeric, "Arms exports (SIPRI trend indicator values)"::numeric) from Arms_exports;
select corr("GDP, PPP (current international $)"::numeric, "Arms exports (SIPRI trend indicator values)"::numeric) from Arms_exports_USA;

select corr("GDP, PPP (current international $)"::numeric, "High-technology exports (current US$)"::numeric) from High_tech_exports;
select corr("GDP, PPP (current international $)"::numeric, "High-technology exports (current US$)"::numeric) from High_tech_exports_USA;

