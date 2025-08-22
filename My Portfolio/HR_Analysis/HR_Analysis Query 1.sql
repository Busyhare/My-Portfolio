SELECT gender, COUNT (*) AS CountbyGender
FROM [dbo].[Main_Data]
GROUP BY gender
ORDER BY CountbyGender desc

CREATE VIEW Racebreakdown AS 
SELECT race, COUNT (*) AS CountbyRace
FROM [dbo].[Main_Data]
GROUP BY race
ORDER BY CountbyRace desc


CREATE VIEW Agedistribution AS 
SELECT AgeGroup, COUNT (*) AS AgeDistribution
FROM [dbo].[Main_Data]
GROUP BY AgeGroup
ORDER BY AgeGroup 


CREATE VIEW LocationDistribution AS 
SELECT location, COUNT (*) AS LocationCount
FROM [dbo].[Main_Data]
GROUP BY location
ORDER BY location 

SELECT AVG(EmploymentLength) AS AvgEmploymentLength
FROM Main_Data 
WHERE Age >=18

SELECT AVG(EmploymentLength)
FROM Main_Data
WHERE Clean_Termdate <= GETDATE() AND Clean_Termdate <> '0000-00-00' AND Age >=18

CREATE VIEW AvgEmploymentLength AS
SELECT AVG(EmploymentLength) AS AvgEmploymentLength
FROM Main_Data
WHERE Clean_Termdate <= GETDATE()


CREATE VIEW DepartmentbyGender AS 
SELECT department,gender, COUNT (*) AS DepartmentbyGender
FROM [dbo].[Main_Data]
GROUP BY department, gender

CREATE VIEW Countbyjobtitle AS
SELECT jobtitle, COUNT (*) AS Countbyjobtitle
FROM [dbo].[Main_Data]
GROUP BY jobtitle


CREATE VIEW Turnover_Rate AS
SELECT department, COUNT(CASE WHEN Clean_Termdate IS NOT NULL
	AND Clean_termdate <= GETDATE() THEN 1 END) *1.0/COUNT(*) AS Turnover_Rate
FROM Main_Data
GROUP BY department



CREATE VIEW Countbystate AS
SELECT location_state, COUNT (*) AS Countbystate
FROM [dbo].[Main_Data]
GROUP BY location_state



CREATE VIEW TotalEmploymentYears AS
SELECT department, DATEDIFF(YEAR, hire_date, ISNULL(Clean_Termdate, GETDATE())) AS TotalEmploymentYears
FROM Main_Data
WHERE hire_date IS NOT NULL

