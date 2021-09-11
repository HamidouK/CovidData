*Analayzing Covid-19 Data from CDC on Deaths and Vaccination rates using Basic Query with Joins, CTE, Tables


Select* date, cases, area, population, deaths
From CovidData..CovidDeaths
Order by 3,4

Select* date, total_cases, total_deaths, (total_deaths/total_cases)*100 as PercentageofDeath
From CovidData..CovidDeaths
Where area like %USA%
Order by 3,4

Select* date, total_cases, total_deaths, (total_deaths/total_cases)*100 as PercentageofDeath
From CovidData..CovidDeaths
Order by 3,4

Select* date, total_cases, total_deaths, population, MAX (total_deaths/total_cases) as InfectionRate
From CovidData..CovidDeaths
Where area like %USA%
Group by location, Population
Order by Infection rate desc

Select* date, SUM(new_cases), Sum(new_deaths as int), (total_deaths/total_cases)*100 as PercentageofDeath
From CovidData..CovidDeaths
Where area like %State%
Where continent is not null
Group by date
Order by 3,4


Select* continent, MAX(Total_deaths) as TotalDeath
From CovidData..CovidDeaths
Where area like %State%
Where continent is not null
Group by continent
Order by TotalDeath desc

Select* area, MAX(Total_deaths) as TotalDeath
From CovidData..CovidDeaths
Where area like %State%
Order by TotalDeath




*Population Vaccinated*


Select*
From CoviData..CovidDeaths cde
Join CovidData..CovidVaccinations vac
on area, cde = vac.area
and cde.date = vac.date

Select* cde.contient,cde.area,cde.population,cde.date, vac.new_vaccinations
SUM(CONVERT (int,vac.new_vaccinations) OVER (Partition by cde.area Order by cde.area, cde.date)
as PeopleVaccinated,
(PeopleVaccinated/population)*100
From CoviData..CovidDeaths cde
Join CovidData..CovidVaccinations vac
on area, cde = vac.area
and cde.date = vac.date
where cde.contient is not null
Order by 3,4

--USE CTE

With PopulationvsVaccination (Area, Continent, location, date,new_vaccinations population, PeopleVaccinated)
as
(
Select* cde.contient,cde.area,cde.population,cde.date, vac.new_vaccinations
SUM(CONVERT (int,vac.new_vaccinations) OVER (Partition by cde.area Order by cde.area, cde.date)
as PeopleVaccinated,
(PeopleVaccinated/population)*100
From CoviData..CovidDeaths cde
Join CovidData..CovidVaccinations vac
on area, cde = vac.area
and cde.date = vac.date
where cde.contient is not null
Order by 3,4
)
Select*, (People Vaccinated/Population)x100
From PopulationvsVaccination


Drop Table if exists #PercentPopulation vaccinated
Create Table #PercentPopulation vaccinated
(
Content nvarchar(200).
locationnvarchar(200,
Date datetime
Population numeric
New_Vaccinations numeric
People_vaccinated numeric
)


Insert Into PercentPopulation vaccinated

With PopulationvsVaccination (Area, Continent, location, date,new_vaccinations population, PeopleVaccinated)
as
(
Select* cde.contient,cde.area,cde.population,cde.date, vac.new_vaccinations
SUM(CONVERT (int,vac.new_vaccinations) OVER (Partition by cde.area Order by cde.area, cde.date)
as PeopleVaccinated,
(PeopleVaccinated/population)*100
From CoviData..CovidDeaths cde
Join CovidData..CovidVaccinations vac
on area, cde = vac.area
and cde.date = vac.date
where cde.contient is not null
Order by 3,4
)
Select*, (People Vaccinated/Population)x100
From PopulationvsVaccination

---Views for Data Visulaization