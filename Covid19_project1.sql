-- Observing The Covid19 Deaths Table
SELECT *
FROM covid_deaths
ORDER BY location,date,total_cases,new_cases

-- Case Fatality Worldwide
SELECT location, date, total_cases, total_deaths, population, (total_deaths/total_cases)*100 AS case_fatality
FROM covid_deaths
WHERE continent IS NOT NULL
ORDER BY location,date,total_cases


-- Case Fatality In Nigeria
SELECT location, date, total_cases, total_deaths, population, (total_deaths/total_cases)*100 AS case_fatality
FROM covid_deaths
WHERE location LIKE 'Nigeria'
AND continent IS NOT NULL
ORDER BY date,total_cases

--Total Cases vs Population World Wide
-- percentage of Population infected
SELECT location, date, total_cases, total_deaths, population, (total_cases/population)*100 AS percentage_infected
FROM covid_deaths
ORDER BY location,date,total_cases

--Total Cases vs Population Nigeria
-- percentage of Population infected
SELECT location, date, total_cases, total_deaths, population, (total_cases/population)*100 AS percentage_infected
FROM covid_deaths
WHERE location LIKE 'Nigeria'
ORDER BY date,total_cases



-- Countries With The Highest Number of cases per Population
SELECT location, MAX(total_cases) AS total_case_count, population, MAX(total_cases/population)*100 AS percentage_infected
FROM covid_deaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY percentage_infected DESC


-- Countries With The Highest Fatality Rate
SELECT location, MAX(CAST(total_deaths AS INT)) AS total_deaths_count, population, MAX(total_deaths/population)*100 AS fatality_rate
FROM covid_deaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY 4 DESC, 2 DESC

-- Highest Fatality Rate In Each Continent
SELECT location, MAX(CAST(total_deaths AS INT)) AS total_deaths_count, population, MAX(total_deaths/population)*100 AS fatality_rate
FROM covid_deaths
WHERE continent IS NULL
AND location NOT LIKE 'High income'
AND location NOT LIKE 'Upper middle income'
AND location NOT LIKE 'Lower middle income'
AND location NOT LIKE 'Low income' 
AND location NOT LIKE 'European Union'
AND location NOT LIKE 'International'
AND location NOT LIKE 'World'
GROUP BY location, population
ORDER BY 4 DESC, 2 DESC

-- Global Case Fatality Report
SELECT SUM(new_cases) AS Total_cases_worldwide, SUM(CAST(new_deaths AS INT)) AS Total_deaths_worldwide,  (SUM(CAST(new_deaths AS INT)))/( SUM(new_cases)) AS Case_Fatality_rate
FROM covid_deaths
WHERE continent IS NULL
AND location NOT LIKE 'High income'
AND location NOT LIKE 'Upper middle income'
AND location NOT LIKE 'Lower middle income'
AND location NOT LIKE 'Low income' 
AND location NOT LIKE 'European Union'
AND location NOT LIKE 'International'
AND location NOT LIKE 'World'


-- Observing the Covid19 Vaccinations Table
SELECT *
FROM covid_vaccinations


-- Population Vs Vaccinations
--Joining the Deaths Table and vaccinations Table
SELECT d.location, d.continent, d.date, d.population, v.new_vaccinations, SUM(CAST(v.new_vaccinations AS BIGINT)) OVER (PARTITION BY d.location ORDER BY d.location,d.date) AS rollingcount_of_vaccinations
FROM covid_deaths d
JOIN covid_vaccinations v
ON d.location = v.location
AND d.date = v.date
WHERE d.continent IS NOT NULL
ORDER BY d.location,d.date 


-- TEMP TABLE
DROP TABLE IF EXISTS #PercentageOfPopulationVaccinated
CREATE TABLE #PercentageOfPopulationVaccinated
(continent NVARCHAR(255),
location NVARCHAR(255),
date DATETIME,
population NUMERIC,
new_vaccinations NUMERIC,
rollingcount_of_vaccinations NUMERIC,
)

INSERT INTO #PercentageOfPopulationVaccinated

SELECT d.continent, d.location, d.date, d.population, v.new_vaccinations, SUM(CAST(v.new_vaccinations AS BIGINT)) OVER (PARTITION BY d.location ORDER BY d.location,d.date) AS rollingcount_of_vaccinations
FROM covid_deaths d
JOIN covid_vaccinations v
ON d.location = v.location
AND d.date = v.date
WHERE d.continent IS NOT NULL
ORDER BY d.location,d.date 

-- Global Vaccination Report By Countries
SELECT *, (rollingcount_of_vaccinations/population)*100 AS population_percent_vaccinated
FROM  #PercentageOfPopulationVaccinated
WHERE continent IS NOT NULL
ORDER BY location,date 


-- Nigeria's Vaccination Report 
SELECT *, (rollingcount_of_vaccinations/population)*100 AS population_percent_vaccinated
FROM  #PercentageOfPopulationVaccinated
WHERE continent IS NOT NULL AND location LIKE 'Nigeria'
ORDER BY location,date 


--LET'S CREATE VIEWS TO STORE DATA FOR LATER VISUALIZATIONS

-- World wide Case Fatality
CREATE VIEW Worldwide_Case_Fatality AS
SELECT location, date, total_cases, total_deaths, population, (total_deaths/total_cases)*100 AS case_fatality
FROM covid_deaths
WHERE continent IS NOT NULL


--Nigeria Case Fatality Report
CREATE VIEW Nigeria_Case_Fatality AS
SELECT location, date, total_cases, total_deaths, population, (total_deaths/total_cases)*100 AS case_fatality
FROM covid_deaths
WHERE location LIKE 'Nigeria'


-- Global Vaccination Report By Countries
CREATE VIEW global_vaccination_report AS
SELECT d.continent, d.location, d.date, d.population, v.new_vaccinations, SUM(CAST(v.new_vaccinations AS BIGINT)) OVER (PARTITION BY d.location ORDER BY d.location,d.date) AS rollingcount_of_vaccinations
FROM covid_deaths d
JOIN covid_vaccinations v
ON d.location = v.location
AND d.date = v.date
WHERE d.continent IS NOT NULL

-- Nigeria Vaccination Report
CREATE VIEW Nigeria_vaccination_report AS
SELECT d.continent, d.location, d.date, d.population, v.new_vaccinations, SUM(CAST(v.new_vaccinations AS BIGINT)) OVER (PARTITION BY d.location ORDER BY d.location,d.date) AS rollingcount_of_vaccinations
FROM covid_deaths d
JOIN covid_vaccinations v
ON d.location = v.location
AND d.date = v.date
WHERE d.location LIKE 'Nigeria'






