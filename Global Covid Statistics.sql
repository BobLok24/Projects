SELECT * 
FROM PortfolioProject.covidvaccinations;

SELECT * 
FROM PortfolioProject.coviddeaths;


SELECT Location, Date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject.coviddeaths;


--  TOTAL CASES VS TOTAL DEATH (Probability of dying if contract COVID in Singapore)
Select Location, Date, total_cases, total_deaths, (total_deaths/total_cases) *100 AS DeathPercentage
FROM PortfolioProject.coviddeaths
WHERE Location like '%Singapore%'
AND Location IS NOT NULL;



-- TOTAL CASES VS POPULATION (Percentage of popultion that contracted COVID in Singapore)
Select Location, date, Population, total_cases, total_deaths,(total_cases/population) *100 AS PercentPopulationInfected
FROM PortfolioProject.coviddeaths
WHERE Location like '%Singapore%'
AND Location IS NOT NULL;


-- COUNTRIES WITH HIGHEST INFECTION RATE COMPARED TO POPULATION
Select Location, Population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population)) *100 AS PercentPopulationInfected
FROM PortfolioProject.coviddeaths
WHERE Location IS NOT NULL
GROUP BY Location, Population
ORDER BY PercentPopulationInfected desc;

-- COUNTRIES WITH HIGHEST DEATH COUNT PER POPULATION
Select Location, MAX(cast(Total_deaths as UNSIGNED)) AS TotalDeathCount
FROM PortfolioProject.coviddeaths
WHERE Location IS NOT NULL
AND Location != 'High income' OR 'Low income'
GROUP BY Location
ORDER BY TotalDeathCount desc;

-- CONTINENT BREAKDOWN
Select continent, MAX(cast(Total_deaths as UNSIGNED)) AS TotalDeathCount
FROM PortfolioProject.coviddeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount desc;


-- GLOBAL DAILY COVID HEADCOUNT 
Select Date, SUM(new_cases) AS Total_Cases, SUM(cast(new_deaths as UNSIGNED)) AS Total_deaths, SUM(cast(new_deaths as UNSIGNED))/ SUM(New_cases) *100 AS DeathPercentage
FROM PortfolioProject.coviddeaths
-- WHERE Location like '%Singapore%'
WHERE Location IS NOT NULL
GROUP BY date;


-- FOR TABLEU GRAPH PLOTTING:

-- TABLE 1

Select SUM(new_cases) AS Total_Cases, SUM(cast(new_deaths as UNSIGNED)) AS Total_deaths, SUM(cast(new_deaths as UNSIGNED))/ SUM(New_cases) *100 AS DeathPercentage
FROM PortfolioProject.coviddeaths
-- WHERE Location like '%Singapore%'
WHERE Location IS NOT NULL;


-- TABLE 2
Select Continent, SUM(cast(new_deaths as UNSIGNED)) AS TotalDeathCount
FROM PortfolioProject.coviddeaths
WHERE Continent IS NOT NULL
GROUP BY Continent
ORDER BY TotalDeathCount desc;


-- TABLE 3
Select Location, Population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population)) *100 AS PercentPopulationInfected
FROM PortfolioProject.coviddeaths
WHERE Location IS NOT NULL
GROUP BY Location, Population
ORDER BY PercentPopulationInfected desc;


-- TABLE 4
Select Location, Population, Date, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population)) *100 AS PercentPopulationInfected
FROM PortfolioProject.coviddeaths
WHERE Location IS NOT NULL
AND Location != "High income" OR "Low income"
GROUP BY Location, Population, Date
ORDER BY PercentPopulationInfected desc;