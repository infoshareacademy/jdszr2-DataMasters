CREATE TABLE public.indicators (
	"CountryName" varchar NULL,
	"CountryCode" varchar NULL,
	"IndicatorName" varchar NULL,
	"IndicatorCode" varchar NULL,
	"Year" int4 NULL,
	"Value" numeric NULL
);

CREATE TABLE public.seriesnotes (
	"Seriescode" varchar NULL,
	"Year" varchar NULL,
	"Description" varchar NULL
);
