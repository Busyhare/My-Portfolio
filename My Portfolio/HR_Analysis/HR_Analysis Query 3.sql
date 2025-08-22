CREATE VIEW Active_Employees AS
SELECT COUNT(*) AS ActiveEmployees
FROM Main_Data
WHERE Clean_Termdate IS NULL OR Clean_Termdate > GETDATE()