-- Retrieve the tea, names and their corresponding project count

SELECT t.team_name, COUNT(tp.project_id) AS project_count
FROM "Application".teams AS t
LEFT JOIN "Application".team_project AS tp ON t.team_id = tp.team_id
GROUP BY t.team_name;