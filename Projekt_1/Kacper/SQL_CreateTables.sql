CREATE TABLE Indicators (
    "CountryName" varchar,
    "CountryCode" varchar(3),
    "IndicatorName" varchar,
    "IndicatorCode" varchar,
    "Year" int,
    "Value" NUMERIC);

CREATE TABLE SeriesNotes (
    "Seriescode" varchar,
    "Year" varchar(6), 							
    "Description" varchar);
	
	CREATE TABLE Country (
    CountryCode varchar(3),
    ShortName varchar,
    TableName varchar,
    LongName varchar,
    Alpha2Code varchar(2),
    CurrencyUnit varchar,
    SpecialNotes varchar,
    Region varchar,
    IncomeGroup varchar,
    Wb2Code varchar(2),
    NationalAccountsBaseYear varchar,
    NationalAccountsReferenceYear varchar,
    SnaPriceValuation varchar,
    LendingCategory varchar,
    OtherGroups varchar(10),
    SystemOfNationalAccounts varchar,
    AlternativeConversionFactor varchar,
    PppSurveyYear varchar,
    BalanceOfPaymentsManualInUse varchar,
    ExternalDebtReportingStatus varchar,
    SystemOfTrade varchar,
    GovernmentAccountingConcept varchar,
    ImfDataDisseminationStandard varchar,
    LatestPopulationCensus varchar,
    LatestHouseholdSurvey varchar,
    SourceOfMostRecentIncomeAndExpenditureData varchar,
    VitalRegistrationComplete varchar,
    LatestAgriculturalCensus varchar,
    LatestIndustrialData int,
    LatestTradeData int,
    LatestWaterWithdrawalData int);
	
	
CREATE TABLE CountryNotes(
    Countrycode varchar(3),
    Seriescode varchar,
    Description varchar);
	
	

CREATE TABLE Footnotes (
    Countrycode varchar(3),
    Seriescode varchar,
    "Year" varchar(6),
    Description varchar);
	
	
CREATE TABLE Series (
    SeriesCode varchar,
    Topic varchar,
    IndicatorName varchar,
    ShortDefinition varchar,
    LongDefinition varchar,
    UnitOfMeasure varchar,
    Periodicity varchar,
    BasePeriod varchar,
    OtherNotes NUMERIC,
    AggregationMethod varchar,
    LimitationsAndExceptions varchar,
    NotesFromOriginalSource varchar,
    GeneralComments varchar,
    "Source" varchar,
    StatisticalConceptAndMethodology varchar,
    DevelopmentRelevance varchar,
    RelatedSourceLinks varchar,
    OtherWebLinks NUMERIC,
    RelatedIndicators NUMERIC,
    LicenseType varchar);