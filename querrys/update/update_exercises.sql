create or replace procedure update_exercises (
    iex_id in EXERCISES.EX_ID%type,
    idistance in EXERCISES.DISTANCE%type,
    isteps in EXERCISES.STEPS%type
) is
    ex_calories       EXERCISES.CALORIES%type;
    current_date      EXERCISES.end_date%type;
    ex_duration       EXERCISES.duration%type;
    ex_duration_min   integer;
    ex_begin_date     EXERCISES.begin_date%type;
    act_id            EXERCISES.activities_template_id%type;  
    ex_cal_step_mult  activities_template.cal_step_mult%type;
    ex_cal_dist_mutl  activities_template.cal_dist_mutl%type;
    ex_cal_time_mult  activities_template.cal_time_mult%type;
begin
    select SYSTIMESTAMP 
    into current_date
    from dual;

    select 
        activities_template_id,
        begin_date
    into 
        act_id,
        ex_begin_date
    from exercises
    where ex_id = iex_id;
    
    select 
        cal_step_mult,
        cal_dist_mutl,
        cal_time_mult
    into
        ex_cal_step_mult,
        ex_cal_dist_mutl,
        ex_cal_time_mult
    from activities_template
    where id = act_id;
    
    select 
        abs( extract( minute from ex_duration ) 
        + extract( hour from ex_duration ) * 60 
        + extract( day from ex_duration ) * 60 * 24
        )
    into ex_duration_min
    from ( 
        select (current_date - ex_begin_date) as ex_duration
        from dual 
    );
    
    ex_calories := 0;
    
    if ex_cal_step_mult is not null
    then
        ex_calories := ex_calories + isteps*ex_cal_step_mult;
    end if;
    
    if ex_cal_dist_mutl is not null
    then
        ex_calories := ex_calories + idistance*ex_cal_dist_mutl;
    end if;
    
    if ex_cal_time_mult is not null
    then
        ex_calories := ex_calories + ex_duration_min*ex_cal_time_mult;
    end if;

    update EXERCISES set
        distance = idistance,
        calories = ex_calories,
        end_date = current_date,
        duration = ex_duration,
        steps = isteps
    where ex_id = iex_id;
end;

