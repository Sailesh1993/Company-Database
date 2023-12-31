-- Retrieve the tea, names and their corresponding project count

SELECT t.team_name, COUNT(tp.project_id) AS project_count
FROM "Application".teams AS t
LEFT JOIN "Application".team_project AS tp ON t.team_id = tp.team_id
GROUP BY t.team_name;

-- Retrieve the projects managed by the managers whose first name starts with "J" or "D"

SELECT p.*, CONCAT(m.first_name, '', m.last_name) AS manager_name
FROM "Application".project AS p
JOIN "Application".team_project AS tp ON p.project_id = tp.project_id
JOIN "Application".teams AS t ON tp.team_id = t.team_id
JOIN "Application".employees AS m ON t.team_id = m.team
Where m.first_name LIKE 'J%' OR m.first_name LIKE 'D%';

-- Retrieve all the employees (both directly and indirectly) working under Andrew Martin
SELECT e.*
FROM "Application".employees AS e
JOIN "Application".employees AS manager ON manager.employee_id = e.manager_id
WHERE manager.first_name = 'Andrew' AND manager.last_name = 'Martin';

-- Retrieve all the employees (both directly and indirectly) working under Robert Brown

SELECT e.*
FROM "Application".employees AS e
JOIN "Application".employees AS manager ON manager.employee_id = e.manager_id
WHERE manager.first_name = 'Robert' AND manager.last_name = 'Brown';

--Retrieve the average hourly salary for each title

SELECT t.title_name AS title, AVG(e.hourly_salary) AS average_hourly_salary
FROM "Application".employees AS e
JOIN "Application".titles AS t ON e.title_id = t.title_id
GROUP BY title;

-- Retrieve the employees who have a higher hourly salary than their respective team's average 

SELECT e.*
FROM "Application".employees AS e
JOIN(
	SELECT t.team_id, AVG(e.hourly_salary) AS avg_hourly_salary
	FROM "Application".employees AS e
	JOIN "Application".teams AS t ON e.team = t.team_id
	GROUP BY t.team_id
) AS team_avg ON e.team = team_avg.team_id
WHERE e.hourly_salary > team_avg.avg_hourly_salary;

-- Retrieve the projects that have more than 3 teams assigned to them

SELECT p.*
FROM "Application".project AS p
JOIN (
	SELECT project_id, COUNT(team_id) AS team_count
	FROM "Application".team_project
	GROUP BY project_id
	Having COUNT(team_id) > 3
) AS project_team ON p.project_id = project_team.project_id;