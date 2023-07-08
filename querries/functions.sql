CREATE FUNCTION track_working_hours(
	p_employee_id INTEGER, 
	p_project_id INTEGER, 
	p_total_hours NUMERIC
) RETURNS VOID AS $$
BEGIN
	IF NOT EXISTS (
		SELECT 1
		FROM "Application".employees
		WHERE employee_id = p_employee_id
	) THEN
		RAISE EXCEPTION 'Employee with ID % does not exist', p_employee_id;
	END IF;

	IF NOT EXISTS (
		SELECT 1
		FROM "Application".project
		WHERE project_id = p_project_id
	) THEN
		RAISE EXCEPTION 'Project with ID % does not exist', p_project_id;
	END IF;
	  
	IF NOT EXISTS (
		SELECT 1
		FROM "Application".team_project AS tp
		JOIN "Application".teams AS t ON tp.team_id = t.team_id
		JOIN "Application".employees AS e ON t.team_id = e.team
		WHERE e.employee_id = p_employee_id
			AND tp.project_id = p_project_id
	) THEN
		RAISE EXCEPTION 'Employee with ID % is not assigned to Project with ID %', p_employee_id, p_project_id;
	END IF;

	IF p_total_hours < 0 THEN
		RAISE EXCEPTION 'Invalid total_hours: %', p_total_hours;
	END IF;
	
	INSERT INTO "Application".hour_tracking (employee_id, project_id, total_hours)
	VALUES (p_employee_id, p_project_id, p_total_hours);
END;
$$ LANGUAGE plpgsql;


