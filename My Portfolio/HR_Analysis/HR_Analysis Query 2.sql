SELECT *
FROM [dbo].[Main_Data]

ALTER TABLE [dbo].[Main_Data]
ADD FullName VARCHAR (200)

UPDATE [dbo].[Main_Data]
SET FullName = CONCAT(first_name, ' ',last_name)

ALTER TABLE [dbo].[Main_Data]
ADD Age INT

UPDATE [dbo].[Main_Data]
SET Age = DATEDIFF(YEAR, birthdate, GETDATE())

ALTER TABLE [dbo].[Main_Data]
ADD AgeGroup VARCHAR(50)

UPDATE [dbo].[Main_Data]
SET AgeGroup = CASE
	WHEN Age BETWEEN 21 AND 30 THEN '21-30'
	WHEN Age BETWEEN 31 AND 40 THEN '31-40'
	WHEN Age BETWEEN 41 AND 50 THEN '41-50'
	WHEN Age BETWEEN 51 AND 60 THEN '51-60'
	ELSE '60+'
END 



SELECT FullName,
	ISNULL(termdate, 'Still Working')
	AS termdate 
FROM [dbo].[Main_Data]

UPDATE [dbo].[Main_Data]
SET termdate = 'Still Working'
WHERE termdate IS NULL

UPDATE [dbo].[Main_Data]
SET termdate = NULL
WHERE termdate = 'Still Working'

SELECT *
FROM [dbo].[Main_Data]
WHERE termdate > GETDATE()

SELECT 
	TRY_CAST(REPLACE(termdate, 'UTC', '') AS DATETIME) AS Clean_Termdate
FROM [dbo].[Main_Data]

SELECT 
	CONVERT(DATE, REPLACE(termdate, 'UTC', ' ')) AS Clean_Termdate
FROM [dbo].[Main_Data]

ALTER TABLE [dbo].[Main_Data]
ADD Clean_Termdate DATE


UPDATE [dbo].[Main_Data]
SET Clean_Termdate = CONVERT(DATE, REPLACE(termdate, 'UTC', ' '))

ALTER TABLE [dbo].[Main_Data]
ADD HireAge INT

UPDATE Main_Data
SET HireAge = DATEDIFF(YEAR, birthdate, hire_date)

ALTER TABLE [dbo].[Main_Data]
ADD prank INT

ALTER TABLE [dbo].[Main_Data]
DROP COLUMN prank

ALTER TABLE [dbo].[Main_Data]
ADD EmploymentLength INT

UPDATE Main_Data
SET EmploymentLength = DATEDIFF(YEAR, hire_date, Clean_Termdate)


SELECT AVG(EmploymentLength) AS AvgEmploymentLength
FROM Main_Data

SELECT department, total_count, terminated_count, terminated_count/total_count AS TerminationRate
FROM(SELECT department,COUNT(*) AS total_count, SUM(CASE WHEN Clean_Termdate <= GETDATE()
AND Clean_Termdate <> GETDATE THEN 1 ELSE 0 END) 
AS terminated_count
FROM [dbo].[Main_Data]
GROUP BY department) AS subquery


CREATE VIEW Turnover_Rate AS
SELECT department, COUNT(CASE WHEN Clean_Termdate IS NOT NULL
	AND Clean_termdate <= GETDATE() THEN 1 END) *1.0/COUNT(*) AS Turnover_Rate
FROM Main_Data
GROUP BY department

SELECT *
FROM Main_Data

