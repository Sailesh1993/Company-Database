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