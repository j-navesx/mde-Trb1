create or replace procedure create_activities_template(
    iname           activities_template.name%type,
    ical_step_mult  activities_template.cal_step_mult%type,
    ical_dist_mutl  activities_template.cal_dist_mutl%type,
    ical_time_mult  activities_template.cal_time_mult%type
) is
    aux_act_id INTEGER;
begin
    insert into activities_template (name,cal_step_mult,cal_dist_mutl,cal_time_mult)
    values (iname,ical_step_mult,ical_dist_mutl,ical_time_mult);
    
    -- select activities_template_id from name
    
    SELECT id 
    INTO aux_act_id
    FROM activities_template 
    WHERE name = iname;
    
    FOR aRow IN (
        SELECT id
        FROM fit_user
    )
    LOOP
    
    -- create totals rows
    
    insert into totals (
        fit_user_id,
        activities_template_id,
        distance,
        calories
    )
    values (
        aRow.id,
        aux_act_id,
        0,
        0
    );
    
    -- create friends leaderboard
    
    insert into friends_leaderboard (
        totals_fit_user_id,
        totals_activities_template_id,
        place
    )
    values (
        aRow.id,
        aux_act_id,
        1
    );
    
    END LOOP;
end;
