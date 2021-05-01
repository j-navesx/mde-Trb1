create or replace procedure update_exercises (
    ifit_user_id in fit_user.id%type,
    idistance in EXERCISES.DISTANCE%type,
    isteps in EXERCISES.STEPS%type,
    ibpm in EXERCISES.avg_bpm%type
) is
    ex_calories       EXERCISES.CALORIES%type;
    ex_end_date       EXERCISES.end_date%type;
    ex_duration       EXERCISES.duration%type;
    ex_duration_min   number(38);
    ex_begin_date     EXERCISES.begin_date%type;
    act_id            EXERCISES.activities_template_id%type;
    iex_id            EXERCISES.ex_id%type;
    ex_cal_step_mult  activities_template.cal_step_mult%type;
    ex_cal_dist_mutl  activities_template.cal_dist_mutl%type;
    ex_cal_time_mult  activities_template.cal_time_mult%type;
begin
    select SYSTIMESTAMP 
    into ex_end_date
    from dual;
    
    select ex_id
    into iex_id
    from exercises
    where fit_user_id = ifit_user_id
    and end_date is null;

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
    
    ex_duration := ex_end_date - ex_begin_date;
    
    ex_duration_min := abs( extract( minute from ex_duration ) 
        + extract( hour from ex_duration ) * 60 
        + extract( day from ex_duration ) * 60 * 24
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
        end_date = ex_end_date,
        duration = ex_duration,
        steps = isteps,
        avg_bpm = ibpm
    where ex_id = iex_id;
end;

